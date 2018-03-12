--- 
title: "Science des données biologiques, UMONS - Le book!"
author: "Philippe Grosjean & Guyliann Engels"
date: "2018-03-12"
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

Cet ouvrage couvrira, à terme, la matière des cinq cours de science des données enseignés aux biologistes de la Faculté des Sciences de l'Université de Mons (Belgique). La matière sera complétée progressivement à partir du premier cours prévu pour l'année académique 2018-2019.

Cet ouvrage sera également disponible en format PDF (en vue de son impression), mais il est surtout conçu pour être utilisé de manière interactive, en ligne. En effet, nous prévoyons d'y adjoindre des capsules (unités d'enseignement) sous forme de vidéos, des démonstrations interactives, et des exercices sous forme de questionnaires interactifs également. **Ces différents éléments ne sont, bien évidemment, utilisables qu'en ligne.**

![](images/front-cover.png)

Le premier cours intitulé **Science des données I: visualisation et inférence** qui sera dispensé aux biologistes de second Bachelier en Faculté des Sciences de l'Université de Mons à partir de l'année académique 2018-2019 contient 25h de cours et 50h d'exercices.

Cette matière est divisée en 12 modules de 2h de cours et 4h d'exercices chacuns. Cependant, la formation étant prévue en grande partie en classe inversée, les 6h de chaque module seront mises à profit pour des activités interactives dans le cadre de la matière dévolue à chaque module.

<!--html_preserve--><div id="htmlwidget-bc20e250d25c180b2416" style="width:600px;height:600px;" class="grViz html-widget"></div>
<script type="application/json" data-for="htmlwidget-bc20e250d25c180b2416">{"x":{"diagram":"\ndigraph general_flow {\n  graph [rankdir = \"TB\", overlap = true, compount = true, fontsize = 10]\n  \n  node [shape = box,\n        fontname = Helvetica,\n        style = filled,\n        fillcolor = LightSteelBlue,\n        fixedsize = true,\n        width = 2]\n  \"1 Introduction\"; \"12 Design/critique\"\n  \n  subgraph cluster_0 {\n    style = filled;\n    color = lightgrey;\n    node [style = filled, color = red];\n    \"2 Visualisation I\"->\"3 Visualisation II\"\n    \"2 Visualisation I\"->\"4 Visualisation III\"\n    label = \"Visualisation & description des données\";\n    color = lightgray\n  }\n  \n  subgraph cluster_1 {\n    style = filled;\n    color = lightgrey;\n    node [style = filled, color = blue];\n    \"5 Quantitatif\"->\"6 Qualitatif\"\n    label = \"Importation & transformation des données\";\n    color = lightgray\n  }\n  \n  subgraph cluster_2 {\n    style = filled;\n    color = lightgrey;\n    node [style = filled, color = green];\n    \"7 Probabilités\"->\"8 Test Chi2\"\n    \"7 Probabilités\"->\"9 IC/t-test\"\n    \"8 Test Chi2\"->\"9 IC/t-test\"\n    \"9 IC/t-test\"->\"10 ANOVA\"\n    \"10 ANOVA\"->\"11 Correlation\"\n    label = \"Inférence & hypothèses\";\n    color = lightgray\n  }\n\n  \"1 Introduction\"->\"2 Visualisation I\" [lhead = cluster_0]\n  \"2 Visualisation I\"->\"5 Quantitatif\" [lhead = cluster_1]\n  \"3 Visualisation II\"->\"7 Probabilités\" [lhead = cluster_2]\n  \"4 Visualisation III\"->\"7 Probabilités\" [lhead = cluster_2]\n  \"6 Qualitatif\"->\"7 Probabilités\" [lhead = cluster_2]\n  \"11 Correlation\"->\"12 Design/critique\"\n}\n","config":{"engine":"dot","options":null}},"evals":[],"jsHooks":[]}</script><!--/html_preserve-->


## Matériel pédagogique {-}

Du matériel varié sera proposé. Les étudiants pourront piocher dans l'offre en fonction de leur profil d'apprenant:

- Des capsules, essentiellement sous forme de vidéos < 10 min,

- Un ouvrage en ligne type 'bookdown' (ici même!),

- Des tutoriaux, éventuellement interactifs,

- Des documents `learnr` avec explications et exercices + quizzs en ligne,

- Des slides (essentiellement liées aux partie de type cours plus classiques),

- Des dépôts Github Classroom `BioDataScience-Course` pour les devoirs ("assignments"), partiellement pré-remplis.

- Des renvois vers des documents externes en ligne, types vidéos youtube ou vimeo, des ouvrages en ligne type 'R for Data Science', des blogs, des tutoriaux, des vignettes liées aux packages R, des parties gratuites de cours Datacamp, ou équivalent, des questions Stackoverflow ou mailing list R, ...


