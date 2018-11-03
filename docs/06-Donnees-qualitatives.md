# Traitement des données II {#qualit}



##### Objectifs {-}

- Comprendre les principaux tableaux de données utilisés en data science

- Savoir réaliser des tableaux de contingences

- Acquérir des données et les encoder correctement et de manière à ce que les analyses soient reproductibles 


##### Prérequis {-}

Ce module est la continuation du module \@ref(import) dont le contenu doit être bien compris et maîtrisé avant de poursuivre ici.


## Tableaux de données

Les tableaux de données sont principalement représentés sous deux formes : les tableaux **cas par variables** et les tableaux de **contingence**.


### Tableaux cas par variables

Chaque individus est représenté en ligne et chaque variable en colonne par convention. En anglais, on parlera de [tidy data](https://www.jstatsoft.org/article/view/v059i10).

Nous nous efforcerons de toujours créer un tableau de ce type pour les données brutes. La question à se poser est la suivante : est-ce que j'ai un seul et même individu représenté sur *chaque* ligne du tableau ? Si la réponse est non, le tableau de données n'est **pas** correctement encodé.

TODO : exemple et solution

Les tableaux de données que vous avez traités jusqu'à présent étaient tous des tableaux cas par variables. Chaque ligne représentait un individu sur qui plusieurs variables (en colonnes) étaient mesurées.


```r
biometry <- read("biometry", package = "BioDataScience", lang = "fr")
head(biometry)
```

```
# # A tibble: 6 x 7
#   gender day_birth  weight height wrist year_measure   age
#   <fct>  <date>      <dbl>  <dbl> <dbl>        <dbl> <dbl>
# 1 M      1995-03-11     69    182  15           2013    18
# 2 M      1998-04-03     74    190  16           2013    15
# 3 M      1967-04-04     83    185  17.5         2013    46
# 4 M      1994-02-10     60    175  15           2013    19
# 5 W      1990-12-02     48    167  14           2013    23
# 6 W      1994-07-15     52    179  14           2013    19
```

L'encodage d'un petit tableau cas par variables directement dans R est facile. Cela peut se faire de plusieurs façons différentes. En voici deux utilisant les fonctions `tibble()` (spécification colonne par colonne, utilisez le snippet `.dmtibble` pour vous aider) et `tribble()` (spécification ligne par ligne, utilisez le snippet `.dmtribble`) :


```r
# Spécification colonne par colonne avec tibble()
(DF <- as_dataframe(tibble(
  x = c(1, 2),
  y = c(3, 4)
)))
```

```
# # A tibble: 2 x 2
#       x     y
#   <dbl> <dbl>
# 1     1     3
# 2     2     4
```


```r
# Spécification ligne par ligne avec tribble()
(DF1 <- as_dataframe(tribble(
  ~x, ~y,
   1,  3,
   2,  4
)))
```

```
# # A tibble: 2 x 2
#       x     y
#   <dbl> <dbl>
# 1     1     3
# 2     2     4
```

La seconde approche est plus naturelle, mais la première permet d'utiliser diverses fonctions de R pour faciliter l'encodage, par exemple :

- Séquence d'entiers successifs :


```r
1:10
```

```
#  [1]  1  2  3  4  5  6  7  8  9 10
```

- Répétition d'un vecteur 5 fois :


```r
rep(c("a", "b", "c"), 5)
```

```
#  [1] "a" "b" "c" "a" "b" "c" "a" "b" "c" "a" "b" "c" "a" "b" "c"
```

- Répétition de chaque item d'un vecteur 5 fois :


```r
rep(c("a", "b", "c"), each = 5)
```

```
#  [1] "a" "a" "a" "a" "a" "b" "b" "b" "b" "b" "c" "c" "c" "c" "c"
```

Pour de plus gros tableaux, il vaut mieux utiliser un tableur tel que Excel ou LibreOffice Calc pour l'encodage. Les tableurs en ligne comme Google Sheets ou Excel Online conviennent très bien également et facilitent un travail collaboratif ainsi que la mise à disposition sut le Net, comme nous avons vu au module \@ref(import).


### Tableaux de contingence

C'est le dénombrement de l'occurence de chaque niveau d'une (tableau à une entrée) ou de deux variables **qualitatives** (tableau à double entrée). L fonction `table()` crée ces deux types de tableaux de contingence à partir de données encodées en tableau cas par variables :


```r
biometry$age_rec <- cut(biometry$age, include.lowest = FALSE, right = TRUE,
  breaks = c(14, 27, 90))
(bio_tab <- table(biometry$gender, biometry$age_rec))
```

```
#    
#     (14,27] (27,90]
#   M     106      92
#   W      97     100
```

Le tableau de contingence peut toujours être calculé à partir d'un tableau cas par variable, mais il peut également être encodé directement si nécessaire. Voic un petit tableau de contingence à simple entrée encodé directement comme tel (vecteur nommé transformé en objet `table` à l'aide de la fonction `as.table()`) :


```r
anthirrhinum <- as.table(c(
  "fleur rouge"   = 54,
  "fleur rose"    = 122,
  "fleur blanche" = 58)
)
anthirrhinum
```

```
#   fleur rouge    fleur rose fleur blanche 
#            54           122            58
```

Une troisième possibilité est d'utiliser un tableau indiquant les **fréquences d'occurence** dans une colonne (`freq` ci-dessus). Ce n'est **pas** un tableau cas par variable, mais une forme bien plus concise et pratique pour préencoder les données qui devront être ensuite transformées en tableau de contingence à l'aide de la fonction `xtabs()`. Voici un exemple pour un tableau de contingence à double entrée. Notez que le tableau cas par variable correspondant devrait contenir 44 + 116 + 19 + 128 = 307 lignes et serait plus fastidieux à construire et à manipuler (même en utilisant la fonction `rep()`).


```r
timolol <- tibble(
  traitement = c("timolol", "timolol", "placebo", "placebo"),
  patient    = c("sain",    "malade",  "sain",    "malade"),
  freq       = c(44,        116,       19,        128)
)
# Creation du tableau de contingence 
timolol_table <- xtabs(data = timolol, freq ~ patient + traitement)
timolol_table
```

```
#         traitement
# patient  placebo timolol
#   malade     128     116
#   sain        19      44
```

La sortie par défaut d'un tableau de contingence n'est pas très esthétique, mais plusieurs options existent pour le formatter d'une façon agréable. En voici deux exemples :


```r
pander::pander(timolol_table,
  caption = "Exemple de table de contingence à double entrée.")
```


--------------------------------
   &nbsp;     placebo   timolol 
------------ --------- ---------
 **malade**     128       116   

  **sain**      19        44    
--------------------------------

Table: Exemple de table de contingence à double entrée.


```r
knitr::kable(timolol_table,
  caption = "Exemple de table de contingence à double entrée.")
```



