from scapy.all import *

ping = ICMP(type=8)

packet = IP(src="10.33.79.113", dst="10.33.79.176")

frame = Ether(src="20:16:b9:2a:02:70", dst="28:7f:cf:99:86:8a")

final_frame = frame/packet/ping

answers, unanswered_packets = srp(final_frame, timeout=10)

print(f"Pong reçu : {answers[0]}")