const fs = require('fs');
const path = require('path');
const axios = require('axios');
const FormData = require('form-data');
const colors = require('colors');
const schedule = require('node-schedule');

// Configuration
const config = {
  telegramToken: '7601126375:AAHQDzQjn_ea7dIaV0RVtLIniJi5FTAGy-0',
  channelId: '-1002638264088',
  proxyFile: 'proxy.txt',
  interval: '*/5 * * * *', // Every 5 minutes in cron format
  credit: '@deathpk'
};

// Color setup
colors.setTheme({
  info: 'green',
  warn: 'yellow',
  error: 'red',
  debug: 'blue',
  white: 'white'
});

// List of proxy sources
const proxySourceList = [
  
'https://github.com/zebbern/Proxy-Scraper/raw/refs/heads/main/http.txt',
  
'https://github.com/zebbern/Proxy-Scraper/raw/refs/heads/main/https.txt',
  
'https://github.com/zebbern/Proxy-Scraper/raw/refs/heads/main/proxydump.txt',
  
'https://github.com/zebbern/Proxy-Scraper/raw/refs/heads/main/socks4.txt',
  
'https://github.com/zebbern/Proxy-Scraper/raw/refs/heads/main/socks5.txt',
  
'https://github.com/MrMarble/proxy-list/raw/refs/heads/main/all.txt',
  
'https://raw.githubusercontent.com/roosterkid/openproxylist/main/HTTPS_RAW.txt',
  
'https://raw.githubusercontent.com/TheSpeedX/PROXY-List/master/http.txt',
  
'https://raw.githubusercontent.com/MuRongPIG/Proxy-Master/main/http.txt',
  
'https://raw.githubusercontent.com/officialputuid/KangProxy/KangProxy/http/http.txt',
  
'https://raw.githubusercontent.com/prxchk/proxy-list/main/http.txt',
  
'https://raw.githubusercontent.com/monosans/proxy-list/main/proxies/http.txt',
  
'https://raw.githubusercontent.com/proxylist-to/proxy-list/main/http.txt',
  
'https://raw.githubusercontent.com/yuceltoluyag/GoodProxy/main/raw.txt',
  
'https://raw.githubusercontent.com/ShiftyTR/Proxy-List/master/http.txt',
  
'https://raw.githubusercontent.com/ShiftyTR/Proxy-List/master/https.txt',
  
'https://raw.githubusercontent.com/mmpx12/proxy-list/master/https.txt',
  
'https://raw.githubusercontent.com/Anonym0usWork1221/Free-Proxies/main/proxy_files/http_proxies.txt',
  
'https://raw.githubusercontent.com/opsxcq/proxy-list/master/list.txt',
  
'https://raw.githubusercontent.com/Anonym0usWork1221/Free-Proxies/main/proxy_files/https_proxies.txt',
  'https://api.openproxylist.xyz/http.txt',
  'https://api.openproxylist.xyz/socks5.txt',
  'https://api.openproxylist.xyz/socks4.txt',
  
'https://raw.githubusercontent.com/TheSpeedX/SOCKS-List/master/socks4.txt',
  
'https://raw.githubusercontent.com/TheSpeedX/SOCKS-List/master/socks5.txt',
  'https://api.proxyscrape.com/v2/?request=displayproxies',
  
'https://api.proxyscrape.com/?request=displayproxies&proxytype=http',
  
'https://api.proxyscrape.com/v2/?request=getproxies&protocol=http&timeout=10000&country=all&ssl=all&anonymity=all',
  
'https://www.proxydocker.com/en/proxylist/download?email=noshare&country=all&city=all&port=all&type=all&anonymity=all&state=all&need=all',
  
'https://api.proxyscrape.com/v2/?request=getproxies&protocol=http&timeout=10000&country=all&ssl=all&anonymity=anonymous',
  
'https://api.proxyscrape.com/v2/?request=displayproxies&protocol=all&timeout=10000&country=all&ssl=all&anonymity=all',
  'http://worm.rip/http.txt',
  'https://proxyspace.pro/http.txt',
  'https://proxyspace.pro/socks4.txt',
  'https://proxyspace.pro/http.txt',
  'https://api.proxyscrape.com/v2/?request=displayproxies',
  
'https://raw.githubusercontent.com/officialputuid/KangProxy/KangProxy/http/http.txt',
  
'https://raw.githubusercontent.com/roosterkid/openproxylist/main/HTTPS_RAW.txt',
  
'https://raw.githubusercontent.com/yuceltoluyag/GoodProxy/main/raw.txt',
  
'https://raw.githubusercontent.com/ShiftyTR/Proxy-List/master/http.txt',
  
'https://raw.githubusercontent.com/ShiftyTR/Proxy-List/master/https.txt',
  
'https://raw.githubusercontent.com/mmpx12/proxy-list/master/https.txt',
  'https://proxyspace.pro/http.txt',
  
'https://api.proxyscrape.com/?request=displayproxies&proxytype=http',
  
'https://raw.githubusercontent.com/monosans/proxy-list/main/proxies/http.txt',
  'http://worm.rip/http.txt',
  'http://worm.rip/https.txt',
  'https://api.openproxylist.xyz/http.txt',
  'http://rootjazz.com/proxies/proxies.txt',
  'https://multiproxy.org/txt_all/proxy.txt',
  'https://proxy-spider.com/api/proxies.example.txt',
  
'https://raw.githubusercontent.com/TheSpeedX/PROXY-List/master/http.txt',
  
'https://raw.githubusercontent.com/jetkai/proxy-list/main/online-proxies/txt/proxies-http.txt',
  
  'https://raw.githubusercontent.com/jetkai/proxy-list/main/online-proxies/txt/proxies-socks4.txt',
  
  'https://raw.githubusercontent.com/jetkai/proxy-list/main/online-proxies/txt/proxies-socks5.txt',
  
  
  
'https://raw.githubusercontent.com/hookzof/socks5_list/master/proxy.txt',
  
'https://raw.githubusercontent.com/clarketm/proxy-list/master/proxy-list-raw.txt',
  
'https://raw.githubusercontent.com/sunny9577/proxy-scraper/master/proxies.txt',
  
'https://raw.githubusercontent.com/opsxcq/proxy-list/master/list.txt',
  
'https://api.proxyscrape.com/v2/?request=getproxies&protocol=http&timeout=10000&country=all&ssl=all&anonymity=all',
  
'https://www.proxydocker.com/en/proxylist/download?email=noshare&country=all&city=all&port=all&type=all&anonymity=all&state=all&need=all',
  
'https://api.proxyscrape.com/v2/?request=getproxies&protocol=http&timeout=10000&country=all&ssl=all&anonymity=anonymous',
  
'https://raw.githubusercontent.com/roosterkid/openproxylist/main/HTTPS_RAW.txt',
  
'https://raw.githubusercontent.com/TheSpeedX/PROXY-List/master/http.txt',
  
'https://raw.githubusercontent.com/MuRongPIG/Proxy-Master/main/http.txt',
  
'https://raw.githubusercontent.com/officialputuid/KangProxy/KangProxy/http/http.txt',
  
'https://raw.githubusercontent.com/prxchk/proxy-list/main/http.txt',
  
'https://raw.githubusercontent.com/monosans/proxy-list/main/proxies/http.txt',
  
'https://raw.githubusercontent.com/proxylist-to/proxy-list/main/http.txt',
  
'https://raw.githubusercontent.com/yuceltoluyag/GoodProxy/main/raw.txt',
  
'https://raw.githubusercontent.com/ShiftyTR/Proxy-List/master/http.txt',
  
'https://raw.githubusercontent.com/ShiftyTR/Proxy-List/master/https.txt',
  
'https://raw.githubusercontent.com/mmpx12/proxy-list/master/https.txt',
  
'https://raw.githubusercontent.com/Anonym0usWork1221/Free-Proxies/main/proxy_files/http_proxies.txt',
  
'https://raw.githubusercontent.com/opsxcq/proxy-list/master/list.txt',
  
'https://raw.githubusercontent.com/Anonym0usWork1221/Free-Proxies/main/proxy_files/https_proxies.txt',
  'https://api.openproxylist.xyz/http.txt',
  'https://api.proxyscrape.com/v2/?request=displayproxies',
  
'https://api.proxyscrape.com/?request=displayproxies&proxytype=http',
  
'https://api.proxyscrape.com/v2/?request=getproxies&protocol=http&timeout=10000&country=all&ssl=all&anonymity=all',
  
'https://www.proxydocker.com/en/proxylist/download?email=noshare&country=all&city=all&port=all&type=all&anonymity=all&state=all&need=all',
  
'https://api.proxyscrape.com/v2/?request=getproxies&protocol=http&timeout=10000&country=all&ssl=all&anonymity=anonymous',
  'http://worm.rip/http.txt',
  'https://proxyspace.pro/http.txt',
  'https://multiproxy.org/txt_all/proxy.txt',
  'https://proxy-spider.com/api/proxies.example.txt',
  'https://sunny9577.github.io/proxy-scraper/proxies.txt',
  
'https://sunny9577.github.io/proxy-scraper/generated/http_proxies.txt',
  
'https://raw.githubusercontent.com/monosans/proxy-list/main/proxies_anonymous/http.txt',
  
'https://raw.githubusercontent.com/zloi-user/hideip.me/main/http.txt',
  'https://www.proxy-list.download/api/v1/get?type=http',
  
'https://raw.githubusercontent.com/zloi-user/hideip.me/main/https.txt',
  
'https://api.proxyscrape.com/v2/?request=displayproxies&protocol=socks4&timeout=5000&country=all&ssl=all&anonymity=all',
  
'https://sunny9577.github.io/proxy-scraper/generated/socks4_proxies.txt',
  
'https://raw.githubusercontent.com/monosans/proxy-list/main/proxies/socks4.txt',
  
'https://raw.githubusercontent.com/monosans/proxy-list/main/proxies_anonymous/socks4.txt',
  
'https://api.proxyscrape.com/v2/?request=displayproxies&protocol=socks5&timeout=5000&country=all&ssl=all&anonymity=all',
  
'https://sunny9577.github.io/proxy-scraper/generated/socks5_proxies.txt',
  
'https://raw.githubusercontent.com/monosans/proxy-list/main/proxies/socks5.txt',
  
'https://raw.githubusercontent.com/monosans/proxy-list/main/proxies_anonymous/socks5.txt',
  
'https://raw.githubusercontent.com/zloi-user/hideip.me/main/socks5.txt',
  
'https://raw.githubusercontent.com/ErcinDedeoglu/proxies/main/proxies/http.txt',
  
'https://raw.githubusercontent.com/TheSpeedX/SOCKS-List/master/http.txt',
  
'https://raw.githubusercontent.com/saisuiu/Lionkings-Http-Proxys-Proxies/main/free.txt',
  
'https://raw.githubusercontent.com/caliphdev/Proxy-List/master/http.txt',
  
'https://raw.githubusercontent.com/vakhov/fresh-proxy-list/master/https.txt',
  
'https://raw.githubusercontent.com/vakhov/fresh-proxy-list/master/http.txt',
  
'https://raw.githubusercontent.com/proxifly/free-proxy-list/main/proxies/protocols/http/data.txt',
  
'https://raw.githubusercontent.com/tuanminpay/live-proxy/master/http.txt',
  
'https://raw.githubusercontent.com/casals-ar/proxy-list/main/https',
  
'https://raw.githubusercontent.com/casals-ar/proxy-list/main/http',
  
'https://raw.githubusercontent.com/Zaeem20/FREE_PROXIES_LIST/master/http.txt',
  
'https://raw.githubusercontent.com/Zaeem20/FREE_PROXIES_LIST/master/https.txt',
  
'https://raw.githubusercontent.com/proxy4parsing/proxy-list/main/http.txt',
  'http://atomintersoft.com/proxy_list_port_80',
  'http://atomintersoft.com/proxy_list_domain_org',
  'http://atomintersoft.com/proxy_list_port_3128',
  'http://alexa.lr2b.com/proxylist.txt',
  'http://browse.feedreader.com/c/Proxy_Server_List-1/449196258',
  'http://free-ssh.blogspot.com/feeds/posts/default',
  'http://browse.feedreader.com/c/Proxy_Server_List-1/449196259',
  'http://johnstudio0.tripod.com/index1.htm',
  'http://atomintersoft.com/transparent_proxy_list',
  'http://atomintersoft.com/anonymous_proxy_list',
  'http://atomintersoft.com/high_anonymity_elite_proxy_list',
  'http://worm.rip/https.txt',
  'http://rootjazz.com/proxies/proxies.txt',
  
'https://raw.githubusercontent.com/jetkai/proxy-list/main/online-proxies/txt/proxies.txt',
  
'https://raw.githubusercontent.com/hookzof/socks5_list/master/proxy.txt',
  
'https://raw.githubusercontent.com/clarketm/proxy-list/master/proxy-list-raw.txt',
  'https://proxyspace.pro/https.txt',
  'https://proxyspace.pro/socks5.txt',
  'https://multiproxy.org/txt_all/proxy.txt',
  'https://proxy-spider.com/api/proxies.example.txt',
];

