# (APPENDIX) Appendices {-}

# Installation de la SciViews Box {#svbox}

![](images/svBox-256.png)

La SciViews Box est une machine virtuelle (c'est-à-dire, l'équivalent d'un ordinateur complet, mais "dématérialisé" et utilisable à l'intérieur de n'importe quel autre ordinateur physique) spécialement configurée pour traiter des données et réaliser des documents scientifiques.

<iframe width="770" height="433" src="http://www.youtube.com/embed/yIVXjl4SwVo?rel=0" frameborder="0" allowfullscreen></iframe>

L'avantage d'utiliser une machine virtuelle dans le contexte qui nous concerne ici est double:

1) Elle est **complètement pré-configurée et pré-testée**.

2) Comme tout le monde utilise la même machine virtuelle, les résultats obtenus chez l'un sont parfaitement **reproductibles** chez d'autres.

L'installation est simple, mais il y a quelques pièges. Suivez le guide...

## Prérequis

Avant d'installer la SciViews Box 2018, vérifiez que votre ordinateur répond aux conditions requises et qu'il est correctement configuré.

### Ordinateur

Il vous faut:

- Un ordinateur suffisamment puissant équipé d'un **processeur Intel Core i5 ou i7, ou son équivalent AMD**, récent si possible. Les tablettes et les machines basiques avec processeur Atom, par exemple, ne sont pas suffisantes. Idéalement, un processeur bi-coeur - bi-thread, ou quadri-coeur est souhaitable.
- Au moins **4Go de mémoire vive**. Le double, voire plus, est nécessaire pour analyser des gros jeux de données mais 4Go devraient suffire pour les analyses de tableaux de tailles plus modestes (dizaines de colonnes _versus_ milliers de lignes couramment rnecontrés en biologie).
- Un **disque dur rapide** (un disque SSD est un plus), avec environ 20Go libres que vous pourrez consacrer à la SciViews Box.
- Une carte graphique de bonne qualité, mais qui n'a pas besoin d'être une bête de course, et un écran confortable. Une résolution de 1024x768 est un strict minimum.
- Un **système d'exploitation récent, et si possible, 64bit**: Linux tel Debian 8 (Jessie) ou 9 (Stretch), Ubuntu 16.04 Xenial ou supérieur, ..., Windows 7 ou plus, Mac OS X 10.10 Yosemite ou plus.
- Une **connection Internet** est souhaitable, voire indispensable, en fonction des fichiers d'installation que vous possédez déjà localement ou non.


### Activation de la fonction de virtualisation dans l'ordinateur

La virtualisation fait appel à un jeu d'instructions disponible sur pratiquement tous les processeurs modernes (Intel VT-x ou AMD-v). Malheureusement, elle est désactivée par défaut sur quasi tous les PC (mais les Macs sont, eux, configurés correctement en sortie d'usine). Tant que ces instructions de virtualisation ne seront pas activées, le programme d'installation de la SciViews Box va bloquer avec le message suivant:

![](images/annexe1/msg_no-virtualization.png)

Même si vous arriviez à l'installer quand même, vous ne pourriez pas la démarrer, et verriez juste le message suivant (issu de la version précédente de la SciViews Box):

![](images/annexe1/msg_no-virtualization2.png)

Pour activer ce jeu d'instructions, il faut aller dans le **BIOS**, c'est-à-dire, le petit programme qui démarre votre ordinateur. Il n'y a malheureusement pas de recette unique car chaque constructeur a sa propre façon de faire. De plus, l'endroit où il faut aller dans les menus de configuration diffère aussi d'un ordinateur à l'autre. Cependant, la procédure générale est la suivante:

