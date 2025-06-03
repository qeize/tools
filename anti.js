#!/usr/bin/env node

const http = require('http');
const https = require('https');
const net = require('net');
const cluster = require('cluster');
const os = require('os');
const fs = require('fs');
const path = require('path');
const crypto = require('crypto');
const { execSync } = require('child_process');

// Configuration
const CONFIG = {
    maxRequestsPerIP: 10,
    windowMs: 60000, // 1 minute
    maxConcurrentConnections: 100,
    suspiciousPatterns: [
        /bot/i, /crawler/i, /spider/i, /scanner/i, /hack/i,
        /null/i, /union/i, /select/i, /script/i, /alert/i,
        /eval/i, /exec/i, /javascript:/i, /vbscript:/i
    ],
    blockedCountries: ['CN', 'RU', 'KP'], // Example blocked countries
    monitorPort: 80,
    customMessage: 'Kize1337 Guardian',
    responseCode: 529
};

// Global tracking objects
const ipTracker = new Map();
const connectionTracker = new Map();
const blockedIPs = new Set();
const statistics = {
    totalRequests: 0,
    blockedRequests: 0,
    suspiciousRequests: 0,
    startTime: Date.now(),
    currentConnections: 0
};

// Command line argument parsing
function parseArguments() {
    const args = process.argv.slice(2);
    
    if (args.length === 0) {
        console.log(`
╔══════════════════════════════════════════════════════════════╗
║                    KIZE1337 GUARDIAN                         ║
║                 Anti-DDoS Protection System                  ║
╠══════════════════════════════════════════════════════════════╣
║                                                              ║
║  Usage: node guardian.js [options]                           ║
║                                                              ║
║  Options:                                                    ║
║    -m, --message <text>     Custom HTTP response message    ║
║    -r, --response <code>    HTTP response code (default:529)║
║    -p, --port <number>      Monitor web port (default: 80)  ║
║    -h, --help              Show this help message           ║
║                                                              ║
║  Examples:                                                   ║
║    node guardian.js -m "Kize1337 Guardian" -r 529 -p 80     ║
║    node guardian.js -m "Access Denied" -r 403 -p 8080       ║
║    node guardian.js --help                                   ║
║                                                              ║
║  Default Configuration:                                      ║
║    • Max requests per IP: 10/minute                          ║
║    • Max concurrent connections: 100                         ║
║    • Monitoring port: 80                                     ║
║    • Response code: 529                                      ║
║                                                              ║
╚══════════════════════════════════════════════════════════════╝
        `);
        process.exit(0);
    }

    for (let i = 0; i < args.length; i++) {
        switch (args[i]) {
            case '-m':
            case '--message':
                CONFIG.customMessage = args[++i] || 'Kize1337 Guardian';
                break;
            case '-r':
            case '--response':
                CONFIG.responseCode = parseInt(args[++i]) || 529;
                break;
            case '-p':
            case '--port':
                CONFIG.monitorPort = parseInt(args[++i]) || 80;
                break;
            case '-h':
            case '--help':
                parseArguments.call({ argv: [] });
                break;
        }
    }
}

// IP address utilities
function getClientIP(req) {
    return req.headers['x-forwarded-for']?.split(',')[0]?.trim() ||
           req.headers['x-real-ip'] ||
           req.connection?.remoteAddress ||
           req.socket?.remoteAddress ||
           req.connection?.socket?.remoteAddress ||
           '127.0.0.1';
}

function isPrivateIP(ip) {
    const privateRanges = [
        /^10\./,
        /^172\.(1[6-9]|2[0-9]|3[0-1])\./,
        /^192\.168\./,
        /^127\./,
        /^169\.254\./,
        /^::1$/,
        /^fc00:/,
        /^fe80:/
    ];
    return privateRanges.some(range => range.test(ip));
}

// Rate limiting
function isRateLimited(ip) {
    if (isPrivateIP(ip)) return false;
    
    const now = Date.now();
    const tracker = ipTracker.get(ip) || { requests: [], firstRequest: now };
    
    // Clean old requests
    tracker.requests = tracker.requests.filter(time => now - time < CONFIG.windowMs);
    
    if (tracker.requests.length >= CONFIG.maxRequestsPerIP) {
        blockedIPs.add(ip);
        return true;
    }
    
    tracker.requests.push(now);
    tracker.firstRequest = tracker.firstRequest || now;
    ipTracker.set(ip, tracker);
    
    return false;
}

