# Visualisation I {#visu1}

Vos objectifs pour ce module sont:

- Découvrir --et vous émerveiller de--  ce que l'on peut faire avec le [logiciel R](http://www.r-project.org) [@R-base]
- Découvrir le format R Markdown [@R-rmarkdown] et la recherche reproductible
- Savoir réaliser différentes variantes d'un graphique en nuage de points dans R avec la fonction `chart()`
- Intégrer ensuite des graphiques dans un rapport et y décrire ce que que vous observez
- Comparer de manière critique un workflow 'classique' en biologie utilisant Microsoft Excel et Word avec une approche utilisant R et R Markdown; prendre conscience de l'énorme potentiel de R


## Prérequis

Si ce n'est déjà fait (matériel du module \@ref(intro)), vous devez installer et vous familiariser avec la 'SciViews Box', RStudio et Markdown. Vous devez aussi maitriser les bases de git et de Github (avoir un compte Github, savoir clôner un dépôt localement, travailler avec Github Desktop pour faire ses commits, push et pull).

**A faire: proposer une liste de matériel pédagogique supplémentaire pour aider à approfondir les prérequis, si nécessaire**


## Visualisation graphique à l'aide du nuage de points

Lorsque vous souhaitez représenter une variable numérique en fonction d'une autre variable numérique. On peut exprimer cette relation dans R sous la forme de  $$y \sim x$$ que l'on peut lire : $$y \ en \ fonction \ de \ x$$ ou encore $$Variable \ quantitative \ en \ fonction \ de \ Variable \ quantitative$$ 

<img src="02-Visualisation-I_files/figure-html/unnamed-chunk-1-1.svg" width="672" />

Les éléments indispensable à la compréhension d'un nuage de points sont : 

- Les axes avec les graduations (en rouge)
- les labels et unité des axes (en bleu)


Vous trouverez une vidéo ci-dessous illustrant l'utilisation du nuage de point dans R sur un jeu de données portant sur la croissance des oursins (fiche informative sur le jeu de données (à faire)).

<!--html_preserve--><iframe src="https://www.youtube.com/embed/-QzG3Xr202w" width="600" height="451" frameborder="0" allowfullscreen=""></iframe><!--/html_preserve-->

Cette vidéo ne vous a montrez que les principaux outils disponible lors de la réalisation de graphique. Feuilletez le livre [R for Data Science](http://r4ds.had.co.nz/data-visualisation.html) qui vous donneras les clés pour obtenir des graphiques de grandes qualités.

### A vous de jouer !

Sur base des jeux de données `urchin_bio`, explorez différents graphiques en nuage de point. Assignment ClassRoom avec /R et un script (+ /reports pour la suite) + projet.

Chargez le package `BioDataScience` + accès direct au learnR (à faire, package en cours de développement sur [github](https://github.com/BioDataScience-Course/BioDataScience))


### Pour en savoir plus...

- [ggplot2 nuage de point](http://www.sthda.com/french/wiki/ggplot2-nuage-de-points-guide-de-d-marrage-rapide-logiciel-r-et-visualisation-de-donn-es#nuage-de-points-simples). Tutarial en français portant sur l'utilisation d'un nuage de point avec le package `ggplot2` et la fonction `geom_point()`.

- [Fundamentals of Data Visualization](http://serialmentor.com/dataviz/). Un livre sur les fondamentaux de la visualisation graphique.

- [R Graphics Cookbook - Chapter 5: Scatter Plots](https://rpubs.com/escott8908/RGC_Ch5_Scatter_Plots). Un chapitre d'un livre en anglais sur l'utilisation du nuage de point.

- [geom_point()](http://ggplot2.tidyverse.org/reference/geom_point.html). La fiche technique de la fonction proposée par tidyverse.


## Intégration des graphiques dans un rapport: R Markdown

- Qu'est-ce que R Markdown?
- ...

### A vous de jouer !

Un squelette de projet RStudio vous a été fournit dans un dépôt Github Classroom, y compris organisation des fichiers et jeux de données types. Votre objectif est de comprendre les données proposées, en utilisant des visualisations graphiques appropriées et en documentant le fruit de votre étude dans un rapport R Notebook. Utilisez le graphique en nuage de points que vous venez d'étudier bien sûr, mais vous êtes aussi encouragés à expérimenter d'autres visualisations graphiques.

_Vous allez comparer différentes approches pour réaliser un rapport d'analyse lors de la prochaine séance d'exercices._

### Pour en savoir plus...

- [What is R Markdown?](https://rmarkdown.rstudio.com/lesson-1.html). Video en anglais + site présentant les différentes possibilités, par les concepteurs de R Markdown (RStudio).

- [Introduction to R Markdown](https://rmarkdown.rstudio.com/articles_intro.html). Tutorial en anglais, par RStudio, les concepteurs de R Markdown,

- Aide mémoire R Markdown: dans les menus RStudio `Help -> Cheatsheets -> R Markdown Cheat Sheet`

- Référence rapide à Markdown: dans les menus RStudio `Help -> Markdown Quick Reference`

- [Introduction à R Markdown](https://rstudio-pubs-static.s3.amazonaws.com/32239_0956f02cef24443abd9525551368ef12.html#6). Présentation en français par Agrocampus Ouest - Rennes.

- [Le langage R Markdown](https://www.fun-mooc.fr/c4x/UPSUD/42001S02/asset/RMarkdown.pdf). Introduction en français concise, mais relativement complète.


## Récapitulons

- Petite réflexion concernant la comparaison Word-Excel _versus_ R Markdown. Rédigez éventuellement un article sur votre blog à ce sujet.


### Testez vos acquis

- Learnr de vérification des acquis
- Learnr de test des compétences


