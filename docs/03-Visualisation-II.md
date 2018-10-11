# Visualisation II {#visu2}




#### Objectifs {-}

- Savoir réaliser différentes variantes de graphiques tel que les histogrammes, les graphes de densité ou encore les diagrammes en violon dans R avec la fonction `chart()`

- Intégrer ensuite des graphiques dans un rapport et y décrire ce que que vous observez

- Gérer des conflits dans GitHub


####  A vous de jouer ! {-}

Une nouvelle tâche va vous être demandée ci-dessous en utilisant GitHub Classroom \@ref(classroom). Cette tâche est un travail **en équipe**. Une fois votre assignation réalisée, faite un clone de votre dépôt et placer le dans le dossier `projects`. Pour cette tâche, vous démarrerez d'un projet RStudio \@ref(rs_projet)

\BeginKnitrBlock{bdd}<div class="bdd">Un projet sur le zooplancton provenant de Madagascar est mis à votre dispositon. 
Utilisez l'URL suivant qui va vous donner accès à votre tâche. Cette tâche est un travail individuel. **Cette tache est un travail en binome**

- <TODO>
</div>\EndKnitrBlock{bdd}

Employez le projet sur la biométrie des oursins et sur le zooplancton pour découvrir les nouveaux outils graphiques décrits dans ce module. 

#### Prérequis {-}

Si ce n'est déjà fait, vous devez avoir réaliser les modules précédents.


## Histogramme

Lors d'une expérience vous souhaitez visualiser la façon dont vos données s'étalent sur un axe (on parle de **distribution**^[TODO] en statistique) pour l'une des variables étudiées. L'histogramme est l'un des outils pouvant vous apporter cette information. Ce graphique va découper en plusieurs **classes**^[TODO] une variable numérique.