// Suspicious pattern detection
function hasSuspiciousPatterns(req) {
    const checkString = `${req.url} ${req.headers['user-agent'] || ''} ${JSON.stringify(req.headers)}`;
    return CONFIG.suspiciousPatterns.some(pattern => pattern.test(checkString));
}

// DDoS Detection
function isDDoSAttack(ip) {
    const tracker = ipTracker.get(ip);
    if (!tracker) return false;
    
    const now = Date.now();
    const requestsInLastMinute = tracker.requests.filter(time => now - time < 60000).length;
    const requestsInLast5Seconds = tracker.requests.filter(time => now - time < 5000).length;
    
    return requestsInLastMinute > 50 || requestsInLast5Seconds > 10;
}

// Firewall integration
function blockIPWithFirewall(ip) {
    if (isPrivateIP(ip)) return;
    
    try {
        // Add to iptables
        execSync(`iptables -I INPUT -s ${ip} -j DROP 2>/dev/null || true`);
        // Add to ipset if available
        execSync(`ipset add blacklist ${ip} 2>/dev/null || true`);
        console.log(`🚫 Blocked IP ${ip} at firewall level`);
    } catch (error) {
        console.log(`⚠️  Could not block IP ${ip} at firewall level: ${error.message}`);
    }
}

// Main request handler
function handleRequest(req, res) {
    const ip = getClientIP(req);
    const userAgent = req.headers['user-agent'] || '';
    const timestamp = new Date().toISOString();
    
    statistics.totalRequests++;
    statistics.currentConnections++;
    
    // Log request
    console.log(`📊 [${timestamp}] ${req.method} ${req.url} from ${ip} - ${userAgent}`);
    
    // Check if IP is already blocked
    if (blockedIPs.has(ip)) {
        statistics.blockedRequests++;
        console.log(`🚫 [${timestamp}] Blocked request from ${ip} (previously blocked)`);
        respondWithBlock(res);
        return;
    }
    
    // Rate limiting check
    if (isRateLimited(ip)) {
        statistics.blockedRequests++;
        blockIPWithFirewall(ip);
        console.log(`⚡ [${timestamp}] Rate limited and blocked ${ip}`);
        respondWithBlock(res);
        return;
    }
    
    // DDoS detection
    if (isDDoSAttack(ip)) {
        statistics.blockedRequests++;
        statistics.suspiciousRequests++;
        blockedIPs.add(ip);
        blockIPWithFirewall(ip);
        console.log(`🔥 [${timestamp}] DDoS detected from ${ip} - BLOCKED`);
        respondWithBlock(res);
        return;
    }
    
    // Suspicious pattern detection
    if (hasSuspiciousPatterns(req)) {
        statistics.suspiciousRequests++;
        console.log(`⚠️  [${timestamp}] Suspicious patterns detected from ${ip}`);
        respondWithBlock(res);
        return;
    }
    
    // Serve monitoring dashboard
    if (req.url === '/' || req.url === '/dashboard') {
        serveMonitoringDashboard(res);
        return;
    }
    
    // Serve API endpoints
    if (req.url === '/api/stats') {
        serveAPIStats(res);
        return;
    }
    
    // Default response for all other requests
    respondWithBlock(res);
    statistics.currentConnections--;
}

// Block response
function respondWithBlock(res) {
    try {
        res.writeHead(CONFIG.responseCode, {
            'Content-Type': 'text/plain; charset=utf-8',
            'Server': CONFIG.customMessage,
            'X-Powered-By': 'Kize1337-Guardian',
            'Cache-Control': 'no-cache, no-store, must-revalidate',
            'Connection': 'close'
        });
        res.end(CONFIG.customMessage);
    } catch (error) {
        console.error('Error sending block response:', error);
    }
}

