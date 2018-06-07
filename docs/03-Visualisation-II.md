# Visualisation II {#visu2}

_A ce niveau, les étudiants pourront choisir entre le module 3 et le module 4 à faire en premier. Ensuite, les groupes switcheront vers l'autre modules et s'entre-aideront._

Distribution des données, histogramme, graphe de densité, violin plot. Projet RStudio, organisation des dossiers, noms de fichiers. Jeux de données fournis. A la fin, projet perso: explorer un autre type de graphique et l’implémenter dans son rapport.

Vos objectifs pour ce module sont:

- Savoir réaliser différentes variantes de différents graphiques tel que les histogrammes, les graphes de densité dans R avec la fonction `chart()`

- Intégrer ensuite des graphiques dans un rapport et y décrire ce que que vous observez


```r
SciViews::R
```

```
## ── Attaching packages ──────────────────────────────────────────────────────────── SciViews::R 1.0.1 ──
```

```
## ✔ SciViews  1.0.1       ✔ purrr     0.2.4  
## ✔ chart     1.0.1       ✔ readr     1.1.1  
## ✔ flow      1.0.0       ✔ tidyr     0.8.0  
## ✔ data      1.0.0       ✔ tibble    1.4.2  
## ✔ svMisc    1.0.2       ✔ ggplot2   2.2.1  
## ✔ forcats   0.3.0       ✔ tidyverse 1.2.1  
## ✔ stringr   1.3.0       ✔ lattice   0.20.35
## ✔ dplyr     0.7.4       ✔ MASS      7.3.49
```

```
## ── Conflicts ───────────────────────────────────────────────────────────────── tidyverse_conflicts() ──
## ✖ dplyr::filter() masks stats::filter()
## ✖ dplyr::lag()    masks stats::lag()
## ✖ dplyr::select() masks MASS::select()
```

```r
knitr::opts_chunk$set(echo=FALSE, results= 'hide', message=FALSE)
iris <- data::read(file = "iris", package = "datasets")
```

## Prérequis

Si ce n'est déjà fait, vous devez avoir réaliser le module précédent.

> A faire: proposer une liste de matériel pédagogique supplémentaire pour aider à approfondir les prérequis, si nécessaire 

## Visualisation graphique à l'aide d'un histogramme

Lors d'une expérience vous souhaitez visualiser la façon dont vos données s'étale sur un axe (On parle de **distribution**^[TODO] en statistique) pour l'une des vairables étudiées. L'histogramme est l'un des outils pouvant vous apporter cette information. Ce graphique va découper en plusieurs **classes**^[TODO] la variable étudiée.


<div class="figure">
<img src="03-Visualisation-II_files/figure-html/unnamed-chunk-1-1.svg" alt="Histogramme montrant la distribution de la longueur des pétales d'iris." width="672" />
<p class="caption">(\#fig:unnamed-chunk-1)Histogramme montrant la distribution de la longueur des pétales d'iris.</p>
</div>
 
Les instructions de base afin de produire un histogramme :

```
chart(DF, formula = ~ VAR) +
  geom_histogram()
```

La fonction `chart()` requiert comme argument le jeu de donnée (dataframe, DF), ainsi que la formule à employer ~ VAR . Pour réaliser un histogramme, vous devez ajouter la seconde fonction `geom_histogram()`.
 
Les éléments indispensables à la compréhension d'un histogramme sont (ici mis en évidence en couleur)

- Les axes avec les graduations (en rouge)
- les labels et unité des axes (en bleu)


Vous pouvez décripter votre histogramme sur base des **modes**^[todo] et de la **symétrie**^[TODO] de ces derniers. Les modes les plus fréquents sont unimodal, bimodal ou multimodal. 

<div class="figure">
<img src="03-Visualisation-II_files/figure-html/unnamed-chunk-2-1.svg" alt="Histogrammes montrant les modes et symétries : a) histogramme unimodal et symétrique, b) histogramme bimodal et asymétrique, c) histogramme unimodal et asymétrique, d) histogramme multimodal et symétrique." width="672" />
<p class="caption">(\#fig:unnamed-chunk-2)Histogrammes montrant les modes et symétries : a) histogramme unimodal et symétrique, b) histogramme bimodal et asymétrique, c) histogramme unimodal et asymétrique, d) histogramme multimodal et symétrique.</p>
</div>


### Pièges et Astuces


Vous devez être particulièrement vigilant lors de la réalisation d'un histogramme au classes de ce dernier. 

```
library(shiny)
runExample("01_hello")
```

## Visualisation graphique à l'aide d'un graphique de densité

L'histogramme n'est pas le seul outil à votre disposition. Vous pouvez également employer le graphique de densité qui se base sur l'histogramme. Il ne s'agit plus de représenter un dénombrement comme l'histogramme le fait mais une **probabilité**^[TODO] d'obtenir une valeur parmi un échantillon aléatoire. Le passage d'un histogramme vers un graphe de densité se base sur une **estimation par noyaux gaussien**^[TODO]

<div class="figure">
<img src="03-Visualisation-II_files/figure-html/unnamed-chunk-3-1.svg" alt="A) Histogramme montrant la distribution de la longueur des pétales d'iris B) Graphique de densité montrant la distribution de la longueur des pétales d'iris." width="672" />
<p class="caption">(\#fig:unnamed-chunk-3)A) Histogramme montrant la distribution de la longueur des pétales d'iris B) Graphique de densité montrant la distribution de la longueur des pétales d'iris.</p>
</div>

Les instructions de base afin de produire un histogramme sont :

```
chart(DF, formula = ~ VAR) +
  geom_density()
```

Les éléments indispensables à la compréhension d'un graphique de densité sont (ici mis en évidence en couleur) : 

- Les axes avec les graduations (en rouge)
- les labels et unité des axes (en bleu)



## Visualisation graphique à l'aide d'un diagramme en violon

Le graphique de densité peut être représenté via un autre graphique qui sera d'autant plus intéressant que la variable facteur étudiée peut être discriminée par un grand nombre de niveaux différents. Il s'agit également d'une estimation se basant sur un histogramme via la méthode l'estimation par noyau gaussien.

<div class="figure">
<img src="03-Visualisation-II_files/figure-html/unnamed-chunk-4-1.svg" alt="Ponts essentiels d'un diagramme en violon." width="672" />
<p class="caption">(\#fig:unnamed-chunk-4)Ponts essentiels d'un diagramme en violon.</p>
</div>

Les instructions de base afin de produire un diagramme en violon sont :

```
chart(DF, formula = YNUM~ factor(VAR)) +
  geom_violin()
```

## A vous de jouer !

Chargez le package `BioDataScience` + accès direct au learnR (à faire, package en cours de développement sur [github](https://github.com/BioDataScience-Course/BioDataScience))

Un squelette de projet RStudio vous a été fournit dans un dépôt Github Classroom, y compris organisation des fichiers et jeux de données types. Votre objectif est de comprendre les données proposées, en utilisant des visualisations graphiques appropriées et en documentant le fruit de votre étude dans un rapport R Notebook. Utilisez le l'histogramme et le graphique de densité graphique que vous venez d'étudier bien sûr, mais vous êtes aussi encouragés à expérimenter d'autres visualisations graphiques.