Table: (\#tab:unnamed-chunk-11)Exemple de table de contingence à double entrée.

          placebo   timolol
-------  --------  --------
malade        128       116
sain           19        44

Il est même possible de représenter *graphiquement* un tableau de contingence pour l'inclure dans une figure composée, éventuellement en les mélangeant avec des graphiques^[Utilisez cette option avec parcimonie : il vaut toujours mieux représenter un tableau comme ... un tableau plutôt que comme une figure !].


```r
tab1 <- ggpubr::ggtexttable(head(biometry), rows = NULL)
tab2 <- ggpubr::ggtexttable(table(biometry$gender, biometry$age_rec))

combine_charts(list(tab1, tab2), nrow = 2)
```

<img src="06-Donnees-qualitatives_files/figure-html/unnamed-chunk-12-1.svg" width="672" style="display: block; margin: auto;" />


### Métadonnées

Les données dans un tableau de données doivent **impérativement** être associées à un ensemble de métadonnées. Les métadonnées (metadata en anglais) apportent des informations complémentaires nécessaires pour une interprétation corrrecte des données. Elles permettent donc de replacer les données dans leur contexte et de spécifier des caractéristiques liées aux pesures réalisées comme les unités de mesure par exemple.

$$Donn\acute{e}es \ de \ qualit\acute{e} \ = \ tableau \ de \ donn\acute{e}es + \ m\acute{e}tadonn\acute{e}es$$

Les données correctement qualifiées et documentée sont les seules qui penvent être utilisées par un collaborateur externe. C'est à dire qu'une personne externe à l'expérience ne peut interpréter le tableau de données que si les métadonnées sont complètes et explicites. 

Exemple de métadonnées :

- Unités de mesure (exemple : 3,5 mL, 21,2 °C)
- Précision de la mesure (21,2 +/- 0,2 dans le cas d’un thermomètre gradué tous les 0,2 °C)
- Méthode de mesure utilisée (thermomètre à mercure, ou électronique, ou ...)
- Type d’instrument employé (marque et modèle du thermomètre par exemple)
- Date de la mesure
- Nom du projet lié à la prise de mesure
- Nom de l’opérateur en charge de la mesure
- ...

Vous avez pu vous aperçevoir que la fonction `read()` permet d'ajouter certaine métadonnées comme les unités aux variables d'un jeu de données. Cependant, il n’est pas toujours possible de rajouter les métadonnées dans un tableau sous forme électronique, mais il faut toujours les consigner dans un **cahier de laboratoire**, et ensuite les **retranscrire dans le rapport**.


## Population et échantillonnage

...


```r
DT::datatable(iris)
```

<!--html_preserve--><div id="htmlwidget-40a25067c3289d431cd0" style="width:100%;height:auto;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-40a25067c3289d431cd0">{"x":{"filter":"none","data":[["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31","32","33","34","35","36","37","38","39","40","41","42","43","44","45","46","47","48","49","50","51","52","53","54","55","56","57","58","59","60","61","62","63","64","65","66","67","68","69","70","71","72","73","74","75","76","77","78","79","80","81","82","83","84","85","86","87","88","89","90","91","92","93","94","95","96","97","98","99","100","101","102","103","104","105","106","107","108","109","110","111","112","113","114","115","116","117","118","119","120","121","122","123","124","125","126","127","128","129","130","131","132","133","134","135","136","137","138","139","140","141","142","143","144","145","146","147","148","149","150"],[5.1,4.9,4.7,4.6,5,5.4,4.6,5,4.4,4.9,5.4,4.8,4.8,4.3,5.8,5.7,5.4,5.1,5.7,5.1,5.4,5.1,4.6,5.1,4.8,5,5,5.2,5.2,4.7,4.8,5.4,5.2,5.5,4.9,5,5.5,4.9,4.4,5.1,5,4.5,4.4,5,5.1,4.8,5.1,4.6,5.3,5,7,6.4,6.9,5.5,6.5,5.7,6.3,4.9,6.6,5.2,5,5.9,6,6.1,5.6,6.7,5.6,5.8,6.2,5.6,5.9,6.1,6.3,6.1,6.4,6.6,6.8,6.7,6,5.7,5.5,5.5,5.8,6,5.4,6,6.7,6.3,5.6,5.5,5.5,6.1,5.8,5,5.6,5.7,5.7,6.2,5.1,5.7,6.3,5.8,7.1,6.3,6.5,7.6,4.9,7.3,6.7,7.2,6.5,6.4,6.8,5.7,5.8,6.4,6.5,7.7,7.7,6,6.9,5.6,7.7,6.3,6.7,7.2,6.2,6.1,6.4,7.2,7.4,7.9,6.4,6.3,6.1,7.7,6.3,6.4,6,6.9,6.7,6.9,5.8,6.8,6.7,6.7,6.3,6.5,6.2,5.9],[3.5,3,3.2,3.1,3.6,3.9,3.4,3.4,2.9,3.1,3.7,3.4,3,3,4,4.4,3.9,3.5,3.8,3.8,3.4,3.7,3.6,3.3,3.4,3,3.4,3.5,3.4,3.2,3.1,3.4,4.1,4.2,3.1,3.2,3.5,3.6,3,3.4,3.5,2.3,3.2,3.5,3.8,3,3.8,3.2,3.7,3.3,3.2,3.2,3.1,2.3,2.8,2.8,3.3,2.4,2.9,2.7,2,3,2.2,2.9,2.9,3.1,3,2.7,2.2,2.5,3.2,2.8,2.5,2.8,2.9,3,2.8,3,2.9,2.6,2.4,2.4,2.7,2.7,3,3.4,3.1,2.3,3,2.5,2.6,3,2.6,2.3,2.7,3,2.9,2.9,2.5,2.8,3.3,2.7,3,2.9,3,3,2.5,2.9,2.5,3.6,3.2,2.7,3,2.5,2.8,3.2,3,3.8,2.6,2.2,3.2,2.8,2.8,2.7,3.3,3.2,2.8,3,2.8,3,2.8,3.8,2.8,2.8,2.6,3,3.4,3.1,3,3.1,3.1,3.1,2.7,3.2,3.3,3,2.5,3,3.4,3],[1.4,1.4,1.3,1.5,1.4,1.7,1.4,1.5,1.4,1.5,1.5,1.6,1.4,1.1,1.2,1.5,1.3,1.4,1.7,1.5,1.7,1.5,1,1.7,1.9,1.6,1.6,1.5,1.4,1.6,1.6,1.5,1.5,1.4,1.5,1.2,1.3,1.4,1.3,1.5,1.3,1.3,1.3,1.6,1.9,1.4,1.6,1.4,1.5,1.4,4.7,4.5,4.9,4,4.6,4.5,4.7,3.3,4.6,3.9,3.5,4.2,4,4.7,3.6,4.4,4.5,4.1,4.5,3.9,4.8,4,4.9,4.7,4.3,4.4,4.8,5,4.5,3.5,3.8,3.7,3.9,5.1,4.5,4.5,4.7,4.4,4.1,4,4.4,4.6,4,3.3,4.2,4.2,4.2,4.3,3,4.1,6,5.1,5.9,5.6,5.8,6.6,4.5,6.3,5.8,6.1,5.1,5.3,5.5,5,5.1,5.3,5.5,6.7,6.9,5,5.7,4.9,6.7,4.9,5.7,6,4.8,4.9,5.6,5.8,6.1,6.4,5.6,5.1,5.6,6.1,5.6,5.5,4.8,5.4,5.6,5.1,5.1,5.9,5.7,5.2,5,5.2,5.4,5.1],[0.2,0.2,0.2,0.2,0.2,0.4,0.3,0.2,0.2,0.1,0.2,0.2,0.1,0.1,0.2,0.4,0.4,0.3,0.3,0.3,0.2,0.4,0.2,0.5,0.2,0.2,0.4,0.2,0.2,0.2,0.2,0.4,0.1,0.2,0.2,0.2,0.2,0.1,0.2,0.2,0.3,0.3,0.2,0.6,0.4,0.3,0.2,0.2,0.2,0.2,1.4,1.5,1.5,1.3,1.5,1.3,1.6,1,1.3,1.4,1,1.5,1,1.4,1.3,1.4,1.5,1,1.5,1.1,1.8,1.3,1.5,1.2,1.3,1.4,1.4,1.7,1.5,1,1.1,1,1.2,1.6,1.5,1.6,1.5,1.3,1.3,1.3,1.2,1.4,1.2,1,1.3,1.2,1.3,1.3,1.1,1.3,2.5,1.9,2.1,1.8,2.2,2.1,1.7,1.8,1.8,2.5,2,1.9,2.1,2,2.4,2.3,1.8,2.2,2.3,1.5,2.3,2,2,1.8,2.1,1.8,1.8,1.8,2.1,1.6,1.9,2,2.2,1.5,1.4,2.3,2.4,1.8,1.8,2.1,2.4,2.3,1.9,2.3,2.5,2.3,1.9,2,2.3,1.8],["setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica"]],"container":"<table class=\"display\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>Sepal.Length<\/th>\n      <th>Sepal.Width<\/th>\n      <th>Petal.Length<\/th>\n      <th>Petal.Width<\/th>\n      <th>Species<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"columnDefs":[{"className":"dt-right","targets":[1,2,3,4]},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script><!--/html_preserve-->


## Acquisition de données

Dans le module \@ref(import), vous avez pris connaissance des types de variable et venez d'apprendre comment encoder différents types de tableaux de données et de leurs associer les indispensables métadonnées. Cependant, la première étape avant d'acquérir des données est de planifier correctement son expérience. La Science des Données est intimement liée à la démarche scientifique et intervient dans toutes les étapes depuis la caractérisation de la question et le planning de l'expérience jusqu'à la diffusion des résultats. Plus en détails, cela correspond à :

- Définir une question (objectif)
- Réaliser une recherche bibliographique sur la thématique
- Définir le protocole de l'expérience à partir de l'objectif
    + Définir la population étudiée et l'échantillonnage
    + Définir les variables à mesurer 
        + Définir les unité des mesures
        + Définir la précision des mesures 
        + Définir les instruments de mesure nécessaires 
- Définir les conventions d'encodage
    + Codifier l'identification des individus
    + Définir les niveaux des variables facteurs et leurs labels
- Acquérir et encoder les données
- Traiter les données
    + Importer des données
    + Remanier des données
    + Visualiser et décrire des données 
    + Analyser les données (traitements statistiques, modélisation,...).
- Produire des supports de présentation pour répondant à la question de départ et diffuser l'information dans la communauté scientifique

Nous trtaitons ici des premières étapes qui visent à acquérir les données.


### Précision et exactitude

Les erreurs de mesures sont inévitables lors de l'acquisition de nos données. Cependant, il est possible de les minimiser en choisissant un instrument plus précis (precise en anglais) et plus exact (accurate en anglais). La figure ci-dessous illustre de manière visuelle la différence qu'il y a entre précision et exactitude.

![](images/sdd1_06/targets.png)


### Codification des données

Afin d'éviter que divers collaborateurs encodent différemment la même information, vous allez devoir préciser très clairement comment encoder les différentes variables de votre jeu de données. Par exemple pour une variable `genre`, est-ce que vous indiquez `homme` ou `femme`, ou `h` / `f`, ou encore `H` / `F` ?

De même, vous allez devoir attribuer un code **unique** à chaque individu mesuré. Enfin, vous devez vous assurer que toutes les mesures sont réalisées de la même manière et avec des instruments qui, s'ils sont différents, seront cependant **intercalibrés**. Comment faire ? Réfléchissez à cette question sur base d'une mesure de la masse des individus à l'aide de pèse-personnes différents ! 


#### Respect de la vie privée

Lors d'expérience sur des personnes, le respect de la vie privée **doit** être pris en compte. Le nom et le prénom, ou toute autre information permettant de retrouver les individus étudiés (adresse mail, numéro de sécurité sociale, etc.) ne *peut pas* apparaître dans la base de données consolidée. En outre, il vous faudra un accord explicite des personnes que vous voulez mesurer, et il faudra leur expliquer *ce que* vous faites, et *comment* les données seront ensuite utilisées. Une question se pose : comment pouvoir revenir vers les enregistrements liés à un individu en particulier (en cas d'erreur d'encodage, par exemple) si les informations relatives directement à ces individus ne sont pas consignées dans le tableau final ? Réfléchissez à la façon dont vous vous y prendriez avant de lire la suite...

Voici un petit tableau qui correspond à ce que vous ne pourrez **pas** faire (nom et prénom explicitement mentionnés dans le tableau) :


```r
(biometry_marvel <- as_dataframe(tribble(
  ~id,                 ~sex ,~weight, ~height,
   "Banner Bruce",     "M",  95,      1.91,
   "Stark Tonny",      "M",  80,      1.79,
   "Fury Nicholas",    "M",  82,      1.93,
   "Romanoff Natasha", "F",  53,      1.70
)))
```

```
# # A tibble: 4 x 4
#   id               sex   weight height
#   <chr>            <chr>  <dbl>  <dbl>
# 1 Banner Bruce     M         95   1.91
# 2 Stark Tonny      M         80   1.79
# 3 Fury Nicholas    M         82   1.93
# 4 Romanoff Natasha F         53   1.7
```

Vous devez fournir une code permettant de garder l'anonymat des sondés à l'ensemble des personnes étudiées vis à vis des analystes qui vont utiliser ces données. Cependant, le code doit permettre au chercheur ayant pris ces mesures de les retrouver dans son cahier de laboratoire, si besoin. Une façon de procéder consiste à attributer un numéro au hasard par tirage dans une urne à chacune des personnes chargées des mesures. Ensuite, chaque expérimentateur attribue lui-même un second numéro aux différentes personnes qu'il mesure. Prenons par exemple le scientifique n°24 (seul lui sait qu'il porte ce numéro). Il attribue un code de 1 à n à chaque personne étudiée. En combinant le code secret de l'expérimentateur et le code individu, cela donne un identifiant unique de la forme `24_1`, `24_2`, etc. Il pourra alors encoder sa partie comme suit : 


```r
(biometry_marvel1 <- as_dataframe(tribble(
  ~id,     ~sex , ~weight, ~height,
   "24_1",  "M",  95,      1.91,
   "24_2",  "M",  80,      1.79,
   "24_3",  "M",  82,      1.93,
   "24_4",  "F",  53,      1.70
)))
```

```
# # A tibble: 4 x 4
#   id    sex   weight height
#   <chr> <chr>  <dbl>  <dbl>
# 1 24_1  M         95   1.91
# 2 24_2  M         80   1.79
# 3 24_3  M         82   1.93
# 4 24_4  F         53   1.7
```

Il garde néanmoins les correspondances dans son carnet de laboratoire, au cas où il faudrait faire des vérifications ou revenir à la donnée originale.


```r
(biometrie_correspondance <- data_frame(
  name = biometry_marvel$id,
  id   = biometry_marvel1$id
))
```

```
# # A tibble: 4 x 2
#   name             id   
#   <chr>            <chr>
# 1 Banner Bruce     24_1 
# 2 Stark Tonny      24_2 
# 3 Fury Nicholas    24_3 
# 4 Romanoff Natasha 24_4
```

A partir des données du tableau général consolidé, personne à part lui ne peut revenir sur ces données d'origine et mettre un nom sur les individus mesurés. Et lui-même n'a pas la possibilité de déterminer *qui* se cache derrière les autres identifiants tels `3_1`, `12_4`, `21_2`, etc.


##### A vous de jouer {-}

Votre objectif est d'acquérir des données pour étudier la prévalence de l'obésité dans la population. En classe, vous allez réfléchir par équipes aux données qu'il vous faudra mesurer : *quoi ?* *pourquoi ?* *comment ?* Les résultats de votre réflexion seront ensuite consolidées pour arriver à un *consensus*  général. Ensuite, le fruit de cette réflexion ainsi que l'analyse que vous réaliserez seront à ajouter dans le projet **sdd1_biometry**. Une feuille Google Sheets sera mise à disposition pour encoder vos données de manière collaborative sur base des spécifications que vous aurez formulées.

**Attention, veuillez à respectez les conventions** que vous aurez édifiées ensemble lors de l'encodage... et n'oubliez pas de préciser également les métadonnées !

## Recombinaison de tableaux

### `gather()` & `spread()`

Encoder correctement un tableau de données n'es pas une chose simple. Il peut y avoir plusieurs manières de le représenter en fonction du type de représentation que l'on souhaite, du type d'analyse,...Quoi qu'il en soit, il est important de connaitre les fonctions permettant de recombiner simplement un tableau de données. 

L'aide-mémoire [Data Import::CHEAT SHEET](https://github.com/rstudio/cheatsheets/blob/master/data-import.pdf) est l'outil pour vous aider dans cette tache. Vous y trouverez des explication dans la section Reshape Data. 

Ces outils provenant du package **tidyr** sont décrits en détails dans  ["R for Data Science"](https://r4ds.had.co.nz/tidy-data.html#spreading-and-gathering). 


Prenons l'exemple de ce tableau de contingence provenant des données relatée dans l'article suivant : [Paleomicrobiology to investigate copper resistance in bacteria : isolation and description of Cupriavidus necator B9 in the soil of a medieval foundry](http://di.umons.ac.be/details.aspx?pub=0a0de102-c145-403f-9e1c-8ad4fdc1fc39). 

L'article est basé sur l'analyse métagénomique de type shotgun pour 4 communautés microbiennes. Comme ces analyses coûtent très cher, il est souvent impossible de faire des réplicats. Un seul échantillon d'ADN a donc été séquencé par communauté. Il en résulte une longue liste de sequences que l'on peut attribuer à des règnes. 


```r
shot_gun <- data.frame(kingdom = c("Archaea", "Bacteria", "Eukaryota", "Viruses", 
                                    "other sequences", "unassigned", 
                                    "unclassified sequences"),
                        c1 = c( 98379, 6665903, 81593, 1245, 757, 1320419, 15508),
                        c4 = c( 217985, 9739134, 101834, 4867, 1406, 2311326, 21572),
                        c7 = c( 143314, 7103244, 71111, 5181, 907, 1600886, 14423),
                        c10 = c(272541, 15966053, 150918, 15303, 2688, 3268646, 35024))

rmarkdown::paged_table(shot_gun)
```

<div data-pagedtable="false">
  <script data-pagedtable-source type="application/json">
{"columns":[{"label":["kingdom"],"name":[1],"type":["fctr"],"align":["left"]},{"label":["c1"],"name":[2],"type":["dbl"],"align":["right"]},{"label":["c4"],"name":[3],"type":["dbl"],"align":["right"]},{"label":["c7"],"name":[4],"type":["dbl"],"align":["right"]},{"label":["c10"],"name":[5],"type":["dbl"],"align":["right"]}],"data":[{"1":"Archaea","2":"98379","3":"217985","4":"143314","5":"272541"},{"1":"Bacteria","2":"6665903","3":"9739134","4":"7103244","5":"15966053"},{"1":"Eukaryota","2":"81593","3":"101834","4":"71111","5":"150918"},{"1":"Viruses","2":"1245","3":"4867","4":"5181","5":"15303"},{"1":"other sequences","2":"757","3":"1406","4":"907","5":"2688"},{"1":"unassigned","2":"1320419","3":"2311326","4":"1600886","5":"3268646"},{"1":"unclassified sequences","2":"15508","3":"21572","4":"14423","5":"35024"}],"options":{"columns":{"min":{},"max":[10]},"rows":{"min":[10],"max":[10]},"pages":{}}}
  </script>
</div>

Ce tableau dénombre les séquences appartenant à chaque règne. Ce tableau de contingence est pratique afin de reprensenter les données mais il ne l'est pas autant pour réaliser des graphiques (par exemple). Les colonnes C1, C4, C7 et C10 sont d'une certaine manière une variable facteur qui a été employé en colonne que l'on peut aisement retransformé comme telle. 


```r
 shot_gun1 <- gather(shot_gun, c1, c4, c7, c10, key = "batch" ,value = "sequences")
rmarkdown::paged_table(shot_gun1)
```

<div data-pagedtable="false">
  <script data-pagedtable-source type="application/json">
{"columns":[{"label":["kingdom"],"name":[1],"type":["fctr"],"align":["left"]},{"label":["batch"],"name":[2],"type":["chr"],"align":["left"]},{"label":["sequences"],"name":[3],"type":["dbl"],"align":["right"]}],"data":[{"1":"Archaea","2":"c1","3":"98379"},{"1":"Bacteria","2":"c1","3":"6665903"},{"1":"Eukaryota","2":"c1","3":"81593"},{"1":"Viruses","2":"c1","3":"1245"},{"1":"other sequences","2":"c1","3":"757"},{"1":"unassigned","2":"c1","3":"1320419"},{"1":"unclassified sequences","2":"c1","3":"15508"},{"1":"Archaea","2":"c4","3":"217985"},{"1":"Bacteria","2":"c4","3":"9739134"},{"1":"Eukaryota","2":"c4","3":"101834"},{"1":"Viruses","2":"c4","3":"4867"},{"1":"other sequences","2":"c4","3":"1406"},{"1":"unassigned","2":"c4","3":"2311326"},{"1":"unclassified sequences","2":"c4","3":"21572"},{"1":"Archaea","2":"c7","3":"143314"},{"1":"Bacteria","2":"c7","3":"7103244"},{"1":"Eukaryota","2":"c7","3":"71111"},{"1":"Viruses","2":"c7","3":"5181"},{"1":"other sequences","2":"c7","3":"907"},{"1":"unassigned","2":"c7","3":"1600886"},{"1":"unclassified sequences","2":"c7","3":"14423"},{"1":"Archaea","2":"c10","3":"272541"},{"1":"Bacteria","2":"c10","3":"15966053"},{"1":"Eukaryota","2":"c10","3":"150918"},{"1":"Viruses","2":"c10","3":"15303"},{"1":"other sequences","2":"c10","3":"2688"},{"1":"unassigned","2":"c10","3":"3268646"},{"1":"unclassified sequences","2":"c10","3":"35024"}],"options":{"columns":{"min":{},"max":[10]},"rows":{"min":[10],"max":[10]},"pages":{}}}
  </script>
</div>
Vous en conviendrez que le tableau nommé shot_gun1 est moins aisée à lire comparé à tableau shot_gun. Cependant, il permet de produire facilement des graphique. 


```r
chart(shot_gun1, formula = sequences ~ batch %fill=% kingdom) +
  geom_col(position = "fill")
```

<img src="06-Donnees-qualitatives_files/figure-html/unnamed-chunk-19-1.svg" width="672" style="display: block; margin: auto;" />

La fonction opposée à `gather()` est la fonction `spread()` qui permet de retourner vers le tableau d'origine. 


```r
shot_gun2 <- spread(shot_gun1, key = batch, value = sequences) 
# visualisation du tableau de données 
rmarkdown::paged_table(shot_gun2)
```

<div data-pagedtable="false">
  <script data-pagedtable-source type="application/json">
{"columns":[{"label":["kingdom"],"name":[1],"type":["fctr"],"align":["left"]},{"label":["c1"],"name":[2],"type":["dbl"],"align":["right"]},{"label":["c10"],"name":[3],"type":["dbl"],"align":["right"]},{"label":["c4"],"name":[4],"type":["dbl"],"align":["right"]},{"label":["c7"],"name":[5],"type":["dbl"],"align":["right"]}],"data":[{"1":"Archaea","2":"98379","3":"272541","4":"217985","5":"143314"},{"1":"Bacteria","2":"6665903","3":"15966053","4":"9739134","5":"7103244"},{"1":"Eukaryota","2":"81593","3":"150918","4":"101834","5":"71111"},{"1":"other sequences","2":"757","3":"2688","4":"1406","5":"907"},{"1":"unassigned","2":"1320419","3":"3268646","4":"2311326","5":"1600886"},{"1":"unclassified sequences","2":"15508","3":"35024","4":"21572","5":"14423"},{"1":"Viruses","2":"1245","3":"15303","4":"4867","5":"5181"}],"options":{"columns":{"min":{},"max":[10]},"rows":{"min":[10],"max":[10]},"pages":{}}}
  </script>
</div>


### `separate` & `unite()`

Lors de vos analyses vous serez confronté à devoir combiner ou séparer des colonnes de votre tableau de données. 

L'aide-mémoire [Data Import::CHEAT SHEET](https://github.com/rstudio/cheatsheets/blob/master/data-import.pdf) est l'outil pour vous aider dans cette tache. Vous y trouverez des explication dans la section Split Cells. 

Ces outils provenant du package **tidyr** sont décrits en détails dans  ["R for Data Science"](https://r4ds.had.co.nz/tidy-data.html#separating-and-uniting). 


Partez donc du jeu de données sur la biométrie des crabes du package **MASS**


```r
crabs <- read("crabs", package = "MASS", lang = "fr")
rmarkdown::paged_table(crabs)
```

<div data-pagedtable="false">
  <script data-pagedtable-source type="application/json">
{"columns":[{"label":["species"],"name":[1],"type":["fctr"],"align":["left"]},{"label":["sex"],"name":[2],"type":["fctr"],"align":["left"]},{"label":["index"],"name":[3],"type":["int"],"align":["right"]},{"label":["front"],"name":[4],"type":["dbl"],"align":["right"]},{"label":["rear"],"name":[5],"type":["dbl"],"align":["right"]},{"label":["length"],"name":[6],"type":["dbl"],"align":["right"]},{"label":["width"],"name":[7],"type":["dbl"],"align":["right"]},{"label":["depth"],"name":[8],"type":["dbl"],"align":["right"]}],"data":[{"1":"B","2":"M","3":"1","4":"8.1","5":"6.7","6":"16.1","7":"19.0","8":"7.0"},{"1":"B","2":"M","3":"2","4":"8.8","5":"7.7","6":"18.1","7":"20.8","8":"7.4"},{"1":"B","2":"M","3":"3","4":"9.2","5":"7.8","6":"19.0","7":"22.4","8":"7.7"},{"1":"B","2":"M","3":"4","4":"9.6","5":"7.9","6":"20.1","7":"23.1","8":"8.2"},{"1":"B","2":"M","3":"5","4":"9.8","5":"8.0","6":"20.3","7":"23.0","8":"8.2"},{"1":"B","2":"M","3":"6","4":"10.8","5":"9.0","6":"23.0","7":"26.5","8":"9.8"},{"1":"B","2":"M","3":"7","4":"11.1","5":"9.9","6":"23.8","7":"27.1","8":"9.8"},{"1":"B","2":"M","3":"8","4":"11.6","5":"9.1","6":"24.5","7":"28.4","8":"10.4"},{"1":"B","2":"M","3":"9","4":"11.8","5":"9.6","6":"24.2","7":"27.8","8":"9.7"},{"1":"B","2":"M","3":"10","4":"11.8","5":"10.5","6":"25.2","7":"29.3","8":"10.3"},{"1":"B","2":"M","3":"11","4":"12.2","5":"10.8","6":"27.3","7":"31.6","8":"10.9"},{"1":"B","2":"M","3":"12","4":"12.3","5":"11.0","6":"26.8","7":"31.5","8":"11.4"},{"1":"B","2":"M","3":"13","4":"12.6","5":"10.0","6":"27.7","7":"31.7","8":"11.4"},{"1":"B","2":"M","3":"14","4":"12.8","5":"10.2","6":"27.2","7":"31.8","8":"10.9"},{"1":"B","2":"M","3":"15","4":"12.8","5":"10.9","6":"27.4","7":"31.5","8":"11.0"},{"1":"B","2":"M","3":"16","4":"12.9","5":"11.0","6":"26.8","7":"30.9","8":"11.4"},{"1":"B","2":"M","3":"17","4":"13.1","5":"10.6","6":"28.2","7":"32.3","8":"11.0"},{"1":"B","2":"M","3":"18","4":"13.1","5":"10.9","6":"28.3","7":"32.4","8":"11.2"},{"1":"B","2":"M","3":"19","4":"13.3","5":"11.1","6":"27.8","7":"32.3","8":"11.3"},{"1":"B","2":"M","3":"20","4":"13.9","5":"11.1","6":"29.2","7":"33.3","8":"12.1"},{"1":"B","2":"M","3":"21","4":"14.3","5":"11.6","6":"31.3","7":"35.5","8":"12.7"},{"1":"B","2":"M","3":"22","4":"14.6","5":"11.3","6":"31.9","7":"36.4","8":"13.7"},{"1":"B","2":"M","3":"23","4":"15.0","5":"10.9","6":"31.4","7":"36.4","8":"13.2"},{"1":"B","2":"M","3":"24","4":"15.0","5":"11.5","6":"32.4","7":"37.0","8":"13.4"},{"1":"B","2":"M","3":"25","4":"15.0","5":"11.9","6":"32.5","7":"37.2","8":"13.6"},{"1":"B","2":"M","3":"26","4":"15.2","5":"12.1","6":"32.3","7":"36.7","8":"13.6"},{"1":"B","2":"M","3":"27","4":"15.4","5":"11.8","6":"33.0","7":"37.5","8":"13.6"},{"1":"B","2":"M","3":"28","4":"15.7","5":"12.6","6":"35.8","7":"40.3","8":"14.5"},{"1":"B","2":"M","3":"29","4":"15.9","5":"12.7","6":"34.0","7":"38.9","8":"14.2"},{"1":"B","2":"M","3":"30","4":"16.1","5":"11.6","6":"33.8","7":"39.0","8":"14.4"},{"1":"B","2":"M","3":"31","4":"16.1","5":"12.8","6":"34.9","7":"40.7","8":"15.7"},{"1":"B","2":"M","3":"32","4":"16.2","5":"13.3","6":"36.0","7":"41.7","8":"15.4"},{"1":"B","2":"M","3":"33","4":"16.3","5":"12.7","6":"35.6","7":"40.9","8":"14.9"},{"1":"B","2":"M","3":"34","4":"16.4","5":"13.0","6":"35.7","7":"41.8","8":"15.2"},{"1":"B","2":"M","3":"35","4":"16.6","5":"13.5","6":"38.1","7":"43.4","8":"14.9"},{"1":"B","2":"M","3":"36","4":"16.8","5":"12.8","6":"36.2","7":"41.8","8":"14.9"},{"1":"B","2":"M","3":"37","4":"16.9","5":"13.2","6":"37.3","7":"42.7","8":"15.6"},{"1":"B","2":"M","3":"38","4":"17.1","5":"12.6","6":"36.4","7":"42.0","8":"15.1"},{"1":"B","2":"M","3":"39","4":"17.1","5":"12.7","6":"36.7","7":"41.9","8":"15.6"},{"1":"B","2":"M","3":"40","4":"17.2","5":"13.5","6":"37.6","7":"43.9","8":"16.1"},{"1":"B","2":"M","3":"41","4":"17.7","5":"13.6","6":"38.7","7":"44.5","8":"16.0"},{"1":"B","2":"M","3":"42","4":"17.9","5":"14.1","6":"39.7","7":"44.6","8":"16.8"},{"1":"B","2":"M","3":"43","4":"18.0","5":"13.7","6":"39.2","7":"44.4","8":"16.2"},{"1":"B","2":"M","3":"44","4":"18.8","5":"15.8","6":"42.1","7":"49.0","8":"17.8"},{"1":"B","2":"M","3":"45","4":"19.3","5":"13.5","6":"41.6","7":"47.4","8":"17.8"},{"1":"B","2":"M","3":"46","4":"19.3","5":"13.8","6":"40.9","7":"46.5","8":"16.8"},{"1":"B","2":"M","3":"47","4":"19.7","5":"15.3","6":"41.9","7":"48.5","8":"17.8"},{"1":"B","2":"M","3":"48","4":"19.8","5":"14.2","6":"43.2","7":"49.7","8":"18.6"},{"1":"B","2":"M","3":"49","4":"19.8","5":"14.3","6":"42.4","7":"48.9","8":"18.3"},{"1":"B","2":"M","3":"50","4":"21.3","5":"15.7","6":"47.1","7":"54.6","8":"20.0"},{"1":"B","2":"F","3":"1","4":"7.2","5":"6.5","6":"14.7","7":"17.1","8":"6.1"},{"1":"B","2":"F","3":"2","4":"9.0","5":"8.5","6":"19.3","7":"22.7","8":"7.7"},{"1":"B","2":"F","3":"3","4":"9.1","5":"8.1","6":"18.5","7":"21.6","8":"7.7"},{"1":"B","2":"F","3":"4","4":"9.1","5":"8.2","6":"19.2","7":"22.2","8":"7.7"},{"1":"B","2":"F","3":"5","4":"9.5","5":"8.2","6":"19.6","7":"22.4","8":"7.8"},{"1":"B","2":"F","3":"6","4":"9.8","5":"8.9","6":"20.4","7":"23.9","8":"8.8"},{"1":"B","2":"F","3":"7","4":"10.1","5":"9.3","6":"20.9","7":"24.4","8":"8.4"},{"1":"B","2":"F","3":"8","4":"10.3","5":"9.5","6":"21.3","7":"24.7","8":"8.9"},{"1":"B","2":"F","3":"9","4":"10.4","5":"9.7","6":"21.7","7":"25.4","8":"8.3"},{"1":"B","2":"F","3":"10","4":"10.8","5":"9.5","6":"22.5","7":"26.3","8":"9.1"},{"1":"B","2":"F","3":"11","4":"11.0","5":"9.8","6":"22.5","7":"25.7","8":"8.2"},{"1":"B","2":"F","3":"12","4":"11.2","5":"10.0","6":"22.8","7":"26.9","8":"9.4"},{"1":"B","2":"F","3":"13","4":"11.5","5":"11.0","6":"24.7","7":"29.2","8":"10.1"},{"1":"B","2":"F","3":"14","4":"11.6","5":"11.0","6":"24.6","7":"28.5","8":"10.4"},{"1":"B","2":"F","3":"15","4":"11.6","5":"11.4","6":"23.7","7":"27.7","8":"10.0"},{"1":"B","2":"F","3":"16","4":"11.7","5":"10.6","6":"24.9","7":"28.5","8":"10.4"},{"1":"B","2":"F","3":"17","4":"11.9","5":"11.4","6":"26.0","7":"30.1","8":"10.9"},{"1":"B","2":"F","3":"18","4":"12.0","5":"10.7","6":"24.6","7":"28.9","8":"10.5"},{"1":"B","2":"F","3":"19","4":"12.0","5":"11.1","6":"25.4","7":"29.2","8":"11.0"},{"1":"B","2":"F","3":"20","4":"12.6","5":"12.2","6":"26.1","7":"31.6","8":"11.2"},{"1":"B","2":"F","3":"21","4":"12.8","5":"11.7","6":"27.1","7":"31.2","8":"11.9"},{"1":"B","2":"F","3":"22","4":"12.8","5":"12.2","6":"26.7","7":"31.1","8":"11.1"},{"1":"B","2":"F","3":"23","4":"12.8","5":"12.2","6":"27.9","7":"31.9","8":"11.5"},{"1":"B","2":"F","3":"24","4":"13.0","5":"11.4","6":"27.3","7":"31.8","8":"11.3"},{"1":"B","2":"F","3":"25","4":"13.1","5":"11.5","6":"27.6","7":"32.6","8":"11.1"},{"1":"B","2":"F","3":"26","4":"13.2","5":"12.2","6":"27.9","7":"32.1","8":"11.5"},{"1":"B","2":"F","3":"27","4":"13.4","5":"11.8","6":"28.4","7":"32.7","8":"11.7"},{"1":"B","2":"F","3":"28","4":"13.7","5":"12.5","6":"28.6","7":"33.8","8":"11.9"},{"1":"B","2":"F","3":"29","4":"13.9","5":"13.0","6":"30.0","7":"34.9","8":"13.1"},{"1":"B","2":"F","3":"30","4":"14.7","5":"12.5","6":"30.1","7":"34.7","8":"12.5"},{"1":"B","2":"F","3":"31","4":"14.9","5":"13.2","6":"30.1","7":"35.6","8":"12.0"},{"1":"B","2":"F","3":"32","4":"15.0","5":"13.8","6":"31.7","7":"36.9","8":"14.0"},{"1":"B","2":"F","3":"33","4":"15.0","5":"14.2","6":"32.8","7":"37.4","8":"14.0"},{"1":"B","2":"F","3":"34","4":"15.1","5":"13.3","6":"31.8","7":"36.3","8":"13.5"},{"1":"B","2":"F","3":"35","4":"15.1","5":"13.5","6":"31.9","7":"37.0","8":"13.8"},{"1":"B","2":"F","3":"36","4":"15.1","5":"13.8","6":"31.7","7":"36.6","8":"13.0"},{"1":"B","2":"F","3":"37","4":"15.2","5":"14.3","6":"33.9","7":"38.5","8":"14.7"},{"1":"B","2":"F","3":"38","4":"15.3","5":"14.2","6":"32.6","7":"38.3","8":"13.8"},{"1":"B","2":"F","3":"39","4":"15.4","5":"13.3","6":"32.4","7":"37.6","8":"13.8"},{"1":"B","2":"F","3":"40","4":"15.5","5":"13.8","6":"33.4","7":"38.7","8":"14.7"},{"1":"B","2":"F","3":"41","4":"15.6","5":"13.9","6":"32.8","7":"37.9","8":"13.4"},{"1":"B","2":"F","3":"42","4":"15.6","5":"14.7","6":"33.9","7":"39.5","8":"14.3"},{"1":"B","2":"F","3":"43","4":"15.7","5":"13.9","6":"33.6","7":"38.5","8":"14.1"},{"1":"B","2":"F","3":"44","4":"15.8","5":"15.0","6":"34.5","7":"40.3","8":"15.3"},{"1":"B","2":"F","3":"45","4":"16.2","5":"15.2","6":"34.5","7":"40.1","8":"13.9"},{"1":"B","2":"F","3":"46","4":"16.4","5":"14.0","6":"34.2","7":"39.8","8":"15.2"},{"1":"B","2":"F","3":"47","4":"16.7","5":"16.1","6":"36.6","7":"41.9","8":"15.4"},{"1":"B","2":"F","3":"48","4":"17.4","5":"16.9","6":"38.2","7":"44.1","8":"16.6"},{"1":"B","2":"F","3":"49","4":"17.5","5":"16.7","6":"38.6","7":"44.5","8":"17.0"},{"1":"B","2":"F","3":"50","4":"19.2","5":"16.5","6":"40.9","7":"47.9","8":"18.1"},{"1":"O","2":"M","3":"1","4":"9.1","5":"6.9","6":"16.7","7":"18.6","8":"7.4"},{"1":"O","2":"M","3":"2","4":"10.2","5":"8.2","6":"20.2","7":"22.2","8":"9.0"},{"1":"O","2":"M","3":"3","4":"10.7","5":"8.6","6":"20.7","7":"22.7","8":"9.2"},{"1":"O","2":"M","3":"4","4":"11.4","5":"9.0","6":"22.7","7":"24.8","8":"10.1"},{"1":"O","2":"M","3":"5","4":"12.5","5":"9.4","6":"23.2","7":"26.0","8":"10.8"},{"1":"O","2":"M","3":"6","4":"12.5","5":"9.4","6":"24.2","7":"27.0","8":"11.2"},{"1":"O","2":"M","3":"7","4":"12.7","5":"10.4","6":"26.0","7":"28.8","8":"12.1"},{"1":"O","2":"M","3":"8","4":"13.2","5":"11.0","6":"27.1","7":"30.4","8":"12.2"},{"1":"O","2":"M","3":"9","4":"13.4","5":"10.1","6":"26.6","7":"29.6","8":"12.0"},{"1":"O","2":"M","3":"10","4":"13.7","5":"11.0","6":"27.5","7":"30.5","8":"12.2"},{"1":"O","2":"M","3":"11","4":"14.0","5":"11.5","6":"29.2","7":"32.2","8":"13.1"},{"1":"O","2":"M","3":"12","4":"14.1","5":"10.4","6":"28.9","7":"31.8","8":"13.5"},{"1":"O","2":"M","3":"13","4":"14.1","5":"10.5","6":"29.1","7":"31.6","8":"13.1"},{"1":"O","2":"M","3":"14","4":"14.1","5":"10.7","6":"28.7","7":"31.9","8":"13.3"},{"1":"O","2":"M","3":"15","4":"14.2","5":"10.6","6":"28.7","7":"31.7","8":"12.9"},{"1":"O","2":"M","3":"16","4":"14.2","5":"10.7","6":"27.8","7":"30.9","8":"12.7"},{"1":"O","2":"M","3":"17","4":"14.2","5":"11.3","6":"29.2","7":"32.2","8":"13.5"},{"1":"O","2":"M","3":"18","4":"14.6","5":"11.3","6":"29.9","7":"33.5","8":"12.8"},{"1":"O","2":"M","3":"19","4":"14.7","5":"11.1","6":"29.0","7":"32.1","8":"13.1"},{"1":"O","2":"M","3":"20","4":"15.1","5":"11.4","6":"30.2","7":"33.3","8":"14.0"},{"1":"O","2":"M","3":"21","4":"15.1","5":"11.5","6":"30.9","7":"34.0","8":"13.9"},{"1":"O","2":"M","3":"22","4":"15.4","5":"11.1","6":"30.2","7":"33.6","8":"13.5"},{"1":"O","2":"M","3":"23","4":"15.7","5":"12.2","6":"31.7","7":"34.2","8":"14.2"},{"1":"O","2":"M","3":"24","4":"16.2","5":"11.8","6":"32.3","7":"35.3","8":"14.7"},{"1":"O","2":"M","3":"25","4":"16.3","5":"11.6","6":"31.6","7":"34.2","8":"14.5"},{"1":"O","2":"M","3":"26","4":"17.1","5":"12.6","6":"35.0","7":"38.9","8":"15.7"},{"1":"O","2":"M","3":"27","4":"17.4","5":"12.8","6":"36.1","7":"39.5","8":"16.2"},{"1":"O","2":"M","3":"28","4":"17.5","5":"12.0","6":"34.4","7":"37.3","8":"15.3"},{"1":"O","2":"M","3":"29","4":"17.5","5":"12.7","6":"34.6","7":"38.4","8":"16.1"},{"1":"O","2":"M","3":"30","4":"17.8","5":"12.5","6":"36.0","7":"39.8","8":"16.7"},{"1":"O","2":"M","3":"31","4":"17.9","5":"12.9","6":"36.9","7":"40.9","8":"16.5"},{"1":"O","2":"M","3":"32","4":"18.0","5":"13.4","6":"36.7","7":"41.3","8":"17.1"},{"1":"O","2":"M","3":"33","4":"18.2","5":"13.7","6":"38.8","7":"42.7","8":"17.2"},{"1":"O","2":"M","3":"34","4":"18.4","5":"13.4","6":"37.9","7":"42.2","8":"17.7"},{"1":"O","2":"M","3":"35","4":"18.6","5":"13.4","6":"37.8","7":"41.9","8":"17.3"},{"1":"O","2":"M","3":"36","4":"18.6","5":"13.5","6":"36.9","7":"40.2","8":"17.0"},{"1":"O","2":"M","3":"37","4":"18.8","5":"13.4","6":"37.2","7":"41.1","8":"17.5"},{"1":"O","2":"M","3":"38","4":"18.8","5":"13.8","6":"39.2","7":"43.3","8":"17.9"},{"1":"O","2":"M","3":"39","4":"19.4","5":"14.1","6":"39.1","7":"43.2","8":"17.8"},{"1":"O","2":"M","3":"40","4":"19.4","5":"14.4","6":"39.8","7":"44.3","8":"17.9"},{"1":"O","2":"M","3":"41","4":"20.1","5":"13.7","6":"40.6","7":"44.5","8":"18.0"},{"1":"O","2":"M","3":"42","4":"20.6","5":"14.4","6":"42.8","7":"46.5","8":"19.6"},{"1":"O","2":"M","3":"43","4":"21.0","5":"15.0","6":"42.9","7":"47.2","8":"19.4"},{"1":"O","2":"M","3":"44","4":"21.5","5":"15.5","6":"45.5","7":"49.7","8":"20.9"},{"1":"O","2":"M","3":"45","4":"21.6","5":"15.4","6":"45.7","7":"49.7","8":"20.6"},{"1":"O","2":"M","3":"46","4":"21.6","5":"14.8","6":"43.4","7":"48.2","8":"20.1"},{"1":"O","2":"M","3":"47","4":"21.9","5":"15.7","6":"45.4","7":"51.0","8":"21.1"},{"1":"O","2":"M","3":"48","4":"22.1","5":"15.8","6":"44.6","7":"49.6","8":"20.5"},{"1":"O","2":"M","3":"49","4":"23.0","5":"16.8","6":"47.2","7":"52.1","8":"21.5"},{"1":"O","2":"M","3":"50","4":"23.1","5":"15.7","6":"47.6","7":"52.8","8":"21.6"},{"1":"O","2":"F","3":"1","4":"10.7","5":"9.7","6":"21.4","7":"24.0","8":"9.8"},{"1":"O","2":"F","3":"2","4":"11.4","5":"9.2","6":"21.7","7":"24.1","8":"9.7"},{"1":"O","2":"F","3":"3","4":"12.5","5":"10.0","6":"24.1","7":"27.0","8":"10.9"},{"1":"O","2":"F","3":"4","4":"12.6","5":"11.5","6":"25.0","7":"28.1","8":"11.5"},{"1":"O","2":"F","3":"5","4":"12.9","5":"11.2","6":"25.8","7":"29.1","8":"11.9"},{"1":"O","2":"F","3":"6","4":"14.0","5":"11.9","6":"27.0","7":"31.4","8":"12.6"},{"1":"O","2":"F","3":"7","4":"14.0","5":"12.8","6":"28.8","7":"32.4","8":"12.7"},{"1":"O","2":"F","3":"8","4":"14.3","5":"12.2","6":"28.1","7":"31.8","8":"12.5"},{"1":"O","2":"F","3":"9","4":"14.7","5":"13.2","6":"29.6","7":"33.4","8":"12.9"},{"1":"O","2":"F","3":"10","4":"14.9","5":"13.0","6":"30.0","7":"33.7","8":"13.3"},{"1":"O","2":"F","3":"11","4":"15.0","5":"12.3","6":"30.1","7":"33.3","8":"14.0"},{"1":"O","2":"F","3":"12","4":"15.6","5":"13.5","6":"31.2","7":"35.1","8":"14.1"},{"1":"O","2":"F","3":"13","4":"15.6","5":"14.0","6":"31.6","7":"35.3","8":"13.8"},{"1":"O","2":"F","3":"14","4":"15.6","5":"14.1","6":"31.0","7":"34.5","8":"13.8"},{"1":"O","2":"F","3":"15","4":"15.7","5":"13.6","6":"31.0","7":"34.8","8":"13.8"},{"1":"O","2":"F","3":"16","4":"16.1","5":"13.6","6":"31.6","7":"36.0","8":"14.0"},{"1":"O","2":"F","3":"17","4":"16.1","5":"13.7","6":"31.4","7":"36.1","8":"13.9"},{"1":"O","2":"F","3":"18","4":"16.2","5":"14.0","6":"31.6","7":"35.6","8":"13.7"},{"1":"O","2":"F","3":"19","4":"16.7","5":"14.3","6":"32.3","7":"37.0","8":"14.7"},{"1":"O","2":"F","3":"20","4":"17.1","5":"14.5","6":"33.1","7":"37.2","8":"14.6"},{"1":"O","2":"F","3":"21","4":"17.5","5":"14.3","6":"34.5","7":"39.6","8":"15.6"},{"1":"O","2":"F","3":"22","4":"17.5","5":"14.4","6":"34.5","7":"39.0","8":"16.0"},{"1":"O","2":"F","3":"23","4":"17.5","5":"14.7","6":"33.3","7":"37.6","8":"14.6"},{"1":"O","2":"F","3":"24","4":"17.6","5":"14.0","6":"34.0","7":"38.6","8":"15.5"},{"1":"O","2":"F","3":"25","4":"18.0","5":"14.9","6":"34.7","7":"39.5","8":"15.7"},{"1":"O","2":"F","3":"26","4":"18.0","5":"16.3","6":"37.9","7":"43.0","8":"17.2"},{"1":"O","2":"F","3":"27","4":"18.3","5":"15.7","6":"35.1","7":"40.5","8":"16.1"},{"1":"O","2":"F","3":"28","4":"18.4","5":"15.5","6":"35.6","7":"40.0","8":"15.9"},{"1":"O","2":"F","3":"29","4":"18.4","5":"15.7","6":"36.5","7":"41.6","8":"16.4"},{"1":"O","2":"F","3":"30","4":"18.5","5":"14.6","6":"37.0","7":"42.0","8":"16.6"},{"1":"O","2":"F","3":"31","4":"18.6","5":"14.5","6":"34.7","7":"39.4","8":"15.0"},{"1":"O","2":"F","3":"32","4":"18.8","5":"15.2","6":"35.8","7":"40.5","8":"16.6"},{"1":"O","2":"F","3":"33","4":"18.9","5":"16.7","6":"36.3","7":"41.7","8":"15.3"},{"1":"O","2":"F","3":"34","4":"19.1","5":"16.0","6":"37.8","7":"42.3","8":"16.8"},{"1":"O","2":"F","3":"35","4":"19.1","5":"16.3","6":"37.9","7":"42.6","8":"17.2"},{"1":"O","2":"F","3":"36","4":"19.7","5":"16.7","6":"39.9","7":"43.6","8":"18.2"},{"1":"O","2":"F","3":"37","4":"19.9","5":"16.6","6":"39.4","7":"43.9","8":"17.9"},{"1":"O","2":"F","3":"38","4":"19.9","5":"17.9","6":"40.1","7":"46.4","8":"17.9"},{"1":"O","2":"F","3":"39","4":"20.0","5":"16.7","6":"40.4","7":"45.1","8":"17.7"},{"1":"O","2":"F","3":"40","4":"20.1","5":"17.2","6":"39.8","7":"44.1","8":"18.6"},{"1":"O","2":"F","3":"41","4":"20.3","5":"16.0","6":"39.4","7":"44.1","8":"18.0"},{"1":"O","2":"F","3":"42","4":"20.5","5":"17.5","6":"40.0","7":"45.5","8":"19.2"},{"1":"O","2":"F","3":"43","4":"20.6","5":"17.5","6":"41.5","7":"46.2","8":"19.2"},{"1":"O","2":"F","3":"44","4":"20.9","5":"16.5","6":"39.9","7":"44.7","8":"17.5"},{"1":"O","2":"F","3":"45","4":"21.3","5":"18.4","6":"43.8","7":"48.4","8":"20.0"},{"1":"O","2":"F","3":"46","4":"21.4","5":"18.0","6":"41.2","7":"46.2","8":"18.7"},{"1":"O","2":"F","3":"47","4":"21.7","5":"17.1","6":"41.7","7":"47.2","8":"19.6"},{"1":"O","2":"F","3":"48","4":"21.9","5":"17.2","6":"42.6","7":"47.4","8":"19.5"},{"1":"O","2":"F","3":"49","4":"22.5","5":"17.2","6":"43.0","7":"48.7","8":"19.8"},{"1":"O","2":"F","3":"50","4":"23.1","5":"20.2","6":"46.2","7":"52.5","8":"21.1"}],"options":{"columns":{"min":{},"max":[10]},"rows":{"min":[10],"max":[10]},"pages":{}}}
  </script>
</div>

La fonction qui permet de combiner facilement les colonnes sex et species est la fonction `unite()` comme montré dans l'exemple ci-dessous. N'hésitez pas à faire appel à la fonction d'aide pour connaitre les arguments de la fonction. 


```r
crabs <- unite(crabs, col = "sp_sex",sex, species, sep = "_")
rmarkdown::paged_table(crabs)
```

<div data-pagedtable="false">
  <script data-pagedtable-source type="application/json">
{"columns":[{"label":["sp_sex"],"name":[1],"type":["chr"],"align":["left"]},{"label":["index"],"name":[2],"type":["int"],"align":["right"]},{"label":["front"],"name":[3],"type":["dbl"],"align":["right"]},{"label":["rear"],"name":[4],"type":["dbl"],"align":["right"]},{"label":["length"],"name":[5],"type":["dbl"],"align":["right"]},{"label":["width"],"name":[6],"type":["dbl"],"align":["right"]},{"label":["depth"],"name":[7],"type":["dbl"],"align":["right"]}],"data":[{"1":"M_B","2":"1","3":"8.1","4":"6.7","5":"16.1","6":"19.0","7":"7.0"},{"1":"M_B","2":"2","3":"8.8","4":"7.7","5":"18.1","6":"20.8","7":"7.4"},{"1":"M_B","2":"3","3":"9.2","4":"7.8","5":"19.0","6":"22.4","7":"7.7"},{"1":"M_B","2":"4","3":"9.6","4":"7.9","5":"20.1","6":"23.1","7":"8.2"},{"1":"M_B","2":"5","3":"9.8","4":"8.0","5":"20.3","6":"23.0","7":"8.2"},{"1":"M_B","2":"6","3":"10.8","4":"9.0","5":"23.0","6":"26.5","7":"9.8"},{"1":"M_B","2":"7","3":"11.1","4":"9.9","5":"23.8","6":"27.1","7":"9.8"},{"1":"M_B","2":"8","3":"11.6","4":"9.1","5":"24.5","6":"28.4","7":"10.4"},{"1":"M_B","2":"9","3":"11.8","4":"9.6","5":"24.2","6":"27.8","7":"9.7"},{"1":"M_B","2":"10","3":"11.8","4":"10.5","5":"25.2","6":"29.3","7":"10.3"},{"1":"M_B","2":"11","3":"12.2","4":"10.8","5":"27.3","6":"31.6","7":"10.9"},{"1":"M_B","2":"12","3":"12.3","4":"11.0","5":"26.8","6":"31.5","7":"11.4"},{"1":"M_B","2":"13","3":"12.6","4":"10.0","5":"27.7","6":"31.7","7":"11.4"},{"1":"M_B","2":"14","3":"12.8","4":"10.2","5":"27.2","6":"31.8","7":"10.9"},{"1":"M_B","2":"15","3":"12.8","4":"10.9","5":"27.4","6":"31.5","7":"11.0"},{"1":"M_B","2":"16","3":"12.9","4":"11.0","5":"26.8","6":"30.9","7":"11.4"},{"1":"M_B","2":"17","3":"13.1","4":"10.6","5":"28.2","6":"32.3","7":"11.0"},{"1":"M_B","2":"18","3":"13.1","4":"10.9","5":"28.3","6":"32.4","7":"11.2"},{"1":"M_B","2":"19","3":"13.3","4":"11.1","5":"27.8","6":"32.3","7":"11.3"},{"1":"M_B","2":"20","3":"13.9","4":"11.1","5":"29.2","6":"33.3","7":"12.1"},{"1":"M_B","2":"21","3":"14.3","4":"11.6","5":"31.3","6":"35.5","7":"12.7"},{"1":"M_B","2":"22","3":"14.6","4":"11.3","5":"31.9","6":"36.4","7":"13.7"},{"1":"M_B","2":"23","3":"15.0","4":"10.9","5":"31.4","6":"36.4","7":"13.2"},{"1":"M_B","2":"24","3":"15.0","4":"11.5","5":"32.4","6":"37.0","7":"13.4"},{"1":"M_B","2":"25","3":"15.0","4":"11.9","5":"32.5","6":"37.2","7":"13.6"},{"1":"M_B","2":"26","3":"15.2","4":"12.1","5":"32.3","6":"36.7","7":"13.6"},{"1":"M_B","2":"27","3":"15.4","4":"11.8","5":"33.0","6":"37.5","7":"13.6"},{"1":"M_B","2":"28","3":"15.7","4":"12.6","5":"35.8","6":"40.3","7":"14.5"},{"1":"M_B","2":"29","3":"15.9","4":"12.7","5":"34.0","6":"38.9","7":"14.2"},{"1":"M_B","2":"30","3":"16.1","4":"11.6","5":"33.8","6":"39.0","7":"14.4"},{"1":"M_B","2":"31","3":"16.1","4":"12.8","5":"34.9","6":"40.7","7":"15.7"},{"1":"M_B","2":"32","3":"16.2","4":"13.3","5":"36.0","6":"41.7","7":"15.4"},{"1":"M_B","2":"33","3":"16.3","4":"12.7","5":"35.6","6":"40.9","7":"14.9"},{"1":"M_B","2":"34","3":"16.4","4":"13.0","5":"35.7","6":"41.8","7":"15.2"},{"1":"M_B","2":"35","3":"16.6","4":"13.5","5":"38.1","6":"43.4","7":"14.9"},{"1":"M_B","2":"36","3":"16.8","4":"12.8","5":"36.2","6":"41.8","7":"14.9"},{"1":"M_B","2":"37","3":"16.9","4":"13.2","5":"37.3","6":"42.7","7":"15.6"},{"1":"M_B","2":"38","3":"17.1","4":"12.6","5":"36.4","6":"42.0","7":"15.1"},{"1":"M_B","2":"39","3":"17.1","4":"12.7","5":"36.7","6":"41.9","7":"15.6"},{"1":"M_B","2":"40","3":"17.2","4":"13.5","5":"37.6","6":"43.9","7":"16.1"},{"1":"M_B","2":"41","3":"17.7","4":"13.6","5":"38.7","6":"44.5","7":"16.0"},{"1":"M_B","2":"42","3":"17.9","4":"14.1","5":"39.7","6":"44.6","7":"16.8"},{"1":"M_B","2":"43","3":"18.0","4":"13.7","5":"39.2","6":"44.4","7":"16.2"},{"1":"M_B","2":"44","3":"18.8","4":"15.8","5":"42.1","6":"49.0","7":"17.8"},{"1":"M_B","2":"45","3":"19.3","4":"13.5","5":"41.6","6":"47.4","7":"17.8"},{"1":"M_B","2":"46","3":"19.3","4":"13.8","5":"40.9","6":"46.5","7":"16.8"},{"1":"M_B","2":"47","3":"19.7","4":"15.3","5":"41.9","6":"48.5","7":"17.8"},{"1":"M_B","2":"48","3":"19.8","4":"14.2","5":"43.2","6":"49.7","7":"18.6"},{"1":"M_B","2":"49","3":"19.8","4":"14.3","5":"42.4","6":"48.9","7":"18.3"},{"1":"M_B","2":"50","3":"21.3","4":"15.7","5":"47.1","6":"54.6","7":"20.0"},{"1":"F_B","2":"1","3":"7.2","4":"6.5","5":"14.7","6":"17.1","7":"6.1"},{"1":"F_B","2":"2","3":"9.0","4":"8.5","5":"19.3","6":"22.7","7":"7.7"},{"1":"F_B","2":"3","3":"9.1","4":"8.1","5":"18.5","6":"21.6","7":"7.7"},{"1":"F_B","2":"4","3":"9.1","4":"8.2","5":"19.2","6":"22.2","7":"7.7"},{"1":"F_B","2":"5","3":"9.5","4":"8.2","5":"19.6","6":"22.4","7":"7.8"},{"1":"F_B","2":"6","3":"9.8","4":"8.9","5":"20.4","6":"23.9","7":"8.8"},{"1":"F_B","2":"7","3":"10.1","4":"9.3","5":"20.9","6":"24.4","7":"8.4"},{"1":"F_B","2":"8","3":"10.3","4":"9.5","5":"21.3","6":"24.7","7":"8.9"},{"1":"F_B","2":"9","3":"10.4","4":"9.7","5":"21.7","6":"25.4","7":"8.3"},{"1":"F_B","2":"10","3":"10.8","4":"9.5","5":"22.5","6":"26.3","7":"9.1"},{"1":"F_B","2":"11","3":"11.0","4":"9.8","5":"22.5","6":"25.7","7":"8.2"},{"1":"F_B","2":"12","3":"11.2","4":"10.0","5":"22.8","6":"26.9","7":"9.4"},{"1":"F_B","2":"13","3":"11.5","4":"11.0","5":"24.7","6":"29.2","7":"10.1"},{"1":"F_B","2":"14","3":"11.6","4":"11.0","5":"24.6","6":"28.5","7":"10.4"},{"1":"F_B","2":"15","3":"11.6","4":"11.4","5":"23.7","6":"27.7","7":"10.0"},{"1":"F_B","2":"16","3":"11.7","4":"10.6","5":"24.9","6":"28.5","7":"10.4"},{"1":"F_B","2":"17","3":"11.9","4":"11.4","5":"26.0","6":"30.1","7":"10.9"},{"1":"F_B","2":"18","3":"12.0","4":"10.7","5":"24.6","6":"28.9","7":"10.5"},{"1":"F_B","2":"19","3":"12.0","4":"11.1","5":"25.4","6":"29.2","7":"11.0"},{"1":"F_B","2":"20","3":"12.6","4":"12.2","5":"26.1","6":"31.6","7":"11.2"},{"1":"F_B","2":"21","3":"12.8","4":"11.7","5":"27.1","6":"31.2","7":"11.9"},{"1":"F_B","2":"22","3":"12.8","4":"12.2","5":"26.7","6":"31.1","7":"11.1"},{"1":"F_B","2":"23","3":"12.8","4":"12.2","5":"27.9","6":"31.9","7":"11.5"},{"1":"F_B","2":"24","3":"13.0","4":"11.4","5":"27.3","6":"31.8","7":"11.3"},{"1":"F_B","2":"25","3":"13.1","4":"11.5","5":"27.6","6":"32.6","7":"11.1"},{"1":"F_B","2":"26","3":"13.2","4":"12.2","5":"27.9","6":"32.1","7":"11.5"},{"1":"F_B","2":"27","3":"13.4","4":"11.8","5":"28.4","6":"32.7","7":"11.7"},{"1":"F_B","2":"28","3":"13.7","4":"12.5","5":"28.6","6":"33.8","7":"11.9"},{"1":"F_B","2":"29","3":"13.9","4":"13.0","5":"30.0","6":"34.9","7":"13.1"},{"1":"F_B","2":"30","3":"14.7","4":"12.5","5":"30.1","6":"34.7","7":"12.5"},{"1":"F_B","2":"31","3":"14.9","4":"13.2","5":"30.1","6":"35.6","7":"12.0"},{"1":"F_B","2":"32","3":"15.0","4":"13.8","5":"31.7","6":"36.9","7":"14.0"},{"1":"F_B","2":"33","3":"15.0","4":"14.2","5":"32.8","6":"37.4","7":"14.0"},{"1":"F_B","2":"34","3":"15.1","4":"13.3","5":"31.8","6":"36.3","7":"13.5"},{"1":"F_B","2":"35","3":"15.1","4":"13.5","5":"31.9","6":"37.0","7":"13.8"},{"1":"F_B","2":"36","3":"15.1","4":"13.8","5":"31.7","6":"36.6","7":"13.0"},{"1":"F_B","2":"37","3":"15.2","4":"14.3","5":"33.9","6":"38.5","7":"14.7"},{"1":"F_B","2":"38","3":"15.3","4":"14.2","5":"32.6","6":"38.3","7":"13.8"},{"1":"F_B","2":"39","3":"15.4","4":"13.3","5":"32.4","6":"37.6","7":"13.8"},{"1":"F_B","2":"40","3":"15.5","4":"13.8","5":"33.4","6":"38.7","7":"14.7"},{"1":"F_B","2":"41","3":"15.6","4":"13.9","5":"32.8","6":"37.9","7":"13.4"},{"1":"F_B","2":"42","3":"15.6","4":"14.7","5":"33.9","6":"39.5","7":"14.3"},{"1":"F_B","2":"43","3":"15.7","4":"13.9","5":"33.6","6":"38.5","7":"14.1"},{"1":"F_B","2":"44","3":"15.8","4":"15.0","5":"34.5","6":"40.3","7":"15.3"},{"1":"F_B","2":"45","3":"16.2","4":"15.2","5":"34.5","6":"40.1","7":"13.9"},{"1":"F_B","2":"46","3":"16.4","4":"14.0","5":"34.2","6":"39.8","7":"15.2"},{"1":"F_B","2":"47","3":"16.7","4":"16.1","5":"36.6","6":"41.9","7":"15.4"},{"1":"F_B","2":"48","3":"17.4","4":"16.9","5":"38.2","6":"44.1","7":"16.6"},{"1":"F_B","2":"49","3":"17.5","4":"16.7","5":"38.6","6":"44.5","7":"17.0"},{"1":"F_B","2":"50","3":"19.2","4":"16.5","5":"40.9","6":"47.9","7":"18.1"},{"1":"M_O","2":"1","3":"9.1","4":"6.9","5":"16.7","6":"18.6","7":"7.4"},{"1":"M_O","2":"2","3":"10.2","4":"8.2","5":"20.2","6":"22.2","7":"9.0"},{"1":"M_O","2":"3","3":"10.7","4":"8.6","5":"20.7","6":"22.7","7":"9.2"},{"1":"M_O","2":"4","3":"11.4","4":"9.0","5":"22.7","6":"24.8","7":"10.1"},{"1":"M_O","2":"5","3":"12.5","4":"9.4","5":"23.2","6":"26.0","7":"10.8"},{"1":"M_O","2":"6","3":"12.5","4":"9.4","5":"24.2","6":"27.0","7":"11.2"},{"1":"M_O","2":"7","3":"12.7","4":"10.4","5":"26.0","6":"28.8","7":"12.1"},{"1":"M_O","2":"8","3":"13.2","4":"11.0","5":"27.1","6":"30.4","7":"12.2"},{"1":"M_O","2":"9","3":"13.4","4":"10.1","5":"26.6","6":"29.6","7":"12.0"},{"1":"M_O","2":"10","3":"13.7","4":"11.0","5":"27.5","6":"30.5","7":"12.2"},{"1":"M_O","2":"11","3":"14.0","4":"11.5","5":"29.2","6":"32.2","7":"13.1"},{"1":"M_O","2":"12","3":"14.1","4":"10.4","5":"28.9","6":"31.8","7":"13.5"},{"1":"M_O","2":"13","3":"14.1","4":"10.5","5":"29.1","6":"31.6","7":"13.1"},{"1":"M_O","2":"14","3":"14.1","4":"10.7","5":"28.7","6":"31.9","7":"13.3"},{"1":"M_O","2":"15","3":"14.2","4":"10.6","5":"28.7","6":"31.7","7":"12.9"},{"1":"M_O","2":"16","3":"14.2","4":"10.7","5":"27.8","6":"30.9","7":"12.7"},{"1":"M_O","2":"17","3":"14.2","4":"11.3","5":"29.2","6":"32.2","7":"13.5"},{"1":"M_O","2":"18","3":"14.6","4":"11.3","5":"29.9","6":"33.5","7":"12.8"},{"1":"M_O","2":"19","3":"14.7","4":"11.1","5":"29.0","6":"32.1","7":"13.1"},{"1":"M_O","2":"20","3":"15.1","4":"11.4","5":"30.2","6":"33.3","7":"14.0"},{"1":"M_O","2":"21","3":"15.1","4":"11.5","5":"30.9","6":"34.0","7":"13.9"},{"1":"M_O","2":"22","3":"15.4","4":"11.1","5":"30.2","6":"33.6","7":"13.5"},{"1":"M_O","2":"23","3":"15.7","4":"12.2","5":"31.7","6":"34.2","7":"14.2"},{"1":"M_O","2":"24","3":"16.2","4":"11.8","5":"32.3","6":"35.3","7":"14.7"},{"1":"M_O","2":"25","3":"16.3","4":"11.6","5":"31.6","6":"34.2","7":"14.5"},{"1":"M_O","2":"26","3":"17.1","4":"12.6","5":"35.0","6":"38.9","7":"15.7"},{"1":"M_O","2":"27","3":"17.4","4":"12.8","5":"36.1","6":"39.5","7":"16.2"},{"1":"M_O","2":"28","3":"17.5","4":"12.0","5":"34.4","6":"37.3","7":"15.3"},{"1":"M_O","2":"29","3":"17.5","4":"12.7","5":"34.6","6":"38.4","7":"16.1"},{"1":"M_O","2":"30","3":"17.8","4":"12.5","5":"36.0","6":"39.8","7":"16.7"},{"1":"M_O","2":"31","3":"17.9","4":"12.9","5":"36.9","6":"40.9","7":"16.5"},{"1":"M_O","2":"32","3":"18.0","4":"13.4","5":"36.7","6":"41.3","7":"17.1"},{"1":"M_O","2":"33","3":"18.2","4":"13.7","5":"38.8","6":"42.7","7":"17.2"},{"1":"M_O","2":"34","3":"18.4","4":"13.4","5":"37.9","6":"42.2","7":"17.7"},{"1":"M_O","2":"35","3":"18.6","4":"13.4","5":"37.8","6":"41.9","7":"17.3"},{"1":"M_O","2":"36","3":"18.6","4":"13.5","5":"36.9","6":"40.2","7":"17.0"},{"1":"M_O","2":"37","3":"18.8","4":"13.4","5":"37.2","6":"41.1","7":"17.5"},{"1":"M_O","2":"38","3":"18.8","4":"13.8","5":"39.2","6":"43.3","7":"17.9"},{"1":"M_O","2":"39","3":"19.4","4":"14.1","5":"39.1","6":"43.2","7":"17.8"},{"1":"M_O","2":"40","3":"19.4","4":"14.4","5":"39.8","6":"44.3","7":"17.9"},{"1":"M_O","2":"41","3":"20.1","4":"13.7","5":"40.6","6":"44.5","7":"18.0"},{"1":"M_O","2":"42","3":"20.6","4":"14.4","5":"42.8","6":"46.5","7":"19.6"},{"1":"M_O","2":"43","3":"21.0","4":"15.0","5":"42.9","6":"47.2","7":"19.4"},{"1":"M_O","2":"44","3":"21.5","4":"15.5","5":"45.5","6":"49.7","7":"20.9"},{"1":"M_O","2":"45","3":"21.6","4":"15.4","5":"45.7","6":"49.7","7":"20.6"},{"1":"M_O","2":"46","3":"21.6","4":"14.8","5":"43.4","6":"48.2","7":"20.1"},{"1":"M_O","2":"47","3":"21.9","4":"15.7","5":"45.4","6":"51.0","7":"21.1"},{"1":"M_O","2":"48","3":"22.1","4":"15.8","5":"44.6","6":"49.6","7":"20.5"},{"1":"M_O","2":"49","3":"23.0","4":"16.8","5":"47.2","6":"52.1","7":"21.5"},{"1":"M_O","2":"50","3":"23.1","4":"15.7","5":"47.6","6":"52.8","7":"21.6"},{"1":"F_O","2":"1","3":"10.7","4":"9.7","5":"21.4","6":"24.0","7":"9.8"},{"1":"F_O","2":"2","3":"11.4","4":"9.2","5":"21.7","6":"24.1","7":"9.7"},{"1":"F_O","2":"3","3":"12.5","4":"10.0","5":"24.1","6":"27.0","7":"10.9"},{"1":"F_O","2":"4","3":"12.6","4":"11.5","5":"25.0","6":"28.1","7":"11.5"},{"1":"F_O","2":"5","3":"12.9","4":"11.2","5":"25.8","6":"29.1","7":"11.9"},{"1":"F_O","2":"6","3":"14.0","4":"11.9","5":"27.0","6":"31.4","7":"12.6"},{"1":"F_O","2":"7","3":"14.0","4":"12.8","5":"28.8","6":"32.4","7":"12.7"},{"1":"F_O","2":"8","3":"14.3","4":"12.2","5":"28.1","6":"31.8","7":"12.5"},{"1":"F_O","2":"9","3":"14.7","4":"13.2","5":"29.6","6":"33.4","7":"12.9"},{"1":"F_O","2":"10","3":"14.9","4":"13.0","5":"30.0","6":"33.7","7":"13.3"},{"1":"F_O","2":"11","3":"15.0","4":"12.3","5":"30.1","6":"33.3","7":"14.0"},{"1":"F_O","2":"12","3":"15.6","4":"13.5","5":"31.2","6":"35.1","7":"14.1"},{"1":"F_O","2":"13","3":"15.6","4":"14.0","5":"31.6","6":"35.3","7":"13.8"},{"1":"F_O","2":"14","3":"15.6","4":"14.1","5":"31.0","6":"34.5","7":"13.8"},{"1":"F_O","2":"15","3":"15.7","4":"13.6","5":"31.0","6":"34.8","7":"13.8"},{"1":"F_O","2":"16","3":"16.1","4":"13.6","5":"31.6","6":"36.0","7":"14.0"},{"1":"F_O","2":"17","3":"16.1","4":"13.7","5":"31.4","6":"36.1","7":"13.9"},{"1":"F_O","2":"18","3":"16.2","4":"14.0","5":"31.6","6":"35.6","7":"13.7"},{"1":"F_O","2":"19","3":"16.7","4":"14.3","5":"32.3","6":"37.0","7":"14.7"},{"1":"F_O","2":"20","3":"17.1","4":"14.5","5":"33.1","6":"37.2","7":"14.6"},{"1":"F_O","2":"21","3":"17.5","4":"14.3","5":"34.5","6":"39.6","7":"15.6"},{"1":"F_O","2":"22","3":"17.5","4":"14.4","5":"34.5","6":"39.0","7":"16.0"},{"1":"F_O","2":"23","3":"17.5","4":"14.7","5":"33.3","6":"37.6","7":"14.6"},{"1":"F_O","2":"24","3":"17.6","4":"14.0","5":"34.0","6":"38.6","7":"15.5"},{"1":"F_O","2":"25","3":"18.0","4":"14.9","5":"34.7","6":"39.5","7":"15.7"},{"1":"F_O","2":"26","3":"18.0","4":"16.3","5":"37.9","6":"43.0","7":"17.2"},{"1":"F_O","2":"27","3":"18.3","4":"15.7","5":"35.1","6":"40.5","7":"16.1"},{"1":"F_O","2":"28","3":"18.4","4":"15.5","5":"35.6","6":"40.0","7":"15.9"},{"1":"F_O","2":"29","3":"18.4","4":"15.7","5":"36.5","6":"41.6","7":"16.4"},{"1":"F_O","2":"30","3":"18.5","4":"14.6","5":"37.0","6":"42.0","7":"16.6"},{"1":"F_O","2":"31","3":"18.6","4":"14.5","5":"34.7","6":"39.4","7":"15.0"},{"1":"F_O","2":"32","3":"18.8","4":"15.2","5":"35.8","6":"40.5","7":"16.6"},{"1":"F_O","2":"33","3":"18.9","4":"16.7","5":"36.3","6":"41.7","7":"15.3"},{"1":"F_O","2":"34","3":"19.1","4":"16.0","5":"37.8","6":"42.3","7":"16.8"},{"1":"F_O","2":"35","3":"19.1","4":"16.3","5":"37.9","6":"42.6","7":"17.2"},{"1":"F_O","2":"36","3":"19.7","4":"16.7","5":"39.9","6":"43.6","7":"18.2"},{"1":"F_O","2":"37","3":"19.9","4":"16.6","5":"39.4","6":"43.9","7":"17.9"},{"1":"F_O","2":"38","3":"19.9","4":"17.9","5":"40.1","6":"46.4","7":"17.9"},{"1":"F_O","2":"39","3":"20.0","4":"16.7","5":"40.4","6":"45.1","7":"17.7"},{"1":"F_O","2":"40","3":"20.1","4":"17.2","5":"39.8","6":"44.1","7":"18.6"},{"1":"F_O","2":"41","3":"20.3","4":"16.0","5":"39.4","6":"44.1","7":"18.0"},{"1":"F_O","2":"42","3":"20.5","4":"17.5","5":"40.0","6":"45.5","7":"19.2"},{"1":"F_O","2":"43","3":"20.6","4":"17.5","5":"41.5","6":"46.2","7":"19.2"},{"1":"F_O","2":"44","3":"20.9","4":"16.5","5":"39.9","6":"44.7","7":"17.5"},{"1":"F_O","2":"45","3":"21.3","4":"18.4","5":"43.8","6":"48.4","7":"20.0"},{"1":"F_O","2":"46","3":"21.4","4":"18.0","5":"41.2","6":"46.2","7":"18.7"},{"1":"F_O","2":"47","3":"21.7","4":"17.1","5":"41.7","6":"47.2","7":"19.6"},{"1":"F_O","2":"48","3":"21.9","4":"17.2","5":"42.6","6":"47.4","7":"19.5"},{"1":"F_O","2":"49","3":"22.5","4":"17.2","5":"43.0","6":"48.7","7":"19.8"},{"1":"F_O","2":"50","3":"23.1","4":"20.2","5":"46.2","6":"52.5","7":"21.1"}],"options":{"columns":{"min":{},"max":[10]},"rows":{"min":[10],"max":[10]},"pages":{}}}
  </script>
</div>

La fonction opposée à `unite()` est la fonction `separate()` qui permet de retourner vers le tableau d'origine.


```r
crabs <- separate(crabs, col = "sp_sex", into = c("sex", "species"), sep = "_")
rmarkdown::paged_table(crabs)
```

<div data-pagedtable="false">
  <script data-pagedtable-source type="application/json">
{"columns":[{"label":["sex"],"name":[1],"type":["chr"],"align":["left"]},{"label":["species"],"name":[2],"type":["chr"],"align":["left"]},{"label":["index"],"name":[3],"type":["int"],"align":["right"]},{"label":["front"],"name":[4],"type":["dbl"],"align":["right"]},{"label":["rear"],"name":[5],"type":["dbl"],"align":["right"]},{"label":["length"],"name":[6],"type":["dbl"],"align":["right"]},{"label":["width"],"name":[7],"type":["dbl"],"align":["right"]},{"label":["depth"],"name":[8],"type":["dbl"],"align":["right"]}],"data":[{"1":"M","2":"B","3":"1","4":"8.1","5":"6.7","6":"16.1","7":"19.0","8":"7.0"},{"1":"M","2":"B","3":"2","4":"8.8","5":"7.7","6":"18.1","7":"20.8","8":"7.4"},{"1":"M","2":"B","3":"3","4":"9.2","5":"7.8","6":"19.0","7":"22.4","8":"7.7"},{"1":"M","2":"B","3":"4","4":"9.6","5":"7.9","6":"20.1","7":"23.1","8":"8.2"},{"1":"M","2":"B","3":"5","4":"9.8","5":"8.0","6":"20.3","7":"23.0","8":"8.2"},{"1":"M","2":"B","3":"6","4":"10.8","5":"9.0","6":"23.0","7":"26.5","8":"9.8"},{"1":"M","2":"B","3":"7","4":"11.1","5":"9.9","6":"23.8","7":"27.1","8":"9.8"},{"1":"M","2":"B","3":"8","4":"11.6","5":"9.1","6":"24.5","7":"28.4","8":"10.4"},{"1":"M","2":"B","3":"9","4":"11.8","5":"9.6","6":"24.2","7":"27.8","8":"9.7"},{"1":"M","2":"B","3":"10","4":"11.8","5":"10.5","6":"25.2","7":"29.3","8":"10.3"},{"1":"M","2":"B","3":"11","4":"12.2","5":"10.8","6":"27.3","7":"31.6","8":"10.9"},{"1":"M","2":"B","3":"12","4":"12.3","5":"11.0","6":"26.8","7":"31.5","8":"11.4"},{"1":"M","2":"B","3":"13","4":"12.6","5":"10.0","6":"27.7","7":"31.7","8":"11.4"},{"1":"M","2":"B","3":"14","4":"12.8","5":"10.2","6":"27.2","7":"31.8","8":"10.9"},{"1":"M","2":"B","3":"15","4":"12.8","5":"10.9","6":"27.4","7":"31.5","8":"11.0"},{"1":"M","2":"B","3":"16","4":"12.9","5":"11.0","6":"26.8","7":"30.9","8":"11.4"},{"1":"M","2":"B","3":"17","4":"13.1","5":"10.6","6":"28.2","7":"32.3","8":"11.0"},{"1":"M","2":"B","3":"18","4":"13.1","5":"10.9","6":"28.3","7":"32.4","8":"11.2"},{"1":"M","2":"B","3":"19","4":"13.3","5":"11.1","6":"27.8","7":"32.3","8":"11.3"},{"1":"M","2":"B","3":"20","4":"13.9","5":"11.1","6":"29.2","7":"33.3","8":"12.1"},{"1":"M","2":"B","3":"21","4":"14.3","5":"11.6","6":"31.3","7":"35.5","8":"12.7"},{"1":"M","2":"B","3":"22","4":"14.6","5":"11.3","6":"31.9","7":"36.4","8":"13.7"},{"1":"M","2":"B","3":"23","4":"15.0","5":"10.9","6":"31.4","7":"36.4","8":"13.2"},{"1":"M","2":"B","3":"24","4":"15.0","5":"11.5","6":"32.4","7":"37.0","8":"13.4"},{"1":"M","2":"B","3":"25","4":"15.0","5":"11.9","6":"32.5","7":"37.2","8":"13.6"},{"1":"M","2":"B","3":"26","4":"15.2","5":"12.1","6":"32.3","7":"36.7","8":"13.6"},{"1":"M","2":"B","3":"27","4":"15.4","5":"11.8","6":"33.0","7":"37.5","8":"13.6"},{"1":"M","2":"B","3":"28","4":"15.7","5":"12.6","6":"35.8","7":"40.3","8":"14.5"},{"1":"M","2":"B","3":"29","4":"15.9","5":"12.7","6":"34.0","7":"38.9","8":"14.2"},{"1":"M","2":"B","3":"30","4":"16.1","5":"11.6","6":"33.8","7":"39.0","8":"14.4"},{"1":"M","2":"B","3":"31","4":"16.1","5":"12.8","6":"34.9","7":"40.7","8":"15.7"},{"1":"M","2":"B","3":"32","4":"16.2","5":"13.3","6":"36.0","7":"41.7","8":"15.4"},{"1":"M","2":"B","3":"33","4":"16.3","5":"12.7","6":"35.6","7":"40.9","8":"14.9"},{"1":"M","2":"B","3":"34","4":"16.4","5":"13.0","6":"35.7","7":"41.8","8":"15.2"},{"1":"M","2":"B","3":"35","4":"16.6","5":"13.5","6":"38.1","7":"43.4","8":"14.9"},{"1":"M","2":"B","3":"36","4":"16.8","5":"12.8","6":"36.2","7":"41.8","8":"14.9"},{"1":"M","2":"B","3":"37","4":"16.9","5":"13.2","6":"37.3","7":"42.7","8":"15.6"},{"1":"M","2":"B","3":"38","4":"17.1","5":"12.6","6":"36.4","7":"42.0","8":"15.1"},{"1":"M","2":"B","3":"39","4":"17.1","5":"12.7","6":"36.7","7":"41.9","8":"15.6"},{"1":"M","2":"B","3":"40","4":"17.2","5":"13.5","6":"37.6","7":"43.9","8":"16.1"},{"1":"M","2":"B","3":"41","4":"17.7","5":"13.6","6":"38.7","7":"44.5","8":"16.0"},{"1":"M","2":"B","3":"42","4":"17.9","5":"14.1","6":"39.7","7":"44.6","8":"16.8"},{"1":"M","2":"B","3":"43","4":"18.0","5":"13.7","6":"39.2","7":"44.4","8":"16.2"},{"1":"M","2":"B","3":"44","4":"18.8","5":"15.8","6":"42.1","7":"49.0","8":"17.8"},{"1":"M","2":"B","3":"45","4":"19.3","5":"13.5","6":"41.6","7":"47.4","8":"17.8"},{"1":"M","2":"B","3":"46","4":"19.3","5":"13.8","6":"40.9","7":"46.5","8":"16.8"},{"1":"M","2":"B","3":"47","4":"19.7","5":"15.3","6":"41.9","7":"48.5","8":"17.8"},{"1":"M","2":"B","3":"48","4":"19.8","5":"14.2","6":"43.2","7":"49.7","8":"18.6"},{"1":"M","2":"B","3":"49","4":"19.8","5":"14.3","6":"42.4","7":"48.9","8":"18.3"},{"1":"M","2":"B","3":"50","4":"21.3","5":"15.7","6":"47.1","7":"54.6","8":"20.0"},{"1":"F","2":"B","3":"1","4":"7.2","5":"6.5","6":"14.7","7":"17.1","8":"6.1"},{"1":"F","2":"B","3":"2","4":"9.0","5":"8.5","6":"19.3","7":"22.7","8":"7.7"},{"1":"F","2":"B","3":"3","4":"9.1","5":"8.1","6":"18.5","7":"21.6","8":"7.7"},{"1":"F","2":"B","3":"4","4":"9.1","5":"8.2","6":"19.2","7":"22.2","8":"7.7"},{"1":"F","2":"B","3":"5","4":"9.5","5":"8.2","6":"19.6","7":"22.4","8":"7.8"},{"1":"F","2":"B","3":"6","4":"9.8","5":"8.9","6":"20.4","7":"23.9","8":"8.8"},{"1":"F","2":"B","3":"7","4":"10.1","5":"9.3","6":"20.9","7":"24.4","8":"8.4"},{"1":"F","2":"B","3":"8","4":"10.3","5":"9.5","6":"21.3","7":"24.7","8":"8.9"},{"1":"F","2":"B","3":"9","4":"10.4","5":"9.7","6":"21.7","7":"25.4","8":"8.3"},{"1":"F","2":"B","3":"10","4":"10.8","5":"9.5","6":"22.5","7":"26.3","8":"9.1"},{"1":"F","2":"B","3":"11","4":"11.0","5":"9.8","6":"22.5","7":"25.7","8":"8.2"},{"1":"F","2":"B","3":"12","4":"11.2","5":"10.0","6":"22.8","7":"26.9","8":"9.4"},{"1":"F","2":"B","3":"13","4":"11.5","5":"11.0","6":"24.7","7":"29.2","8":"10.1"},{"1":"F","2":"B","3":"14","4":"11.6","5":"11.0","6":"24.6","7":"28.5","8":"10.4"},{"1":"F","2":"B","3":"15","4":"11.6","5":"11.4","6":"23.7","7":"27.7","8":"10.0"},{"1":"F","2":"B","3":"16","4":"11.7","5":"10.6","6":"24.9","7":"28.5","8":"10.4"},{"1":"F","2":"B","3":"17","4":"11.9","5":"11.4","6":"26.0","7":"30.1","8":"10.9"},{"1":"F","2":"B","3":"18","4":"12.0","5":"10.7","6":"24.6","7":"28.9","8":"10.5"},{"1":"F","2":"B","3":"19","4":"12.0","5":"11.1","6":"25.4","7":"29.2","8":"11.0"},{"1":"F","2":"B","3":"20","4":"12.6","5":"12.2","6":"26.1","7":"31.6","8":"11.2"},{"1":"F","2":"B","3":"21","4":"12.8","5":"11.7","6":"27.1","7":"31.2","8":"11.9"},{"1":"F","2":"B","3":"22","4":"12.8","5":"12.2","6":"26.7","7":"31.1","8":"11.1"},{"1":"F","2":"B","3":"23","4":"12.8","5":"12.2","6":"27.9","7":"31.9","8":"11.5"},{"1":"F","2":"B","3":"24","4":"13.0","5":"11.4","6":"27.3","7":"31.8","8":"11.3"},{"1":"F","2":"B","3":"25","4":"13.1","5":"11.5","6":"27.6","7":"32.6","8":"11.1"},{"1":"F","2":"B","3":"26","4":"13.2","5":"12.2","6":"27.9","7":"32.1","8":"11.5"},{"1":"F","2":"B","3":"27","4":"13.4","5":"11.8","6":"28.4","7":"32.7","8":"11.7"},{"1":"F","2":"B","3":"28","4":"13.7","5":"12.5","6":"28.6","7":"33.8","8":"11.9"},{"1":"F","2":"B","3":"29","4":"13.9","5":"13.0","6":"30.0","7":"34.9","8":"13.1"},{"1":"F","2":"B","3":"30","4":"14.7","5":"12.5","6":"30.1","7":"34.7","8":"12.5"},{"1":"F","2":"B","3":"31","4":"14.9","5":"13.2","6":"30.1","7":"35.6","8":"12.0"},{"1":"F","2":"B","3":"32","4":"15.0","5":"13.8","6":"31.7","7":"36.9","8":"14.0"},{"1":"F","2":"B","3":"33","4":"15.0","5":"14.2","6":"32.8","7":"37.4","8":"14.0"},{"1":"F","2":"B","3":"34","4":"15.1","5":"13.3","6":"31.8","7":"36.3","8":"13.5"},{"1":"F","2":"B","3":"35","4":"15.1","5":"13.5","6":"31.9","7":"37.0","8":"13.8"},{"1":"F","2":"B","3":"36","4":"15.1","5":"13.8","6":"31.7","7":"36.6","8":"13.0"},{"1":"F","2":"B","3":"37","4":"15.2","5":"14.3","6":"33.9","7":"38.5","8":"14.7"},{"1":"F","2":"B","3":"38","4":"15.3","5":"14.2","6":"32.6","7":"38.3","8":"13.8"},{"1":"F","2":"B","3":"39","4":"15.4","5":"13.3","6":"32.4","7":"37.6","8":"13.8"},{"1":"F","2":"B","3":"40","4":"15.5","5":"13.8","6":"33.4","7":"38.7","8":"14.7"},{"1":"F","2":"B","3":"41","4":"15.6","5":"13.9","6":"32.8","7":"37.9","8":"13.4"},{"1":"F","2":"B","3":"42","4":"15.6","5":"14.7","6":"33.9","7":"39.5","8":"14.3"},{"1":"F","2":"B","3":"43","4":"15.7","5":"13.9","6":"33.6","7":"38.5","8":"14.1"},{"1":"F","2":"B","3":"44","4":"15.8","5":"15.0","6":"34.5","7":"40.3","8":"15.3"},{"1":"F","2":"B","3":"45","4":"16.2","5":"15.2","6":"34.5","7":"40.1","8":"13.9"},{"1":"F","2":"B","3":"46","4":"16.4","5":"14.0","6":"34.2","7":"39.8","8":"15.2"},{"1":"F","2":"B","3":"47","4":"16.7","5":"16.1","6":"36.6","7":"41.9","8":"15.4"},{"1":"F","2":"B","3":"48","4":"17.4","5":"16.9","6":"38.2","7":"44.1","8":"16.6"},{"1":"F","2":"B","3":"49","4":"17.5","5":"16.7","6":"38.6","7":"44.5","8":"17.0"},{"1":"F","2":"B","3":"50","4":"19.2","5":"16.5","6":"40.9","7":"47.9","8":"18.1"},{"1":"M","2":"O","3":"1","4":"9.1","5":"6.9","6":"16.7","7":"18.6","8":"7.4"},{"1":"M","2":"O","3":"2","4":"10.2","5":"8.2","6":"20.2","7":"22.2","8":"9.0"},{"1":"M","2":"O","3":"3","4":"10.7","5":"8.6","6":"20.7","7":"22.7","8":"9.2"},{"1":"M","2":"O","3":"4","4":"11.4","5":"9.0","6":"22.7","7":"24.8","8":"10.1"},{"1":"M","2":"O","3":"5","4":"12.5","5":"9.4","6":"23.2","7":"26.0","8":"10.8"},{"1":"M","2":"O","3":"6","4":"12.5","5":"9.4","6":"24.2","7":"27.0","8":"11.2"},{"1":"M","2":"O","3":"7","4":"12.7","5":"10.4","6":"26.0","7":"28.8","8":"12.1"},{"1":"M","2":"O","3":"8","4":"13.2","5":"11.0","6":"27.1","7":"30.4","8":"12.2"},{"1":"M","2":"O","3":"9","4":"13.4","5":"10.1","6":"26.6","7":"29.6","8":"12.0"},{"1":"M","2":"O","3":"10","4":"13.7","5":"11.0","6":"27.5","7":"30.5","8":"12.2"},{"1":"M","2":"O","3":"11","4":"14.0","5":"11.5","6":"29.2","7":"32.2","8":"13.1"},{"1":"M","2":"O","3":"12","4":"14.1","5":"10.4","6":"28.9","7":"31.8","8":"13.5"},{"1":"M","2":"O","3":"13","4":"14.1","5":"10.5","6":"29.1","7":"31.6","8":"13.1"},{"1":"M","2":"O","3":"14","4":"14.1","5":"10.7","6":"28.7","7":"31.9","8":"13.3"},{"1":"M","2":"O","3":"15","4":"14.2","5":"10.6","6":"28.7","7":"31.7","8":"12.9"},{"1":"M","2":"O","3":"16","4":"14.2","5":"10.7","6":"27.8","7":"30.9","8":"12.7"},{"1":"M","2":"O","3":"17","4":"14.2","5":"11.3","6":"29.2","7":"32.2","8":"13.5"},{"1":"M","2":"O","3":"18","4":"14.6","5":"11.3","6":"29.9","7":"33.5","8":"12.8"},{"1":"M","2":"O","3":"19","4":"14.7","5":"11.1","6":"29.0","7":"32.1","8":"13.1"},{"1":"M","2":"O","3":"20","4":"15.1","5":"11.4","6":"30.2","7":"33.3","8":"14.0"},{"1":"M","2":"O","3":"21","4":"15.1","5":"11.5","6":"30.9","7":"34.0","8":"13.9"},{"1":"M","2":"O","3":"22","4":"15.4","5":"11.1","6":"30.2","7":"33.6","8":"13.5"},{"1":"M","2":"O","3":"23","4":"15.7","5":"12.2","6":"31.7","7":"34.2","8":"14.2"},{"1":"M","2":"O","3":"24","4":"16.2","5":"11.8","6":"32.3","7":"35.3","8":"14.7"},{"1":"M","2":"O","3":"25","4":"16.3","5":"11.6","6":"31.6","7":"34.2","8":"14.5"},{"1":"M","2":"O","3":"26","4":"17.1","5":"12.6","6":"35.0","7":"38.9","8":"15.7"},{"1":"M","2":"O","3":"27","4":"17.4","5":"12.8","6":"36.1","7":"39.5","8":"16.2"},{"1":"M","2":"O","3":"28","4":"17.5","5":"12.0","6":"34.4","7":"37.3","8":"15.3"},{"1":"M","2":"O","3":"29","4":"17.5","5":"12.7","6":"34.6","7":"38.4","8":"16.1"},{"1":"M","2":"O","3":"30","4":"17.8","5":"12.5","6":"36.0","7":"39.8","8":"16.7"},{"1":"M","2":"O","3":"31","4":"17.9","5":"12.9","6":"36.9","7":"40.9","8":"16.5"},{"1":"M","2":"O","3":"32","4":"18.0","5":"13.4","6":"36.7","7":"41.3","8":"17.1"},{"1":"M","2":"O","3":"33","4":"18.2","5":"13.7","6":"38.8","7":"42.7","8":"17.2"},{"1":"M","2":"O","3":"34","4":"18.4","5":"13.4","6":"37.9","7":"42.2","8":"17.7"},{"1":"M","2":"O","3":"35","4":"18.6","5":"13.4","6":"37.8","7":"41.9","8":"17.3"},{"1":"M","2":"O","3":"36","4":"18.6","5":"13.5","6":"36.9","7":"40.2","8":"17.0"},{"1":"M","2":"O","3":"37","4":"18.8","5":"13.4","6":"37.2","7":"41.1","8":"17.5"},{"1":"M","2":"O","3":"38","4":"18.8","5":"13.8","6":"39.2","7":"43.3","8":"17.9"},{"1":"M","2":"O","3":"39","4":"19.4","5":"14.1","6":"39.1","7":"43.2","8":"17.8"},{"1":"M","2":"O","3":"40","4":"19.4","5":"14.4","6":"39.8","7":"44.3","8":"17.9"},{"1":"M","2":"O","3":"41","4":"20.1","5":"13.7","6":"40.6","7":"44.5","8":"18.0"},{"1":"M","2":"O","3":"42","4":"20.6","5":"14.4","6":"42.8","7":"46.5","8":"19.6"},{"1":"M","2":"O","3":"43","4":"21.0","5":"15.0","6":"42.9","7":"47.2","8":"19.4"},{"1":"M","2":"O","3":"44","4":"21.5","5":"15.5","6":"45.5","7":"49.7","8":"20.9"},{"1":"M","2":"O","3":"45","4":"21.6","5":"15.4","6":"45.7","7":"49.7","8":"20.6"},{"1":"M","2":"O","3":"46","4":"21.6","5":"14.8","6":"43.4","7":"48.2","8":"20.1"},{"1":"M","2":"O","3":"47","4":"21.9","5":"15.7","6":"45.4","7":"51.0","8":"21.1"},{"1":"M","2":"O","3":"48","4":"22.1","5":"15.8","6":"44.6","7":"49.6","8":"20.5"},{"1":"M","2":"O","3":"49","4":"23.0","5":"16.8","6":"47.2","7":"52.1","8":"21.5"},{"1":"M","2":"O","3":"50","4":"23.1","5":"15.7","6":"47.6","7":"52.8","8":"21.6"},{"1":"F","2":"O","3":"1","4":"10.7","5":"9.7","6":"21.4","7":"24.0","8":"9.8"},{"1":"F","2":"O","3":"2","4":"11.4","5":"9.2","6":"21.7","7":"24.1","8":"9.7"},{"1":"F","2":"O","3":"3","4":"12.5","5":"10.0","6":"24.1","7":"27.0","8":"10.9"},{"1":"F","2":"O","3":"4","4":"12.6","5":"11.5","6":"25.0","7":"28.1","8":"11.5"},{"1":"F","2":"O","3":"5","4":"12.9","5":"11.2","6":"25.8","7":"29.1","8":"11.9"},{"1":"F","2":"O","3":"6","4":"14.0","5":"11.9","6":"27.0","7":"31.4","8":"12.6"},{"1":"F","2":"O","3":"7","4":"14.0","5":"12.8","6":"28.8","7":"32.4","8":"12.7"},{"1":"F","2":"O","3":"8","4":"14.3","5":"12.2","6":"28.1","7":"31.8","8":"12.5"},{"1":"F","2":"O","3":"9","4":"14.7","5":"13.2","6":"29.6","7":"33.4","8":"12.9"},{"1":"F","2":"O","3":"10","4":"14.9","5":"13.0","6":"30.0","7":"33.7","8":"13.3"},{"1":"F","2":"O","3":"11","4":"15.0","5":"12.3","6":"30.1","7":"33.3","8":"14.0"},{"1":"F","2":"O","3":"12","4":"15.6","5":"13.5","6":"31.2","7":"35.1","8":"14.1"},{"1":"F","2":"O","3":"13","4":"15.6","5":"14.0","6":"31.6","7":"35.3","8":"13.8"},{"1":"F","2":"O","3":"14","4":"15.6","5":"14.1","6":"31.0","7":"34.5","8":"13.8"},{"1":"F","2":"O","3":"15","4":"15.7","5":"13.6","6":"31.0","7":"34.8","8":"13.8"},{"1":"F","2":"O","3":"16","4":"16.1","5":"13.6","6":"31.6","7":"36.0","8":"14.0"},{"1":"F","2":"O","3":"17","4":"16.1","5":"13.7","6":"31.4","7":"36.1","8":"13.9"},{"1":"F","2":"O","3":"18","4":"16.2","5":"14.0","6":"31.6","7":"35.6","8":"13.7"},{"1":"F","2":"O","3":"19","4":"16.7","5":"14.3","6":"32.3","7":"37.0","8":"14.7"},{"1":"F","2":"O","3":"20","4":"17.1","5":"14.5","6":"33.1","7":"37.2","8":"14.6"},{"1":"F","2":"O","3":"21","4":"17.5","5":"14.3","6":"34.5","7":"39.6","8":"15.6"},{"1":"F","2":"O","3":"22","4":"17.5","5":"14.4","6":"34.5","7":"39.0","8":"16.0"},{"1":"F","2":"O","3":"23","4":"17.5","5":"14.7","6":"33.3","7":"37.6","8":"14.6"},{"1":"F","2":"O","3":"24","4":"17.6","5":"14.0","6":"34.0","7":"38.6","8":"15.5"},{"1":"F","2":"O","3":"25","4":"18.0","5":"14.9","6":"34.7","7":"39.5","8":"15.7"},{"1":"F","2":"O","3":"26","4":"18.0","5":"16.3","6":"37.9","7":"43.0","8":"17.2"},{"1":"F","2":"O","3":"27","4":"18.3","5":"15.7","6":"35.1","7":"40.5","8":"16.1"},{"1":"F","2":"O","3":"28","4":"18.4","5":"15.5","6":"35.6","7":"40.0","8":"15.9"},{"1":"F","2":"O","3":"29","4":"18.4","5":"15.7","6":"36.5","7":"41.6","8":"16.4"},{"1":"F","2":"O","3":"30","4":"18.5","5":"14.6","6":"37.0","7":"42.0","8":"16.6"},{"1":"F","2":"O","3":"31","4":"18.6","5":"14.5","6":"34.7","7":"39.4","8":"15.0"},{"1":"F","2":"O","3":"32","4":"18.8","5":"15.2","6":"35.8","7":"40.5","8":"16.6"},{"1":"F","2":"O","3":"33","4":"18.9","5":"16.7","6":"36.3","7":"41.7","8":"15.3"},{"1":"F","2":"O","3":"34","4":"19.1","5":"16.0","6":"37.8","7":"42.3","8":"16.8"},{"1":"F","2":"O","3":"35","4":"19.1","5":"16.3","6":"37.9","7":"42.6","8":"17.2"},{"1":"F","2":"O","3":"36","4":"19.7","5":"16.7","6":"39.9","7":"43.6","8":"18.2"},{"1":"F","2":"O","3":"37","4":"19.9","5":"16.6","6":"39.4","7":"43.9","8":"17.9"},{"1":"F","2":"O","3":"38","4":"19.9","5":"17.9","6":"40.1","7":"46.4","8":"17.9"},{"1":"F","2":"O","3":"39","4":"20.0","5":"16.7","6":"40.4","7":"45.1","8":"17.7"},{"1":"F","2":"O","3":"40","4":"20.1","5":"17.2","6":"39.8","7":"44.1","8":"18.6"},{"1":"F","2":"O","3":"41","4":"20.3","5":"16.0","6":"39.4","7":"44.1","8":"18.0"},{"1":"F","2":"O","3":"42","4":"20.5","5":"17.5","6":"40.0","7":"45.5","8":"19.2"},{"1":"F","2":"O","3":"43","4":"20.6","5":"17.5","6":"41.5","7":"46.2","8":"19.2"},{"1":"F","2":"O","3":"44","4":"20.9","5":"16.5","6":"39.9","7":"44.7","8":"17.5"},{"1":"F","2":"O","3":"45","4":"21.3","5":"18.4","6":"43.8","7":"48.4","8":"20.0"},{"1":"F","2":"O","3":"46","4":"21.4","5":"18.0","6":"41.2","7":"46.2","8":"18.7"},{"1":"F","2":"O","3":"47","4":"21.7","5":"17.1","6":"41.7","7":"47.2","8":"19.6"},{"1":"F","2":"O","3":"48","4":"21.9","5":"17.2","6":"42.6","7":"47.4","8":"19.5"},{"1":"F","2":"O","3":"49","4":"22.5","5":"17.2","6":"43.0","7":"48.7","8":"19.8"},{"1":"F","2":"O","3":"50","4":"23.1","5":"20.2","6":"46.2","7":"52.5","8":"21.1"}],"options":{"columns":{"min":{},"max":[10]},"rows":{"min":[10],"max":[10]},"pages":{}}}
  </script>
</div>

## Multi-tableaux

Durant vos analyses, vous serez confronté à devoir gérer plusieurs tableaux que vous allez vouloir rassembler en un seul tableau.

L'aide-mémoire [Data Import::CHEAT SHEET](https://github.com/rstudio/cheatsheets/blob/master/data-transformation.pdf) est l'outil pour vous aider dans cette tache. Vous y trouverez des explications dans la section Combine Tables. 

Ces outils provenant du package **dplyr** sont décrits en détails dans ["R for Data Science"](https://r4ds.had.co.nz/relational-data.html). 

Pour combiner deux tableaux de données par les lignes, la fonction la plus simple est `bind_rows()`.

Partons de données mesurée dans les mésoscosmes de notre laboratoire les différents paramètres suivants : 
- la temperature, le ph, la salinté, l'oxygène dissous à l'aide d'instruments tels qu'un pHmètre, un conductimètre ou encore un oxymètre
- la concentration en orthophosphate et en nitrate dissous  dans l'eau à l'aide d'un autoanalyseur employant la colorimétrie

Ils ont obtenu 3 fichiers qu'ils ont du par la suite recombiner.

Le groupe A a encodé le tableau suivant : 


```r
param_physico_A <- as_dataframe(tibble(sample = c("A0", "B0", "A0", "B0", "A0", 
                                                "B0", "A0", "B0"), 
                                     ph = c(7.94, 7.94, 7.94, 7.99, 7.94, 7.99,
                                            7.94, 7.99),
                                     salinity = c(34.0, 35.3, 33.9, 35.1, 34.0,
                                                  35.2, 33.9, 35.1),
                                     oxygen = c(7.98, 8.00, 7.98, 7.98, 7.99, 
                                                7.86, 7.89, 7.98),
                                     temperature = c(24.6, 24.4, 25.1, 24.7, 
                                                     24.9, 24.7, 25.0, 24.6),
                                     student = c("st1", "st1", "st2", "st2", 
                                                 "st3", "st3", "st4", "st4" )
                                     ))
rmarkdown::paged_table(param_physico_A)
```

<div data-pagedtable="false">
  <script data-pagedtable-source type="application/json">
{"columns":[{"label":["sample"],"name":[1],"type":["chr"],"align":["left"]},{"label":["ph"],"name":[2],"type":["dbl"],"align":["right"]},{"label":["salinity"],"name":[3],"type":["dbl"],"align":["right"]},{"label":["oxygen"],"name":[4],"type":["dbl"],"align":["right"]},{"label":["temperature"],"name":[5],"type":["dbl"],"align":["right"]},{"label":["student"],"name":[6],"type":["chr"],"align":["left"]}],"data":[{"1":"A0","2":"7.94","3":"34.0","4":"7.98","5":"24.6","6":"st1"},{"1":"B0","2":"7.94","3":"35.3","4":"8.00","5":"24.4","6":"st1"},{"1":"A0","2":"7.94","3":"33.9","4":"7.98","5":"25.1","6":"st2"},{"1":"B0","2":"7.99","3":"35.1","4":"7.98","5":"24.7","6":"st2"},{"1":"A0","2":"7.94","3":"34.0","4":"7.99","5":"24.9","6":"st3"},{"1":"B0","2":"7.99","3":"35.2","4":"7.86","5":"24.7","6":"st3"},{"1":"A0","2":"7.94","3":"33.9","4":"7.89","5":"25.0","6":"st4"},{"1":"B0","2":"7.99","3":"35.1","4":"7.98","5":"24.6","6":"st4"}],"options":{"columns":{"min":{},"max":[10]},"rows":{"min":[10],"max":[10]},"pages":{}}}
  </script>
</div>

Le groupe B a encodé le tableau suivant :


```r
param_physico_B <- as_dataframe(tibble(sample = c("A0", "B0", "A0", "B0"), 
                                      ph = c(7.94, 7.99, 7.93, 7.99),
                                      salinity = c(33.8, 35.0, 33.9, 35.1),
                                      oxygen = c(7.96, 8.01, 7.90, 8.00),
                                      temperature = c(25.0, 24.6, 24.0, 24.0),
                                      student = c( "st5", "st5", "st6", "st6")
                                      ))
rmarkdown::paged_table(param_physico_A)
```

<div data-pagedtable="false">
  <script data-pagedtable-source type="application/json">
{"columns":[{"label":["sample"],"name":[1],"type":["chr"],"align":["left"]},{"label":["ph"],"name":[2],"type":["dbl"],"align":["right"]},{"label":["salinity"],"name":[3],"type":["dbl"],"align":["right"]},{"label":["oxygen"],"name":[4],"type":["dbl"],"align":["right"]},{"label":["temperature"],"name":[5],"type":["dbl"],"align":["right"]},{"label":["student"],"name":[6],"type":["chr"],"align":["left"]}],"data":[{"1":"A0","2":"7.94","3":"34.0","4":"7.98","5":"24.6","6":"st1"},{"1":"B0","2":"7.94","3":"35.3","4":"8.00","5":"24.4","6":"st1"},{"1":"A0","2":"7.94","3":"33.9","4":"7.98","5":"25.1","6":"st2"},{"1":"B0","2":"7.99","3":"35.1","4":"7.98","5":"24.7","6":"st2"},{"1":"A0","2":"7.94","3":"34.0","4":"7.99","5":"24.9","6":"st3"},{"1":"B0","2":"7.99","3":"35.2","4":"7.86","5":"24.7","6":"st3"},{"1":"A0","2":"7.94","3":"33.9","4":"7.89","5":"25.0","6":"st4"},{"1":"B0","2":"7.99","3":"35.1","4":"7.98","5":"24.6","6":"st4"}],"options":{"columns":{"min":{},"max":[10]},"rows":{"min":[10],"max":[10]},"pages":{}}}
  </script>
</div>


La combinaison des deux tableaux de données se fait via la fonction bind_rows()


```r
param_physico <- bind_rows(param_physico_A, param_physico_B)
rmarkdown::paged_table(param_physico)
```

<div data-pagedtable="false">
  <script data-pagedtable-source type="application/json">
{"columns":[{"label":["sample"],"name":[1],"type":["chr"],"align":["left"]},{"label":["ph"],"name":[2],"type":["dbl"],"align":["right"]},{"label":["salinity"],"name":[3],"type":["dbl"],"align":["right"]},{"label":["oxygen"],"name":[4],"type":["dbl"],"align":["right"]},{"label":["temperature"],"name":[5],"type":["dbl"],"align":["right"]},{"label":["student"],"name":[6],"type":["chr"],"align":["left"]}],"data":[{"1":"A0","2":"7.94","3":"34.0","4":"7.98","5":"24.6","6":"st1"},{"1":"B0","2":"7.94","3":"35.3","4":"8.00","5":"24.4","6":"st1"},{"1":"A0","2":"7.94","3":"33.9","4":"7.98","5":"25.1","6":"st2"},{"1":"B0","2":"7.99","3":"35.1","4":"7.98","5":"24.7","6":"st2"},{"1":"A0","2":"7.94","3":"34.0","4":"7.99","5":"24.9","6":"st3"},{"1":"B0","2":"7.99","3":"35.2","4":"7.86","5":"24.7","6":"st3"},{"1":"A0","2":"7.94","3":"33.9","4":"7.89","5":"25.0","6":"st4"},{"1":"B0","2":"7.99","3":"35.1","4":"7.98","5":"24.6","6":"st4"},{"1":"A0","2":"7.94","3":"33.8","4":"7.96","5":"25.0","6":"st5"},{"1":"B0","2":"7.99","3":"35.0","4":"8.01","5":"24.6","6":"st5"},{"1":"A0","2":"7.93","3":"33.9","4":"7.90","5":"24.0","6":"st6"},{"1":"B0","2":"7.99","3":"35.1","4":"8.00","5":"24.0","6":"st6"}],"options":{"columns":{"min":{},"max":[10]},"rows":{"min":[10],"max":[10]},"pages":{}}}
  </script>
</div>

Les deux groupes ont également réalisés des prélèvements d'eau qui ont été dosé par colorimétrie avec un autoanalyseur. Les échantillons des deux groupes ont été analysé dans la même série.


```r
nutrient <- as_dataframe(tibble(sample = rep(c("A0", "B0"), times = 6),
                                student = c("st4", "st4", "st6", "st6", 
                                            "st5", "st5", "st2", "st2",
                                            "st1", "st1", "st3", "st3"),
                                po4_conc = c(2.445, 0.374, 2.446, 0.394, 2.433,
                                             0.361, 2.441, 0.372, 2.438, 0.388,
                                             2.445, 0.390),
                                no3_conc = c(1.145, 0.104, 0.447, 0.066, 0.439,
                                             0.093, 0.477, 0.167, 0.443, 0.593,
                                             0.450, 0.125)
                                     ))
rmarkdown::paged_table(nutrient)
```

<div data-pagedtable="false">
  <script data-pagedtable-source type="application/json">
{"columns":[{"label":["sample"],"name":[1],"type":["chr"],"align":["left"]},{"label":["student"],"name":[2],"type":["chr"],"align":["left"]},{"label":["po4_conc"],"name":[3],"type":["dbl"],"align":["right"]},{"label":["no3_conc"],"name":[4],"type":["dbl"],"align":["right"]}],"data":[{"1":"A0","2":"st4","3":"2.445","4":"1.145"},{"1":"B0","2":"st4","3":"0.374","4":"0.104"},{"1":"A0","2":"st6","3":"2.446","4":"0.447"},{"1":"B0","2":"st6","3":"0.394","4":"0.066"},{"1":"A0","2":"st5","3":"2.433","4":"0.439"},{"1":"B0","2":"st5","3":"0.361","4":"0.093"},{"1":"A0","2":"st2","3":"2.441","4":"0.477"},{"1":"B0","2":"st2","3":"0.372","4":"0.167"},{"1":"A0","2":"st1","3":"2.438","4":"0.443"},{"1":"B0","2":"st1","3":"0.388","4":"0.593"},{"1":"A0","2":"st3","3":"2.445","4":"0.450"},{"1":"B0","2":"st3","3":"0.390","4":"0.125"}],"options":{"columns":{"min":{},"max":[10]},"rows":{"min":[10],"max":[10]},"pages":{}}}
  </script>
</div>

Pour combiner deux tableaux de données par les colonnes, la fonction la plus simple est `bind_cols()`.

Vous devez être très vigilant lors de l'utilisation de cette fonction car cette dernière combine vos tableaux sans s'assurer que vos lignes soient alignées convenablement. 




```r
param <- bind_cols(param_physico, nutrient)
# Visualisation du tableau de données
rmarkdown::paged_table(param)
```

<div data-pagedtable="false">
  <script data-pagedtable-source type="application/json">
{"columns":[{"label":["sample"],"name":[1],"type":["chr"],"align":["left"]},{"label":["ph"],"name":[2],"type":["dbl"],"align":["right"]},{"label":["salinity"],"name":[3],"type":["dbl"],"align":["right"]},{"label":["oxygen"],"name":[4],"type":["dbl"],"align":["right"]},{"label":["temperature"],"name":[5],"type":["dbl"],"align":["right"]},{"label":["student"],"name":[6],"type":["chr"],"align":["left"]},{"label":["sample1"],"name":[7],"type":["chr"],"align":["left"]},{"label":["student1"],"name":[8],"type":["chr"],"align":["left"]},{"label":["po4_conc"],"name":[9],"type":["dbl"],"align":["right"]},{"label":["no3_conc"],"name":[10],"type":["dbl"],"align":["right"]}],"data":[{"1":"A0","2":"7.94","3":"34.0","4":"7.98","5":"24.6","6":"st1","7":"A0","8":"st4","9":"2.445","10":"1.145"},{"1":"B0","2":"7.94","3":"35.3","4":"8.00","5":"24.4","6":"st1","7":"B0","8":"st4","9":"0.374","10":"0.104"},{"1":"A0","2":"7.94","3":"33.9","4":"7.98","5":"25.1","6":"st2","7":"A0","8":"st6","9":"2.446","10":"0.447"},{"1":"B0","2":"7.99","3":"35.1","4":"7.98","5":"24.7","6":"st2","7":"B0","8":"st6","9":"0.394","10":"0.066"},{"1":"A0","2":"7.94","3":"34.0","4":"7.99","5":"24.9","6":"st3","7":"A0","8":"st5","9":"2.433","10":"0.439"},{"1":"B0","2":"7.99","3":"35.2","4":"7.86","5":"24.7","6":"st3","7":"B0","8":"st5","9":"0.361","10":"0.093"},{"1":"A0","2":"7.94","3":"33.9","4":"7.89","5":"25.0","6":"st4","7":"A0","8":"st2","9":"2.441","10":"0.477"},{"1":"B0","2":"7.99","3":"35.1","4":"7.98","5":"24.6","6":"st4","7":"B0","8":"st2","9":"0.372","10":"0.167"},{"1":"A0","2":"7.94","3":"33.8","4":"7.96","5":"25.0","6":"st5","7":"A0","8":"st1","9":"2.438","10":"0.443"},{"1":"B0","2":"7.99","3":"35.0","4":"8.01","5":"24.6","6":"st5","7":"B0","8":"st1","9":"0.388","10":"0.593"},{"1":"A0","2":"7.93","3":"33.9","4":"7.90","5":"24.0","6":"st6","7":"A0","8":"st3","9":"2.445","10":"0.450"},{"1":"B0","2":"7.99","3":"35.1","4":"8.00","5":"24.0","6":"st6","7":"B0","8":"st3","9":"0.390","10":"0.125"}],"options":{"columns":{"min":{},"max":[10]},"rows":{"min":[10],"max":[10]},"pages":{}}}
  </script>
</div>

Qu'observez vous ? 

Effectivement nos deux tableaux de données n'ont pas les lignes dans le même ordre. Il faut être vigilant lors de ce genre de combinaison de tableaux. IL est préférable d'employer des fonctions comme left_joint() qui vont employer un ou plusieurs colonnes similaire sur les deux tableaux de donnée.


```r
param <- left_join(param_physico, nutrient, by = c("student", "sample"))
# Visualisation du tableau de données
rmarkdown::paged_table(param)
```

<div data-pagedtable="false">
  <script data-pagedtable-source type="application/json">
{"columns":[{"label":["sample"],"name":[1],"type":["chr"],"align":["left"]},{"label":["ph"],"name":[2],"type":["dbl"],"align":["right"]},{"label":["salinity"],"name":[3],"type":["dbl"],"align":["right"]},{"label":["oxygen"],"name":[4],"type":["dbl"],"align":["right"]},{"label":["temperature"],"name":[5],"type":["dbl"],"align":["right"]},{"label":["student"],"name":[6],"type":["chr"],"align":["left"]},{"label":["po4_conc"],"name":[7],"type":["dbl"],"align":["right"]},{"label":["no3_conc"],"name":[8],"type":["dbl"],"align":["right"]}],"data":[{"1":"A0","2":"7.94","3":"34.0","4":"7.98","5":"24.6","6":"st1","7":"2.438","8":"0.443"},{"1":"B0","2":"7.94","3":"35.3","4":"8.00","5":"24.4","6":"st1","7":"0.388","8":"0.593"},{"1":"A0","2":"7.94","3":"33.9","4":"7.98","5":"25.1","6":"st2","7":"2.441","8":"0.477"},{"1":"B0","2":"7.99","3":"35.1","4":"7.98","5":"24.7","6":"st2","7":"0.372","8":"0.167"},{"1":"A0","2":"7.94","3":"34.0","4":"7.99","5":"24.9","6":"st3","7":"2.445","8":"0.450"},{"1":"B0","2":"7.99","3":"35.2","4":"7.86","5":"24.7","6":"st3","7":"0.390","8":"0.125"},{"1":"A0","2":"7.94","3":"33.9","4":"7.89","5":"25.0","6":"st4","7":"2.445","8":"1.145"},{"1":"B0","2":"7.99","3":"35.1","4":"7.98","5":"24.6","6":"st4","7":"0.374","8":"0.104"},{"1":"A0","2":"7.94","3":"33.8","4":"7.96","5":"25.0","6":"st5","7":"2.433","8":"0.439"},{"1":"B0","2":"7.99","3":"35.0","4":"8.01","5":"24.6","6":"st5","7":"0.361","8":"0.093"},{"1":"A0","2":"7.93","3":"33.9","4":"7.90","5":"24.0","6":"st6","7":"2.446","8":"0.447"},{"1":"B0","2":"7.99","3":"35.1","4":"8.00","5":"24.0","6":"st6","7":"0.394","8":"0.066"}],"options":{"columns":{"min":{},"max":[10]},"rows":{"min":[10],"max":[10]},"pages":{}}}
  </script>
</div>

##### A vous de jouer {-}

TODO