// Monitoring dashboard HTML
function getMonitoringHTML() {
    const uptime = Math.floor((Date.now() - statistics.startTime) / 1000);
    const blockedIPsArray = Array.from(blockedIPs).slice(-10);
    
    return `
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Kize1337 Guardian - Live Monitoring</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body {
            font-family: 'Courier New', monospace;
            background: linear-gradient(135deg, #0f0f23 0%, #1a1a2e 100%);
            color: #00ff00;
            min-height: 100vh;
            padding: 20px;
        }
        .container {
            max-width: 1200px;
            margin: 0 auto;
            background: rgba(0, 20, 40, 0.8);
            border: 2px solid #00ff00;
            border-radius: 10px;
            padding: 20px;
            box-shadow: 0 0 20px rgba(0, 255, 0, 0.3);
        }
        .header {
            text-align: center;
            margin-bottom: 30px;
            padding: 20px;
            border: 1px solid #00ff00;
            border-radius: 8px;
            background: rgba(0, 255, 0, 0.1);
        }
        .header h1 {
            font-size: 2.5em;
            text-shadow: 0 0 10px #00ff00;
            margin-bottom: 10px;
        }
        .header p {
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
            background: rgba(0, 50, 100, 0.6);
            border: 1px solid #00ff00;
            border-radius: 8px;
            padding: 20px;
            text-align: center;
            transition: all 0.3s ease;
        }
        .stat-card:hover {
            box-shadow: 0 0 15px rgba(0, 255, 0, 0.5);
            transform: translateY(-2px);
        }
        .stat-card h3 {
            color: #00cccc;
            margin-bottom: 10px;
            font-size: 1.1em;
        }
        .stat-card .value {
            font-size: 2em;
            font-weight: bold;
            text-shadow: 0 0 5px #00ff00;
        }
        .blocked-ips {
            background: rgba(100, 0, 0, 0.6);
            border: 1px solid #ff0000;
            border-radius: 8px;
            padding: 20px;
            margin-top: 20px;
        }
        .blocked-ips h3 {
            color: #ff4444;
            margin-bottom: 15px;
            text-align: center;
        }
        .ip-list {
            display: flex;
            flex-wrap: wrap;
            gap: 10px;
            justify-content: center;
        }
        .ip-item {
            background: rgba(255, 0, 0, 0.2);
            border: 1px solid #ff4444;
            border-radius: 4px;
            padding: 5px 10px;
            font-size: 0.9em;
            color: #ff8888;
        }
        .status {
            position: fixed;
            top: 20px;
            right: 20px;
            background: rgba(0, 255, 0, 0.9);
            color: #000;
            padding: 10px 20px;
            border-radius: 20px;
            font-weight: bold;
            animation: pulse 2s infinite;
        }
        @keyframes pulse {
            0% { opacity: 1; }
            50% { opacity: 0.7; }
            100% { opacity: 1; }
        }
        .config-info {
            background: rgba(0, 100, 100, 0.3);
            border: 1px solid #00cccc;
            border-radius: 8px;
            padding: 15px;
            margin-top: 20px;
        }
        .config-info h3 {
            color: #00cccc;
            margin-bottom: 10px;
        }
        .config-item {
            margin: 5px 0;
            font-size: 0.9em;
        }
    </style>
    <script>
        function refreshStats() {
            fetch('/api/stats')
                .then(response => response.json())
                .then(data => {
                    document.getElementById('totalRequests').textContent = data.totalRequests;
                    document.getElementById('blockedRequests').textContent = data.blockedRequests;
                    document.getElementById('suspiciousRequests').textContent = data.suspiciousRequests;
                    document.getElementById('currentConnections').textContent = data.currentConnections;
                    document.getElementById('uptime').textContent = data.uptime + 's';
                })
                .catch(error => console.error('Error fetching stats:', error));
        }
        
        setInterval(refreshStats, 2000);
        refreshStats();
    </script>
</head>
<body>
    <div class="status">🛡️ ACTIVE</div>
    <div class="container">
        <div class="header">
            <h1>🛡️ KIZE1337 GUARDIAN</h1>
            <p>Advanced Anti-DDoS Protection System</p>
        </div>
        
        <div class="stats-grid">
            <div class="stat-card">
                <h3>📊 Total Requests</h3>
                <div class="value" id="totalRequests">${statistics.totalRequests}</div>
            </div>
            <div class="stat-card">
                <h3>🚫 Blocked Requests</h3>
                <div class="value" id="blockedRequests">${statistics.blockedRequests}</div>
            </div>
            <div class="stat-card">
                <h3>⚠️ Suspicious Requests</h3>
                <div class="value" id="suspiciousRequests">${statistics.suspiciousRequests}</div>
            </div>
            <div class="stat-card">
                <h3>🔗 Current Connections</h3>
                <div class="value" id="currentConnections">${statistics.currentConnections}</div>
            </div>
            <div class="stat-card">
                <h3>⏱️ Uptime</h3>
                <div class="value" id="uptime">${uptime}s</div>
            </div>
            <div class="stat-card">
                <h3>🛡️ Protection Status</h3>
                <div class="value" style="color: #00ff00;">ACTIVE</div>
            </div>
        </div>
        
        <div class="blocked-ips">
            <h3>🚫 Recently Blocked IPs</h3>
            <div class="ip-list">
                ${blockedIPsArray.length > 0 ? 
                    blockedIPsArray.map(ip => `<div class="ip-item">${ip}</div>`).join('') :
                    '<div class="ip-item">No blocked IPs</div>'
                }
            </div>
        </div>
        
        <div class="config-info">
            <h3>⚙️ Current Configuration</h3>
            <div class="config-item">🎯 Custom Message: ${CONFIG.customMessage}</div>
            <div class="config-item">📡 Response Code: ${CONFIG.responseCode}</div>
            <div class="config-item">🔌 Monitor Port: ${CONFIG.monitorPort}</div>
            <div class="config-item">⏱️ Rate Limit: ${CONFIG.maxRequestsPerIP} requests/minute</div>
            <div class="config-item">🔗 Max Connections: ${CONFIG.maxConcurrentConnections}</div>
        </div>
    </div>
</body>
</html>`;
}