/**
 * Format current date and time
 * @returns {string} Formatted date string (YYYY-MM-DD HH:mm:ss)
 */
function getFormattedDate() {
  const now = new Date();
  const pad = num => num.toString().padStart(2, '0');
  
  return `${now.getFullYear()}-${pad(now.getMonth() + 
1)}-${pad(now.getDate())} ` +
         
`${pad(now.getHours())}:${pad(now.getMinutes())}:${pad(now.getSeconds())}`;
}

/**
 * Clear console based on OS
 */
function clearConsole() {
  process.stdout.write(process.platform === 'win32' ? 
'\x1B[2J\x1B[0f' : '\x1B[2J\x1B[3J\x1B[H');
}

/**
 * Download proxies from a single source
 */
async function fetchProxyFromSource(url) {
  try {
    const response = await axios.get(url, { timeout: 10000 });
    console.log(` -| Getting ${url}`.info);
    return response.data;
  } catch (error) {
    console.log(` -| Failed to get ${url}`.error);
    return '';
  }
}

/**
 * Download proxies from all sources
 */
async function fetchAllProxies() {
  clearConsole();
  
  if (fs.existsSync(config.proxyFile)) {
    try {
      fs.unlinkSync(config.proxyFile);
      console.log(`File ${config.proxyFile} already 
exists!`.error);
      console.log(`Starting to download new 
${config.proxyFile}!`.warn);
    } catch (error) {
      console.log(`Error removing existing file: 
${error.message}`.error);
    }
  } else {
    console.log(`Starting to download ${config.proxyFile}!`.info);
  }
  
  const promises = proxySourceList.map(url => 
fetchProxyFromSource(url));
  const results = await Promise.all(promises);
  return results.join('\n');
}

