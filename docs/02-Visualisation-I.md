# Visualisation I {#visu1}



#### Objectifs : {-}

- Découvrir --et vous émerveiller de--  ce que l'on peut faire avec le [logiciel R](http://www.r-project.org) [@R-base]

- Savoir réaliser différentes variantes d'un graphique en nuage de points dans R avec la fonction `chart()`

- Découvrir le format R Markdown [@R-rmarkdown] et la recherche reproductible

- Intégrer ensuite des graphiques dans un rapport et y décrire ce que que vous observez

- Comparer de manière critique un workflow 'classique' en biologie utilisant Microsoft Excel et Word avec une approche utilisant R et R Markdown; prendre conscience de l'énorme potentiel de R


#### Prérequis : {-}

Si ce n'est déjà fait, vous devez installer et vous familiariser avec la 'SciViews Box', RStudio et Markdown . Vous devez aussi maitriser les bases de git et de Github (avoir un compte Github, savoir clôner un dépôt localement, travailler avec Github Desktop pour faire ses commits, push et pull). L'ensemble de ces outils a été abordé lors de la création de votre site professionnel et personnel du module \@ref(intro).

Avant de poursuivre, vous allez devoir découvrir les premiers rudiments de R afin de pouvoir réaliser par la suite vos premiers graphiques. Pour cela, vous aurez à lire attentivement et effectuer tous les exercices de deux tutoriels^[Reportez-vous à l'Appendice \@ref(learnr) pour apprendre à utiliser ces tutoriels.].

\BeginKnitrBlock{bdd}<div class="bdd">Démarrez la SciViews Box et RStudio. Dans la fenêtre **Console** de RStudio, entrez l'instruction suivante suivie de la touche `Entrée` pour ouvrir le tutoriel concernant les bases de R :

    BioDataScience::run("02a_base")

Ensuite, vous pouvez également parcourir le tutoriel qui vous permettra de découvrir R (cliquez dans la fenêtre **Console** de RStudio et appuyez sur la touche `ESC` pour reprendre la main dans R à la fin d'un tutoriel) :

    BioDataScience::run("02b_decouverte")

([BioDataScience](https://github.com/BioDataScience-Course/BioDataScience) est un package R spécialement développé pour ce cours et que vous avez dû installer lors de la configuration de votre SciViews Box, voir Appendice \@ref(install-tuto)).</div>\EndKnitrBlock{bdd}


## Nuage de points

Dès que vous vous sentez familiarisé avec les principes de base de R, vous allez pouvoir réaliser assez rapidement des beaux graphiques. Par exemple, si vous souhaitez représenter une variable numérique en fonction d'une autre variable numérique, vous pouvez exprimer cela sous la forme d'une **formule**^[Dans R, une **formule** permet de spécifier les variables avec lesquelles on souhaite travailler, et leur rôle. Par exemple ici, la variable _x_ sur l'axe des abscisses et la variable _y_ sur l'axe des ordonnées.]

$$y \sim x$$

que l'on peut lire "y en fonction de x". Pour les deux variables numériques _x_ et _y_, la représentation graphique la plus classique est le **nuage de points** (voir Fig. \@ref(fig:first-scatterplot) pour un exemple).

<div class="figure" style="text-align: center">
<img src="02-Visualisation-I_files/figure-html/first-scatterplot-1.svg" alt="Exemple de graphique en nuage de points. Des éléments essentiels sont ici mis en évidence en couleurs. \label{np_intro}" width="672" />
<p class="caption">(\#fig:first-scatterplot)Exemple de graphique en nuage de points. Des éléments essentiels sont ici mis en évidence en couleurs. \label{np_intro}</p>
</div>

Les éléments indispensables à la compréhension d'un nuage de points sont mis en évidence à la Fig. \@ref(fig:first-scatterplot) : 

- Les axes avec les graduations (en rouge),
- les labels et les unités des axes (en bleu).

Les instructions dans R pour produire un tel nuage de point sont :


```r
# Chargement de SciViews::R
SciViews::R
# Importation du jeu de données
(urchin <- read("urchin_bio", package = "data.io", lang = "fr"))
```

```
# # A tibble: 421 x 19
#    origin diameter1 diameter2 height buoyant_weight weight solid_parts
#    <fct>      <dbl>     <dbl>  <dbl>          <dbl>  <dbl>       <dbl>
#  1 Fishe…       9.9      10.2    5               NA  0.522       0.478
#  2 Fishe…      10.5      10.6    5.7             NA  0.642       0.589
#  3 Fishe…      10.8      10.8    5.2             NA  0.734       0.677
#  4 Fishe…       9.6       9.3    4.6             NA  0.370       0.344
#  5 Fishe…      10.4      10.7    4.8             NA  0.610       0.559
#  6 Fishe…      10.5      11.1    5               NA  0.610       0.551
#  7 Fishe…      11        11      5.2             NA  0.672       0.605
#  8 Fishe…      11.1      11.2    5.7             NA  0.703       0.628
#  9 Fishe…       9.4       9.2    4.6             NA  0.413       0.375
# 10 Fishe…      10.1       9.5    4.7             NA  0.449       0.398
# # ... with 411 more rows, and 12 more variables: integuments <dbl>,
# #   dry_integuments <dbl>, digestive_tract <dbl>,
# #   dry_digestive_tract <dbl>, gonads <dbl>, dry_gonads <dbl>,
# #   skeleton <dbl>, lantern <dbl>, test <dbl>, spines <dbl>,
# #   maturity <int>, sex <fct>
```

```r
# Réalisation du graphique 
chart(urchin, height ~ weight) +
  geom_point()
```

<img src="02-Visualisation-I_files/figure-html/unnamed-chunk-2-1.svg" width="672" style="display: block; margin: auto;" />

La fonction `chart()` requiert comme argument le jeu de donnée (`urchin`, c'est un objet `dataframe` ou `tibble` dans le langage de R), ainsi que la formule à employer dans laquelle vous avez indiqué le nom des variables que vous voulez sur l'axe des ordonnées à gauche et des abscisses à droite de la formule. Vous voyez que le jeu de données contient beaucoup de variables (les titres des colonnes du tableau en sortie). Parmi toutes ces variables, nous avons choisi ici de représenter `height` en fonction de `weight`, la hauteir en fonction de la masse des oursins. Jusqu'ici, nous avons spécifié _ce que_ nous voulons représenter, mais pas encore _comment_ (sous quelle apparence), nous voulons les métérialiser sur le graphique. Pour un nuage de points, nous voulons les représenter sous forme de ... points ! Donc, nous devons ajouter la fonction `geom_point()` pour indiquer cela.


### Le nuage de points en vidéo

Vous trouverez une vidéo ci-dessous vous expliquant la création du nuage de points dans R sur ce jeu de données mais analysant d'autres variables.

<!--html_preserve--><iframe src="https://www.youtube.com/embed/-QzG3Xr202w" width="770" height="433" frameborder="0" allowfullscreen=""></iframe><!--/html_preserve-->

Cette vidéo ne vous a montré que les principaux outils disponibles lors de la réalisation de graphiques. Soyez curieux et expérimentez par vous-même ! 


### A vous de jouer !

\BeginKnitrBlock{bdd}<div class="bdd">Dans la fenêtre **Console** de RStudio, entrez l'instruction suivante suivie de la touche `Entrée` pour ouvrir le tutoriel concernant le nuage de points :

    BioDataScience::run("02c_nuage_de_points")

N'oubliez pas d'appuyer sur la touche `ESC` pour reprendre la main dans R à la fin d'un tutoriel)</div>\EndKnitrBlock{bdd}

### Pièges et Astuces

#### Modifications des échelles d'un graphiques

Vous devez être vigilant lors de la réalisation d'un nuage de point particulièrement sur l'étendue des valeurs présentées sur vos axes. Vous devez utilisez votre expertise de biologistes pour vous posez les deux questions suivantes :

- Est ce que l'axe représente des valeurs plausibles de hauteurs et de masses de ces oursins apparetenant à l'espèce *Paracentrotus lividus* ?

- Quels est la précision des mesures effectuées ?

Dans certains cas, la forme du nuage de points peut être distendu par la présence de valeurs aberrantes. Ce n'est pas le cas ici, mais nous pouvons le simuler en distandant artificiellement soit l'axe X, soit l'axe Y, soit les deux :


```r
A <- chart(urchin, height ~  weight) + 
  geom_point() +
  theme(text = element_text(size = 10)) # Réduction des labels
# Modification des échelles
B <- A + scale_x_continuous(limits = c(0, 500))
C <- A + scale_x_continuous(limits = c(-100, 120))
D <- A + scale_x_continuous(limits = c(-400, 400)) + scale_y_continuous(limits = c(-400, 400))
# Assemblage des graphiques
combine_charts(list(A, B, C, D), font.label = list(size = 14, align = "hv"))
```

<div class="figure" style="text-align: center">
<img src="02-Visualisation-I_files/figure-html/unnamed-chunk-5-1.svg" alt="Piège du nuage de points. A) graphique initialemontrant la variation de la hauteur [mm] en fonction de la masse [g] B) graphique A avec la modification de l'échelle de l'axe X. C) Graphique A avec une seconde modification de l'axe X. D) Graphique A avec modification de l'échelle de l'axe X et de l'axe Y." width="672" />
<p class="caption">(\#fig:unnamed-chunk-5)Piège du nuage de points. A) graphique initialemontrant la variation de la hauteur [mm] en fonction de la masse [g] B) graphique A avec la modification de l'échelle de l'axe X. C) Graphique A avec une seconde modification de l'axe X. D) Graphique A avec modification de l'échelle de l'axe X et de l'axe Y.</p>
</div>


#### Transformations des données

Vous avez la possibilité d'appliquer une transformation de vos données (il est même conseillé de le faire) afin qu'elles soient plus facilement analysables. Par exemple, il est possible d'utiliser des fonctions de puissance, racines, logarithmes, exponentielles^[Pour les proportions (p) ou les pourcentages (%) (valeurs bornées entre 0 et 1 ou 0 et 100%, la transformation arcsin est souvent utilisée : $p′ = \arcsin \sqrt{p}$.] pour modifier l'apparence du nuage de points dans le but de le rendre plus linéaire (car il est plus facile d'analyser statistiquement des données qui s'alignent le long d'une droite). 


```r
# Réalisation du graphique de la hauteur en fonction de la masse
A <- chart(urchin, height ~  weight) + 
  geom_point()
# Application du logarithme sur les deux variables représentées
B <- chart(urchin, log(height) ~  log(weight)) + 
  geom_point()
# Assemblage des graphiques
combine_charts(list(A, B), font.label = list(size = 14, align = "hv"))
```

<div class="figure" style="text-align: center">
<img src="02-Visualisation-I_files/figure-html/unnamed-chunk-6-1.svg" alt="A) Variation de la hauteur [mm] en fonction de la masse [g] d'oursins violets. B) Variation du logarithme népérien de la hauteur [mm] en fonction du logarithme népérien de la masse [g] de ces mêmes oursins" width="672" />
<p class="caption">(\#fig:unnamed-chunk-6)A) Variation de la hauteur [mm] en fonction de la masse [g] d'oursins violets. B) Variation du logarithme népérien de la hauteur [mm] en fonction du logarithme népérien de la masse [g] de ces mêmes oursins</p>
</div>


#### Utilisation des snippets

RStudio permet de récupérer rapidement des instructions à partir d'une banque de solutions toutes prêtes. Cela s'appelle des **snippets**. Vous avez une série de snippets disponibles dans la SciViews Box. Cela qui vous permet de réaliser un graphique en nuage de poinsts s'appelle `.cbxy`. Entrez ce code et appuyez ensuite sur la tabulation dans un script R, et vous verrez le code remplacé par ceci :

```
chart(data = DF, YNUM ~ XNUM) +
  geom_point()
```

Vous avez à votre disposition un ensemble de snippet que vous pouvez retrouvez dans l'aide mémoire sur [**SciViews**](https://github.com/BioDataScience-Course/cheatsheets/blob/master/keynote/sciviews_cheatsheet.pdf).

Vous avez également à votre disposition l'aide-mémoire sur la visualisation des données ([**Data Visualization Cheat Sheet**](https://www.rstudio.com/resources/cheatsheets/)).

### A vous de jouer !

Une nouvelle tâche va vous être demandée ci-dessous en utilisant GitHub Classroom \@ref(classroom). Cette tâche est un travail **individuel**. Une fois votre assignation réalisée, faite un clone de votre dépôt et placer le dans le dossier `project`.

Cette nouvelle tâche qui vous est demandée vous propose d'employer un projet RStudio \@ref(rs_projet)

\BeginKnitrBlock{bdd}<div class="bdd">Les instructions que vous employez dans un learnR peuvent être employée dans un script d'analyse. Sur base du jeux de données `urchin_bio`, explorez différents graphiques en nuages de points. 

Utilisez l'URL suivant qui va vous donner accès à votre tâche.

- <https://classroom.github.com/a/eYrXLy_u>
</div>\EndKnitrBlock{bdd}

Inspirez vous de script présent dans le dépôt sdd1_iris. Vous devez commencer par faire un fork du dépôt puis de faire un clone du dépôt sur votre ordinateur en local. 

- <https://github.com/BioDataScience-Course/sdd1_iris>

Faites une attention toute particulière à l'écriture d'un script. Il contient un titre , une date de la dernière mise à jour, le nom de l'auteur, un ensemble de commentaires permettant l'organisation de ce script.

Des explications détaillées se trouvent dans l'annexe \@ref(script) dédiée aux R scripts.

### Pour en savoir plus...

- [Visualisation des données dans R for Data Science](http://r4ds.had.co.nz/data-visualisation.html). Chapitre du livre portant sur la visualisation des données

- [ggplot2 nuage de point](http://www.sthda.com/french/wiki/ggplot2-nuage-de-points-guide-de-d-marrage-rapide-logiciel-r-et-visualisation-de-donn-es#nuage-de-points-simples). Tutorial en français portant sur l'utilisation d'un nuage de point avec le package `ggplot2` et la fonction `geom_point()`.

- [Fundamentals of Data Visualization](http://serialmentor.com/dataviz/). Un livre sur les fondamentaux de la visualisation graphique.

- [R Graphics Cookbook - Chapter 5: Scatter Plots](https://rpubs.com/escott8908/RGC_Ch5_Scatter_Plots). Un chapitre d'un livre en anglais sur l'utilisation du nuage de point.

- [geom_point()](http://ggplot2.tidyverse.org/reference/geom_point.html). La fiche technique de la fonction.

### A vous de jouer !

\BeginKnitrBlock{bdd}<div class="bdd">Dans la fenêtre **Console** de RStudio, entrez l'instruction suivante suivie de la touche `Entrée` pour ouvrir le tutoriel concernant le nuage de points :

    BioDataScience::run("02d_np_challenge")

N'oubliez pas d'appuyer sur la touche `ESC` pour reprendre la main dans R à la fin d'un tutoriel)</div>\EndKnitrBlock{bdd}

## Intégration des graphiques dans un rapport: R Markdown

Un fichier R Markdown est un fichier terminant par l'extension `.Rmd`. Il provient de la combinaison du language markdown appris durant le premier module et le code appris durant la première partie de ce module 2. 

![](images/annexe_a2/rmd.gif)

Des explications détaillées se trouvent dans l'annexe \@ref(Rmd) dédiée au R Markdown.

L'écriture d'un rapport d'analyse scientifique doit respecter certaines conventions que vous pouvez retrouvez dans l'annexe \@ref(redaction_scientifique).

### Pour en savoir plus...

- [What is R Markdown?](https://rmarkdown.rstudio.com/lesson-1.html). Video en anglais + site présentant les différentes possibilités, par les concepteurs de R Markdown (RStudio).

- [Introduction to R Markdown](https://rmarkdown.rstudio.com/articles_intro.html). Tutorial en anglais, par RStudio, les concepteurs de R Markdown,

- Aide mémoire R Markdown: dans les menus RStudio `Help -> Cheatsheets -> R Markdown Cheat Sheet`

- Référence rapide à Markdown: dans les menus RStudio `Help -> Markdown Quick Reference`

- [Introduction à R Markdown](https://rstudio-pubs-static.s3.amazonaws.com/32239_0956f02cef24443abd9525551368ef12.html#6). Présentation en français par Agrocampus Ouest - Rennes.

- [Le langage R Markdown](https://www.fun-mooc.fr/c4x/UPSUD/42001S02/asset/RMarkdown.pdf). Introduction en français concise, mais relativement complète.


- https://rworkshop.uni.lu/lectures/lecture04_rmarkdown.html#12

### A vous de jouer !

- Utilisation de R Notebook

\BeginKnitrBlock{bdd}<div class="bdd">
Employez le projet sdd1_urchin_bio que vous avez obtenu via le lien GitHub Classroom dans la première partie de ce module. 

Votre objectif est de comprendre les données proposées, en utilisant des visualisations graphiques appropriées et en documentant le fruit de votre étude dans un rapport R Notebook. Utilisez le graphique en nuage de points que vous venez d'étudier bien sûr, mais vous êtes aussi encouragés à expérimenter d'autres visualisations graphiques.</div>\EndKnitrBlock{bdd}

- Workflow "classique" en biologie (Microsoft Excel et Word) comparé à R et R Markdown

\BeginKnitrBlock{bdd}<div class="bdd">Comparez le workflow classique en biologie et R - R Markdown en suivant les explications suivantes :
  
Utilisez l'URL suivant qui va vous donner accès à votre tâche.

- <https://classroom.github.com/g/2Cii2dws>
</div>\EndKnitrBlock{bdd}