// Serve monitoring dashboard
function serveMonitoringDashboard(res) {
    try {
        res.writeHead(200, {
            'Content-Type': 'text/html; charset=utf-8',
            'Server': CONFIG.customMessage,
            'X-Powered-By': 'Kize1337-Guardian'
        });
        res.end(getMonitoringHTML());
    } catch (error) {
        console.error('Error serving dashboard:', error);
        res.writeHead(500);
        res.end('Internal Server Error');
    }
}

// Serve API stats
function serveAPIStats(res) {
    try {
        const uptime = Math.floor((Date.now() - statistics.startTime) / 1000);
        const stats = {
            ...statistics,
            uptime,
            blockedIPsCount: blockedIPs.size,
            trackedIPsCount: ipTracker.size
        };
        
        res.writeHead(200, {
            'Content-Type': 'application/json',
            'Server': CONFIG.customMessage,
            'X-Powered-By': 'Kize1337-Guardian'
        });
        res.end(JSON.stringify(stats, null, 2));
    } catch (error) {
        console.error('Error serving API stats:', error);
        res.writeHead(500);
        res.end('{"error": "Internal Server Error"}');
    }
}

// Cleanup old tracking data
function cleanupTrackingData() {
    const now = Date.now();
    const oldestAllowed = now - (CONFIG.windowMs * 5); // Keep 5 windows worth of data
    
    for (const [ip, tracker] of ipTracker.entries()) {
        tracker.requests = tracker.requests.filter(time => time > oldestAllowed);
        if (tracker.requests.length === 0 && (now - tracker.firstRequest) > CONFIG.windowMs) {
            ipTracker.delete(ip);
        }
    }
    
    // Remove old blocked IPs (after 24 hours)
    const dayAgo = now - (24 * 60 * 60 * 1000);
    for (const ip of blockedIPs) {
        const tracker = ipTracker.get(ip);
        if (!tracker || (tracker.firstRequest && tracker.firstRequest < dayAgo)) {
            blockedIPs.delete(ip);
        }
    }
    
    statistics.currentConnections = Math.max(0, statistics.currentConnections - 1);
}