/**
 * Remove duplicate lines from file
 */
async function removeDuplicates(filePath) {
  try {
    const fileContent = fs.readFileSync(filePath, 'utf8');
    const lines = fileContent.split('\n').filter(line => 
line.trim() !== '');
    const uniqueLines = [...new Set(lines)];
    fs.writeFileSync(filePath, uniqueLines.join('\n'));
    return uniqueLines.length;
  } catch (error) {
    console.log(`Error removing duplicates: 
${error.message}`.error);
    throw error;
  }
}

/**
 * Send file to Telegram channel
 */
async function sendToTelegram(filePath, count) {
  try {
    const formData = new FormData();
    const fileStream = fs.createReadStream(filePath);
    
    formData.append('chat_id', config.channelId);
    formData.append('document', fileStream, {
      filename: path.basename(filePath),
      contentType: 'text/plain'
    });
    
    const caption = `Date/time: ${getFormattedDate()}\n` +
                   `Count: ${count}\n` +
                   `Credit: ${config.credit}\n` + `✯════ ✪ ════✯`;
    formData.append('caption', caption);
    
    const response = await axios.post(
      
`https://api.telegram.org/bot${config.telegramToken}/sendDocument`,
      formData,
      { headers: formData.getHeaders() }
    );
    
    if (response.data.ok) {
      console.log(`Successfully sent to Telegram at 
${getFormattedDate()}`.info);
    } else {
      throw new Error(`Telegram API error: 
${JSON.stringify(response.data)}`);
    }
  } catch (error) {
    console.log(`Failed to send to Telegram: 
${error.message}`.error);
  }
}

/**
 * Main process
 */
async function processProxies() {
  try {
    const proxyData = await fetchAllProxies();
    fs.writeFileSync(config.proxyFile, proxyData);
    
    const uniqueCount = await removeDuplicates(config.proxyFile);
    console.log(`\n( ${uniqueCount} ) Proxies successfully 
downloaded.`.white);
    
    await sendToTelegram(config.proxyFile, uniqueCount);
  } catch (error) {
    console.log(`Error in process: ${error.message}`.error);
  }
}

// Start the application
console.log('Starting Proxy Scraper with Telegram Sender'.debug);
console.log(`Scheduled to run every 5 minutes. Channel: 
${config.channelId}`.info);

// Run immediately on startup
processProxies();

// Schedule to run every 5 minutes
schedule.scheduleJob(config.interval, processProxies);
