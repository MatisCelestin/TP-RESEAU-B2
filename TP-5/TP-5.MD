# TP5 SECU : Exploit, pwn, fix

🌞 Déterminer

- à quelle IP ce client essaie de se co quand on le lance
- à quel port il essaie de se co sur cette IP
```
Internet Protocol Version 4, Src: 10.33.74.119, Dst: 10.1.1.2
Destination Port: 13337
```

🌞 Scanner le réseau

- trouvez une ou plusieurs machines qui héberge une app sur ce port
- votre scan nmap doit être le plus discret possible : il ne teste que ce port là, rien d'autres
- testez d'abord dans un réseau avec des VMs


```
sudo nmap -sS -p 13337 10.33.64.0/20 > Bureau/reseau/scan.txt 

PORT      STATE SERVICE
13337/tcp open  unknown
MAC Address: E4:B3:18:48:36:68 (Intel Corporate)
```

