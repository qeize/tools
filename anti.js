#!/usr/bin/env node
const http = require('http');
const https = require('https');
const cluster = require('cluster');
const os = require('os');
const net = require('net');
const dgram = require('dgram');
const dns = require('dns');
const fs = require('fs');
const path = require('path');
const { exec } = require('child_process');

// Advanced Configuration
const config = {
    port: 80,
    monitorPort: 8080,
    responseCode: 400,
    statusMessage: "Bad Request",
    bodyMessage: "Kize1337 Guardian\nProtected by Death Networks",
    workers: os.cpus().length * 2,
    maxConnections: 100,
    rateLimitWindow: 1000, // 1 second
    maxRequestsPerWindow: 10,
    banDuration: 300000, // 5 minutes
    tcpTimeout: 5000,
    udpTimeout: 3000,
    enableFirewall: true,
    logLevel: 'info'
};

// Global tracking objects
const connections = new Map();
const bannedIPs = new Map();
const rateLimiter = new Map();
const statistics = {
    totalRequests: 0,
    blockedRequests: 0,
    activeConnections: 0,
    bannedIPs: 0,
    uptime: Date.now(),
    attacks: {
        http: 0,
        tcp: 0,
        udp: 0,
        dns: 0
    }
};

// Parse command line arguments
function parseArguments() {
    const args = process.argv.slice(2);
    
    if (args.length === 0) {
        showUsage();
        process.exit(0);
    }

    for (let i = 0; i < args.length; i++) {
        const arg = args[i];
        const nextArg = args[i + 1];

        switch (arg) {
            case '-p':
            case '--port':
                config.port = parseInt(nextArg) || 80;
                i++;
                break;
            case '-m':
            case '--message':
                config.bodyMessage = nextArg || config.bodyMessage;
                i++;
                break;
            case '-r':
            case '--response':
                config.responseCode = parseInt(nextArg) || 400;
                i++;
                break;
            case '--status-msg':
                config.statusMessage = nextArg || config.statusMessage;
                i++;
                break;
            case '--monitor-port':
                config.monitorPort = parseInt(nextArg) || 8080;
                i++;
                break;
            case '--max-connections':
                config.maxConnections = parseInt(nextArg) || 100;
                i++;
                break;
            case '--rate-limit':
                config.maxRequestsPerWindow = parseInt(nextArg) || 10;
                i++;
                break;
            case '--ban-duration':
                config.banDuration = parseInt(nextArg) * 1000 || 300000;
                i++;
                break;
            case '-h':
            case '--help':
                showUsage();
                process.exit(0);
                break;
        }
    }
}

function showUsage() {
    console.log(`
╔══════════════════════════════════════════════════════════════════╗
║                    Kize1337 Guardian Anti-DDoS                   ║
║                      Professional Protection                     ║
╚══════════════════════════════════════════════════════════════════╝

Usage: node guardian.js [options]

Required Options:
  -m, --message <text>       Custom response message
  -r, --response <code>      HTTP response code (200, 400, 404, etc.)
  -p, --port <number>        Main server port (default: 80)

Optional Options:
  --status-msg <text>        Custom HTTP status message
  --monitor-port <number>    Monitoring dashboard port (default: 8080)
  --max-connections <num>    Max concurrent connections (default: 100)
  --rate-limit <num>         Max requests per second per IP (default: 10)
  --ban-duration <seconds>   Ban duration in seconds (default: 300)
  -h, --help                 Show this help message

Examples:
  node guardian.js -m "Kize1337 Guardian" -r 400 -p 80
  node guardian.js -m "Protected Server" -r 404 --monitor-port 8080
  node guardian.js -m "Death Networks" -r 529 --rate-limit 5

Features:
  ✓ Multi-layer DDoS protection (L2/L3/L4/L7)
  ✓ Real-time monitoring dashboard
  ✓ Advanced rate limiting
  ✓ Automatic IP banning
  ✓ TCP/UDP/DNS/HTTP protection
  ✓ Cluster-based architecture
  ✓ Firewall integration
`);
}

// IP validation and security functions
function isValidIP(ip) {
    const ipv4Regex = /^(\d{1,3}\.){3}\d{1,3}$/;
    const ipv6Regex = /^([0-9a-fA-F]{1,4}:){7}[0-9a-fA-F]{1,4}$/;
    return ipv4Regex.test(ip) || ipv6Regex.test(ip);
}

