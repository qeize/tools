#!/usr/bin/env node
const http = require('http');
const https = require('https');
const cluster = require('cluster');
const os = require('os');
const fs = require('fs');
const path = require('path');
const { URL } = require('url');

// Configuration
const config = {
    port: 80,
    monitorPort: 8080,
    responseCode: 529,
    statusMessage: "Service Temporarily Overloaded",
    bodyMessage: "Kize1337 Guardian\nProtected by Advanced DDoS Protection",
    workers: os.cpus().length,
    maxRequestsPerMinute: 60,
    maxRequestsPerSecond: 10,
    maxConnections: 1000,
    banDuration: 300000, // 5 minutes
    whitelistIPs: ['127.0.0.1', '::1'],
    suspiciousPatterns: [
        /bot/i, /crawler/i, /spider/i, /scraper/i,
        /sqlmap/i, /nmap/i, /masscan/i, /zap/i,
        /nikto/i, /dirb/i, /gobuster/i, /wfuzz/i
    ],
    blockedUserAgents: [
        '', 'null', 'undefined', '-',
        'python-requests', 'curl', 'wget'
    ]
};

// Global storage for rate limiting and monitoring
const rateLimiter = new Map();
const bannedIPs = new Map();
const connectionCount = new Map();
const stats = {
    totalRequests: 0,
    blockedRequests: 0,
    bannedIPs: 0,
    startTime: Date.now(),
    requestsPerSecond: 0,
    lastSecondRequests: 0,
    lastSecondTime: Math.floor(Date.now() / 1000)
};

// Parse command line arguments
function parseArguments() {
    const args = process.argv.slice(2);
    
    if (args.length === 0 || args.includes('-h') || args.includes('--help')) {
        showUsage();
        process.exit(0);
    }

    for (let i = 0; i < args.length; i++) {
        switch (args[i]) {
            case '-p':
            case '--port':
                config.port = parseInt(args[i + 1]) || 80;
                i++;
                break;
            case '-mp':
            case '--monitor-port':
                config.monitorPort = parseInt(args[i + 1]) || 8080;
                i++;
                break;
            case '-r':
            case '--response-code':
                config.responseCode = parseInt(args[i + 1]) || 529;
                i++;
                break;
            case '-m':
            case '--message':
                config.bodyMessage = args[i + 1] || config.bodyMessage;
                i++;
                break;
            case '--status-message':
                config.statusMessage = args[i + 1] || config.statusMessage;
                i++;
                break;
            case '--max-rpm':
                config.maxRequestsPerMinute = parseInt(args[i + 1]) || 60;
                i++;
                break;
            case '--max-rps':
                config.maxRequestsPerSecond = parseInt(args[i + 1]) || 10;
                i++;
                break;
        }
    }
}

function showUsage() {
    console.log(`
╔═══════════════════════════════════════════════════════════════╗
║                    Kize1337 Guardian v2.0                    ║
║              Advanced Anti-DDoS Protection System            ║
╚═══════════════════════════════════════════════════════════════╝

USAGE:
  node guardian.js [OPTIONS]

OPTIONS:
  -p,  --port <number>          Main server port (default: 80)
  -mp, --monitor-port <number>  Monitoring dashboard port (default: 8080)
  -r,  --response-code <number> HTTP response code (default: 529)
  -m,  --message <string>       Custom response message
       --status-message <string> Custom status message
       --max-rpm <number>        Max requests per minute per IP (default: 60)
       --max-rps <number>        Max requests per second per IP (default: 10)
  -h,  --help                   Show this help message

EXAMPLES:
  node guardian.js
  node guardian.js -p 80 -mp 8080 -r 404 -m "Access Denied by Kize1337"
  node guardian.js --port 443 --response-code 529 --message "Protected Zone"

MONITORING:
  Access monitoring dashboard at: http://your-server:8080
  Real-time statistics and banned IPs management available.
`);
}

