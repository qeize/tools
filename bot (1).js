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
'https://raw.githubusercontent.com/zloi-user/hideip.me/main/socks5.txt',
'https://raw.githubusercontent.com/zloi-user/hideip.me/main/socks4.txt',
'https://raw.githubusercontent.com/zloi-user/hideip.me/main/https.txt',
'https://raw.githubusercontent.com/zloi-user/hideip.me/main/http.txt',
'https://raw.githubusercontent.com/zloi-user/hideip.me/main/connect.txt',
'https://raw.githubusercontent.com/zevtyardt/proxy-list/main/all.txt',
'https://raw.githubusercontent.com/Zaeem20/FREE_PROXIES_LIST/master/socks5.txt',
'https://raw.githubusercontent.com/Zaeem20/FREE_PROXIES_LIST/master/socks4.txt',
'https://raw.githubusercontent.com/Zaeem20/FREE_PROXIES_LIST/master/proxy.txt',
'https://raw.githubusercontent.com/Zaeem20/FREE_PROXIES_LIST/master/https.txt',
'https://raw.githubusercontent.com/Zaeem20/FREE_PROXIES_LIST/master/http.txt',
'https://raw.githubusercontent.com/yuceltoluyag/GoodProxy/main/raw.txt',
'https://raw.githubusercontent.com/yogendratamang48/ProxyList/master/proxies.txt',
'https://raw.githubusercontent.com/yemixzy/proxy-list/master/proxies.txt',
'https://raw.githubusercontent.com/yemixzy/proxy-list/main/proxies/unchecked.txt',
'https://raw.githubusercontent.com/Vann-Dev/proxy-list/main/proxies/socks5.txt',
'https://raw.githubusercontent.com/Vann-Dev/proxy-list/main/proxies/socks4.txt',
'https://raw.githubusercontent.com/Vann-Dev/proxy-list/main/proxies/https.txt',
'https://raw.githubusercontent.com/Vann-Dev/proxy-list/main/proxies/http.txt',
'https://raw.githubusercontent.com/vakhov/fresh-proxy-list/master/socks5.txt',
'https://raw.githubusercontent.com/vakhov/fresh-proxy-list/master/socks4.txt',
'https://raw.githubusercontent.com/vakhov/fresh-proxy-list/master/proxylist.txt',
'https://raw.githubusercontent.com/vakhov/fresh-proxy-list/master/https.txt',
'https://raw.githubusercontent.com/vakhov/fresh-proxy-list/master/http.txt',
'https://raw.githubusercontent.com/UptimerBot/proxy-list/main/proxies/socks5.txt',
'https://raw.githubusercontent.com/UptimerBot/proxy-list/main/proxies/socks4.txt',
'https://raw.githubusercontent.com/UptimerBot/proxy-list/main/proxies/http.txt',
'https://raw.githubusercontent.com/tuanminpay/live-proxy/master/socks5.txt',
'https://raw.githubusercontent.com/tuanminpay/live-proxy/master/socks4.txt',
'https://raw.githubusercontent.com/tuanminpay/live-proxy/master/http.txt',
'https://raw.githubusercontent.com/tuanminpay/live-proxy/master/all.txt',
'https://raw.githubusercontent.com/Tsprnay/Proxy-lists/master/proxies/https.txt',
'https://raw.githubusercontent.com/Tsprnay/Proxy-lists/master/proxies/http.txt',
'https://raw.githubusercontent.com/Tsprnay/Proxy-lists/master/proxies/all.txt',
'https://raw.githubusercontent.com/TheSpeedX/SOCKS-List/master/socks5.txt',
'https://raw.githubusercontent.com/TheSpeedX/SOCKS-List/master/socks4.txt',
'https://raw.githubusercontent.com/TheSpeedX/SOCKS-List/master/http.txt',
'https://raw.githubusercontent.com/TheSpeedX/PROXY-List/master/socks5.txt',
'https://raw.githubusercontent.com/TheSpeedX/PROXY-List/master/socks4.txt',
'https://raw.githubusercontent.com/TheSpeedX/PROXY-List/master/http.txt',
'https://raw.githubusercontent.com/sunny9577/proxy-scraper/master/proxies.txt',
'https://raw.githubusercontent.com/sunny9577/proxy-scraper/master/generated/socks5_proxies.txt',
'https://raw.githubusercontent.com/sunny9577/proxy-scraper/master/generated/socks4_proxies.txt',
'https://raw.githubusercontent.com/sunny9577/proxy-scraper/master/generated/http_proxies.txt',
'https://raw.githubusercontent.com/sunny9577/proxy-scraper/main/proxies.txt',
'https://raw.githubusercontent.com/sunny9577/proxy-scraper/main/generated/socks5_proxies.txt',
'https://raw.githubusercontent.com/sunny9577/proxy-scraper/main/generated/socks4_proxies.txt',
'https://raw.githubusercontent.com/sunny9577/proxy-scraper/main/generated/http_proxies.txt',
'https://raw.githubusercontent.com/ShiftyTR/Proxy-List/master/socks5.txt',
'https://raw.githubusercontent.com/ShiftyTR/Proxy-List/master/socks4.txt',
'https://raw.githubusercontent.com/shiftytr/proxy-list/master/proxy.txt',
'https://raw.githubusercontent.com/ShiftyTR/Proxy-List/master/proxy.txt',
'https://raw.githubusercontent.com/ShiftyTR/Proxy-List/master/https.txt',
'https://raw.githubusercontent.com/ShiftyTR/Proxy-List/master/http.txt',
'https://raw.githubusercontent.com/saschazesiger/Free-Proxies/master/proxies/working.txt',
'https://raw.githubusercontent.com/saschazesiger/Free-Proxies/master/proxies/ultrafast.txt',
'https://raw.githubusercontent.com/saschazesiger/Free-Proxies/master/proxies/socks5.txt',
'https://raw.githubusercontent.com/saschazesiger/Free-Proxies/master/proxies/socks4.txt',
'https://raw.githubusercontent.com/saschazesiger/Free-Proxies/master/proxies/premium.txt',
'https://raw.githubusercontent.com/saschazesiger/Free-Proxies/master/proxies/new.txt',
'https://raw.githubusercontent.com/saschazesiger/Free-Proxies/master/proxies/http.txt',
'https://raw.githubusercontent.com/saschazesiger/Free-Proxies/master/proxies/fast.txt',
'https://raw.githubusercontent.com/saisuiu/Lionkings-Http-Proxys-Proxies/main/free.txt',
'https://raw.githubusercontent.com/saisuiu/Lionkings-Http-Proxys-Proxies/main/cnfree.txt',
'https://raw.githubusercontent.com/RX4096/proxy-list/main/online/socks5.txt',
'https://raw.githubusercontent.com/RX4096/proxy-list/main/online/socks4.txt',
'https://raw.githubusercontent.com/RX4096/proxy-list/main/online/https.txt',
'https://raw.githubusercontent.com/RX4096/proxy-list/main/online/http.txt',
'https://raw.githubusercontent.com/rx443/proxy-list/main/online/https.txt',
'https://raw.githubusercontent.com/rx443/proxy-list/main/online/http.txt',
'https://raw.githubusercontent.com/roosterkid/openproxylist/main/SOCKS5_RAW.txt',
'https://raw.githubusercontent.com/roosterkid/openproxylist/main/SOCKS4_RAW.txt',
'https://raw.githubusercontent.com/roosterkid/openproxylist/main/HTTPS_RAW.txt',
'https://raw.githubusercontent.com/roosterkid/openproxylist/main/HTTP_RAW.txt',
'https://raw.githubusercontent.com/rdavydov/proxy-list/main/proxies_anonymous/socks5.txt',
'https://raw.githubusercontent.com/rdavydov/proxy-list/main/proxies_anonymous/socks4.txt',
'https://raw.githubusercontent.com/rdavydov/proxy-list/main/proxies_anonymous/http.txt',
'https://raw.githubusercontent.com/rdavydov/proxy-list/main/proxies/socks5.txt',
'https://raw.githubusercontent.com/rdavydov/proxy-list/main/proxies/socks4.txt',
'https://raw.githubusercontent.com/rdavydov/proxy-list/main/proxies/http.txt',
'https://raw.githubusercontent.com/prxchk/proxy-list/main/socks5.txt',
'https://raw.githubusercontent.com/prxchk/proxy-list/main/socks4.txt',
'https://raw.githubusercontent.com/prxchk/proxy-list/main/https.txt',
'https://raw.githubusercontent.com/prxchk/proxy-list/main/http.txt',
'https://raw.githubusercontent.com/prxchk/proxy-list/main/all.txt',
'https://raw.githubusercontent.com/ProxyScraper/ProxyScraper/main/socks5.txt',
'https://raw.githubusercontent.com/ProxyScraper/ProxyScraper/main/socks4.txt',
'https://raw.githubusercontent.com/ProxyScraper/ProxyScraper/main/http.txt',
'https://raw.githubusercontent.com/proxylist-to/proxy-list/main/socks5.txt',
'https://raw.githubusercontent.com/proxylist-to/proxy-list/main/socks4.txt',
'https://raw.githubusercontent.com/proxylist-to/proxy-list/main/http.txt',
'https://raw.githubusercontent.com/proxy4parsing/proxy-list/main/https.txt',
'https://raw.githubusercontent.com/proxy4parsing/proxy-list/main/http.txt',
'https://raw.githubusercontent.com/proxifly/free-proxy-list/main/proxies/protocols/http/data.txt',
'https://raw.githubusercontent.com/proxifly/free-proxy-list/main/proxies/all/data.txt',
'https://raw.githubusercontent.com/opsxcq/proxy-list/master/list.txt',
'https://raw.githubusercontent.com/officialputuid/KangProxy/KangProxy/xResults/RAW.txt',
'https://raw.githubusercontent.com/officialputuid/KangProxy/KangProxy/xResults/old-data/Proxies.txt',
'https://raw.githubusercontent.com/officialputuid/KangProxy/KangProxy/socks5/socks5.txt',
'https://raw.githubusercontent.com/officialputuid/KangProxy/KangProxy/socks4/socks4.txt',
'https://raw.githubusercontent.com/officialputuid/KangProxy/KangProxy/https/https.txt',
'https://raw.githubusercontent.com/officialputuid/KangProxy/KangProxy/http/http.txt',
'https://raw.githubusercontent.com/ObcbO/getproxy/master/socks5.txt',
'https://raw.githubusercontent.com/ObcbO/getproxy/master/socks4.txt',
'https://raw.githubusercontent.com/ObcbO/getproxy/master/https.txt',
'https://raw.githubusercontent.com/ObcbO/getproxy/master/http.txt',
'https://raw.githubusercontent.com/ObcbO/getproxy/master/file/socks5.txt',
'https://raw.githubusercontent.com/ObcbO/getproxy/master/file/socks4.txt',
'https://raw.githubusercontent.com/ObcbO/getproxy/master/file/https.txt',
'https://raw.githubusercontent.com/ObcbO/getproxy/master/file/http.txt',
'https://raw.githubusercontent.com/mython-dev/free-proxy-4000/main/proxy-4000.txt',
'https://raw.githubusercontent.com/MuRongPIG/Proxy-Master/main/socks5.txt',
'https://raw.githubusercontent.com/MuRongPIG/Proxy-Master/main/socks4.txt',
'https://raw.githubusercontent.com/MuRongPIG/Proxy-Master/main/https.txt',
'https://raw.githubusercontent.com/MuRongPIG/Proxy-Master/main/http.txt',
'https://raw.githubusercontent.com/MrMarble/proxy-list/main/all.txt',
'https://raw.githubusercontent.com/monosans/proxy-list/main/proxies_anonymous/socks5.txt',
'https://raw.githubusercontent.com/monosans/proxy-list/main/proxies_anonymous/socks4.txt',
'https://raw.githubusercontent.com/monosans/proxy-list/main/proxies_anonymous/http.txt',
'https://raw.githubusercontent.com/monosans/proxy-list/main/proxies/socks5.txt',
'https://raw.githubusercontent.com/monosans/proxy-list/main/proxies/socks4.txt',
'https://raw.githubusercontent.com/monosans/proxy-list/main/proxies/https.txt',
'https://raw.githubusercontent.com/monosans/proxy-list/main/proxies/http.txt',
'https://raw.githubusercontent.com/mmpx12/proxy-list/master/socks5.txt',
'https://raw.githubusercontent.com/mmpx12/proxy-list/master/socks4.txt',
'https://raw.githubusercontent.com/mmpx12/proxy-list/master/https.txt',
'https://raw.githubusercontent.com/mmpx12/proxy-list/master/http.txt',
'https://raw.githubusercontent.com/miyukii-chan/proxy-list/master/proxies/http.txt',
'https://raw.githubusercontent.com/mishakorzik/Free-Proxy/main/proxy.txt',
'https://raw.githubusercontent.com/mertguvencli/http-proxy-list/main/proxy-list/data.txt',
'https://raw.githubusercontent.com/manuGMG/proxy-365/main/SOCKS5.txt',
'https://raw.githubusercontent.com/mallisc5/master/proxy-list-raw.txt',
'https://raw.githubusercontent.com/jetkai/proxy-list/main/online-proxies/txt/proxies.txt',
'https://raw.githubusercontent.com/jetkai/proxy-list/main/online-proxies/txt/proxies-socks5.txt',
'https://raw.githubusercontent.com/jetkai/proxy-list/main/online-proxies/txt/proxies-socks4.txt',
'https://raw.githubusercontent.com/jetkai/proxy-list/main/online-proxies/txt/proxies-https.txt',
'https://raw.githubusercontent.com/jetkai/proxy-list/main/online-proxies/txt/proxies-http.txt',
'https://raw.githubusercontent.com/j0rd1s3rr4n0/api/main/proxy/http.txt',
'https://raw.githubusercontent.com/ItzRazvyy/ProxyList/main/socks5.txt',
'https://raw.githubusercontent.com/ItzRazvyy/ProxyList/main/socks4.txt',
'https://raw.githubusercontent.com/ItzRazvyy/ProxyList/main/https.txt',
'https://raw.githubusercontent.com/ItzRazvyy/ProxyList/main/http.txt',
'https://raw.githubusercontent.com/im-razvan/proxy_list/main/socks5',
'https://raw.githubusercontent.com/im-razvan/proxy_list/main/http.txt',
'https://raw.githubusercontent.com/HyperBeats/proxy-list/main/socks5.txt',
'https://raw.githubusercontent.com/HyperBeats/proxy-list/main/socks4.txt',
'https://raw.githubusercontent.com/HyperBeats/proxy-list/main/https.txt',
'https://raw.githubusercontent.com/HyperBeats/proxy-list/main/http.txt',
'https://raw.githubusercontent.com/hookzof/socks5_list/master/proxy.txt',
'https://raw.githubusercontent.com/hendrikbgr/Free-Proxy-Repo/master/proxy_list.txt',
'https://raw.githubusercontent.com/fate0/proxylist/master/proxy.list',
'https://raw.githubusercontent.com/fahimscirex/proxybd/master/proxylist/socks4.txt',
'https://raw.githubusercontent.com/fahimscirex/proxybd/master/proxylist/http.txt',
'https://raw.githubusercontent.com/ErcinDedeoglu/proxies/main/proxies/socks5.txt',
'https://raw.githubusercontent.com/ErcinDedeoglu/proxies/main/proxies/socks4.txt',
'https://raw.githubusercontent.com/ErcinDedeoglu/proxies/main/proxies/https.txt',
'https://raw.githubusercontent.com/ErcinDedeoglu/proxies/main/proxies/http.txt',
'https://raw.githubusercontent.com/enseitankado/proxine/main/proxy/socks5.txt',
'https://raw.githubusercontent.com/enseitankado/proxine/main/proxy/socks4.txt',
'https://raw.githubusercontent.com/enseitankado/proxine/main/proxy/https.txt',
'https://raw.githubusercontent.com/enseitankado/proxine/main/proxy/http.txt',
'https://raw.githubusercontent.com/elliottophellia/yakumo/master/results/socks5/global/socks5_checked.txt',
'https://raw.githubusercontent.com/elliottophellia/yakumo/master/results/socks4/global/socks4_checked.txt',
'https://raw.githubusercontent.com/elliottophellia/yakumo/master/results/mix_checked.txt',
'https://raw.githubusercontent.com/elliottophellia/yakumo/master/results/http/global/http_checked.txt',
'https://raw.githubusercontent.com/dunno10-a/proxy/main/proxies/socks5.txt',
'https://raw.githubusercontent.com/dunno10-a/proxy/main/proxies/socks4.txt',
'https://raw.githubusercontent.com/dunno10-a/proxy/main/proxies/https.txt',
'https://raw.githubusercontent.com/dunno10-a/proxy/main/proxies/http.txt',
'https://raw.githubusercontent.com/dunno10-a/proxy/main/proxies/all.txt',
'https://raw.githubusercontent.com/Daesrock/XenProxy/main/socks5.txt',
'https://raw.githubusercontent.com/Daesrock/XenProxy/main/socks4.txt',
'https://raw.githubusercontent.com/Daesrock/XenProxy/main/proxylist.txt',
'https://raw.githubusercontent.com/Daesrock/XenProxy/main/https.txt',
'https://raw.githubusercontent.com/crackmag/proxylist/proxy/proxy.list',
'https://raw.githubusercontent.com/clarketm/proxy-list/master/proxy-list.txt',
'https://raw.githubusercontent.com/clarketm/proxy-list/master/proxy-list-raw.txt',
'https://raw.githubusercontent.com/casals-ar/proxy-list/main/socks5',
'https://raw.githubusercontent.com/casals-ar/proxy-list/main/socks4',
'https://raw.githubusercontent.com/casals-ar/proxy-list/main/https',
'https://raw.githubusercontent.com/casals-ar/proxy-list/main/http',
'https://raw.githubusercontent.com/caliphdev/Proxy-List/master/http.txt',
'https://raw.githubusercontent.com/caliphdev/Proxy-List/main/socks5.txt',
'https://raw.githubusercontent.com/caliphdev/Proxy-List/main/http.txt',
'https://raw.githubusercontent.com/BreakingTechFr/Proxy_Free/main/proxies/socks5.txt',
'https://raw.githubusercontent.com/BreakingTechFr/Proxy_Free/main/proxies/socks4.txt',
'https://raw.githubusercontent.com/BreakingTechFr/Proxy_Free/main/proxies/https.txt',
'https://raw.githubusercontent.com/BreakingTechFr/Proxy_Free/main/proxies/http.txt',
'https://raw.githubusercontent.com/BreakingTechFr/Proxy_Free/main/proxies/all.txt',
'https://raw.githubusercontent.com/BlackCage/Proxy-Scraper-and-Verifier/main/Proxies/Not_Processed/proxies.txt',
'https://raw.githubusercontent.com/berkay-digital/Proxy-Scraper/main/proxies.txt',
'https://raw.githubusercontent.com/B4RC0DE-TM/proxy-list/main/HTTP.txt',
'https://raw.githubusercontent.com/aslisk/proxyhttps/main/https.txt',
'https://raw.githubusercontent.com/Anonym0usWork1221/Free-Proxies/main/proxy_files/socks5_proxies.txt',
'https://raw.githubusercontent.com/Anonym0usWork1221/Free-Proxies/main/proxy_files/socks4_proxies.txt',
'https://raw.githubusercontent.com/Anonym0usWork1221/Free-Proxies/main/proxy_files/https_proxies.txt',
'https://raw.githubusercontent.com/Anonym0usWork1221/Free-Proxies/main/proxy_files/http_proxies.txt',
'https://raw.githubusercontent.com/andigwandi/free-proxy/main/proxy_list.txt',
'https://raw.githubusercontent.com/almroot/proxylist/master/list.txt',
'https://raw.githubusercontent.com/ALIILAPRO/Proxy/main/socks5.txt',
'https://raw.githubusercontent.com/ALIILAPRO/Proxy/main/http.txt',
'https://raw.githubusercontent.com/a2u/free-proxy-list/master/free-proxy-list.txt',
'https://proxyspace.pro/socks5.txt',
'https://proxyspace.pro/socks4.txt',
'https://proxyspace.pro/https.txt',
'https://proxyspace.pro/http.txt',
'https://proxy-spider.com/api/proxies.example.txt',
'https://openproxylist.xyz/socks5.txt',
'https://openproxylist.xyz/socks4.txt',
'https://openproxylist.xyz/https.txt',
'https://openproxylist.xyz/http.txt',
'https://naawy.com/api/public/proxylist/getList/?proxyType=socks5&format=txt',
'https://naawy.com/api/public/proxylist/getList/?proxyType=socks4&format=txt',
'https://naawy.com/api/public/proxylist/getList/?proxyType=https&format=txt',
'https://naawy.com/api/public/proxylist/getList/?proxyType=http&format=txt',
'https://multiproxy.org/txt_all/proxy.txt',
'https://api.proxyscrape.com/v2/?request=getproxies&protocol=http&timeout=10000&country=all&ssl=all&anonymity=anonymous',
'https://api.proxyscrape.com/v2/?request=getproxies&protocol=http&timeout=10000&country=all&ssl=all&anonymity=all',
'https://api.proxyscrape.com/v2/?request=displayproxies',
'https://api.proxyscrape.com/?request=getproxies&proxytype=http&timeout=10000&country=all&ssl=all&anonymity=all',
'https://api.proxyscrape.com/?request=displayproxies&proxytype=http',
'https://api.openproxylist.xyz/socks5.txt',
'https://api.openproxylist.xyz/socks4.txt',
'https://api.openproxylist.xyz/http.txt',
'https://api.good-proxies.ru/getfree.php?count=1000&key=freeproxy',
'https://github.com/zebbern/Proxy-Scraper/raw/refs/heads/main/http.txt',
'https://github.com/zebbern/Proxy-Scraper/raw/refs/heads/main/https.txt',
'https://github.com/zebbern/Proxy-Scraper/raw/refs/heads/main/proxydump.txt',
'https://github.com/zebbern/Proxy-Scraper/raw/refs/heads/main/socks4.txt',
'https://github.com/zebbern/Proxy-Scraper/raw/refs/heads/main/socks5.txt',
'https://www.proxydocker.com/en/proxylist/download?email=noshare&country=all&city=all&port=all&type=all&anonymity=all&state=all&need=all',
'https://api.proxyscrape.com/v2/?request=getproxies&protocol=all&timeout=10000&country=all&ssl=all&anonymity=all',
'http://worm.rip/http.txt',
'http://worm.rip/https.txt',
'http://rootjazz.com/proxies/proxies.txt',
'https://sunny9577.github.io/proxy-scraper/proxies.txt',
'https://sunny9577.github.io/proxy-scraper/generated/http_proxies.txt',
'https://api.proxyscrape.com/v2/?request=displayproxies&protocol=socks4&timeout=5000&country=all&ssl=all&anonymity=all',
'https://sunny9577.github.io/proxy-scraper/generated/socks4_proxies.txt',
'https://api.proxyscrape.com/v2/?request=displayproxies&protocol=socks5&timeout=5000&country=all&ssl=all&anonymity=all',
'https://sunny9577.github.io/proxy-scraper/generated/socks5_proxies.txt',
'https://www.proxy-list.download/api/v1/get?type=http',
'https://www.proxy-list.download/api/v1/get?type=socks4',
'https://www.proxy-list.download/api/v1/get?type=socks5',
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

