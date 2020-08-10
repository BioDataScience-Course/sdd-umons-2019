--- 
title: "Science des données biologiques"
author: "Philippe Grosjean & Guyliann Engels avec des contributions de Raphael Conotte"
date: "2020-08-10"
site: bookdown::bookdown_site
output:
  bookdown::gitbook:
    includes:
      after_body: disqus.html
documentclass: book
bibliography: [book.bib, packages.bib]
biblio-style: apalike
link-citations: yes
github-repo: biodatascience-course/sdd-umons
url: 'https\://biodatascience-course.sciviews.org/sdd-umons/'
description: "Tutoriel interactif pour la science des données avec R & SciViews-R."
cover-image: "images/front-cover.png"
---

# Préambule {-}




<div class="info">
<p>Cet ouvrage a été écrit pour le cours de science des données I : inférence et visualisation à Mons et le cours de Bio-informatique et Sciences des Données à Charleroi pour l’année académique 2019-2020 (UMONS). Afin de trouver la dernière version disponible de cet ouvrage suivez le lien suivant : - <a href="http://biodatascience-course.sciviews.org/sdd-umons/" class="uri">http://biodatascience-course.sciviews.org/sdd-umons/</a></p>
</div>
 
Cet ouvrage interactif est le premier volume d'une série de trois ouvrages traitant de la science des données biologiques. L'écriture de cette suite de livres a débuté au cours de l'année académique 2018-2019. 

Pour l'année académique 2019-2020, cet ouvrage interactif est le support des cours suivants :

