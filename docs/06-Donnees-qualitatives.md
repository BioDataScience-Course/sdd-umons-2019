# Données qualitatives {#qualit}

Variables de type `factor`/`ordered`, transformation, découpage en classes, tableau de contigence. Choix des variables à mesurer, biométrie humaine.



```r
knitr::opts_chunk$set(echo=FALSE, results= 'hide', message=FALSE)
SciViews::R
```

```
## ── Attaching packages ──────────────────────────────────────────── SciViews::R 1.0.0 ──
```

```
## ✔ SciViews  1.0.0          ✔ readr     1.1.1     
## ✔ svMisc    1.1.0          ✔ tidyr     0.8.1     
## ✔ forcats   0.3.0          ✔ tibble    1.4.2     
## ✔ stringr   1.3.1          ✔ ggplot2   3.0.0.9000
## ✔ dplyr     0.7.6          ✔ tidyverse 1.2.1     
## ✔ purrr     0.2.5          ✔ MASS      7.3.50
```

```
## ── Conflicts ───────────────────────────────────────────────── tidyverse_conflicts() ──
## ✖ dplyr::filter() masks stats::filter()
## ✖ dplyr::lag()    masks stats::lag()
## ✖ dplyr::select() masks MASS::select()
```

```r
library(knitr)
library(chart)
```

```
## Le chargement a nécessité le package : lattice
```

```r
library(ggpubr)
```

```
## Le chargement a nécessité le package : magrittr
```

```
## 
## Attachement du package : 'magrittr'
```

```
## The following object is masked from 'package:purrr':
## 
##     set_names
```

```
## The following object is masked from 'package:tidyr':
## 
##     extract
```

```r
library(flow)
library(data)
dm <- read("diamonds", package = "ggplot2")
```

> Suite d'idée afin de rédiger le chapitre 6

Vos objectifs pour ce module sont :

- Appréhender le découpage en classe d'une variable numérique, afin de réaliser une variable facteur 

- Appréhender la réalisation des tableaux de contingences.

- Acquérir des données et les encoder de manière reproductible 

## Découpage en classe


<img src="06-Donnees-qualitatives_files/figure-html/unnamed-chunk-1-1.svg" width="672" />

## Tableaux de contingences














## Acquisition de données scientifiques

Vous avez pour objectif de réaliser une recherche 

Thématique de la **biométrie humaine**

- Recherche bibliographique sur la thématique
- Profil de l'expérience
    + Variables mesurées afin de répondre à la thématique 
    + Analyses souhiatées 
- Acquisition des données
    + Précision & exactitude
    + Systèmes de codifications : respect de la vie privée
- Encodage des données 
    + Importation des données
    + Correction des erreurs (tidy)
- Traitement des données ( Transform, visualise, model )
    + Visualisation graphiques des données
    + Analyse statistiques des données 
- Réalisation d'un rapport structuré répondant à la question de départ




## A vous de jouer !