**Tout ce matériel sera disponible à partir d'un site web, de Moodle et/ou du dossier `SDD` sur `StudentTemp` en Intranet. Les aspects pratiques seront à réaliser en utilisant la SciViews Box. Les questions pourront être adressées par mail via `sdd@sciviews.org`**


## Evaluation {-}

Sur 20:

- 2 points pour la progression sur base des exercices `learnr` en classe inversée.

- 2 points pour la restitution des capsules/participation.

- 5 points pour un quizz `learnr` final: 5 questions au hasard pour chaque étudiant sur base de 20 questions au total.

- 11 points pour l’évaluation d’un des rapports (choisi en fin de sesssion)

- Eventuellement un point bonus pour une participation particulièrement bonne, ou tout autre élément à valoriser (site web perso/blob exceptionnel, participation importante au bookdown collaboratif, aide des autres étudiants, etc.)

----

Matériel distribué sous licence [CC BY-NC-SA 4.0](https://creativecommons.org/licenses/by-nc-sa/4.0/deed.fr).




----

La suite est un mémo pour les nouvelles fonctionnalités apportées par bookdown... le temps qu'on s'y habitue!


**Book-wide references**

With R Markdown, it is only possible to reference items inside the same document, and there is no numbered figures, tables or equations (at least if LaTeX code is not used, but then, you can olny generate a PDF). Bookdown fills the gap with new formatting instructions that work across all documents of the book. It also provides updated versions of R MArkdown output formats that support numbered figures, tables and equations, e.g., `html_document2` to replace `html_document`, for instance.


**Reference to chapter and titles**

You can reference **chapters** and **titles** using \@ref(intro). The book is organized in chapters and all numbers are by chapters. However, there are special level 1 title you can use:

- **Parts**: use `# (PART) Part I {-}` just before the first title of that part. 

- **Appendix**: use `# (APPENDIX) Appendix {-}` just before appendices titles. They will be numbered separately.


**Numbered figures and tables**

**Figures** and **tables** are in their own environments:


```r
par(mar = c(4, 4, .1, .1))
plot(pressure, type = 'b', pch = 19)
```

<div class="figure" style="text-align: center">
<img src="index_files/figure-html/nice-fig-1.png" alt="Here is a nice figure!" width="80%" />
<p class="caption">(\#fig:nice-fig)Here is a nice figure!</p>
</div>

Reference a figure by its code chunk label with the `fig:` prefix, e.g., see Figure \@ref(fig:nice-fig). Similarly, you can reference tables generated from `knitr::kable()`, e.g., see Table \@ref(tab:nice-tab).


```r
knitr::kable(
  head(iris, 20), caption = 'Here is a nice table!',
  booktabs = TRUE
)
```



Table: (\#tab:nice-tab)Here is a nice table!

 Sepal.Length   Sepal.Width   Petal.Length   Petal.Width  Species 
-------------  ------------  -------------  ------------  --------
          5.1           3.5            1.4           0.2  setosa  
          4.9           3.0            1.4           0.2  setosa  
          4.7           3.2            1.3           0.2  setosa  
          4.6           3.1            1.5           0.2  setosa  
          5.0           3.6            1.4           0.2  setosa  
          5.4           3.9            1.7           0.4  setosa  
          4.6           3.4            1.4           0.3  setosa  
          5.0           3.4            1.5           0.2  setosa  
          4.4           2.9            1.4           0.2  setosa  
          4.9           3.1            1.5           0.1  setosa  
          5.4           3.7            1.5           0.2  setosa  
          4.8           3.4            1.6           0.2  setosa  
          4.8           3.0            1.4           0.1  setosa  
          4.3           3.0            1.1           0.1  setosa  
          5.8           4.0            1.2           0.2  setosa  
          5.7           4.4            1.5           0.4  setosa  
          5.4           3.9            1.3           0.4  setosa  
          5.1           3.5            1.4           0.3  setosa  
          5.7           3.8            1.7           0.3  setosa  
          5.1           3.8            1.5           0.3  setosa  


**Numbered equations**

To number equations and allow to refer to them, use an `equation` environment and label them with the syntax `(\#eq:label)`:

\begin{equation} 
  f\left(k\right) = \binom{n}{k} p^k\left(1-p\right)^{n-k}
  (\#eq:binom)
\end{equation} 

... and here, I refer to eq. \@ref(eq:binom). In the vase equations are not labelled, use the `equation*` environment instead.


**Citations**

You can reference citations, too. For example, we are using the **bookdown** package [@R-bookdown] in this sample book, which was built on top of R Markdown and **knitr** [@xie2015].


**Cache long computations**

If some computation is time-consuming, we could consider to cache it:


```r
# A verrry long computation!
1 + 1
```

```
## [1] 2
```


**TODO:** browse the bookdown book from 2.4 Figures on....