// Initialize firewall rules
function initializeFirewall() {
    try {
        // Create ipset for blocked IPs if not exists
        execSync('ipset create blacklist hash:ip 2>/dev/null || true');
        execSync('iptables -I INPUT -m set --match-set blacklist src -j DROP 2>/dev/null || true');
        console.log('🔥 Firewall rules initialized');
    } catch (error) {
        console.log('⚠️  Could not initialize firewall rules (running without root?)');
    }
}

// Worker process
function startWorker() {
    console.log(`🚀 Worker ${process.pid} starting...`);
    
    // Initialize firewall (only in master or single process)
    if (cluster.isMaster || !cluster.isMaster) {
        initializeFirewall();
    }
    
    // Create HTTP server
    const server = http.createServer(handleRequest);
    
    // Handle server errors
    server.on('error', (error) => {
        console.error(`❌ Server error:`, error);
        if (error.code === 'EADDRINUSE') {
            console.error(`❌ Port ${CONFIG.monitorPort} is already in use`);
            process.exit(1);
        }
    });
    
    // Connection limiting
    server.on('connection', (socket) => {
        statistics.currentConnections++;
        
        if (statistics.currentConnections > CONFIG.maxConcurrentConnections) {
            socket.destroy();
            statistics.currentConnections--;
            statistics.blockedRequests++;
            return;
        }
        
        socket.on('close', () => {
            statistics.currentConnections = Math.max(0, statistics.currentConnections - 1);
        });
        
        // Set socket timeout
        socket.setTimeout(30000, () => {
            socket.destroy();
        });
    });
    
    // Start server
    server.listen(CONFIG.monitorPort, () => {
        console.log(`
╔══════════════════════════════════════════════════════════════╗
║                  🛡️  KIZE1337 GUARDIAN ACTIVE 🛡️             ║
╠══════════════════════════════════════════════════════════════╣
║                                                              ║
║  🌐 Monitoring Dashboard: http://localhost:${CONFIG.monitorPort.toString().padEnd(18)}║
║  📡 API Endpoint: http://localhost:${CONFIG.monitorPort}/api/stats${' '.repeat(11)}║
║  🎯 Custom Message: ${CONFIG.customMessage.padEnd(33)}║
║  📊 Response Code: ${CONFIG.responseCode.toString().padEnd(34)}║
║  👥 Worker PID: ${process.pid.toString().padEnd(37)}║
║                                                              ║
║  Status: 🟢 PROTECTION ACTIVE                                ║
║  Rate Limit: ${CONFIG.maxRequestsPerIP} requests/minute${' '.repeat(25)}║
║  Max Connections: ${CONFIG.maxConcurrentConnections.toString().padEnd(33)}║
║                                                              ║
╚══════════════════════════════════════════════════════════════╝
        `);
    });
    
    // Cleanup interval
    setInterval(cleanupTrackingData, 60000); // Every minute
    
    // Graceful shutdown
    process.on('SIGTERM', () => {
        console.log('🛑 Shutting down gracefully...');
        server.close(() => {
            process.exit(0);
        });
    });
    
    process.on('SIGINT', () => {
        console.log('\n🛑 Shutting down gracefully...');
        server.close(() => {
            process.exit(0);
        });
    });
}

// Main execution
function main() {
    parseArguments();
    
    if (cluster.isMaster) {
        const numCPUs = os.cpus().length;
        console.log(`🖥️  Starting Kize1337 Guardian with ${numCPUs} workers...`);
        
        // Fork workers
        for (let i = 0; i < numCPUs; i++) {
            cluster.fork();
        }
        
        // Handle worker deaths
        cluster.on('exit', (worker, code, signal) => {
            console.log(`⚠️  Worker ${worker.process.pid} died. Restarting...`);
            cluster.fork();
        });
        
        console.log(`🎯 Master process ${process.pid} is running`);
    } else {
        startWorker();
    }
}

// Handle uncaught exceptions
process.on('uncaughtException', (error) => {
    console.error('❌ Uncaught Exception:', error);
    process.exit(1);
});

process.on('unhandledRejection', (reason, promise) => {
    console.error('❌ Unhandled Rejection at:', promise, 'reason:', reason);
    process.exit(1);
});

// Start the application
if (require.main === module) {
    main();
}

module.exports = {
    CONFIG,
    handleRequest,
    isRateLimited,
    hasSuspiciousPatterns,
    isDDoSAttack
};
