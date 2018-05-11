--- 
title: "Science des données biologiques, UMONS"
author: "Philippe Grosjean & Guyliann Engels"
date: "2018-05-11"
site: bookdown::bookdown_site
output: bookdown::gitbook
documentclass: book
bibliography: [book.bib, packages.bib]
biblio-style: apalike
link-citations: yes
github-repo: biodatascience-course/sdd-umons
url: 'http\://biodatascience-course.sciviews.org/sdd-umons/'
description: "Tutoriel interactif pour la science des données avec R & SciViews::R."
cover-image: "images/front-cover.png"
---

# Préambule {-}

Placeholder


## Vue générale du cours {-}
## Matériel pédagogique {-}
## Comment apprendre? {-}
## Evaluation {-}

<!--chapter:end:index.Rmd-->


# (PART) Cours I: visualisation et inférence {-}

Placeholder

# Introduction {#intro}

Placeholder



<!--chapter:end:01-Introduction.Rmd-->

# Visualisation I {#visu1}

Vos objectifs pour ce module sont:

- Découvrir --et vous émerveiller de--  ce que l'on peut faire avec le [logiciel R](http://www.r-project.org) [@R-base]

- Savoir réaliser différentes variantes d'un graphique en nuage de points dans R avec la fonction `chart()`

- Découvrir le format R Markdown [@R-rmarkdown] et la recherche reproductible

- Intégrer ensuite des graphiques dans un rapport et y décrire ce que que vous observez

- Comparer de manière critique un workflow 'classique' en biologie utilisant Microsoft Excel et Word avec une approche utilisant R et R Markdown; prendre conscience de l'énorme potentiel de R


## Prérequis

Si ce n'est déjà fait (matériel du module \@ref(intro)), vous devez installer et vous familiariser avec la 'SciViews Box', RStudio et Markdown. Vous devez aussi maitriser les bases de git et de Github (avoir un compte Github, savoir clôner un dépôt localement, travailler avec Github Desktop pour faire ses commits, push et pull).

**A faire: proposer une liste de matériel pédagogique supplémentaire pour aider à approfondir les prérequis, si nécessaire**



## Visualisation graphique à l'aide du nuage de points

Découvrez les premiers rudiments de R afin de réaliser par la suite vos premiers graphiques.

