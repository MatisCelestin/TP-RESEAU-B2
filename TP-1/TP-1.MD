## II. Go further

☀️ Hosts ?

```
- matis@thinkpad:~$ ping b2.hello.vous 
PING b2.hello.vous (1.1.1.1) 56(84) bytes of data.
64 bytes from b2.hello.vous (1.1.1.1): icmp_seq=1 ttl=56 time=33.1 ms
64 bytes from b2.hello.vous (1.1.1.1): icmp_seq=2 ttl=56 time=32.1 ms
64 bytes from b2.hello.vous (1.1.1.1): icmp_seq=3 ttl=56 time=33.1 ms
```

☀️ Go mater une vidéo youtube et déterminer, pendant qu'elle tourne...

```
- matis@thinkpad:~$ ps aux | grep firefox
matis      25663
- matis@thinkpad:~$ sudo ss -tnp | grep 25663
ESTAB 0      0       192.168.0.30:57516  172.64.155.209:443  users:(("firefox",pid=25663,fd=132))
- Port serveur : 443
- PC local : 57516 
```

☀️ Requêtes DNS

```
- matis@thinkpad:~$ host www.thinkerview.com
www.thinkerview.com has address 188.114.97.2
-matis@thinkpad:~$ nslookup 143.90.88.12
12.88.90.143.in-addr.arpa	name = EAOcf-140p12.ppp15.odn.ne.jp.
```

☀️ Hop hop hop

```
matis@thinkpad:~$ traceroute www.ynov.com
traceroute to www.ynov.com (104.26.11.233), 30 hops max, 60 byte packets
 1  _gateway (192.168.0.254)  9.114 ms  9.074 ms  9.403 ms
 2  * * *
 3  * * *
 4  prs-b3-link.ip.twelve99.net (62.115.46.68)  43.649 ms * *
 5  cloudflare-ic-382666.ip.twelve99-cust.net (213.248.75.93)  46.850 ms  51.129 ms  49.510 ms
 6  141.101.67.83 (141.101.67.83)  69.516 ms 141.101.67.54 (141.101.67.54)  38.880 ms 141.101.67.89 (141.101.67.89)  39.185 ms
 7  104.26.11.233 (104.26.11.233)  32.291 ms  32.204 ms  32.792 ms
```

☀️ IP publique

```
Grace à la commande traceroute on obtient l'IP suivante : 104.26.11.233
```

## III. Le requin

☀️ Capture ARP

```
[https://github.com/MatisCelestin/TP-RESEAU-B2/tree/main/TP-1/CAPTURE](./CAPTURE/arp.pca)
```

☀️ Capture DNS

```
[https://github.com/MatisCelestin/TP-RESEAU-B2/blob/main/TP-1/CAPTURE/dns.pcap](./CAPTURE/dns.pcap)
```

☀️ Capture TCP

```
[https://github.com/MatisCelestin/TP-RESEAU-B2/blob/main/TP-1/CAPTURE/tcp.pcap](./CAPTURE/tcp.pcap)
```
