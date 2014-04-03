% Sécurité des systèmes informatiques
% Alex Auvolat, Nissim Zerbib
% 4 avril 2014

## Introduction


La sécurité est une chaîne : elle est aussi solide que le plus faible de ses maillons.

Facteurs les plus souvent en cause :

  - erreur humaine
  - faille dans l'implémentation

Intérêts nationaux et économiques majeurs mis en cause :
  
  - certaines administrations et certains dirigeants des principales puissances mondiales sont encore vulnérables !
  - vol d'informations et de technologies
  - cybercriminalité et surveillance des populations

Bien sûr les illustrations ne sont pas de nous.

## Niveau de conscience de l'utilisateur lambda quant à l'importance de ces questions

- Une majorité de gens utilise des systèmes peu sécurisés.
- Les mots de passe les plus utilisés actuellement : 123456, password, motdepasse, qwerty, azerty etc.
- Certains chefs d'état et de services de renseignements, de polices manquent d'une formation basique à la cryptographie. Entre la corbeille non vidée de l'affaire Clear Stream, les agendas papiers de gens qui touchent 500000 euros de prime d'indic en liquide, ou un certain Paul Bismuth qui pense échapper à des écoutes en changeant de portable, il y a encore fort à faire pour éveiller les esprits.
- Pendant ce temps, les services secrets de divers pays écoutent toutes les communications mondiales, de nombreux cyber-attaquants sont aux aguets.

## Trouver le bon équilibre

Il faut adapter la sécurité de son infrastructure à l'ampleur de la menace et à la chaîne entière. Inutile de tout chiffrer si les utilisateurs sont totalement imprudents.

# I. Failles de sécurité et exploitation

## La sécurité sous Unix

Entités fondamentales pour la sécurité :

 - utilisateurs
 - groupes d'utilisateurs (par exemple `users` ou `wheel`)

Permissions pour un fichiers :

 - trois bits de droits (lecture, écriture, exécution)
 - attribués à trois entités (utilisateur, groupe, autre)
 - plus le bit `setuid`

## Le bit `setuid` : un bon modèle de sécurité ?

- Un programme appartenant à `root` et ayant le bit `setuid` sera exécuté en tant que
  `root` dans tous les cas, même s'il est lancé par un utilisateur
- Intérêt : permet l'implémentation de commandes telles que `su` ou `sudo`.
- Inconvénient : si le programme est vulnérable (*buffer overflow* par exemple), ou s'il a
  été modifié, cela permet une escalade des privilèges.

## Le `chroot` : un bon modèle de sécurité ?

- C'est un appel système qui permet de restreindre la portion du système de
  fichiers qui est visible pour l'application.
- Intérêt : exécuter un service ou un programme dangereux dans un environnement restreint,
  où il ne pourra pas *faire trop de mal*.
- Inconvénient : un programme qui tourne en tant que `root` dans un environnement chrooté
  peut facilement s'échapper. D'autre part, seul `root` peut appeller l'appel système `chroot`.
  Il faut donc penser à toujours abandonner ses privilèges `root` après avoir fait un `chroot`.
- D'autres méthodes d'isolement ont été développées : Jails de FreeBSD, virtualisation, ...

## La faille classique : le *buffer overflow*

