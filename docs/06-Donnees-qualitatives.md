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

<!--html_preserve--><div id="htmlwidget-d6c0d2c311041ebde7ee" style="width:100%;height:auto;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-d6c0d2c311041ebde7ee">{"x":{"filter":"none","data":[["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31","32","33","34","35","36","37","38","39","40","41","42","43","44","45","46","47","48","49","50","51","52","53","54","55","56","57","58","59","60","61","62","63","64","65","66","67","68","69","70","71","72","73","74","75","76","77","78","79","80","81","82","83","84","85","86","87","88","89","90","91","92","93","94","95","96","97","98","99","100","101","102","103","104","105","106","107","108","109","110","111","112","113","114","115","116","117","118","119","120","121","122","123","124","125","126","127","128","129","130","131","132","133","134","135","136","137","138","139","140","141","142","143","144","145","146","147","148","149","150"],[5.1,4.9,4.7,4.6,5,5.4,4.6,5,4.4,4.9,5.4,4.8,4.8,4.3,5.8,5.7,5.4,5.1,5.7,5.1,5.4,5.1,4.6,5.1,4.8,5,5,5.2,5.2,4.7,4.8,5.4,5.2,5.5,4.9,5,5.5,4.9,4.4,5.1,5,4.5,4.4,5,5.1,4.8,5.1,4.6,5.3,5,7,6.4,6.9,5.5,6.5,5.7,6.3,4.9,6.6,5.2,5,5.9,6,6.1,5.6,6.7,5.6,5.8,6.2,5.6,5.9,6.1,6.3,6.1,6.4,6.6,6.8,6.7,6,5.7,5.5,5.5,5.8,6,5.4,6,6.7,6.3,5.6,5.5,5.5,6.1,5.8,5,5.6,5.7,5.7,6.2,5.1,5.7,6.3,5.8,7.1,6.3,6.5,7.6,4.9,7.3,6.7,7.2,6.5,6.4,6.8,5.7,5.8,6.4,6.5,7.7,7.7,6,6.9,5.6,7.7,6.3,6.7,7.2,6.2,6.1,6.4,7.2,7.4,7.9,6.4,6.3,6.1,7.7,6.3,6.4,6,6.9,6.7,6.9,5.8,6.8,6.7,6.7,6.3,6.5,6.2,5.9],[3.5,3,3.2,3.1,3.6,3.9,3.4,3.4,2.9,3.1,3.7,3.4,3,3,4,4.4,3.9,3.5,3.8,3.8,3.4,3.7,3.6,3.3,3.4,3,3.4,3.5,3.4,3.2,3.1,3.4,4.1,4.2,3.1,3.2,3.5,3.6,3,3.4,3.5,2.3,3.2,3.5,3.8,3,3.8,3.2,3.7,3.3,3.2,3.2,3.1,2.3,2.8,2.8,3.3,2.4,2.9,2.7,2,3,2.2,2.9,2.9,3.1,3,2.7,2.2,2.5,3.2,2.8,2.5,2.8,2.9,3,2.8,3,2.9,2.6,2.4,2.4,2.7,2.7,3,3.4,3.1,2.3,3,2.5,2.6,3,2.6,2.3,2.7,3,2.9,2.9,2.5,2.8,3.3,2.7,3,2.9,3,3,2.5,2.9,2.5,3.6,3.2,2.7,3,2.5,2.8,3.2,3,3.8,2.6,2.2,3.2,2.8,2.8,2.7,3.3,3.2,2.8,3,2.8,3,2.8,3.8,2.8,2.8,2.6,3,3.4,3.1,3,3.1,3.1,3.1,2.7,3.2,3.3,3,2.5,3,3.4,3],[1.4,1.4,1.3,1.5,1.4,1.7,1.4,1.5,1.4,1.5,1.5,1.6,1.4,1.1,1.2,1.5,1.3,1.4,1.7,1.5,1.7,1.5,1,1.7,1.9,1.6,1.6,1.5,1.4,1.6,1.6,1.5,1.5,1.4,1.5,1.2,1.3,1.4,1.3,1.5,1.3,1.3,1.3,1.6,1.9,1.4,1.6,1.4,1.5,1.4,4.7,4.5,4.9,4,4.6,4.5,4.7,3.3,4.6,3.9,3.5,4.2,4,4.7,3.6,4.4,4.5,4.1,4.5,3.9,4.8,4,4.9,4.7,4.3,4.4,4.8,5,4.5,3.5,3.8,3.7,3.9,5.1,4.5,4.5,4.7,4.4,4.1,4,4.4,4.6,4,3.3,4.2,4.2,4.2,4.3,3,4.1,6,5.1,5.9,5.6,5.8,6.6,4.5,6.3,5.8,6.1,5.1,5.3,5.5,5,5.1,5.3,5.5,6.7,6.9,5,5.7,4.9,6.7,4.9,5.7,6,4.8,4.9,5.6,5.8,6.1,6.4,5.6,5.1,5.6,6.1,5.6,5.5,4.8,5.4,5.6,5.1,5.1,5.9,5.7,5.2,5,5.2,5.4,5.1],[0.2,0.2,0.2,0.2,0.2,0.4,0.3,0.2,0.2,0.1,0.2,0.2,0.1,0.1,0.2,0.4,0.4,0.3,0.3,0.3,0.2,0.4,0.2,0.5,0.2,0.2,0.4,0.2,0.2,0.2,0.2,0.4,0.1,0.2,0.2,0.2,0.2,0.1,0.2,0.2,0.3,0.3,0.2,0.6,0.4,0.3,0.2,0.2,0.2,0.2,1.4,1.5,1.5,1.3,1.5,1.3,1.6,1,1.3,1.4,1,1.5,1,1.4,1.3,1.4,1.5,1,1.5,1.1,1.8,1.3,1.5,1.2,1.3,1.4,1.4,1.7,1.5,1,1.1,1,1.2,1.6,1.5,1.6,1.5,1.3,1.3,1.3,1.2,1.4,1.2,1,1.3,1.2,1.3,1.3,1.1,1.3,2.5,1.9,2.1,1.8,2.2,2.1,1.7,1.8,1.8,2.5,2,1.9,2.1,2,2.4,2.3,1.8,2.2,2.3,1.5,2.3,2,2,1.8,2.1,1.8,1.8,1.8,2.1,1.6,1.9,2,2.2,1.5,1.4,2.3,2.4,1.8,1.8,2.1,2.4,2.3,1.9,2.3,2.5,2.3,1.9,2,2.3,1.8],["setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica"]],"container":"<table class=\"display\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>Sepal.Length<\/th>\n      <th>Sepal.Width<\/th>\n      <th>Petal.Length<\/th>\n      <th>Petal.Width<\/th>\n      <th>Species<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"columnDefs":[{"className":"dt-right","targets":[1,2,3,4]},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script><!--/html_preserve-->


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