- [Science des données I : Visualisation et inférence, UMONS](http://applications.umons.ac.be/web/fr/pde/2019-2020/ue/US-B2-SCBIOL-006-M.htm) dont le responsable est Grosjean Philippe

- [Bio-informatique et sciences des données, UMONS-ULB](http://applications.umons.ac.be/web/fr/pde/2019-2020/ue/US-B2-SCBIOC-926-C.htm) dont le responsable est Conotte Raphael

Cet ouvrage est conçu pour être utilisé de manière interactive en ligne. En effet, nous y ajoutons des vidéos, des démonstrations interactives ainsi que des exercices sous forme de questionnaires interactifs. **Ces différents éléments ne sont, bien évidemment, utilisables qu'en ligne.**

![](images/front-cover.png)

----

_Le matériel dans cet ouvrage est distribué sous licence [CC BY-NC-SA 4.0](https://creativecommons.org/licenses/by-nc-sa/4.0/deed.fr)._

----


## Vue générale des cours {-}

Le cours de  **Science des données I: visualisation et inférence**  est dispensé aux biologistes de second Bachelier en Faculté des Sciences de l'Université de Mons à partir de l'année académique 2018-2019.

Le cours de **Bio-informatique et sciences des données, UMONS-ULB** est dispensé au biologistes de second Bachelier en Faculté des Sciences à Charleroi en co-diplomation entre l'Université de Mons (UMONS) et l'Université Libre de Bruxelles (ULB) à partir de l'année académique 2019-2020.

La matière est divisée en 12 modules de sessions de 6h chacuns en présentiel. Il nécessitera environ un tiers de ce temps (voir plus, en fonction de votre rythme et de votre technique d'apprentissage) en travail à domicile. **Une première séance de 2h précèdera ces 12 modules afin d'installer les logiciels (SciViews Box, R, RStudio, Github Desktop), et de se familiariser avec eux.**

<!--html_preserve--><div id="htmlwidget-a9dbfdc017f1e056ba08" style="width:600px;height:600px;" class="grViz html-widget"></div>
<script type="application/json" data-for="htmlwidget-a9dbfdc017f1e056ba08">{"x":{"diagram":"\ndigraph general_flow {\n  graph [rankdir = \"TB\", overlap = true, compount = true, fontsize = 10]\n  \n  node [shape = box,\n        fontname = Helvetica,\n        style = filled,\n        fillcolor = LightSteelBlue,\n        fixedsize = true,\n        width = 2]\n  \"1 Introduction\"; \"12 Design/critique\"\n  \n  subgraph cluster_0 {\n    style = filled;\n    color = lightgrey;\n    node [style = filled, color = red];\n    \"2 Visualisation I\"->\"3 Visualisation II\"\n    \"2 Visualisation I\"->\"4 Visualisation III\"\n    label = \"Visualisation & description des données\";\n    color = lightgray\n  }\n  \n  subgraph cluster_1 {\n    style = filled;\n    color = lightgrey;\n    node [style = filled, color = blue];\n    \"5 Quantitatif\"->\"6 Qualitatif\"\n    label = \"Importation & transformation des données\";\n    color = lightgray\n  }\n  \n  subgraph cluster_2 {\n    style = filled;\n    color = lightgrey;\n    node [style = filled, color = green];\n    \"7 Probabilités\"->\"8 Test Chi2\"\n    \"7 Probabilités\"->\"9 IC/t-test\"\n    \"8 Test Chi2\"->\"9 IC/t-test\"\n    \"9 IC/t-test\"->\"10 ANOVA\"\n    \"10 ANOVA\"->\"11 Correlation\"\n    label = \"Inférence & hypothèses\";\n    color = lightgray\n  }\n\n  \"1 Introduction\"->\"2 Visualisation I\" [lhead = cluster_0]\n  \"2 Visualisation I\"->\"5 Quantitatif\" [lhead = cluster_1]\n  \"3 Visualisation II\"->\"7 Probabilités\" [lhead = cluster_2]\n  \"4 Visualisation III\"->\"7 Probabilités\" [lhead = cluster_2]\n  \"6 Qualitatif\"->\"7 Probabilités\" [lhead = cluster_2]\n  \"11 Correlation\"->\"12 Design/critique\"\n}\n","config":{"engine":"dot","options":null}},"evals":[],"jsHooks":[]}</script><!--/html_preserve-->


## Matériel pédagogique {-}

Le matériel pédagogique rassemblé dans ce syllabus interactif est aussi varié que possible. Vous pourrez ainsi piocher dans l'offre en fonction de vos envies et de votre profil d'apprenant pour optimiser votre travail. Vous trouverez:

- le présent ouvrage en ligne,

- des tutoriaux interactifs (réalisés avec un logiciel appelé `learnr`) que vous pourrez exécuter directement sur votre ordinateur, et qui vous donnerons accès à des pages Web réactives contenant des explications, des exercices et des quizzs en ligne,

- des slides de présentations,

- des dépôts Github Classroom dans la section `BioDataScience-Course` (vous apprendrez ce que c'est très rapidement dès le premier module) pour réaliser et documenter vos travaux personnels.

- des renvois vers des documents externes en ligne, types vidéos youtube ou vimeo, des ouvrages en ligne en anglais ou en français, des blogs, des tutoriaux, des parties gratuites de cours Datacamp ou équivalents, des questions sur des sites comme "Stackoverflow" ou issues des "mailing lists" R, ...

<div class="info">
<p>Tout ce matériel est accessible à partir du <a href="http://biodatascience-course.sciviews.org">site Web du cours</a>, du présent syllabus interactif (et de Moodle pour les étudiants de l’UMONS et de Charleroi). Ces derniers ont aussi accès au dossier <code>SDD</code> sur <code>StudentTemp</code> en Intranet à l’UMONS. Les aspects pratiques seront à réaliser en utilisant la <strong>‘SciViews Box’</strong>, une machine virtuelle préconfigurée que nous installerons ensemble lors du premier cours<a href="#fn1" class="footnote-ref" id="fnref1"><sup>1</sup></a>. Il vous faudra donc avoir accès à un ordinateur (sous Windows, MacOS, ou Linux peu importe, suffisamment puissant et connecté à Internet ou à l’Intranet UMONS). Enfin, vous pourrez poser vos questions par mail à l’adresse <code>sdd@sciviews.org</code>.</p>
<div class="footnotes">
<hr />
<ol>
<li id="fn1"><p>Il est donc très important que vous soyez présent à ce cours, et vous pouvez venir aussi si vous le souhaitez avec votre propre ordinateur portable.<a href="#fnref1" class="footnote-back">↩</a></p></li>
</ol>
</div>
</div>


## Comment apprendre? {-}


```r
fortunes::fortune("brain surgery")
```

```
# 
# I wish to perform brain surgery this afternoon at 4pm and don't know where
# to start. My background is the history of great statistician sports
# legends but I am willing to learn. I know there are courses and numerous
# books on brain surgery but I don't have the time for those. Please direct
# me to the appropriate HowTos, and be on standby for solving any problem I
# may encounter while in the operating room. Some of you might ask for
# specifics of the case, but that would require my following the posting
# guide and spending even more time than I am already taking to write this
# note.
#    -- I. Ben Fooled (aka Frank Harrell)
#       R-help (April 1, 2005)
```

Version courte: **en pratiquant et en faisant des erreurs !**

Version longue: aujourd'hui --et encore plus à l'avenir-- les données sont complexes et ne se manipulent plus simplement avec un tableur comme Microsoft Excel. Vous apprendrez donc à maitriser des outils professionnels très puissants mais aussi relativement complexes. La méthode d'apprentissage que nous vous proposons a pour objectif prioritaire de vous faciliter la tâche, quelles que soient vos aptitudes au départ. Envisagez votre voyage en science des données comme l'apprentissage d'une nouvelle langue. **C'est en pratiquant, et en pratiquant encore sur le long terme que vous allez progresser.** Pour vous aider dans cet apprentissage progressif et sur la durée, la formation s'étale sur quatre années, et est répartie en cinq cours de difficulté croissante. N'hésitez pas à expérimenter, tester ou essayer des nouvelles idées (même au delà de ce qui sera demandé dans les exercices) et surtout, **n'ayez pas peur de faire des erreurs**. Vous en ferez, ... beaucoup ... _nous vous le souhaitons!_ La meilleure manière d'apprendre, c'est en faisant des erreurs et en mettant ensuite tout en oeuvre pour les comprendre et les corriger. Donc, si un message d'erreur, ou un "warning" apparait, ne soyez pas intimidé. Prenez une bonne respiration, lisez-le attentivement, essayez de le comprendre, et au besoin faites-vous aider: la solution est sur le Net, 'Google^[Il existe tout de même des outils plus pointus pour obtenir de l'aide sur le logiciel R comme [rseek.org](https://rseek.org), [rdocumentation.org](https://www.rdocumentation.org) ou [rdrr.io](https://rdrr.io). Rien ne sert de chercher 'R' dans Goggle.] est votre ami'!


##### System information {-}


```r
sessioninfo::session_info()
```

```
# ─ Session info ──────────────────────────────────────────────────────────
#  setting  value                       
#  version  R version 3.5.3 (2019-03-11)
#  os       Ubuntu 18.04.2 LTS          
#  system   x86_64, linux-gnu           
#  ui       X11                         
#  language (EN)                        
#  collate  en_US.UTF-8                 
#  ctype    en_US.UTF-8                 
#  tz       Europe/Brussels             
#  date     2020-08-10                  
# 
# ─ Packages ──────────────────────────────────────────────────────────────
#  package      * version   date       lib source        
#  assertthat     0.2.1     2019-03-21 [2] CRAN (R 3.5.3)
#  bookdown       0.9       2018-12-21 [2] CRAN (R 3.5.3)
#  brew           1.0-6     2011-04-13 [2] CRAN (R 3.5.3)
#  cli            1.1.0     2019-03-19 [2] CRAN (R 3.5.3)
#  codetools      0.2-16    2018-12-24 [2] CRAN (R 3.5.3)
#  colorspace     1.4-1     2019-03-18 [2] CRAN (R 3.5.3)
#  crayon         1.3.4     2017-09-16 [2] CRAN (R 3.5.3)
#  DiagrammeR     1.0.0     2018-03-01 [2] CRAN (R 3.5.3)
#  digest         0.6.18    2018-10-10 [2] CRAN (R 3.5.3)
#  downloader     0.4       2015-07-09 [2] CRAN (R 3.5.3)
#  dplyr          0.8.0.1   2019-02-15 [2] CRAN (R 3.5.3)
#  evaluate       0.13      2019-02-12 [2] CRAN (R 3.5.3)
#  farver         1.1.0     2018-11-20 [2] CRAN (R 3.5.3)
#  fortunes       1.5-4     2016-12-29 [2] CRAN (R 3.5.3)
#  gganimate      1.0.3     2019-04-02 [2] CRAN (R 3.5.3)
#  ggplot2        3.1.1     2019-04-07 [2] CRAN (R 3.5.3)
#  glue           1.3.1     2019-03-12 [2] CRAN (R 3.5.3)
#  gridExtra      2.3       2017-09-09 [2] CRAN (R 3.5.3)
#  gtable         0.3.0     2019-03-25 [2] CRAN (R 3.5.3)
#  hms            0.4.2     2018-03-10 [2] CRAN (R 3.5.3)
#  htmltools      0.3.6     2017-04-28 [2] CRAN (R 3.5.3)
#  htmlwidgets    1.3       2018-09-30 [2] CRAN (R 3.5.3)
#  igraph         1.2.4     2019-02-13 [2] CRAN (R 3.5.3)
#  influenceR     0.1.0     2015-09-03 [2] CRAN (R 3.5.3)
#  inline         0.3.15    2018-05-18 [2] CRAN (R 3.5.3)
#  jsonlite       1.6       2018-12-07 [2] CRAN (R 3.5.3)
#  knitr          1.22      2019-03-08 [2] CRAN (R 3.5.3)
#  lazyeval       0.2.2     2019-03-15 [2] CRAN (R 3.5.3)
#  magick         2.0       2018-10-05 [2] CRAN (R 3.5.3)
#  magrittr       1.5       2014-11-22 [2] CRAN (R 3.5.3)
#  munsell        0.5.0     2018-06-12 [2] CRAN (R 3.5.3)
#  pillar         1.3.1     2018-12-15 [2] CRAN (R 3.5.3)
#  pkgconfig      2.0.2     2018-08-16 [2] CRAN (R 3.5.3)
#  plyr           1.8.4     2016-06-08 [2] CRAN (R 3.5.3)
#  prettyunits    1.0.2     2015-07-13 [2] CRAN (R 3.5.3)
#  progress       1.2.0     2018-06-14 [2] CRAN (R 3.5.3)
#  purrr          0.3.2     2019-03-15 [2] CRAN (R 3.5.3)
#  R6             2.4.0     2019-02-14 [2] CRAN (R 3.5.3)
#  RColorBrewer   1.1-2     2014-12-07 [2] CRAN (R 3.5.3)
#  Rcpp           1.0.1     2019-03-17 [2] CRAN (R 3.5.3)
#  readr          1.3.1     2018-12-21 [2] CRAN (R 3.5.3)
#  rgexf          0.15.3    2015-03-24 [2] CRAN (R 3.5.3)
#  rlang          0.3.4     2019-04-07 [2] CRAN (R 3.5.3)
#  rmarkdown      1.12      2019-03-14 [2] CRAN (R 3.5.3)
#  Rook           1.1-1     2014-10-20 [2] CRAN (R 3.5.3)
#  rstudioapi     0.10      2019-03-19 [2] CRAN (R 3.5.3)
#  scales         1.0.0     2018-08-09 [2] CRAN (R 3.5.3)
#  sessioninfo    1.1.1     2018-11-05 [2] CRAN (R 3.5.3)
#  stringi        1.4.3     2019-03-12 [2] CRAN (R 3.5.3)
#  stringr        1.4.0     2019-02-10 [2] CRAN (R 3.5.3)
#  tibble         2.1.1     2019-03-16 [2] CRAN (R 3.5.3)
#  tidyr          0.8.3     2019-03-01 [2] CRAN (R 3.5.3)
#  tidyselect     0.2.5     2018-10-11 [2] CRAN (R 3.5.3)
#  tweenr         1.0.1     2018-12-14 [2] CRAN (R 3.5.3)
#  viridis        0.5.1     2018-03-29 [2] CRAN (R 3.5.3)
#  viridisLite    0.3.0     2018-02-01 [2] CRAN (R 3.5.3)
#  visNetwork     2.0.6     2019-03-26 [2] CRAN (R 3.5.3)
#  withr          2.1.2     2018-03-15 [2] CRAN (R 3.5.3)
#  xfun           0.6       2019-04-02 [2] CRAN (R 3.5.3)
#  XML            3.98-1.19 2019-03-06 [2] CRAN (R 3.5.3)
#  yaml           2.2.0     2018-07-25 [2] CRAN (R 3.5.3)
# 
# [1] /home/sv/R/x86_64-pc-linux-gnu-library/3.5
# [2] /usr/local/lib/R/site-library
# [3] /usr/lib/R/site-library
# [4] /usr/lib/R/library
```
