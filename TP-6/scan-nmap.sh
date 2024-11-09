root@fac50de5d760:~# nmap -p-  172.18.0.1/16
Starting Nmap 7.80 ( https://nmap.org ) at 2024-11-09 15:57 UTC
Nmap scan report for 172.18.0.1
Host is up (0.000014s latency).
Not shown: 65533 closed ports
PORT      STATE SERVICE
22/tcp    open  ssh
22222/tcp open  easyengine
MAC Address: 02:42:F6:AB:4D:02 (Unknown)

Nmap scan report for client.arp-spoofing-dist-2_default (172.18.0.3)
Host is up (0.000018s latency).
All 65535 scanned ports on client.arp-spoofing-dist-2_default (172.18.0.3) are closed
MAC Address: 02:42:AC:12:00:03 (Unknown)

Nmap scan report for db.arp-spoofing-dist-2_default (172.18.0.4)
Host is up (0.000018s latency).
Not shown: 65534 closed ports
PORT     STATE SERVICE
3306/tcp open  mysql
MAC Address: 02:42:AC:12:00:04 (Unknown)