Chargez le package `BioDataScience` + accès direct au learnR (à faire, package en cours de développement sur [github](https://github.com/BioDataScience-Course/BioDataScience))

Maintenant que vous avez appris deux trois principes dans R, vous souhaitez représenter une variable numérique en fonction d'une autre variable numérique. On peut exprimer cette relation dans R sous la forme de  $$y \sim x$$ que l'on peut lire : $$y \ en \ fonction \ de \ x$$ ou encore $$Variable \ quantitative \ en \ fonction \ de \ Variable \ quantitative$$ 

<img src="02-Visualisation-I_files/figure-html/unnamed-chunk-1-1.svg" width="672" />

Les éléments indispensables à la compréhension d'un nuage de points sont : 

- Les axes avec les graduations (en rouge)
- les labels et unité des axes (en bleu)


Vous trouverez une vidéo ci-dessous illustrant l'utilisation du nuage de point dans R sur un jeu de données portant sur la croissance des oursins (fiche informative sur le jeu de données (à faire)).

<!--html_preserve--><iframe src="https://www.youtube.com/embed/-QzG3Xr202w" width="600" height="451" frameborder="0" allowfullscreen=""></iframe><!--/html_preserve-->

Cette vidéo ne vous a montrez que les principaux outils disponibles lors de la réalisation de graphique. Feuilletez le livre [R for Data Science](http://r4ds.had.co.nz/data-visualisation.html) qui vous donneras les clés pour obtenir des graphiques de grandes qualités.

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

### La rédaction de rapport scientifique

Un rapport scientifique respecte généralement le schéma suivant :

1. Tables des matières
2. Introduction
3. Matériels et méthodes
4. Résultat
5. Discussion
6. Conclusion
7. Bibliographie
9. Annexe (si nécessaire)

Pour des travaux de plus grandes ampleurs comme les travaux de fin d'études, le schéma ci-dessus est adapté en y ajoutant généralement une partie remerciement en début de manuscrit.

La rédaction de travaux s'appuye toujours sur une recherche bibliographique au préalable. Cependant, il est capital d'insérer convenablement les sources du travail au sein de la bibliographie afin d'éviter le **plagiat** volontaire ou involontaire. Il existe une multitude de programme permettant la gestion d'une bibliographie comme [Mendeley](https://www.mendeley.com/), [Zotero](https://www.zotero.org/) ou encore [Endnote](https://endnote.com/) 

### Pour en savoir plus...

- [What is R Markdown?](https://rmarkdown.rstudio.com/lesson-1.html). Video en anglais + site présentant les différentes possibilités, par les concepteurs de R Markdown (RStudio).

- [Introduction to R Markdown](https://rmarkdown.rstudio.com/articles_intro.html). Tutorial en anglais, par RStudio, les concepteurs de R Markdown,

- Aide mémoire R Markdown: dans les menus RStudio `Help -> Cheatsheets -> R Markdown Cheat Sheet`

- Référence rapide à Markdown: dans les menus RStudio `Help -> Markdown Quick Reference`

- [Introduction à R Markdown](https://rstudio-pubs-static.s3.amazonaws.com/32239_0956f02cef24443abd9525551368ef12.html#6). Présentation en français par Agrocampus Ouest - Rennes.

- [Le langage R Markdown](https://www.fun-mooc.fr/c4x/UPSUD/42001S02/asset/RMarkdown.pdf). Introduction en français concise, mais relativement complète.

- [Recherche documentaire et aide à la création (ReDAC)](https://moodle.umons.ac.be/enrol/index.php?id=5). L'Université de Mons met à disposition de ces étudiants un cours en ligne afin de trouver un maximum de renseignement sur la rédaction de rapport scientifique.

- [Citer ses sources dans un rapport R Notebook](https://rmarkdown.rstudio.com/authoring_bibliographies_and_citations.html#citation_styles) : page en anglais présentant la manière d'introduire une bibliographie dans un rapport R Notebook.

## Récapitulons

- Petite réflexion concernant la comparaison Word-Excel _versus_ R Markdown. Rédigez éventuellement un article sur votre blog à ce sujet.


### Testez vos acquis

- Learnr de vérification des acquis
- Learnr de test des compétences



<!--chapter:end:02-Visualisation-I.Rmd-->

# Visualisation II {#visu2}

_A ce niveau, les étudiants pourront choisir entre le module 3 et le module 4 à faire en premier. Ensuite, les groupes switcheront vers l'autre modules et s'entre-aideront._

Distribution des données, histogramme, graphe de densité, violin plot. Projet RStudio, organisation des dossiers, noms de fichiers. Jeux de données fournis. A la fin, projet perso: explorer un autre type de graphique et l’implémenter dans son rapport.


<!--chapter:end:03-Visualisation-II.Rmd-->

# Visualisation III {#visu3}

Quantiles, médianes, quartiles, percentiles, boite de dispersion, boite de dispersion parallèle. Graphiques composites et intro aux graphes de base et lattice. Restitution graphe perso.

<!--chapter:end:04-Visualisation-III.Rmd-->


# Importation/transformation des données {#import}

Placeholder



<!--chapter:end:05-Importation-Transformation.Rmd-->

# Données qualitatives {#qualit}

Variables de type `factor`/`ordered`, transformation, découpage en classes, tableau de contigence. Choix des variables à mesurer, biométrie humaine.

<!--chapter:end:06-Donnees-qualitatives.Rmd-->

# Probabilités & distributions {#proba}

On part du paradoxe bayésien (effet d’un test de dépistage en fonction de la prévalence d’une maladie) -> probabilités et calculs de probabilités. Généralisation = lois de distributions. Distributions discrètes et continues. Principales lois de distributions et utilisation en pratique. Evaluation par les pairs d’un rapport réalisé jusqu’ici.

<!--chapter:end:07-Probabilites-Distributions.Rmd-->

# Test Chi carré {#chi2}

Restitution globale concernant l’évaluation de rapports par les pairs. Test de Chi2, et application sur base d’une courte manip réalisée par les étudiants (par exemple, sur des coraux).

<!--chapter:end:08-Test-Chi2.Rmd-->

# Moyenne {#moyenne}

Moyenne, intervalle de confiance et t-test. Présentation graphique: dynamite plot + barres d’erreurs. Transformation des données pour linéariser et ou rendre symétrique autour de la moyenne. Comparaison moyenne/médiane => paramétrique versus non paramétrique.

Exemple d'équation avec référence, voir éq. \@ref(eq:moyenne):

\begin{equation} 
  \mu=\sum_{i=1}^n{\frac{x_i}{n}}
  (\#eq:moyenne)
\end{equation} 

L'équation suivante n'est pas libellée:

\begin{equation*} 
  \mu=\frac{\sum_{i=1}^nx_i}{n}
\end{equation*}

<!--chapter:end:09-Moyenne.Rmd-->

# Variance {#variance}

Comparaison de deux populations (suite): Wilcoxon-Mann-Withney + comparaison au t-test. Variance, ANOVAs, test de Bartlett. Graphiques associés. Petite recherche biblio concernant l’application en pratique de ces tests à faire par les étudiants.

<!--chapter:end:10-Variance.Rmd-->

# Corrélation {#correlation}

Suite ANOVA (ANOVA à deux facteurs) + correlation + graphes et tests. Restitution participation à l’élaboration du bookdown commun.

<!--chapter:end:11-Correlation.Rmd-->

# Design expérimental & critique statistique {#design}

Design de l’expérience, choix du nombre de réplicas et puissance d’un test. Critique stat + "bad graphs" + pseudo-réplication. "Challenges" sur base de la critique statistique. Débriefing général.

<!--chapter:end:12-Design-et-Critique.Rmd-->

# (APPENDIX) Appendices {-}

# Installation de la SciViews Box {#svbox}

**A faire...**

<!--chapter:end:A1-Installation-svbox.Rmd-->

# Références {-}


<!--chapter:end:B0-References.Rmd-->