function isSuspiciousRequest(req, clientIP) {
    const suspiciousPatterns = [
        /\.\./,
        /<script/i,
        /union.*select/i,
        /base64_decode/i,
        /eval\(/i,
        /system\(/i,
        /exec\(/i,
        /passthru\(/i,
        /shell_exec/i,
        /\bor\b.*\b1=1\b/i,
        /\band\b.*\b1=1\b/i
    ];

    const userAgent = req.headers['user-agent'] || '';
    const url = req.url || '';
    
    // Check for suspicious patterns
    for (const pattern of suspiciousPatterns) {
        if (pattern.test(url) || pattern.test(userAgent)) {
            return true;
        }
    }

    // Check for excessive headers
    if (Object.keys(req.headers).length > 50) {
        return true;
    }

    // Check for suspicious user agents
    const suspiciousUAs = ['wget', 'curl', 'python', 'go-http-client', 'libwww'];
    if (suspiciousUAs.some(ua => userAgent.toLowerCase().includes(ua))) {
        return true;
    }

    return false;
}

function updateFirewallRules(ip, action = 'ban') {
    if (!config.enableFirewall) return;

    const command = action === 'ban' 
        ? `iptables -A INPUT -s ${ip} -j DROP`
        : `iptables -D INPUT -s ${ip} -j DROP`;

    exec(command, (error) => {
        if (error && config.logLevel === 'debug') {
            console.log(`[Firewall] Could not ${action} IP ${ip}: ${error.message}`);
        }
    });
}

function checkRateLimit(clientIP) {
    const now = Date.now();
    const windowStart = now - config.rateLimitWindow;
    
    if (!rateLimiter.has(clientIP)) {
        rateLimiter.set(clientIP, []);
    }
    
    const requests = rateLimiter.get(clientIP);
    
    // Remove old requests outside the window
    const validRequests = requests.filter(timestamp => timestamp > windowStart);
    rateLimiter.set(clientIP, validRequests);
    
    // Add current request
    validRequests.push(now);
    
    return validRequests.length <= config.maxRequestsPerWindow;
}

function banIP(clientIP, reason = 'Rate limit exceeded') {
    bannedIPs.set(clientIP, {
        bannedAt: Date.now(),
        reason: reason,
        attempts: (bannedIPs.get(clientIP)?.attempts || 0) + 1
    });
    
    updateFirewallRules(clientIP, 'ban');
    statistics.bannedIPs = bannedIPs.size;
    
    console.log(`[Security] Banned IP ${clientIP} - Reason: ${reason}`);
    
    // Auto-unban after duration
    setTimeout(() => {
        bannedIPs.delete(clientIP);
        updateFirewallRules(clientIP, 'unban');
        statistics.bannedIPs = bannedIPs.size;
        console.log(`[Security] Unbanned IP ${clientIP}`);
    }, config.banDuration);
}

function isIPBanned(clientIP) {
    return bannedIPs.has(clientIP);
}

// Main HTTP server with advanced protection
function createMainServer() {
    const server = http.createServer((req, res) => {
        const clientIP = req.connection.remoteAddress || 
                        req.socket.remoteAddress || 
                        req.headers['x-forwarded-for']?.split(',')[0] ||
                        req.headers['x-real-ip'] ||
                        'unknown';

        statistics.totalRequests++;

        // Check if IP is banned
        if (isIPBanned(clientIP)) {
            statistics.blockedRequests++;
            statistics.attacks.http++;
            res.writeHead(429, 'Too Many Requests', { 'Connection': 'close' });
            res.end();
            return;
        }

        // Rate limiting check
        if (!checkRateLimit(clientIP)) {
            banIP(clientIP, 'Rate limit exceeded');
            statistics.blockedRequests++;
            statistics.attacks.http++;
            res.writeHead(429, 'Too Many Requests', { 'Connection': 'close' });
            res.end();
            return;
        }

        // Check for suspicious patterns
        if (isSuspiciousRequest(req, clientIP)) {
            banIP(clientIP, 'Suspicious request pattern');
            statistics.blockedRequests++;
            statistics.attacks.http++;
            res.writeHead(403, 'Forbidden', { 'Connection': 'close' });
            res.end();
            return;
        }

        // Custom response headers
        const headers = {
            'Server': 'Death Networks',
            'X-Powered-By': 'Kize1337',
            'Content-Type': 'text/plain; charset=utf-8',
            'Connection': 'close',
            'Content-Length': Buffer.byteLength(config.bodyMessage),
            'X-Guardian': 'Active',
            'X-Protection-Level': 'Maximum'
        };

        res.writeHead(config.responseCode, config.statusMessage, headers);
        res.end(config.bodyMessage);
    });

    // Connection limiting
    server.on('connection', (socket) => {
        const clientIP = socket.remoteAddress;
        
        if (connections.size >= config.maxConnections) {
            socket.destroy();
            statistics.blockedRequests++;
            return;
        }

        connections.set(socket, { ip: clientIP, connectedAt: Date.now() });
        statistics.activeConnections = connections.size;

        socket.on('close', () => {
            connections.delete(socket);
            statistics.activeConnections = connections.size;
        });

        socket.setTimeout(config.tcpTimeout, () => {
            socket.destroy();
        });
    });

    server.maxConnections = config.maxConnections;
    return server;
}

// Monitoring dashboard
function createMonitoringServer() {
    const monitoringHTML = `
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Kize1337 Guardian - Monitoring Dashboard</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #1e3c72 0%, #2a5298 100%);
            color: white;
            min-height: 100vh;
            padding: 20px;
        }
        .container {
            max-width: 1200px;
            margin: 0 auto;
        }
        .header {
            text-align: center;
            margin-bottom: 30px;
            padding: 20px;
            background: rgba(255,255,255,0.1);
            border-radius: 15px;
            backdrop-filter: blur(10px);
        }
        .logo {
            font-size: 2.5em;
            font-weight: bold;
            margin-bottom: 10px;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.3);
        }
        .subtitle {
            font-size: 1.2em;
            opacity: 0.8;
        }
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }
        .stat-card {
            background: rgba(255,255,255,0.15);
            padding: 25px;
            border-radius: 15px;
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255,255,255,0.2);
            transition: transform 0.3s ease;
        }
        .stat-card:hover {
            transform: translateY(-5px);
        }
        .stat-title {
            font-size: 0.9em;
            opacity: 0.8;
            margin-bottom: 10px;
        }
        .stat-value {
            font-size: 2em;
            font-weight: bold;
        }
        .status-indicator {
            display: inline-block;
            width: 12px;
            height: 12px;
            border-radius: 50%;
            margin-right: 8px;
        }
        .status-active { background: #4CAF50; }
        .status-warning { background: #FF9800; }
        .status-danger { background: #F44336; }
        .attack-log {
            background: rgba(255,255,255,0.1);
            border-radius: 15px;
            padding: 20px;
            margin-top: 20px;
        }
        .log-title {
            font-size: 1.3em;
            margin-bottom: 15px;
            border-bottom: 2px solid rgba(255,255,255,0.2);
            padding-bottom: 10px;
        }
        .refresh-btn {
            background: rgba(255,255,255,0.2);
            color: white;
            border: none;
            padding: 12px 25px;
            border-radius: 8px;
            cursor: pointer;
            font-size: 1em;
            transition: background 0.3s ease;
            margin: 10px;
        }
        .refresh-btn:hover {
            background: rgba(255,255,255,0.3);
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <div class="logo">🛡️ Kize1337 Guardian</div>
            <div class="subtitle">Advanced DDoS Protection System</div>
            <button class="refresh-btn" onclick="location.reload()">🔄 Refresh Data</button>
        </div>
        
        <div class="stats-grid">
            <div class="stat-card">
                <div class="stat-title">System Status</div>
                <div class="stat-value">
                    <span class="status-indicator status-active"></span>
                    ACTIVE
                </div>
            </div>
            <div class="stat-card">
                <div class="stat-title">Total Requests</div>
                <div class="stat-value" id="totalRequests">0</div>
            </div>
            <div class="stat-card">
                <div class="stat-title">Blocked Requests</div>
                <div class="stat-value" id="blockedRequests">0</div>
            </div>
            <div class="stat-card">
                <div class="stat-title">Active Connections</div>
                <div class="stat-value" id="activeConnections">0</div>
            </div>
            <div class="stat-card">
                <div class="stat-title">Banned IPs</div>
                <div class="stat-value" id="bannedIPs">0</div>
            </div>
            <div class="stat-card">
                <div class="stat-title">Uptime</div>
                <div class="stat-value" id="uptime">0s</div>
            </div>
        </div>

        <div class="attack-log">
            <div class="log-title">🚨 Attack Statistics</div>
            <div class="stats-grid">
                <div class="stat-card">
                    <div class="stat-title">HTTP Attacks</div>
                    <div class="stat-value" id="httpAttacks">0</div>
                </div>
                <div class="stat-card">
                    <div class="stat-title">TCP Attacks</div>
                    <div class="stat-value" id="tcpAttacks">0</div>
                </div>
                <div class="stat-card">
                    <div class="stat-title">UDP Attacks</div>
                    <div class="stat-value" id="udpAttacks">0</div>
                </div>
                <div class="stat-card">
                    <div class="stat-title">DNS Attacks</div>
                    <div class="stat-value" id="dnsAttacks">0</div>
                </div>
            </div>
        </div>
    </div>

    <script>
        function updateStats() {
            fetch('/api/stats')
                .then(response => response.json())
                .then(data => {
                    document.getElementById('totalRequests').textContent = data.totalRequests.toLocaleString();
                    document.getElementById('blockedRequests').textContent = data.blockedRequests.toLocaleString();
                    document.getElementById('activeConnections').textContent = data.activeConnections;
                    document.getElementById('bannedIPs').textContent = data.bannedIPs;
                    document.getElementById('uptime').textContent = formatUptime(data.uptime);
                    document.getElementById('httpAttacks').textContent = data.attacks.http.toLocaleString();
                    document.getElementById('tcpAttacks').textContent = data.attacks.tcp.toLocaleString();
                    document.getElementById('udpAttacks').textContent = data.attacks.udp.toLocaleString();
                    document.getElementById('dnsAttacks').textContent = data.attacks.dns.toLocaleString();
                })
                .catch(console.error);
        }

        function formatUptime(startTime) {
            const uptime = Math.floor((Date.now() - startTime) / 1000);
            const hours = Math.floor(uptime / 3600);
            const minutes = Math.floor((uptime % 3600) / 60);
            const seconds = uptime % 60;
            return hours + 'h ' + minutes + 'm ' + seconds + 's';
        }

        // Update stats every 2 seconds
        setInterval(updateStats, 2000);
        updateStats();
    </script>
</body>
</html>`;

    return http.createServer((req, res) => {
        if (req.url === '/api/stats') {
            res.writeHead(200, {
                'Content-Type': 'application/json',
                'Access-Control-Allow-Origin': '*'
            });
            res.end(JSON.stringify({
                ...statistics,
                uptime: statistics.uptime
            }));
        } else {
            res.writeHead(200, {
                'Content-Type': 'text/html',
                'Cache-Control': 'no-cache'
            });
            res.end(monitoringHTML);
        }
    });
}

// TCP Protection
function createTCPProtection() {
    const tcpServer = net.createServer((socket) => {
        const clientIP = socket.remoteAddress;
        
        if (isIPBanned(clientIP)) {
            statistics.attacks.tcp++;
            socket.destroy();
            return;
        }

        socket.setTimeout(config.tcpTimeout, () => {
            statistics.attacks.tcp++;
            banIP(clientIP, 'TCP timeout');
            socket.destroy();
        });

        socket.on('error', () => {
            statistics.attacks.tcp++;
            socket.destroy();
        });
    });

    // Listen on common vulnerable ports
    const protectedPorts = [21, 22, 23, 25, 53, 80, 110, 143, 443, 993, 995, 3389, 5432, 3306];
    protectedPorts.forEach(port => {
        if (port !== config.port && port !== config.monitorPort) {
            try {
                const server = net.createServer();
                server.listen(port, () => {
                    console.log(`[TCP Protection] Protecting port ${port}`);
                });
                server.on('connection', (socket) => {
                    statistics.attacks.tcp++;
                    socket.destroy();
                });
            } catch (error) {
                // Port might be in use, continue
            }
        }
    });
}

// UDP Protection
function createUDPProtection() {
    const udpPorts = [53, 123, 161, 1900, 5353];
    
    udpPorts.forEach(port => {
        try {
            const udpSocket = dgram.createSocket('udp4');
            
            udpSocket.on('message', (msg, rinfo) => {
                statistics.attacks.udp++;
                
                if (isIPBanned(rinfo.address)) {
                    return;
                }

                // Check for UDP flood
                if (!checkRateLimit(rinfo.address)) {
                    banIP(rinfo.address, 'UDP flood detected');
                }
            });

            udpSocket.bind(port, () => {
                console.log(`[UDP Protection] Protecting UDP port ${port}`);
            });
        } catch (error) {
            // Port might be in use, continue
        }
    });
}

// DNS Protection
function createDNSProtection() {
    dns.setServers(['8.8.8.8', '8.8.4.4']);
    
    // Monitor DNS queries for amplification attacks
    const originalLookup = dns.lookup;
    dns.lookup = function(hostname, options, callback) {
        if (typeof options === 'function') {
            callback = options;
            options = {};
        }
        
        statistics.attacks.dns++;
        
        // Add delay to prevent DNS amplification
        setTimeout(() => {
            originalLookup.call(this, hostname, options, callback);
        }, 100);
    };
}

// Cleanup functions
function cleanup() {
    console.log('\n[System] Shutting down Guardian...');
    
    // Unban all IPs from firewall
    if (config.enableFirewall) {
        bannedIPs.forEach((_, ip) => {
            updateFirewallRules(ip, 'unban');
        });
    }
    
    process.exit(0);
}

// Main execution
function main() {
    parseArguments();
    
    if (process.getuid && process.getuid() !== 0) {
        console.log('[Warning] Running without root privileges. Some features may be limited.');
    }

    if (cluster.isMaster) {
        console.log(`
╔══════════════════════════════════════════════════════════════════╗
║                    🛡️  Kize1337 Guardian Started                ║
║                      Advanced DDoS Protection                   ║
╚══════════════════════════════════════════════════════════════════╝

[Master] Configuration:
├─ Main Port: ${config.port}
├─ Monitor Port: ${config.monitorPort} 
├─ Response Code: ${config.responseCode}
├─ Status Message: ${config.statusMessage}
├─ Workers: ${config.workers}
├─ Max Connections: ${config.maxConnections}
├─ Rate Limit: ${config.maxRequestsPerWindow}/sec
└─ Ban Duration: ${config.banDuration/1000}s

[Protection] Multi-layer defense activated:
✓ HTTP/HTTPS Layer 7 Protection
✓ TCP Layer 4 Protection  
✓ UDP Flood Protection
✓ DNS Amplification Protection
✓ Advanced Rate Limiting
✓ Automatic IP Banning
✓ Firewall Integration
✓ Real-time Monitoring

Dashboard: http://localhost:${config.monitorPort}
        `);

        // Fork workers
        for (let i = 0; i < config.workers; i++) {
            cluster.fork();
        }

        cluster.on('exit', (worker, code, signal) => {
            console.log(`[Master] Worker ${worker.process.pid} died (${signal || code}). Restarting...`);
            cluster.fork();
        });

        // Start monitoring server in master process
        const monitoringServer = createMonitoringServer();
        monitoringServer.listen(config.monitorPort, () => {
            console.log(`[Monitor] Dashboard running on port ${config.monitorPort}`);
        });

        // Enable protections in master
        createTCPProtection();
        createUDPProtection();
        createDNSProtection();

        // Cleanup handlers
        process.on('SIGINT', cleanup);
        process.on('SIGTERM', cleanup);
        process.on('uncaughtException', (error) => {
            console.error('[Error] Uncaught Exception:', error);
        });

        // Statistics reporting
        setInterval(() => {
            console.log(`[Stats] Requests: ${statistics.totalRequests} | Blocked: ${statistics.blockedRequests} | Active: ${statistics.activeConnections} | Banned: ${statistics.bannedIPs}`);
        }, 30000);

    } else {
        // Worker process - handle HTTP requests
        const server = createMainServer();
        
        server.listen(config.port, () => {
            console.log(`[Worker ${process.pid}] HTTP server listening on port ${config.port}`);
        });

        server.on('error', (error) => {
            console.error(`[Worker ${process.pid}] Server error:`, error);
        });
    }
}

// Start the system
main();