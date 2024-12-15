# https://github.com/chainski

import os
import time
import requests
import pystyle
import random
import sys
from pystyle import *

def sendRequest(s): 
    try: 
        return requests.get(s).content
    except Exception:
        pass

def saveFile(f,w):
    try:
        f.write(sendRequest(w))
    except Exception:
        pass 

os.system('cls')
os.system('mode con: cols=120 lines=50')

banner = '''
Famod Service 
Telegram : @nminh23
'''
print(Colorate.Horizontal(Colors.purple_to_red, Center.XCenter(banner)))

os.system('cls')
print()
Write.Print("[+] This program will autoscrape proxies into separate files", Colors.red_to_yellow, interval=0.01)
print()
Write.Print("\n[+] Scraping Proxies Please Wait . . . \n", Colors.red_to_purple, interval=0)

http = open('proxy.txt','wb')
allsocks = open('live.txt','wb')

# HTTP Proxies Sources
http_ = [
"https://api.proxyscrape.com/v3/free-proxy-list/get?request=displayproxies",
"https://api.proxyscrape.com/v3/free-proxy-list/get?request=displayproxies&protocol=http&country=all&anonymity=all&timeout=100000000&proxy_format=ipport&format=text",
"https://raw.githubusercontent.com/vakhov/fresh-proxy-list/master/proxylist.txt",
"https://api.proxyscrape.com/?request=getproxies&proxytype=https&timeout=10000&country=all&ssl=all&anonymity=all",
"https://api.proxyscrape.com/v2/?request=getproxies&protocol=http&timeout=10000&country=all&ssl=all&anonymity=all",
"https://raw.githubusercontent.com/TheSpeedX/PROXY-List/master/http.txt",
"https://raw.githubusercontent.com/MuRongPIG/Proxy-Master/main/http.txt",
"https://raw.githubusercontent.com/prxchk/proxy-list/main/http.txt",
"https://raw.githubusercontent.com/saisuiu/Lionkings-Http-Proxys-Proxies/main/cnfree.txt",
"https://raw.githubusercontent.com/Anonym0usWork1221/Free-Proxies/main/proxy_files/http_proxies.txt",
"https://raw.githubusercontent.com/Anonym0usWork1221/Free-Proxies/main/proxy_files/https_proxies.txt",
"https://raw.githubusercontent.com/roosterkid/openproxylist/main/HTTPS_RAW.txt",
"https://raw.githubusercontent.com/officialputuid/KangProxy/KangProxy/https/https.txt",
"https://api.proxyscrape.com/v2/?request=displayproxies&protocol=socks4",
"https://api.proxyscrape.com/?request=displayproxies&proxytype=socks4&country=all",
"https://api.openproxylist.xyz/socks4.txt",
"https://proxyspace.pro/socks4.txt",
"https://raw.githubusercontent.com/monosans/proxy-list/main/proxies/socks4.txt",
"https://raw.githubusercontent.com/monosans/proxy-list/main/proxies_anonymous/socks4.txt",
"https://raw.githubusercontent.com/jetkai/proxy-list/main/online-proxies/txt/proxies-socks4.txt",
"https://raw.githubusercontent.com/ShiftyTR/Proxy-List/master/socks4.txt",
"https://raw.githubusercontent.com/TheSpeedX/PROXY-List/master/socks4.txt",
"https://raw.githubusercontent.com/roosterkid/openproxylist/main/SOCKS4_RAW.txt",
"https://proxyspace.pro/socks4.txt",
"https://www.proxy-list.download/api/v1/get?type=socks4",
"https://raw.githubusercontent.com/HyperBeats/proxy-list/main/socks4.txt",
"https://raw.githubusercontent.com/mmpx12/proxy-list/master/socks4.txt",
"https://raw.githubusercontent.com/saschazesiger/Free-Proxies/master/proxies/socks4.txt",
"https://raw.githubusercontent.com/B4RC0DE-TM/proxy-list/main/SOCKS4.txt",
"https://raw.githubusercontent.com/rdavydov/proxy-list/main/proxies/socks4.txt",
"https://raw.githubusercontent.com/rdavydov/proxy-list/main/proxies_anonymous/socks4.txt",
"https://raw.githubusercontent.com/zevtyardt/proxy-list/main/socks4.txt",
"https://raw.githubusercontent.com/MuRongPIG/Proxy-Master/main/socks4.txt",
"https://raw.githubusercontent.com/Zaeem20/FREE_PROXIES_LIST/master/socks4.txt",
"https://raw.githubusercontent.com/prxchk/proxy-list/main/socks4.txt",
"https://raw.githubusercontent.com/ALIILAPRO/Proxy/main/socks4.txt",
"https://raw.githubusercontent.com/zloi-user/hideip.me/main/socks4.txt",
"https://www.proxyscan.io/download?type=socks4,"
"https://raw.githubusercontent.com/B4RC0DE-TM/proxy-list/main/SOCKS5.txt",
"https://raw.githubusercontent.com/saschazesiger/Free-Proxies/master/proxies/socks5.txt",
"https://raw.githubusercontent.com/mmpx12/proxy-list/master/socks5.txt",
"https://api.openproxylist.xyz/socks5.txt",
"https://api.proxyscrape.com/?request=displayproxies&proxytype=socks5",
"https://api.proxyscrape.com/v2/?request=displayproxies&protocol=socks5",
"https://proxyspace.pro/socks5.txt",
"https://raw.githubusercontent.com/manuGMG/proxy-365/main/SOCKS5.txt",
"https://raw.githubusercontent.com/monosans/proxy-list/main/proxies/socks5.txt",
"https://raw.githubusercontent.com/monosans/proxy-list/main/proxies_anonymous/socks5.txt",
"https://raw.githubusercontent.com/ShiftyTR/Proxy-List/master/socks5.txt",
"https://raw.githubusercontent.com/jetkai/proxy-list/main/online-proxies/txt/proxies-socks5.txt",
"https://raw.githubusercontent.com/roosterkid/openproxylist/main/SOCKS5_RAW.txt",
"https://raw.githubusercontent.com/TheSpeedX/PROXY-List/master/socks5.txt",
"https://raw.githubusercontent.com/hookzof/socks5_list/master/proxy.txt",
"https://raw.githubusercontent.com/rdavydov/proxy-list/main/proxies/socks5.txt",
"https://raw.githubusercontent.com/rdavydov/proxy-list/main/proxies_anonymous/socks5.txt",
"https://raw.githubusercontent.com/zevtyardt/proxy-list/main/socks5.txt",
"https://raw.githubusercontent.com/MuRongPIG/Proxy-Master/main/socks5.txt",
"https://raw.githubusercontent.com/Zaeem20/FREE_PROXIES_LIST/master/socks5.txt",
"https://raw.githubusercontent.com/prxchk/proxy-list/main/socks5.txt",
"https://raw.githubusercontent.com/ALIILAPRO/Proxy/main/socks5.txt",
"https://spys.me/socks.txt",
"https://raw.githubusercontent.com/zloi-user/hideip.me/main/socks5.txt",
"https://www.proxy-list.download/api/v1/get?type=https&anon=elite",
"https://raw.githubusercontent.com/clarketm/proxy-list/master/proxy-list-raw.txt",
"https://raw.githubusercontent.com/jetkai/proxy-list/main/online-proxies/txt/proxies-http.txt",
"https://raw.githubusercontent.com/jetkai/proxy-list/main/archive/txt/proxies-http.txt",
"https://raw.githubusercontent.com/monosans/proxy-list/main/proxies/http.txt",
"https://raw.githubusercontent.com/TheSpeedX/PROXY-List/master/http.txt",
"https://www.proxy-list.download/api/v1/get?type=http",
"https://api.openproxylist.xyz/http.txt",
"https://raw.githubusercontent.com/mmpx12/proxy-list/master/http.txt",
"https://raw.githubusercontent.com/ShiftyTR/Proxy-List/master/http.txt",
"https://raw.githubusercontent.com/proxy4parsing/proxy-list/main/http.txt",
"http://alexa.lr2b.com/proxylist.txt",
"http://olaf4snow.com/public/proxy.txt",
"http://inav.chat.ru/ftp/proxy.txt",
"https://api.proxyscrape.com/?request=displayproxies&proxytype=http",
"https://www.proxy-list.download/api/v1/get?type=http",
"https://raw.githubusercontent.com/TheSpeedX/SOCKS-List/master/http.txt",
"https://api.openproxylist.xyz/http.txt",
"https://raw.githubusercontent.com/shiftytr/proxy-list/master/proxy.txt",
"http://alexa.lr2b.com/proxylist.txt",
"http://rootjazz.com/proxies/proxies.txt",
"https://raw.githubusercontent.com/clarketm/proxy-list/master/proxy-list-raw.txt",
"https://raw.githubusercontent.com/sunny9577/proxy-scraper/master/proxies.txt",
"https://raw.githubusercontent.com/opsxcq/proxy-list/master/list.txt",
"https://proxy-spider.com/api/proxies.example.txt",
"https://multiproxy.org/txt_all/proxy.txt",
"https://raw.githubusercontent.com/roosterkid/openproxylist/main/HTTPS_RAW.txt",
"https://raw.githubusercontent.com/UserR3X/proxy-list/main/online/http.txt",
"https://raw.githubusercontent.com/UserR3X/proxy-list/main/online/https.txt",
"https://raw.githubusercontent.com/UptimerBot/proxy-list/main/proxies/http.txt",
"https://raw.githubusercontent.com/proxy4parsing/proxy-list/main/http.txt",
"https://raw.githubusercontent.com/mertguvencli/http-proxy-list/main/proxy-list/data.txt",
"https://raw.githubusercontent.com/hendrikbgr/Free-Proxy-Repo/master/proxy_list.txt",
"https://raw.githubusercontent.com/almroot/proxylist/master/list.txt",
"https://raw.githubusercontent.com/aslisk/proxyhttps/main/https.txt",
"https://raw.githubusercontent.com/saisuiu/uiu/main/free.txt",
"https://raw.githubusercontent.com/hanwayTech/free-proxy-list/main/http.txt",
"https://raw.githubusercontent.com/hanwayTech/free-proxy-list/main/https.txt",
"https://raw.githubusercontent.com/Zaeem20/FREE_PROXIES_LIST/master/http.txt",
"https://raw.githubusercontent.com/Zaeem20/FREE_PROXIES_LIST/master/https.txt",
"https://raw.githubusercontent.com/rx443/proxy-list/online/all.txt",
"https://raw.githubusercontent.com/Anonym0usWork1221/Free-Proxies/main/http.txt",
"https://raw.githubusercontent.com/Anonym0usWork1221/Free-Proxies/main/https.txt",
"https://raw.githubusercontent.com/zevtyardt/proxy-list/main/http.txt",
"https://raw.githubusercontent.com/vakhov/fresh-proxy-list/master/proxylist.txt",
"https://api.proxyscrape.com/v2/?request=displayproxies&protocol=all&timeout=10000&country=all&ssl=all&anonymity=all",
"https://raw.githubusercontent.com/roosterkid/openproxylist/main/HTTPS_RAW.txt",
"https://raw.githubusercontent.com/hookzof/socks5_list/master/proxy.txt",
"https://raw.githubusercontent.com/TheSpeedX/PROXY-List/master/http.txt",
"https://raw.githubusercontent.com/monosans/proxy-list/main/proxies/http.txt",
"https://raw.githubusercontent.com/TheSpeedX/PROXY-List/master/http.txt",
"https://raw.githubusercontent.com/mmpx12/proxy-list/master/http.txt",
"https://raw.githubusercontent.com/mmpx12/proxy-list/master/https.txt",
"https://raw.githubusercontent.com/ShiftyTR/Proxy-List/master/http.txt",
"https://raw.githubusercontent.com/ShiftyTR/Proxy-List/master/https.txt",
"https://raw.githubusercontent.com/proxy4parsing/proxy-list/main/http.txt",
"https://raw.githubusercontent.com/saschazesiger/Free-Proxies/master/proxies/http.txt",
"https://raw.githubusercontent.com/mertguvencli/http-proxy-list/main/proxy-list/data.txt",
"https://raw.githubusercontent.com/Anonym0usWork1221/Free-Proxies/main/http.txt",
"https://raw.githubusercontent.com/Anonym0usWork1221/Free-Proxies/main/https.txt",
"https://raw.githubusercontent.com/ErcinDedeoglu/proxies/main/proxies/http.txt",
"https://raw.githubusercontent.com/tahaluindo/proxy-list/main/proxy-list/data.txt",
"https://raw.githubusercontent.com/proxy4parsing/proxy-list/main/http.txt",
"https://raw.githubusercontent.com/almroot/proxylist/master/list.txt",
"https://raw.githubusercontent.com/mertguvencli/http-proxy-list/main/proxy-list/data.txt",
"https://raw.githubusercontent.com/caliphdev/Proxy-List/master/http.txt",
"https://raw.githubusercontent.com/TheSpeedX/PROXY-List/master/http.txt",
"https://api.openproxylist.xyz/socks4.txt",
"https://api.openproxylist.xyz/socks5.txt",
"https://api.proxyscrape.com/?request=displayproxies&proxytype=socks4",
"https://api.proxyscrape.com/v2/?request=displayproxies&protocol=socks4",
"https://api.proxyscrape.com/?request=displayproxies&proxytype=socks5",
"https://api.proxyscrape.com/v2/?request=displayproxies&protocol=socks5",
"https://proxy-list.download/api/v1/get?type=socks4",
"https://proxy-list.download/api/v1/get?type=socks5",
"https://proxyspace.pro/socks4.txt",
"https://proxyspace.pro/socks5.txt",
"https://raw.githubusercontent.com/ALIILAPRO/Proxy/main/socks4.txt",
"https://raw.githubusercontent.com/ALIILAPRO/Proxy/main/socks5.txt",
"https://raw.githubusercontent.com/B4RC0DE-TM/proxy-list/main/SOCKS4.txt",
"https://raw.githubusercontent.com/B4RC0DE-TM/proxy-list/main/SOCKS5.txt",
"https://raw.githubusercontent.com/hookzof/socks5_list/master/proxy.txt",
"https://raw.githubusercontent.com/jetkai/proxy-list/main/online-proxies/txt/proxies-socks4.txt",
"https://raw.githubusercontent.com/jetkai/proxy-list/main/online-proxies/txt/proxies-socks5.txt",
"https://raw.githubusercontent.com/manuGMG/proxy-365/main/SOCKS4.txt",
"https://raw.githubusercontent.com/manuGMG/proxy-365/main/SOCKS5.txt",
"https://raw.githubusercontent.com/mmpx12/proxy-list/master/socks4.txt",
"https://raw.githubusercontent.com/mmpx12/proxy-list/master/socks5.txt",
"https://raw.githubusercontent.com/monosans/proxy-list/main/proxies/socks4.txt",
"https://raw.githubusercontent.com/monosans/proxy-list/main/proxies/socks5.txt",
"https://raw.githubusercontent.com/monosans/proxy-list/main/proxies_anonymous/socks4.txt",
"https://raw.githubusercontent.com/monosans/proxy-list/main/proxies_anonymous/socks5.txt",
"https://raw.githubusercontent.com/MuRongPIG/Proxy-Master/main/socks4.txt",
"https://raw.githubusercontent.com/MuRongPIG/Proxy-Master/main/socks5.txt",
"https://raw.githubusercontent.com/officialputuid/KangProxy/KangProxy/socks5/socks4.txt",
"https://raw.githubusercontent.com/officialputuid/KangProxy/KangProxy/socks5/socks5.txt",
"https://raw.githubusercontent.com/prxchk/proxy-list/main/socks4.txt",
"https://raw.githubusercontent.com/prxchk/proxy-list/main/socks5.txt",
"https://raw.githubusercontent.com/rdavydov/proxy-list/main/proxies/socks4.txt",
"https://raw.githubusercontent.com/rdavydov/proxy-list/main/proxies/socks5.txt",
"https://raw.githubusercontent.com/rdavydov/proxy-list/main/proxies_anonymous/socks4.txt",
"https://raw.githubusercontent.com/rdavydov/proxy-list/main/proxies_anonymous/socks5.txt",
"https://raw.githubusercontent.com/roosterkid/openproxylist/main/SOCKS4_RAW.txt",
"https://raw.githubusercontent.com/roosterkid/openproxylist/main/SOCKS5_RAW.txt",
"https://raw.githubusercontent.com/RX4096/proxy-list/main/online/socks4.txt",
"https://raw.githubusercontent.com/RX4096/proxy-list/main/online/socks5.txt",
"https://raw.githubusercontent.com/saschazesiger/Free-Proxies/master/proxies/socks4.txt",
"https://raw.githubusercontent.com/saschazesiger/Free-Proxies/master/proxies/socks5.txt",
"https://raw.githubusercontent.com/ShiftyTR/Proxy-List/master/socks4.txt",
"https://raw.githubusercontent.com/ShiftyTR/Proxy-List/master/socks5.txt",
"https://raw.githubusercontent.com/TheSpeedX/PROXY-List/master/socks4.txt",
"https://raw.githubusercontent.com/TheSpeedX/PROXY-List/master/socks5.txt",
"https://raw.githubusercontent.com/UptimerBot/proxy-list/main/proxies/socks4.txt",
"https://raw.githubusercontent.com/UptimerBot/proxy-list/main/proxies/socks5.txt",
"https://raw.githubusercontent.com/Zaeem20/FREE_PROXIES_LIST/master/socks4.txt",
"https://raw.githubusercontent.com/Zaeem20/FREE_PROXIES_LIST/master/socks5.txt",
"https://raw.githubusercontent.com/zevtyardt/proxy-list/main/socks4.txt",
"https://raw.githubusercontent.com/zevtyardt/proxy-list/main/socks5.txt",
"https://spys.me/socks.txt",
"https://spys.one/en/socks-proxy-list/",
"https://api.proxyscrape.com/?request=displayproxies&proxytype=socks4&country=all",
"https://www.proxy-list.download/api/v1/get?type=socks4",
"https://www.proxyscan.io/download?type=socks4",
"https://raw.githubusercontent.com/TheSpeedX/PROXY-List/master/socks4.txt",
"https://api.openproxylist.xyz/socks4.txt",
"https://raw.githubusercontent.com/ShiftyTR/Proxy-List/master/socks4.txt",
"https://raw.githubusercontent.com/roosterkid/openproxylist/main/SOCKS4_RAW.txt",
"https://raw.githubusercontent.com/monosans/proxy-list/main/proxies/socks4.txt",
"https://raw.githubusercontent.com/mmpx12/proxy-list/master/socks4.txt",
"https://raw.githubusercontent.com/UptimerBot/proxy-list/main/proxies/socks4.txt",
"https://proxylist.live/nodes/socks4_1.php?page=1&showall=1",
"https://openproxy.space/list/socks4",
"https://github.com/hanwayTech/free-proxy-list/blob/main/socks4.txt",
"https://raw.githubusercontent.com/Zaeem20/FREE_PROXIES_LIST/master/socks4.txt",
"https://raw.githubusercontent.com/Anonym0usWork1221/Free-Proxies/main/socks4.txt",
"https://proxyspace.pro/socks4.txt",
"https://raw.githubusercontent.com/ObcbO/getproxy/master/socks4.txt",
"https://raw.githubusercontent.com/zevtyardt/proxy-list/main/socks4.txt",
"https://api.proxyscrape.com/v2/?request=getproxies&protocol=socks5&timeout=10000&country=all&simplified=true",
"https://www.proxy-list.download/api/v1/get?type=socks5",
"https://raw.githubusercontent.com/TheSpeedX/PROXY-List/master/socks5.txt",
"https://raw.githubusercontent.com/hookzof/socks5_list/master/proxy.txt",
"https://raw.githubusercontent.com/ShiftyTR/Proxy-List/master/socks5.txt",
"https://api.openproxylist.xyz/socks5.txt",
"https://raw.githubusercontent.com/roosterkid/openproxylist/main/SOCKS5_RAW.txt",
"https://raw.githubusercontent.com/monosans/proxy-list/main/proxies/socks5.txt",
"https://raw.githubusercontent.com/mmpx12/proxy-list/master/socks5.txt",
"https://raw.githubusercontent.com/manuGMG/proxy-365/main/SOCKS5.txt",
"https://raw.githubusercontent.com/UptimerBot/proxy-list/main/proxies/socks5.txt",
"https://github.com/hanwayTech/free-proxy-list/blob/main/socks5.txt",
"https://raw.githubusercontent.com/Zaeem20/FREE_PROXIES_LIST/master/socks5.txt",
"https://openproxy.space/list/socks5",
"https://proxylist.live/nodes/socks5_1.php?page=1&showall=1",
"https://spys.me/socks.txt",
"https://raw.githubusercontent.com/Anonym0usWork1221/Free-Proxies/main/socks5.txt",
"https://proxyspace.pro/socks5.txt",
"https://raw.githubusercontent.com/zevtyardt/proxy-list/main/socks5.txt",
"https://raw.githubusercontent.com/yemixzy/proxy-list/main/proxy-list/data.txt",
"https://raw.githubusercontent.com/andigwandi/free-proxy/main/proxy_list.txt",
"https://raw.githubusercontent.com/ObcbO/getproxy/master/http.txt",
"https://raw.githubusercontent.com/ObcbO/getproxy/master/https.txt",
"https://sheesh.rip/http.txt",
"https://proxyspace.pro/http.txt",
"https://proxyspace.pro/https.txt"
"https://raw.githubusercontent.com/jetkai/proxy-list/main/online-proxies/txt/proxies-https.txt",
"https://raw.githubusercontent.com/jetkai/proxy-list/main/archive/txt/proxies-https.txt",
"https://raw.githubusercontent.com/roosterkid/openproxylist/main/HTTPS_RAW.txt",
"https://www.proxy-list.download/api/v1/get?type=https",
"https://www.proxy-list.download/api/v1/get?type=https"
]

for h in http_:
    saveFile(http, h)

Write.Print("[!] Successfully Scraped And Saved\n", Colors.white_to_red, interval=0)
time.sleep(1)

# SOCKS4 Proxies Sources
allsocks_ = [
]

for s in allsocks_:
    saveFile(allsocks, s)
"https://www.proxy-list.download/api/v1/get?type=https",
"https://www.proxy-list.download/api/v1/get?type=https",
Write.Print("[!] Successfully Scraped And Saved All Sock Proxies!\n", Colors.white_to_red, interval=0)
time.sleep(1)


# Closing Files
http.close()
allsocks.close()

# Done!
time.sleep(1)
Write.Print("Thanks for using my tools <3\n", Colors.red_to_yellow, interval=0.06)
input()