- Origine de la faille : erreur de programmation (omission volontaire ou erreur d'inattention)
- Tous les programmes écrits dans un langage non managé comme C ou C++ sont vulnérables
- En particulier : le noyau, les services réseau (serveur mail, web, SQL, ...), etc.
- L'exploitation d'un *buffer overflow* permet d'exécuter du code arbitraire (injection de code)

## Le *buffer overflow* en pratique

(montrer du code, faire une démo)

## Stratégies de protection

- Addess space layout randomization
- Data execution prevention
- Certification statique des programmes

## Attaques sur le réseau : les attaques DoS et DDoS

## Exemple d'attaque DDoS : l'amplification DNS

## Les attaques *Man In The Middle*

Illustration avec Wireshark.

## Les failles du web : les injections SQL

## Les failles du web : les failles XSS


## Introduction de failles dans le code source


La plupart des logiciels propriétaires possèdent (probablement) des backdoors : \scriptsize
<https://www.schneier.com/blog/archives/2013/09/the_nsa_is_brea.html>


Mais les logiciels libres ne sont pas non plus à l'abris :
\scriptsize

<http://www.infoq.com/news/2013/10/Linux-Backdoor?utm_source=tuicool>


Pour ceux qui voudraient utiliser un maximum de services et logiciels libres, sûrs etc. : \scriptsize <https://prism-break.org/fr/>

## Exploitation de failles humaines : l'ingénierie sociale

Mêmes les infrastructures les mieux protégées ne sont pas à l'abri :

\scriptsize

<http://www.thesecurityblogger.com/?p=1903>

## Failles et fuites matérielles

Tempest

Article Shamir : Unsafe and sound

Composants électroniques

# II. Cryptographie

## Objectifs de la cryptographie

> - Confidentialité : le message reste secret
> - Authentification : le message vient bien de la bonne entité
> - Intégrité : le message n'a pas été modifé
> -  Anonymat : on ne peut trouver de qui vient le message



##

\center\includegraphics[width=9cm]{cryptoduck.jpg}

##

\center\includegraphics[width=9cm]{nobear.jpg}


## Fondamentaux

  - On n'invente pas son propre algorithme de cryptographie (à moins d'être cryptologue) ! Il est probable qu'il soit vulnérable.
Cela vaut aussi pour les protocoles, implémentations, etc...

  - Principe numéro 2 de Kerchoffs : Il [le cryptosystème] faut qu’il n’exige pas le secret, et qu’il puisse sans inconvénient tomber entre les mains de l’ennemi.

Le seul secret doit être un paramètre de l'algorithme : la clé.

## Cryptographie symétrique

Le principe général : le chiffrement doit cacher les propriétés statistiques du message. Chaque bit du message crypté doit idéalement dépendre de tous les bits du message original.
Le nombre de clés disponibles doit être grand pour empêcher une recherche exhaustive.

  - Primitif : César, Vigenère
  - Standards : DES, AES et autres
  - Modes de chiffrement


## Scénario 1 : envoi de mail chiffré et cryptographie asymétrique

Comment échanger la clé ?

\center\includegraphics[width=10cm]{aliceBob.jpg}


## Solution : cryptographie asyymétrique, GPG, explication technique

\center\includegraphics[width=10cm]{asymmetric.png}

## Fonctionnement : chiffrage

\center\includegraphics[width=10cm]{cryptagePGP.png}


## Fonctionnement : déchiffrage


\center\includegraphics[width=10cm]{decryptPGP.png}


## L'exemple d'EL Gamal


## Scénario 2 : communication sécurisée

Empêcher les attaques de type Man in the Middle : comment être sûr qu'on se connecte bien au bon serveur.

## Solution : SSL, explication technique

\center\includegraphics[width=9cm]{diffie1.jpg}

## Scénario 3 : stockage de mots de passe

Pour les services webs : L'astuce est de ne jamais les stocker !

Faille Adobe : les mots de passe étaient chiffrés et pourtant...

\scriptsize

<http://nakedsecurity.sophos.com/2013/11/04/anatomy-of-a-password-disaster-adobes-giant-sized-cryptographic-blunder/>

## Solution : le hachage, explication technique



Ajouter du sel pour empêcher l'utilisation efficace de tables précalculées.

## Scénario 4 : anonymiser ses actions sur Internet

L'exemple de Tor : à partir de primitives cryptographiques de base, on peut réaliser différentes architectures.

\center\includegraphics[width=8.1cm]{tor.jpg}

# III. Logiciels malicieux

## Les virus

  - Un virus est un programme auto-reproducteur.
  - Charge finale : le virus est vecteur de l'attaque.

## Autres malwares

## Conclusion

La mise en place et le maintien d'une infrastructure sécurisée repose à la fois sur une expertise (respect à la lettre des standards cryptographiques, utilisation de logiciels reconnus) et sur une bonne connaissance des utilisateurs.

\center{On n'est jamais à l'abri...}