- Redémarrer l'ordinateur,
- Au tout début du démarrage, il faut appuyer sur une touche ou une combinaison de touches (par exemple, `DEL`, `F2`, ...). Restez à l'affût d'un message furtif qui l'indique à l'écran,
- Une fois entré dans le BIOS, repérez l'entrée correspondant au jeu d'instructions de virtualisation. Vous aurez plus de chances en regardant dans le menu relatif au processeur, ou dans les options avancées. Recherchez une entrée de type "Virtualisation", "Intel Virtual Technology", ou "Instructions AMD-v". Activez cette entrée (cela n'aura aucun effet sur les logiciels que vous avez installés jusqu'ici et qui n'utilisent pas cette fonction),
- Sortez du BIOS en sauvegardant les modifications (suivez les instructions à l'écran),
- Redémarrez l'ordinateur.

![](images/annexe1/bios-virtualisation.jpg)

Si vous n'arrivez pas à entrer dans le BIOS, ou à trouver l'entrée correspondante dans celui-ci, rechercher "BIOS Virtualization" accompagné de la marque et du modèle de votre ordinateur dans votre moteur de recherche internet favori. Vous y trouverez certainement des instructions plus précises relatives à votre ordinateur. [Ce site](https://www.tactig.com/enable-intel-vt-x-amd-virtualization-pc-vmware-virtualbox/) liste quelques uns de raccourcis claviers à utiliser en fonction de la marque des ordinateurs pour entrer dans le BIOS.

**Si votre ordinateur est conforme aux spécifications ci-dessus, et si la virtualisation est activée, vous êtes maintenant prêt à installer la SciViews Box!**


## Installation

Vous allez devoir d'abord installer **[VirtualBox](http://www.virtualbox.org)**, un logiciel gratuit et libre qui se chargera de gérer votre machine virtuelle. Ensuite, vous installerez la SciViews Box en elle-même. Pour finir, vous aurez aussi besoin de **[Github Desktop](https://desktop.github.com)**.


### VirtualBox

![](images/annexe1/virtualbox.png)

Récupérez l'installateur correspondant à votre système [ici](https://www.virtualbox.org/wiki/Downloads). L'installation avec tous les paramètres par défaut convient. Il se peut que vous voyez un message vous indiquant que VirtualBox doit réinitialiser le réseau ou une autre ressource. Vérifiez que tous les documents en cours éventuels sont sauvegardés, et ensuite, vous pourrez continuer l'installation sans risques.

![](images/annexe1/virtualbox_install_warning.png)

De même, sous Windows, l'installateur de VirtualBox vous préviendra peut-être qu'il doit installer l'un ou l'autre périphérique. Vous pouvez également continuer sans craintes (précaution prise par Microsoft, mais ces périphériques fonctionnent bien).

![](images/annexe1/virtualbox_install_device.png)


### SciViews Box

![](images/annexe1/svbox_screenshot.png)

La procédure d'installation de la SciViews Box diffère selon le système.

#### Installation sous Windows

Chargez l'installateur [ici](http://go.sciviews.org/svbox2018a-win) ou récupérez-le depuis le disque `StudentTemp` de la salle informatique (` SDD\Software\SciViews Box 2018`). Pensez aussi à placer le fichier `svbox2018a.vdi.xz` dans le même répertoire que l'installateur `svbox2018a_win_setup.exe` ou vous devrez le télécharger lors de l'installation (il pèse tout de même 2,9Gb)! Lancez l'installation. Vous verrez l'écran suivant. Vous pouvez cliquer 'Yes'/'Oui'.

![](images/annexe1/svbox_install_warning.png)

Si le fichier `svbox2018a.vdi.xz` n'est pas présent, il se charge (cliquez sur "Details" pour suivre l'opération):

![](images/annexe1/svbox_install_download.png)

A la fin de l'installation, vous verrez qu'il y a encore une opération sélectionnée obligatoire: la décompression du disque virtuel de la SciViews Box:

![](images/annexe1/svbox_install_done.png)

En cliquant 'Finish', cette décompression démarre. **Ne l'interrompez surtout pas. Sinon, votre SciViews Box ne pourra pas démarrer et vous devrez tout recommencer à zéro en désinstallant et réinstallant complètement l'application**.

![](images/annexe1/svbox_install_uncompress.png)

Losque tout est installé, vous avez une nouvelle icône sur votre bureau. Poursuivez à la section suivante pour démarrer et paramétrer votre SciViews Box.

![](images/annexe1/svbox_install_desktop_icon.png)

En option, vous pouvez épingler le programme dans la barre des tâches. Il sera plus facilement accessible (voir ci-dessous).

![](images/annexe1/pin-in-taskbar.gif)

#### Installation sur un Mac

Chargez l'installateur [ici](http://go.sciviews.org/svbox2018a-mac) ou récupérez le depuis le disque `StudentTemp` de la salle informatique (` SDD/Software/SciViews Box 2018`). Si vous le pouvez, placez le fichier `svbox2018a.vdi.xz` dans le dossier de téléchargements (`Téléchargements` ou `Downloads` selon la version de votre MacOS), sinon, ce fichier sera téléchargé au même emplacement (il pèse 2,9Gb)! Double-cliquez sur `svbox2018a_macos_setup.dmg`. Suivez simplement les instructions. 

![](images/annexe1/svbox_mac-install.gif)

- Déplacez à la souris 'SciViews Box 2018a' vers le dossier 'Applications' dans cette fenêtre (cette partie de l'installation est très rapide, donc, vous n'aurez peut-être pas l'impression que quelque chose se passe),
- Ensuite double-cliquez sur le dossier 'Applications' et recherchez l'entrée 'SciViews Box 2018a'. Double-cliquez dessus,
- Si vous avez chargé l'installateur depuis Internet, il se peut que votre Mac indique un message et vous empêche d'ouvrir le fichier. Dans ce cas, il faut cliquer avec le bouton droit de la souris et selectionner "Ouvrir" dans le menu contextuel **tout en maintenant la touche `ALT` enfoncée**, et ensuite cliquer "Ouvrir" dans la boite qui s'affiche.

Laissez l'installation se terminer. Cela peut prendre plusieurs minutes! En option, vous pouvez aussi accrocher le programme de manière permanente dans le "Dock" pour le lancer facilement depuis cet endroit. Cliquez bouton droit et dans le menu "Options", sélectionnez l'entrée "Garder dans le Dock".

![](images/annexe1/svbox_mac-keep-in-dock.gif)


#### Installation sous Linux

Il est parfaitement possible d'installer la SciViews Box sous Linux. Cependant, un programme d'installation simplifié n'a pas encore été développé pour ce système. _Voyez au cas par cas avec vos enseignants pour qu'ils vous expliquent comment installer la SciViews Box manuellement sous Linux._


### Github Desktop

![](images/annexe1/github-desktop-website.png)

Dans ce cours, nous utiliserons Git et Github pour gérer les différentes versions de vos projets et les partager avec vos binômes et vos enseignants. [Github Desktop](https://desktop.github.com) facilite grandement la gestion de vos projets. Ce programme est très facile à installer: son téléchargement et le lancement de son installateur ne pose pas de problèmes particuliers. _Notez toutefois que ce programme n'est pas encore disponible pour Linux._


## Configuration

Même si la SciViews Box est pré-configurée, vous allez avoir quelques étapes simples et rapides à réaliser pour être complètement opérationnel. Ces étapes sont détaillées ci-dessous.


### Lanceur SciViews Box

L'application que vous venez d'installer est un lanceur rapide qui facilite le démarrage, la fermeture et la gestion de votre machine virtuelle SciViews Box 2018a. Démarrez-là et vous verrez la fenêtre suivante:



### Accès aux fichiers

![](images/annexe1/svbox-diagram.svg)


### Finalisation de l'installation de la SciViews Box


