# Visualisation I {#visu1}



Vos objectifs pour ce module sont:

- Découvrir --et vous émerveiller de--  ce que l'on peut faire avec le [logiciel R](http://www.r-project.org) [@R-base]

- Savoir réaliser différentes variantes d'un graphique en nuage de points dans R avec la fonction `chart()`

- Découvrir le format R Markdown [@R-rmarkdown] et la recherche reproductible

- Intégrer ensuite des graphiques dans un rapport et y décrire ce que que vous observez

- Comparer de manière critique un workflow 'classique' en biologie utilisant Microsoft Excel et Word avec une approche utilisant R et R Markdown; prendre conscience de l'énorme potentiel de R

Si ce n'est déjà fait, vous devez installer et vous familiariser avec la 'SciViews Box', RStudio et Markdown . Vous devez aussi maitriser les bases de git et de Github (avoir un compte Github, savoir clôner un dépôt localement, travailler avec Github Desktop pour faire ses commits, push et pull). L'ensemble de ces outils a été abordé lors de la création de votre site profesionnel et personnel du module \@ref(intro).

## Visualisation graphique à l'aide du nuage de points

Découvrez les premiers rudiments de R afin de réaliser par la suite vos premiers graphiques.

![](images/hex_BioDataScience.png){width="15%"}
Lancez votre machine virtuelle, ouvrez Rstudio puis lancez l'instruction suivante
`BioDataScience::run("02a_r_decouverte")` (package en cours de développement sur [github](https://github.com/BioDataScience-Course/BioDataScience)).

Maintenant que vous avez appris deux/trois principes dans R, vous souhaitez représenter une variable numérique en fonction d'une autre variable numérique. On peut exprimer cette relation dans R sous la forme de  $$y \sim x$$ que l'on peut lire : $$y \ en \ fonction \ de \ x$$ ou encore $$Variable \ quantitative \ en \ fonction \ de \ Variable \ quantitative$$ 

<div class="figure">
<img src="02-Visualisation-I_files/figure-html/unnamed-chunk-1-1.svg" alt="Points essentiels d'un nuage de points. \label{np_intro}" width="672" />
<p class="caption">(\#fig:unnamed-chunk-1)Points essentiels d'un nuage de points. \label{np_intro}</p>
</div>

Les éléments indispensables à la compréhension d'un nuage de points sont mis en évidence dans la figure ci dessus (ici mis en évidence en couleur) : 

- Les axes avec les graduations (en rouge)
- les labels et les unités des axes (en bleu)

Les instructions de base afin de produire une nuage de point sont :


```r
# Importation du jeu de données
ub <- read("urchin_bio", package = "data.io")
# Réalisation du graphique 
chart(ub, formula = height ~ weight) +
  geom_point()
```

<div class="figure">
<img src="02-Visualisation-I_files/figure-html/unnamed-chunk-2-1.svg" alt="Instructions pour obtenir un nuage de point." width="672" />
<p class="caption">(\#fig:unnamed-chunk-2)Instructions pour obtenir un nuage de point.</p>
</div>


La fonction `chart()` requiert comme argument le jeu de donnée ( dataframe, ub), ainsi que la formule à employer YNUM (height) ~ XNUM (weight). Pour réaliser une nuage de point vous devez ajouter la seconde fonction `geom_point()`.


### Pièges et Astuces

#### Modifications des échelles d'un graphiques

Vous devez être vigilant lors de la réalisation d'un nuage de point particulièrement sur les ranges de valeurs présentés sur vos axes. 

Vous devez utilisez votre expertise de biologistes pour vous posez les deux questions suivantes :

- Est ce que l'axe représente des valeurs plausibles de hauteurs et de masses de *P. lividus* ?

- Quels est la précision de mesures effectués ?


```r
# Réalisation du graphique ci-dessus
a <- chart(ub,formula = height ~  weight) + 
  geom_point() +
  theme(text = element_text(size = 10)) # reduction des labels
# Modification des échelles
b <- a + scale_x_continuous(limits = c(0,500))

c <- a + scale_x_continuous(limits = c(-100, 120))

d <- a + scale_x_continuous(limits = c(-400, 400)) +
  scale_y_continuous(limits = c(-400, 400))
# Assemblage des graphiques
ggpubr::ggarrange(a,b,c,d,labels = "AUTO", font.label = list(size = 14, align = "hv"))
```

<div class="figure">
<img src="02-Visualisation-I_files/figure-html/unnamed-chunk-3-1.svg" alt="Piège du nuage de points. A) graphique initiale montrant la variation de la hauteur [mm] en fonction de la masse [g] B) graphique A avec la modification de l'échelle de l'axe x. C) Graphique A avec une seconde modification de l'axe x. D) Graphique A avec modification de l'echelle de l'axe x et de l'axe Y." width="672" />
<p class="caption">(\#fig:unnamed-chunk-3)Piège du nuage de points. A) graphique initiale montrant la variation de la hauteur [mm] en fonction de la masse [g] B) graphique A avec la modification de l'échelle de l'axe x. C) Graphique A avec une seconde modification de l'axe x. D) Graphique A avec modification de l'echelle de l'axe x et de l'axe Y.</p>
</div>


#### Application de transformations mathématiques sur les données

Vous avez la possiblité d'appliquer une transformation des données (il est même conseillé de le faire) afin qu'elle soit plus facilement analysable comme en alignant les point d'un nuage de point le long d'une droite (On parle de **linéarisation**^[TODO def] des données en statistiques). 

Vous pouvez utilisez la puissance, racine, logarithme, exponentielle, inverse, ..

Pour les proportions (p) ou les pourcentages (%) (valeurs bornées entre 0 et 1 ou 0 et 100%, la transformation arcsin est souvent utilisée :

$p′ = \arcsin \sqrt{p}$


```r
# Réalisation du graphique de la hauteur en fonction du poids
a <- chart(ub,formula = height ~  weight) + 
  geom_point()
# Application du logarithme sur les deux variables étudiées
b <- chart(ub,formula = log(height) ~  log(weight)) + 
  geom_point()
# Assemblage des graphiques
ggpubr::ggarrange(a,b,labels = "AUTO", font.label = list(size = 14, align = "hv"))
```

<div class="figure">
<img src="02-Visualisation-I_files/figure-html/unnamed-chunk-4-1.svg" alt="A) Variation de la hauteur [mm] en fonction de la masse [g] d'oursins violets. B) Variation du logarithme népérien de la hauteur [mm] en fonction du logarithme népérien de la masse [g] d'oursins violets " width="672" />
<p class="caption">(\#fig:unnamed-chunk-4)A) Variation de la hauteur [mm] en fonction de la masse [g] d'oursins violets. B) Variation du logarithme népérien de la hauteur [mm] en fonction du logarithme népérien de la masse [g] d'oursins violets </p>
</div>

#### Utilisation des snippets

Rstudio permet d'ajouter des snippets^[Suite d'instruction préenregistré dasn Rstudio servant d'aide lors de l'analyse de données.] afin de faciliter l'apprentissage des suites d'instruction pour analyser des données sur R. Sciviews fournit une succession de snippets que vous pouvez retrouver dans l'aide mémoire^[TODO]

```
... # ouverture des sciviews snippets
```

### Vidéo, A faire

Vous trouverez une vidéo ci-dessous illustrant l'utilisation du nuage de point dans R sur un jeu de données portant sur la croissance des oursins.

<!--html_preserve--><iframe src="https://www.youtube.com/embed/-QzG3Xr202w" width="600" height="451" frameborder="0" allowfullscreen=""></iframe><!--/html_preserve-->

Cette vidéo ne vous a montré que les principaux outils disponibles lors de la réalisation de graphique. Soyez curieux et regardez la section **A vous de jouer** ci-dessous. 

Vous avez à votre disposition l'aide-mémoire sur la visualisation des données ([**Data Visualization Cheat Sheet**](https://www.rstudio.com/resources/cheatsheets/))

### A vous de jouer !

![](images/hex_BioDataScience.png){width="15%"}
Lancez votre machine virtuelle, ouvrez Rstudio puis lancez l'instruction suivante
`BioDataScience::run("02b_nuage_points")` (package en cours de développement sur [github](https://github.com/BioDataScience-Course/BioDataScience)).

Les instructions que vous employez dans un learnR peuvent être employée dans un script d'analyse. Sur base des jeux de données `urchin_bio`, explorez différents graphiques en nuage de point. Assignment ClassRoom avec /R et un script.

Inspirez vous de script présent dans le projet que vous venez de clonez. Faites une attention toute particulière à l'écriture d'un script. Il contient un titre , une date de la dernière mise à jour, le nom de l'auteur , un ensemble de commentaires permettant l'organisation de ce script.

Réalisez votre propre script et réalisez les graphiques suivants :

- Représentez la variation de la hauteur en fonction de la masse des oursins

- Représentez la variation du parties solides en fonction du poids immergés des oursins

- Explorez par vous même le jeu de données `urchin_bio` qui contient pas moins de 19 variables que vous pouvez tentez d'associer graphiquement. Réalisez au moins 5 graphiques différents.


### Pour en savoir plus...

- [Visualisation des données dans R for Data Science](http://r4ds.had.co.nz/data-visualisation.html). Chapitre du livre portant sur la visualisation des données

- [ggplot2 nuage de point](http://www.sthda.com/french/wiki/ggplot2-nuage-de-points-guide-de-d-marrage-rapide-logiciel-r-et-visualisation-de-donn-es#nuage-de-points-simples). Tutorial en français portant sur l'utilisation d'un nuage de point avec le package `ggplot2` et la fonction `geom_point()`.

- [Fundamentals of Data Visualization](http://serialmentor.com/dataviz/). Un livre sur les fondamentaux de la visualisation graphique.

- [R Graphics Cookbook - Chapter 5: Scatter Plots](https://rpubs.com/escott8908/RGC_Ch5_Scatter_Plots). Un chapitre d'un livre en anglais sur l'utilisation du nuage de point.

- [geom_point()](http://ggplot2.tidyverse.org/reference/geom_point.html). La fiche technique de la fonction proposée par tidyverse.


## Intégration des graphiques dans un rapport: R Markdown

Un fichier R Markdown est un fichier terminant par l'extension `.rmd`. Il provient de la combinaison du language markdown appris durant le premier module et le code appris durant la première partie de ce module 2.

> TODO ADD PICTURE 

### Pièges et astuces

#### La rédaction de rapport scientifique

La rédaction respecte une multitude de règles dont en voici quelques unes. Un rapport scientifique respecte généralement le schéma suivant :

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

- [Recherche documentaire et aide à la création (ReDAC)](https://moodle.umons.ac.be/enrol/index.php?id=5). L'Université de Mons met à disposition de ses étudiants un cours en ligne afin de trouver un maximum de renseignements sur la rédaction de rapport scientifique.

- [Citer ses sources dans un rapport R Notebook](https://rmarkdown.rstudio.com/authoring_bibliographies_and_citations.html#citation_styles) : page en anglais présentant la manière d'introduire une bibliographie dans un rapport R Notebook.

- https://rworkshop.uni.lu/lectures/lecture04_rmarkdown.html#12

### A vous de jouer !

Un squelette de projet RStudio vous est fournit dans un dépôt Github Classroom, y compris organisation des fichiers et jeux de données types. Votre objectif est de comprendre les données proposées, en utilisant des visualisations graphiques appropriées et en documentant le fruit de votre étude dans un rapport R Notebook. Utilisez le graphique en nuage de points que vous venez d'étudier bien sûr, mais vous êtes aussi encouragés à expérimenter d'autres visualisations graphiques.

## Testez vos acquis

Lancez votre machine virtuelle, ouvrez Rstudio puis lancez l'instruction suivante
`BioDataScience::run("...")` (package en cours de développement sur [github](https://github.com/BioDataScience-Course/BioDataScience)).



