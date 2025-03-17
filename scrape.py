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
Death Networks
Telegram: @keccy
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
"https://github.com/zebbern/Proxy-Scraper/raw/refs/heads/main/http.txt",
"https://github.com/zebbern/Proxy-Scraper/raw/refs/heads/main/https.txt",
"https://github.com/zebbern/Proxy-Scraper/raw/refs/heads/main/proxydump.txt",
"https://github.com/zebbern/Proxy-Scraper/raw/refs/heads/main/socks4.txt",
"https://github.com/zebbern/Proxy-Scraper/raw/refs/heads/main/socks5.txt",
"https://github.com/MrMarble/proxy-list/raw/refs/heads/main/all.txt",
"https://github.com/TuanMinPay/live-proxy/raw/refs/heads/master/all.txt",
"https://github.com/dpangestuw/Free-Proxy/raw/refs/heads/main/All_proxies.txt",
"https://github.com/saisuiu/Lionkings-Http-Proxys-Proxies/raw/refs/heads/main/free.txt",
"https://github.com/TheSpeedX/PROXY-List/raw/refs/heads/master/http.txt",
"https://github.com/TheSpeedX/PROXY-List/raw/refs/heads/master/socks4.txt",
"https://github.com/TheSpeedX/PROXY-List/raw/refs/heads/master/socks5.txt",
"https://github.com/vakhov/fresh-proxy-list/raw/refs/heads/master/http.txt",
"https://github.com/vakhov/fresh-proxy-list/raw/refs/heads/master/https.txt",
"https://github.com/Zaeem20/FREE_PROXIES_LIST/raw/refs/heads/master/http.txt",
"https://github.com/Zaeem20/FREE_PROXIES_LIST/raw/refs/heads/master/https.txt",
"https://github.com/Zaeem20/FREE_PROXIES_LIST/raw/refs/heads/master/socks4.txt",
"https://github.com/Zaeem20/FREE_PROXIES_LIST/raw/refs/heads/master/socks5.txt",
"https://github.com/ErcinDedeoglu/proxies/raw/refs/heads/main/proxies/http.txt",
"https://github.com/ErcinDedeoglu/proxies/raw/refs/heads/main/proxies/https.txt",
"https://github.com/ErcinDedeoglu/proxies/raw/refs/heads/main/proxies/socks4.txt",
"https://github.com/ErcinDedeoglu/proxies/raw/refs/heads/main/proxies/socks5.txt",
"https://github.com/yemixzy/proxy-list/raw/refs/heads/main/proxies/http.txt",
"https://github.com/yemixzy/proxy-list/raw/refs/heads/main/proxies/socks4.txt",
"https://github.com/yemixzy/proxy-list/raw/refs/heads/main/proxies/socks5.txt",
"https://github.com/monosans/proxy-list/raw/refs/heads/main/proxies/all.txt",
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