<div class="figure" style="text-align: center">
<img src="03-Visualisation-II_files/figure-html/unnamed-chunk-2-1.svg" alt="Histogramme montrant la distribution de la taille d'un échantillon de zooplancton étudié par analyse d'image." width="672" />
<p class="caption">(\#fig:unnamed-chunk-2)Histogramme montrant la distribution de la taille d'un échantillon de zooplancton étudié par analyse d'image.</p>
</div>

Les éléments indispensables à la compréhension d'un histogramme sont (ici mis en évidence en couleur)

- Les axes avec les graduations (en rouge)
- les labels et unité des axes (en bleu)

Les instructions de base afin de produire un histogramme :


```r
# Importation du jeu de données
(zooplankton <- read( file = "zooplankton", package = "data.io", lang = "fr"))
```

```
# # A tibble: 1,262 x 20
#      ecd  area perimeter feret major minor  mean  mode   min   max std_dev
#    <dbl> <dbl>     <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl>   <dbl>
#  1 0.770 0.465      4.45 1.32  1.16  0.509 0.363 0.036 0.004 0.908   0.231
#  2 0.700 0.385      2.32 0.728 0.713 0.688 0.361 0.492 0.024 0.676   0.183
#  3 0.815 0.521      4.15 1.33  1.11  0.598 0.308 0.032 0.008 0.696   0.204
#  4 0.785 0.484      4.44 1.78  1.56  0.394 0.332 0.036 0.004 0.728   0.218
#  5 0.361 0.103      1.71 0.739 0.694 0.188 0.153 0.016 0.008 0.452   0.110
#  6 0.832 0.544      5.27 1.66  1.36  0.511 0.371 0.02  0.004 0.844   0.268
#  7 1.23  1.20      15.7  3.92  1.37  1.11  0.217 0.012 0.004 0.784   0.214
#  8 0.620 0.302      3.98 1.19  1.04  0.370 0.316 0.012 0.004 0.756   0.246
#  9 1.19  1.12      15.3  3.85  1.34  1.06  0.176 0.012 0.004 0.728   0.172
# 10 1.04  0.856      7.60 1.89  1.66  0.656 0.404 0.044 0.004 0.88    0.264
# # ... with 1,252 more rows, and 9 more variables: range <dbl>, size <dbl>,
# #   aspect <dbl>, elongation <dbl>, compactness <dbl>, transparency <dbl>,
# #   circularity <dbl>, density <dbl>, class <fct>
```

```r
# Réalisation du graphique
chart(zooplankton, formula = ~ size) +
  geom_histogram(bins = 50) 
```

<div class="figure" style="text-align: center">
<img src="03-Visualisation-II_files/figure-html/unnamed-chunk-3-1.svg" alt="Instructions pour obtenir un histogramme." width="672" />
<p class="caption">(\#fig:unnamed-chunk-3)Instructions pour obtenir un histogramme.</p>
</div>

```r
# bins permet de préciser le nombre de classes souhaitées
```

La fonction `chart()` requiert comme argument le jeu de donnée (`zooplankton`, c'est un objet `dataframe` ou `tibble` dans le langage de R), ainsi que la formule à employer dans laquelle vous avez indiqué le nom de la variable que vous voulez sur l'axe des abscisses à droite de la formule. Vous voyez que le jeu de données contient beaucoup de variables (les titres des colonnes du tableau en sortie). Parmi toutes ces variables, nous avons choisi ici de représenter `size`, Jusqu'ici, nous avons spécifié _ce que_ nous voulons représenter, mais pas encore _comment_ (sous quelle apparence), nous voulons matérialiser cela sur le graphique. Pour un histogramme, nous devons ajouter la fonction `geom_histogram()`. L'argument `bins` dans cette fonction permet de préciser le nombre de classes souhaitées.

Vous pouvez décrypter votre histogramme sur base des **modes**^[TODO] et de la **symétrie**^[TODO] de ces derniers. Les modes les plus fréquents sont unimodal, bimodal ou multimodal. 

<div class="figure" style="text-align: center">
<img src="03-Visualisation-II_files/figure-html/unnamed-chunk-4-1.svg" alt="Histogrammes montrant les modes et symétries : A. histogramme unimodal et symétrique, B. histogramme bimodal et asymétrique, C. histogramme unimodal et asymétrique, D. histogramme multimodal et symétrique." width="672" />
<p class="caption">(\#fig:unnamed-chunk-4)Histogrammes montrant les modes et symétries : A. histogramme unimodal et symétrique, B. histogramme bimodal et asymétrique, C. histogramme unimodal et asymétrique, D. histogramme multimodal et symétrique.</p>
</div>

### Pièges et astuces

#### Nombres de classes d'un histogramme

Vous devez être particulièrement vigilant lors de la réalisation d'un histogramme aux classes de ce dernier. 


```r
# Réalisation du graphique précédent
a <- chart(zooplankton, formula = ~ size) +
  geom_histogram(bins = 50) 

# Modification du nombre de classes
b <- chart(zooplankton, formula = ~ size) +
  geom_histogram(bins = 20)

c <- chart(zooplankton, formula = ~ size) +
  geom_histogram(bins = 10)

d <- chart(zooplankton, formula = ~ size) +
  geom_histogram(bins = 5) 

# Assemblage des graphiques
ggarrange(a, b, c, d, labels = "AUTO", font.label = list(size = 14, align = "hv"))
```

<div class="figure" style="text-align: center">
<img src="03-Visualisation-II_files/figure-html/unnamed-chunk-5-1.svg" alt="Piège de l'histogramme. A. histogramme initial montrant la répartition des tailles au sein d'organismes planctoniques. B., C., D. Histogramme A en modifiant le nombres de classes." width="672" />
<p class="caption">(\#fig:unnamed-chunk-5)Piège de l'histogramme. A. histogramme initial montrant la répartition des tailles au sein d'organismes planctoniques. B., C., D. Histogramme A en modifiant le nombres de classes.</p>
</div>

Comme vous pouvez le voir ci-dessus, le changement du nombre de classes peut modifier complètement la perception des données via l'histogramme.


#### Utilisation des snippets

RStudio permet de récupérer rapidement des instructions à partir d'une banque de solutions toutes prêtes. Cela s'appelle des **snippets**. Vous avez une série de snippets disponibles dans la SciViews Box. Celui qui vous permet de réaliser un histogramme s'appelle `.cuhist` (pour **c**hart -> **u**nivariate -> **hist**ogram). Entrez ce label dans une zone d'édition de code R et appuyez ensuite sur la tabulation, et vous verrez le code remplacé par ceci :

```
chart(data = DF, ~VARNUM) +
    geom_histogram(binwidth = 30)
```

L'argument `binwidth =` permet de préciser la largeur des classes.

Vous avez à votre disposition un ensemble de snippets que vous pouvez retrouver dans l'aide-mémoire sur [**SciViews**](https://github.com/BioDataScience-Course/cheatsheets/blob/master/keynote/sciviews_cheatsheet.pdf).

Vous avez également à votre disposition l'aide-mémoire sur la visualisation des données ([**Data Visualization Cheat Sheet**](https://www.rstudio.com/resources/cheatsheets/)).


#### Histogramme par facteur

Lors de l'analyse de jeux de données, vous serez amené à réaliser un histogramme par facteur (c'est-à-dire, en fonction de différents niveau d'une variable représentant des groupes).


```r
# Importation du jeu de données
(iris <- read(file = "iris", package = "datasets", lang = "fr"))
```

```
# # A tibble: 150 x 5
#    sepal_length sepal_width petal_length petal_width species
#           <dbl>       <dbl>        <dbl>       <dbl> <fct>  
#  1          5.1         3.5          1.4         0.2 setosa 
#  2          4.9         3            1.4         0.2 setosa 
#  3          4.7         3.2          1.3         0.2 setosa 
#  4          4.6         3.1          1.5         0.2 setosa 
#  5          5           3.6          1.4         0.2 setosa 
#  6          5.4         3.9          1.7         0.4 setosa 
#  7          4.6         3.4          1.4         0.3 setosa 
#  8          5           3.4          1.5         0.2 setosa 
#  9          4.4         2.9          1.4         0.2 setosa 
# 10          4.9         3.1          1.5         0.1 setosa 
# # ... with 140 more rows
```

```r
# Réalisation de l'histogramme par facteur
chart(iris, ~ sepal_length %fill=% species) +
  geom_histogram() +
  scale_fill_viridis_d() # palette de couleur harmonieuse
```

```
# `stat_bin()` using `bins = 30`. Pick better value with `binwidth`.
```

<div class="figure" style="text-align: center">
<img src="03-Visualisation-II_files/figure-html/unnamed-chunk-6-1.svg" alt="Histogramme de la longueur des sépales de 3 espèces d'iris." width="672" />
<p class="caption">(\#fig:unnamed-chunk-6)Histogramme de la longueur des sépales de 3 espèces d'iris.</p>
</div>

La fonction `chart()` requiert comme argument le jeu de donnée (`iris`, c'est un objet `dataframe` ou `tibble` dans le langage de R), ainsi que la formule à employer dans laquelle vous avez indiqué le nom de la variable que vous voulez sur l'axe des abscisses à droite de la formule. Parmi toutes ces variables, nous avons choisi ici de représenter `sepal_length`. L'intérieur des barres est colorée (`%fill=%`) pour différencier les 3 espèces de ce jeu de données sur base de la variable `species`. Jusqu'ici, nous avons spécifié _ce que_ nous voulons représenter, mais pas encore _comment_ (sous quelle apparence), nous voulons les matérialiser sur le graphique. Pour un histogramme, nous devons ajouter la fonction `geom_histogram()` pour indiquer cela. La fonction `scale_fill_viridis_d()` permet d'obtenir des couleurs harmonieuses.

Le rendu du graphique n'est pas optimal. Voici deux astuces pour l'améliorer. La premières astuces est d'employer préférentiellement les `facets` au lieu de l'argument `%fill=%` an utilisant l'opérateur `|` dans la formule.


```r
chart(iris, ~ sepal_length | species) +
  geom_histogram()
```

```
# `stat_bin()` using `bins = 30`. Pick better value with `binwidth`.
```

<div class="figure" style="text-align: center">
<img src="03-Visualisation-II_files/figure-html/unnamed-chunk-7-1.svg" alt="Histogramme de la longueur des sépales de 3 espèces d'iris en employant les facets pour séparer les espèces." width="672" />
<p class="caption">(\#fig:unnamed-chunk-7)Histogramme de la longueur des sépales de 3 espèces d'iris en employant les facets pour séparer les espèces.</p>
</div>

L'histogramme est maintenant séparé en trois en fonction des niveaux de la variable facteur `species`.

[Simon Jackson](https://drsimonj.svbtle.com/plotting-background-data-for-groups-with-ggplot2) propose une seconde solution combinant les facets et l'argument `fill =`. Il faut ensuite ajouter par derriere un histogramme grisé ne tenant pas compte de la variable facteur.


```r
chart(iris, formula = ~ sepal_width %fill=% species | species) +
  geom_histogram(data = iris[ , -c(5)] , fill = "grey") + # histogramme ne tenant pas compte de la variable species
  geom_histogram(show.legend = FALSE) + # show.legend = FALSE permet de cacher la légende, si cette denrière n'est pas informative.
  scale_fill_viridis_d()
```

```
# `stat_bin()` using `bins = 30`. Pick better value with `binwidth`.
# `stat_bin()` using `bins = 30`. Pick better value with `binwidth`.
```

<div class="figure" style="text-align: center">
<img src="03-Visualisation-II_files/figure-html/unnamed-chunk-8-1.svg" alt="Histogramme de la longeur des sépales de 3 espèces d'iris en employant la solution de Simon Jackson." width="672" />
<p class="caption">(\#fig:unnamed-chunk-8)Histogramme de la longeur des sépales de 3 espèces d'iris en employant la solution de Simon Jackson.</p>
</div>

## Graphique de densité

L'histogramme n'est pas le seul outil à votre disposition. Vous pouvez également employer le graphique de densité qui se présente un peu comme un histogramme lissé. Le passage d'un histogramme vers un graphe de densité se base sur une **estimation par noyaux gaussien**^[TODO]

<div class="figure" style="text-align: center">
<img src="03-Visualisation-II_files/figure-html/unnamed-chunk-9-1.svg" alt="A. Histogramme et B. graphique de densité montrant la distribution de la taille d'un échantillon de zooplancton étudié par analyse d'image." width="672" />
<p class="caption">(\#fig:unnamed-chunk-9)A. Histogramme et B. graphique de densité montrant la distribution de la taille d'un échantillon de zooplancton étudié par analyse d'image.</p>
</div>

Les éléments indispensables à la compréhension d'un graphique de densité sont (ici mis en évidence en couleur) : 

- Les axes avec les graduations (en rouge)
- les labels et unité des axes (en bleu)

Les instructions de base afin de produire un graphique de densité sont :


```r
# Importation du jeu de données
(zooplankton <- read( file = "zooplankton", package = "data.io", lang = "fr"))
```

```
# # A tibble: 1,262 x 20
#      ecd  area perimeter feret major minor  mean  mode   min   max std_dev
#    <dbl> <dbl>     <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl>   <dbl>
#  1 0.770 0.465      4.45 1.32  1.16  0.509 0.363 0.036 0.004 0.908   0.231
#  2 0.700 0.385      2.32 0.728 0.713 0.688 0.361 0.492 0.024 0.676   0.183
#  3 0.815 0.521      4.15 1.33  1.11  0.598 0.308 0.032 0.008 0.696   0.204
#  4 0.785 0.484      4.44 1.78  1.56  0.394 0.332 0.036 0.004 0.728   0.218
#  5 0.361 0.103      1.71 0.739 0.694 0.188 0.153 0.016 0.008 0.452   0.110
#  6 0.832 0.544      5.27 1.66  1.36  0.511 0.371 0.02  0.004 0.844   0.268
#  7 1.23  1.20      15.7  3.92  1.37  1.11  0.217 0.012 0.004 0.784   0.214
#  8 0.620 0.302      3.98 1.19  1.04  0.370 0.316 0.012 0.004 0.756   0.246
#  9 1.19  1.12      15.3  3.85  1.34  1.06  0.176 0.012 0.004 0.728   0.172
# 10 1.04  0.856      7.60 1.89  1.66  0.656 0.404 0.044 0.004 0.88    0.264
# # ... with 1,252 more rows, and 9 more variables: range <dbl>, size <dbl>,
# #   aspect <dbl>, elongation <dbl>, compactness <dbl>, transparency <dbl>,
# #   circularity <dbl>, density <dbl>, class <fct>
```

```r
# Réalisation du graphique
chart(zooplankton, formula = ~ size) +
  geom_density()
```

<div class="figure" style="text-align: center">
<img src="03-Visualisation-II_files/figure-html/unnamed-chunk-10-1.svg" alt="Instructions pour obtenir un graphique de densité." width="672" />
<p class="caption">(\#fig:unnamed-chunk-10)Instructions pour obtenir un graphique de densité.</p>
</div>

La fonction `chart()` requiert comme argument le jeu de donnée ( dataframe, `zooplankton`), ainsi que la formule à employer (`~ size`). Pour réaliser un graphique de densité vous devez ensuite ajouter la fonction `geom_density()`.


## Diagramme en violon

Le graphique en violon est constitué de deux graphiques de densité en miroir. LE résultat fait penser à un violon pour une distribution bimodale. Cette représentation est visuellement très convainquante lorsque la variable étudiée contient suffisamment d'onservations pour permettre de déterminer précisément sa distribution (plusieurs dizaines ou centaines d'observations).

<div class="figure" style="text-align: center">
<img src="03-Visualisation-II_files/figure-html/unnamed-chunk-11-1.svg" alt="Graphe en violon de la distribution de la taille d'un échantillon de zooplancton étudié par analyse d'image." width="672" />
<p class="caption">(\#fig:unnamed-chunk-11)Graphe en violon de la distribution de la taille d'un échantillon de zooplancton étudié par analyse d'image.</p>
</div>

Les instructions pour produire un diagramme en violon sont :


```r
# Importation du jeu de données
zooplankton <- read( file = "zooplankton", package = "data.io", lang = "fr")

# Réduction du jeu de données 
zooplankton_sub <- filter(zooplankton, class %in% c("Annelid", "Calanoid", "Cyclopoid", "Decapod"))
# Réalisation du graphique
chart(zooplankton_sub, formula = size ~ class) +
  geom_violin()
```

<div class="figure" style="text-align: center">
<img src="03-Visualisation-II_files/figure-html/unnamed-chunk-12-1.svg" alt="Instructions pour obtenir un diagramme en violon." width="672" />
<p class="caption">(\#fig:unnamed-chunk-12)Instructions pour obtenir un diagramme en violon.</p>
</div>

La fonction `chart()` requiert comme argument le jeu de donnée (`dataframe`, `zooplankton`), ainsi que la formule à employer  `YVAR (size) ~ XVAR (class)`. Pour réaliser un graphique de densité vous devez ajouter la fonction `geom_density()`.


### Pièges et astuces

Parfois, un diagramme en violon apparait trop encombré, comme ci-dessous.


```r
chart(zooplankton, formula = size~ class) +
  geom_violin() 
```

<div class="figure" style="text-align: center">
<img src="03-Visualisation-II_files/figure-html/unnamed-chunk-13-1.svg" alt="Diagramme en violon montrant la densité de tailles des 17 classes d'organismes planctonique." width="672" />
<p class="caption">(\#fig:unnamed-chunk-13)Diagramme en violon montrant la densité de tailles des 17 classes d'organismes planctonique.</p>
</div>

Les libellés des classes sur l'axe X se chevauchent. La fonction `coord_flip()` peut améliorer le rendu du graphique en le faisant basculer de 90°.


```r
chart(zooplankton, formula = size~ class) +
  geom_violin() +
  coord_flip()
```

<div class="figure" style="text-align: center">
<img src="03-Visualisation-II_files/figure-html/unnamed-chunk-14-1.svg" alt="Diagramme en violon montrant la densité de tailles des 17 classes d'organismes planctonique avec l'ajout de la fonction `coord_flip()`." width="672" />
<p class="caption">(\#fig:unnamed-chunk-14)Diagramme en violon montrant la densité de tailles des 17 classes d'organismes planctonique avec l'ajout de la fonction `coord_flip()`.</p>
</div>

Le package [ggridges](https://cran.r-project.org/web/packages/ggridges/vignettes/introduction.html) propose une seconde solution basée sur le principe de graphique de densité avec la fonction `geom_density_ridges()`. 


```r
# Importation du packages
library(ggridges)

# Réalisation du graphique
chart(zooplankton, class ~ size) +
  geom_density_ridges()
```

<div class="figure" style="text-align: center">
<img src="03-Visualisation-II_files/figure-html/unnamed-chunk-15-1.svg" alt="Diagramme en violon montrant la densité de tailles des 17 classes d'organismes planctonique avec la fonction geom_density_ridges." width="672" />
<p class="caption">(\#fig:unnamed-chunk-15)Diagramme en violon montrant la densité de tailles des 17 classes d'organismes planctonique avec la fonction geom_density_ridges.</p>
</div>


## A vous de jouer !

\BeginKnitrBlock{bdd}<div class="bdd">
Ouvrez RStudio dans votre SciViews Box, puis exécutez l'instruction suivante dans la fenêtre console :

    BioDataScience::run("...")
</div>\EndKnitrBlock{bdd}

Un squelette de projet RStudio vous a été fournit via une tâche Github Classroom, y compris une organisation des fichiers et des jeux de données types. Votre objectif est de comprendre les données proposées en utilisant des visualisations graphiques appropriées et en documentant le fruit de votre étude dans un rapport R Notebook. Utilisez l'histogramme et le graphique de densité que vous venez d'étudier bien sûr, mais vous êtes aussi encouragés à expérimenter d'autres formes de visualisations graphiques.
