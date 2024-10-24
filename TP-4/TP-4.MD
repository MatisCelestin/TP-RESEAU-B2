# TP4 SECU : Exfiltration

## I. Getting started Scapy

🌞 ping.py
- un ping vers la passerelle du réseau de l'école
```
from scapy.all import *

ping = ICMP(type=8)

packet = IP(src="10.33.79.113", dst="10.33.79.176")

frame = Ether(src="20:16:b9:2a:02:70", dst="28:7f:cf:99:86:8a")

final_frame = frame/packet/ping

answers, unanswered_packets = srp(final_frame, timeout=10)

print(f"Pong reçu : {answers[0]}")
```
- affiche dans le terminal le pong reçu
```
matis@thinkpad:~/Bureau/tp4$ sudo python3 tp4-scapy.py 
Begin emission:
Finished sending 1 packets.
..*
Received 3 packets, got 1 answers, remaining 0 packets
Pong reçu : (<Ether  dst=28:7f:cf:99:86:8a src=20:16:b9:2a:02:70 type=IPv4 |<IP  frag=0 proto=icmp src=10.33.79.113 dst=10.33.79.176 |<ICMP  type=echo-request |>>>, <Ether  dst=20:16:b9:2a:02:70 src=28:7f:cf:99:86:8a type=IPv4 |<IP  version=4 ihl=5 tos=0x0 len=28 id=58066 flags= frag=0 ttl=64 proto=icmp chksum=0xe4ab src=10.33.79.176 dst=10.33.79.113 |<ICMP  type=echo-reply code=0 chksum=0x0 id=0x0 seq=0x0 |>>>)
```

🌞 tcp_cap.py

codes
```

```