// IP validation and checking functions
function isValidIP(ip) {
    const ipv4Regex = /^(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$/;
    const ipv6Regex = /^(?:[0-9a-fA-F]{1,4}:){7}[0-9a-fA-F]{1,4}$/;
    return ipv4Regex.test(ip) || ipv6Regex.test(ip);
}

function getClientIP(req) {
    return req.headers['x-forwarded-for']?.split(',')[0]?.trim() ||
           req.headers['x-real-ip'] ||
           req.connection.remoteAddress ||
           req.socket.remoteAddress ||
           (req.connection.socket ? req.connection.socket.remoteAddress : null) ||
           '0.0.0.0';
}

function isSuspiciousRequest(req, clientIP) {
    const userAgent = req.headers['user-agent'] || '';
    const referer = req.headers['referer'] || '';
    
    // Check blocked user agents
    if (config.blockedUserAgents.includes(userAgent.toLowerCase())) {
        return 'Blocked User Agent';
    }
    
    // Check suspicious patterns
    for (const pattern of config.suspiciousPatterns) {
        if (pattern.test(userAgent) || pattern.test(referer)) {
            return 'Suspicious Pattern Detected';
        }
    }
    
    // Check for missing essential headers
    if (!userAgent && req.method !== 'HEAD') {
        return 'Missing User Agent';
    }
    
    // Check for suspicious methods
    const suspiciousMethods = ['TRACE', 'TRACK', 'DEBUG', 'OPTIONS'];
    if (suspiciousMethods.includes(req.method)) {
        return 'Suspicious HTTP Method';
    }
    
    // Check for SQL injection patterns in URL
    const sqlPatterns = [/union.*select/i, /script.*alert/i, /'.*or.*'/i, /drop.*table/i];
    for (const pattern of sqlPatterns) {
        if (pattern.test(req.url)) {
            return 'SQL Injection Attempt';
        }
    }
    
    return null;
}

function checkRateLimit(clientIP) {
    const now = Date.now();
    const currentSecond = Math.floor(now / 1000);
    
    if (!rateLimiter.has(clientIP)) {
        rateLimiter.set(clientIP, {
            requests: [],
            secondlyCount: 0,
            lastSecond: currentSecond
        });
    }
    
    const ipData = rateLimiter.get(clientIP);
    
    // Reset secondly counter if new second
    if (ipData.lastSecond !== currentSecond) {
        ipData.secondlyCount = 0;
        ipData.lastSecond = currentSecond;
    }
    
    // Check per-second limit
    ipData.secondlyCount++;
    if (ipData.secondlyCount > config.maxRequestsPerSecond) {
        return 'Rate limit exceeded (per second)';
    }
    
    // Clean old requests (older than 1 minute)
    ipData.requests = ipData.requests.filter(time => now - time < 60000);
    
    // Check per-minute limit
    if (ipData.requests.length >= config.maxRequestsPerMinute) {
        return 'Rate limit exceeded (per minute)';
    }
    
    ipData.requests.push(now);
    return null;
}

function banIP(ip, reason) {
    bannedIPs.set(ip, {
        bannedAt: Date.now(),
        reason: reason,
        attempts: (bannedIPs.get(ip)?.attempts || 0) + 1
    });
    
    // Auto-unban after duration
    setTimeout(() => {
        bannedIPs.delete(ip);
    }, config.banDuration);
    
    stats.bannedIPs = bannedIPs.size;
    console.log(`[SECURITY] IP ${ip} banned for: ${reason}`);
}

function createMainServer() {
    return http.createServer((req, res) => {
        const clientIP = getClientIP(req);
        stats.totalRequests++;
        
        // Update requests per second counter
        const currentSecond = Math.floor(Date.now() / 1000);
        if (stats.lastSecondTime !== currentSecond) {
            stats.requestsPerSecond = stats.lastSecondRequests;
            stats.lastSecondRequests = 1;
            stats.lastSecondTime = currentSecond;
        } else {
            stats.lastSecondRequests++;
        }
        
        // Check if IP is whitelisted
        if (config.whitelistIPs.includes(clientIP)) {
            return handleLegitimateRequest(req, res);
        }
        
        // Check if IP is banned
        if (bannedIPs.has(clientIP)) {
            stats.blockedRequests++;
            return sendProtectionResponse(res, 'IP Banned');
        }
        
        // Validate IP
        if (!isValidIP(clientIP)) {
            stats.blockedRequests++;
            banIP(clientIP, 'Invalid IP Address');
            return sendProtectionResponse(res, 'Invalid IP');
        }
        
        // Check for suspicious request
        const suspiciousReason = isSuspiciousRequest(req, clientIP);
        if (suspiciousReason) {
            stats.blockedRequests++;
            banIP(clientIP, suspiciousReason);
            return sendProtectionResponse(res, suspiciousReason);
        }
        
        // Check rate limiting
        const rateLimitReason = checkRateLimit(clientIP);
        if (rateLimitReason) {
            stats.blockedRequests++;
            banIP(clientIP, rateLimitReason);
            return sendProtectionResponse(res, rateLimitReason);
        }
        
        // Track connections
        const currentConnections = connectionCount.get(clientIP) || 0;
        if (currentConnections >= 10) { // Max 10 concurrent connections per IP
            stats.blockedRequests++;
            banIP(clientIP, 'Too many concurrent connections');
            return sendProtectionResponse(res, 'Connection Limit');
        }
        
        connectionCount.set(clientIP, currentConnections + 1);
        
        // Clean up connection count when response ends
        res.on('close', () => {
            const count = connectionCount.get(clientIP) || 0;
            if (count <= 1) {
                connectionCount.delete(clientIP);
            } else {
                connectionCount.set(clientIP, count - 1);
            }
        });
        
        // If all checks pass, still send protection response
        sendProtectionResponse(res, 'Protected');
    });
}

function handleLegitimateRequest(req, res) {
    // This is where you would handle legitimate requests
    // For now, we'll just send the protection response
    sendProtectionResponse(res, 'Whitelisted Access');
}

function sendProtectionResponse(res, reason) {
    const headers = {
        'Server': 'Kize1337-Guardian/2.0',
        'X-Powered-By': 'Advanced-DDoS-Protection',
        'X-Protection': 'Kize1337-Guardian',
        'X-Block-Reason': reason,
        'Content-Type': 'text/plain; charset=utf-8',
        'Connection': 'close',
        'Cache-Control': 'no-cache, no-store, must-revalidate',
        'Pragma': 'no-cache',
        'Expires': '0',
        'Content-Length': Buffer.byteLength(config.bodyMessage)
    };
    
    try {
        res.writeHead(config.responseCode, config.statusMessage, headers);
        res.end(config.bodyMessage);
    } catch (error) {
        console.error('[ERROR] Failed to send response:', error.message);
    }
}

function createMonitoringServer() {
    return http.createServer((req, res) => {
        if (req.url === '/api/stats') {
            res.writeHead(200, {
                'Content-Type': 'application/json',
                'Access-Control-Allow-Origin': '*'
            });
            
            const uptime = Date.now() - stats.startTime;
            const statsData = {
                ...stats,
                uptime: Math.floor(uptime / 1000),
                bannedIPsList: Array.from(bannedIPs.entries()).map(([ip, data]) => ({
                    ip,
                    ...data,
                    timeLeft: Math.max(0, config.banDuration - (Date.now() - data.bannedAt))
                })),
                rateLimiterSize: rateLimiter.size,
                activeConnections: Array.from(connectionCount.entries()).reduce((sum, [, count]) => sum + count, 0)
            };
            
            res.end(JSON.stringify(statsData, null, 2));
        } else {
            // Serve monitoring dashboard
            res.writeHead(200, { 'Content-Type': 'text/html' });
            res.end(getMonitoringHTML());
        }
    });
}

function getMonitoringHTML() {
    return `<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Kize1337 Guardian - Monitoring Dashboard</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { 
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: #fff; min-height: 100vh; padding: 20px;
        }
        .container { max-width: 1200px; margin: 0 auto; }
        .header { text-align: center; margin-bottom: 30px; }
        .header h1 { font-size: 2.5em; margin-bottom: 10px; text-shadow: 2px 2px 4px rgba(0,0,0,0.3); }
        .header p { font-size: 1.2em; opacity: 0.9; }
        .stats-grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(250px, 1fr)); gap: 20px; margin-bottom: 30px; }
        .stat-card { 
            background: rgba(255,255,255,0.1); backdrop-filter: blur(10px);
            border-radius: 15px; padding: 25px; text-align: center;
            border: 1px solid rgba(255,255,255,0.2); transition: transform 0.3s ease;
        }
        .stat-card:hover { transform: translateY(-5px); }
        .stat-value { font-size: 2.5em; font-weight: bold; margin-bottom: 10px; }
        .stat-label { font-size: 1.1em; opacity: 0.8; }
        .banned-ips { 
            background: rgba(255,255,255,0.1); backdrop-filter: blur(10px);
            border-radius: 15px; padding: 25px; border: 1px solid rgba(255,255,255,0.2);
        }
        .banned-ips h3 { margin-bottom: 20px; font-size: 1.5em; }
        .banned-ip { 
            display: flex; justify-content: space-between; align-items: center;
            padding: 10px; margin: 5px 0; background: rgba(255,255,255,0.05);
            border-radius: 8px; border-left: 4px solid #ff6b6b;
        }
        .ip-info { flex-grow: 1; }
        .ip-address { font-weight: bold; }
        .ip-reason { font-size: 0.9em; opacity: 0.8; margin-top: 2px; }
        .ip-time { font-size: 0.8em; opacity: 0.7; }
        .status { display: inline-block; padding: 5px 15px; border-radius: 20px; font-size: 0.9em; font-weight: bold; }
        .status.active { background: #4CAF50; }
        .status.protected { background: #FF9800; }
        .refresh { position: fixed; bottom: 20px; right: 20px; }
        .refresh button { 
            background: rgba(255,255,255,0.2); border: none; color: white;
            padding: 15px 20px; border-radius: 50px; cursor: pointer;
            font-size: 1em; backdrop-filter: blur(10px);
            border: 1px solid rgba(255,255,255,0.3); transition: all 0.3s ease;
        }
        .refresh button:hover { background: rgba(255,255,255,0.3); transform: scale(1.05); }
        .config-info { 
            background: rgba(255,255,255,0.1); backdrop-filter: blur(10px);
            border-radius: 15px; padding: 20px; margin-bottom: 20px;
            border: 1px solid rgba(255,255,255,0.2);
        }
        .config-grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 15px; }
        .config-item { text-align: center; }
        .config-value { font-size: 1.3em; font-weight: bold; }
        .config-label { font-size: 0.9em; opacity: 0.8; }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>🛡️ Kize1337 Guardian</h1>
            <p>Advanced Anti-DDoS Protection System</p>
            <span class="status active">ACTIVE PROTECTION</span>
        </div>
        
        <div class="config-info">
            <h3 style="margin-bottom: 15px; text-align: center;">⚙️ Configuration</h3>
            <div class="config-grid">
                <div class="config-item">
                    <div class="config-value">${config.port}</div>
                    <div class="config-label">Main Port</div>
                </div>
                <div class="config-item">
                    <div class="config-value">${config.responseCode}</div>
                    <div class="config-label">Response Code</div>
                </div>
                <div class="config-item">
                    <div class="config-value">${config.maxRequestsPerSecond}</div>
                    <div class="config-label">Max RPS</div>
                </div>
                <div class="config-item">
                    <div class="config-value">${config.maxRequestsPerMinute}</div>
                    <div class="config-label">Max RPM</div>
                </div>
            </div>
        </div>
        
        <div class="stats-grid" id="stats-grid">
            <!-- Stats will be populated by JavaScript -->
        </div>
        
        <div class="banned-ips">
            <h3>🚫 Banned IPs</h3>
            <div id="banned-list">
                <!-- Banned IPs will be populated by JavaScript -->
            </div>
        </div>
    </div>
    
    <div class="refresh">
        <button onclick="updateStats()">🔄 Refresh</button>
    </div>
    
    <script>
        function formatUptime(seconds) {
            const days = Math.floor(seconds / 86400);
            const hours = Math.floor((seconds % 86400) / 3600);
            const minutes = Math.floor((seconds % 3600) / 60);
            const secs = seconds % 60;
            
            if (days > 0) return \`\${days}d \${hours}h \${minutes}m\`;
            if (hours > 0) return \`\${hours}h \${minutes}m \${secs}s\`;
            if (minutes > 0) return \`\${minutes}m \${secs}s\`;
            return \`\${secs}s\`;
        }
        
        function formatTime(ms) {
            const seconds = Math.floor(ms / 1000);
            const minutes = Math.floor(seconds / 60);
            if (minutes > 0) return \`\${minutes}m \${seconds % 60}s\`;
            return \`\${seconds}s\`;
        }
        
        function updateStats() {
            fetch('/api/stats')
                .then(response => response.json())
                .then(data => {
                    // Update stats grid
                    const statsGrid = document.getElementById('stats-grid');
                    statsGrid.innerHTML = \`
                        <div class="stat-card">
                            <div class="stat-value">\${data.totalRequests.toLocaleString()}</div>
                            <div class="stat-label">Total Requests</div>
                        </div>
                        <div class="stat-card">
                            <div class="stat-value" style="color: #ff6b6b">\${data.blockedRequests.toLocaleString()}</div>
                            <div class="stat-label">Blocked Requests</div>
                        </div>
                        <div class="stat-card">
                            <div class="stat-value" style="color: #4CAF50">\${data.requestsPerSecond}</div>
                            <div class="stat-label">Requests/Second</div>
                        </div>
                        <div class="stat-card">
                            <div class="stat-value" style="color: #FFA726">\${data.bannedIPs}</div>
                            <div class="stat-label">Banned IPs</div>
                        </div>
                        <div class="stat-card">
                            <div class="stat-value" style="color: #42A5F5">\${formatUptime(data.uptime)}</div>
                            <div class="stat-label">Uptime</div>
                        </div>
                        <div class="stat-card">
                            <div class="stat-value" style="color: #AB47BC">\${data.activeConnections}</div>
                            <div class="stat-label">Active Connections</div>
                        </div>
                    \`;
                    
                    // Update banned IPs list
                    const bannedList = document.getElementById('banned-list');
                    if (data.bannedIPsList.length === 0) {
                        bannedList.innerHTML = '<p style="text-align: center; opacity: 0.7; padding: 20px;">No banned IPs</p>';
                    } else {
                        bannedList.innerHTML = data.bannedIPsList.map(item => \`
                            <div class="banned-ip">
                                <div class="ip-info">
                                    <div class="ip-address">\${item.ip}</div>
                                    <div class="ip-reason">\${item.reason}</div>
                                </div>
                                <div class="ip-time">
                                    \${item.timeLeft > 0 ? formatTime(item.timeLeft) + ' left' : 'Expired'}
                                </div>
                            </div>
                        \`).join('');
                    }
                })
                .catch(error => console.error('Error updating stats:', error));
        }
        
        // Auto-refresh every 2 seconds
        setInterval(updateStats, 2000);
        updateStats(); // Initial load
    </script>
</body>
</html>`;
}

// Cleanup functions
function cleanup() {
    const now = Date.now();
    
    // Clean expired bans
    for (const [ip, data] of bannedIPs.entries()) {
        if (now - data.bannedAt > config.banDuration) {
            bannedIPs.delete(ip);
        }
    }
    
    // Clean old rate limit data
    for (const [ip, data] of rateLimiter.entries()) {
        data.requests = data.requests.filter(time => now - time < 60000);
        if (data.requests.length === 0 && now - data.lastSecond * 1000 > 60000) {
            rateLimiter.delete(ip);
        }
    }
    
    stats.bannedIPs = bannedIPs.size;
}

// Main execution
if (require.main === module) {
    parseArguments();
    
    if (cluster.isMaster) {
        console.log(`
╔═══════════════════════════════════════════════════════════════╗
║                    Kize1337 Guardian v2.0                    ║
║              Advanced Anti-DDoS Protection System            ║
╚═══════════════════════════════════════════════════════════════╝
        `);
        
        console.log(`[MASTER] Starting with configuration:`);
        console.log(`  • Main Port: ${config.port}`);
        console.log(`  • Monitor Port: ${config.monitorPort}`);
        console.log(`  • Response Code: ${config.responseCode}`);
        console.log(`  • Status Message: ${config.statusMessage}`);
        console.log(`  • Workers: ${config.workers}`);
        console.log(`  • Max RPM: ${config.maxRequestsPerMinute}`);
        console.log(`  • Max RPS: ${config.maxRequestsPerSecond}`);
        console.log(`  • Ban Duration: ${config.banDuration / 1000}s`);
        console.log(`  • Body Message: ${config.bodyMessage}`);
        
        // Start monitoring server (only on master)
        const monitorServer = createMonitoringServer();
        monitorServer.listen(config.monitorPort, () => {
            console.log(`[MONITOR] Dashboard available at: http://localhost:${config.monitorPort}`);
        });
        
        // Fork workers for main server
        for (let i = 0; i < config.workers; i++) {
            cluster.fork();
        }
        
        cluster.on('exit', (worker, code, signal) => {
            console.log(`[MASTER] Worker ${worker.process.pid} died (${signal || code}). Restarting...`);
            cluster.fork();
        });
        
        // Cleanup routine
        setInterval(cleanup, 30000); // Clean every 30 seconds
        
        // Graceful shutdown
        process.on('SIGTERM', () => {
            console.log('[MASTER] Received SIGTERM, shutting down gracefully...');
            process.exit(0);
        });
        
        process.on('SIGINT', () => {
            console.log('\n[MASTER] Received SIGINT, shutting down gracefully...');
            process.exit(0);
        });
        
    } else {
        // Worker process - handle main server
        const server = createMainServer();
        
        server.listen(config.port, () => {
            console.log(`[WORKER ${process.pid}] Protection server listening on port ${config.port}`);
        });
        
        server.on('error', (error) => {
            console.error(`[WORKER ${process.pid}] Server error:`, error.message);
        });
    }
}

module.exports = { createMainServer, createMonitoringServer, config };