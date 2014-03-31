% Sécurité des systèmes informatiques
% Nissim Zerbib, Alex Auvolat
% 2014-04-04

## Introduction

Bla bla bla

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

## Les failles du web : les injections SQL

## Les failles du web : les failles XSS

## Exploitation de failles humaines : l'ingéniérie sociale

# II. Cryptographie

## Scénario 1 : envoi de mail chiffré

\center\includegraphics[width=10cm]{aliceBob.jpg}

## Solution : GPG, explication technique

\center\includegraphics[width=10cm]{asymmetric.png}

## Scénario 2 : communication sécurisée

## Solution : SSL, explication technique

\center\includegraphics[width=9cm]{diffie1.jpg}

## Scénario 3 : stockage de mots de passe

## Solution : le hashage, explication technique

## Conclusion

\center{On n'est jamais à l'abri...}



