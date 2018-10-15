# Rédaction scientifique {#redaction_scientifique}



La rédaction scientifique respecte un certain caneva expliqué dans cette annexe. 

#### Pour en savoir plus... {-}

- [Recherche documentaire et aide à la création (ReDAC)](https://moodle.umons.ac.be/enrol/index.php?id=5). L'Université de Mons met à disposition de ses étudiants un cours en ligne afin de trouver un maximum de renseignements sur la rédaction de rapports scientifiques.


## Organisation 

 Un rapport scientifique respecte généralement le schéma suivant :

1. Table des matières (facultatif)
2. Introduction
3. But
4. Matériel et méthodes
5. Résultats
6. Discussion
7. Conclusion
8. Bibliographie
9. Annexe(s) (si nécessaire)

Pour des travaux de plus grandes ampleurs comme les travaux de fin d'études, le schéma ci-dessus est adapté, et éventuellement divisé en chapitres, en y ajoutant généralement une partie remerciement en début de manuscrit.


## Contenu 

Le rapport sert à restituer de façon synthétique les résultats d'une étude scientifique, et les interprétations. Le tout est remis dans le contexte de la bibliographie existante en la synthétisant dans l'introduction et en comparant les résultats avec d'autres études connexes dans la discussion. Il faut garder à l’esprit qu’un lecteur doit comprendre l’intégralité du rapport avec un minimum de connaissances _a priori_ sur l'étude réalisée, mais avec des connaissances générales dans la spécialité. Donc, un rapport sur un sujet biologique est adressé à un lecteur biologiste pour lequel il ne faut pas rappeler les concepts de base dans sa discipline. Par contre, il faut expliquer avec suffisamment de détails comment l'étude a été réalisée dans la section "matériel et méthodes".

En général, les phrases sont simples, directes, courtes et précises (veuillez à utiliser le vocabulaire adéquat et les termes justes). Les explications sont, autant que possible, linéaires. Evitez les renvois dans différentes autres parties du rapoort, si ce n'est pour rappeler un élément évoqué plus haut, ou pour se référer à une figure ou une table. A ce sujet, les figures (dont les images, photos, schémas et graphiques) sont numérotées (Figure 1, Figure 2, ...) et accompagnées d'une légende en dessous d'elles. La figure et sa légende doivent être compréhensibles telles quelles. Dans le texte, vous pourrez alors vous référer à la figure, par exemple: "Tel phénomène est observable (voir Fig. 3)", ou "La Fig. 4 montre ...". idem pour les tableaux qui sont également numérotés (Tableau 1, Tableau 2, ...) et légendés, mais _au dessus_ du tableau. Les règles de lisibilité du tableau + légende et de renvoi vers les tableaux sont identiques que pour les figures. Les équations peuvent aussi être numérotées et des renvois de type (eq. 5) peuvent être utilisées. Enfin, toute affirmation doit être soit démontrées dans le rapport, ou amendées d'une citation vers un autre document scientifique qui la démontre. La partie bibliographie regroupe la liste de tous les documents qui sont ainsi cités à la fin du rapport.

Veuillez à respecter les notations propres au système métrique international, les abbrévations usuelles dans la discipline, et le droit d'auteur et les licenses si vous voulez citer un passage ou reprendre une illustration provenant d'un autre auteur. Enfin, en vue de rendre le document parfaitement reproductible, vous pouvez indiquer dans les annexes où trouver la source (le document `.Rmd`) et les données analysées. Vous pouvez également terminer avec un chunk qui renseigne de l'état du système R utilisé, y compris l'ensemble des packages annexes employés. Ce chunk, présenté en annexe, contiendra l'instruction `utils::sessionInfo()`, ou mieux : `xfun::session_info()` (version courte) ou `devtools::session_info()` (version longue). Par exemple :


```r
xfun::session_info()
```

```
R version 3.4.4 (2018-03-15)
Platform: x86_64-apple-darwin15.6.0 (64-bit)
Running under: macOS High Sierra 10.13.4

Locale: fr_BE.UTF-8 / fr_BE.UTF-8 / fr_BE.UTF-8 / C / fr_BE.UTF-8 / fr_BE.UTF-8

Package version:
  acepack_1.4.1       anytime_0.3.1       assertthat_0.2.0   
  backports_1.1.2     base64enc_0.1-3     BH_1.66.0.1        
  bindr_0.1.1         bindrcpp_0.2.2      bookdown_0.7       
  broom_0.5.0         callr_3.0.0         cellranger_1.1.0   
  chart_1.2.0         checkmate_1.8.5     cli_1.0.0          
  clipr_0.4.1         cluster_2.0.7-1     codetools_0.2-15   
  colorspace_1.3-2    compiler_3.4.4      cowplot_0.9.3      
  crayon_1.3.4        curl_3.2            data.io_1.2.0      
  data.table_1.11.4   datasets_3.4.4      DBI_1.0.0          
  dbplyr_1.2.2        digest_0.6.18       dplyr_0.7.6        
  ellipse_0.4.1       evaluate_0.12       fansi_0.3.0        
  flow_1.0.0          forcats_0.3.0       foreign_0.8-71     
  Formula_1.2-3       fs_1.2.6            ggplot2_2.2.1      
  ggplotify_0.0.3     ggpubr_0.1.8        ggrepel_0.8.0      
  ggsci_2.9           ggsignif_0.4.0      glue_1.3.0         
  graphics_3.4.4      grDevices_3.4.4     grid_3.4.4         
  gridExtra_2.3       gridGraphics_0.3-0  gtable_0.2.0       
  haven_1.1.2         highr_0.7           Hmisc_4.1-1        
  hms_0.4.2           htmlTable_1.12      htmltools_0.3.6    
  htmlwidgets_1.3     httr_1.3.1          igraph_1.2.2       
  jsonlite_1.5        knitr_1.20          labeling_0.3       
  lattice_0.20-35     latticeExtra_0.6-28 lazyeval_0.2.1     
  lubridate_1.7.4     magrittr_1.5        markdown_0.8       
  MASS_7.3-50         Matrix_1.2-14       methods_3.4.4      
  mime_0.6            modelr_0.1.2        munsell_0.5.0      
  nlme_3.1-137        nnet_7.3-12         nycflights13_1.0.0 
  openssl_1.0.2       pillar_1.3.0        pkgconfig_2.0.2    
  plogr_0.2.0         plyr_1.8.4          polynom_1.3.9      
  processx_3.2.0      proto_1.0.0         pryr_0.1.4         
  ps_1.1.0            purrr_0.2.5         R6_2.3.0           
  RApiDatetime_0.0.3  RColorBrewer_1.1-2  Rcpp_0.12.19       
  readr_1.1.1         readxl_1.1.0        rematch_1.0.1      
  reprex_0.2.1        reshape2_1.4.3      rlang_0.2.2.9001   
  rmarkdown_1.10      rpart_4.1-13        rprojroot_1.3-2    
  rstudioapi_0.7      rvcheck_0.1.0       rvest_0.3.2        
  scales_1.0.0        SciViews_1.1.0      selectr_0.4.1      
  splines_3.4.4       stats_3.4.4         stringi_1.2.4      
  stringr_1.3.1       survival_2.42-6     svMisc_1.1.0       
  tibble_1.4.2        tidyr_0.8.1         tidyselect_0.2.4   
  tidyverse_1.2.1     tinytex_0.8         tools_3.4.4        
  tsibble_0.5.1       utf8_1.1.4          utils_3.4.4        
  viridis_0.5.1       viridisLite_0.3.0   whisker_0.3.2      
  withr_2.1.2         xfun_0.3            xml2_1.2.0         
  yaml_2.2.0         
```


### Table des matières

La table des matières est d'une importance capitale pour un long document (mais facultative pour un plus court rapport) afin de présenter la structure de votre oeuvre aux lecteurs. Heureusement, il n'est pas nécessaire de l'écrire manuellement. La table des matières est générée automatiquement dans un rapport R Markdown. L'instruction à ajouter dans le préambule du document R Notebook afin d'obtenir une table des matières est `toc: yes` (ne l'encodez pas directement, mais sélectionnez l'option `Include table of contents` dans les options de formattage du document accessibles à partir du bouton engrenage à droite de `Preview` ou `Knit` -> `Output Options...`). Lorsque vous fermerez cette boite de dialogue de configuration, l'entrée _ad hoc_ sera ajoutée pour vous dans le prambule.

![](images/annexe_a4/table_contents.png)

Vous pouvez aussi choisir de numéroter vos titres automatiquement. L'instruction à ajouter en plus de `toc: yes` dans le préambule du document R Notebook afin d'obtenir une table des matières avec des titres numéroté est `number_sections: yes`. Encore une fois, passez par la boite de dialogue de configuration, et cochez-y l'entrée `Number section headings`. 

![](images/annexe_a4/table_contents2.png)

Voyez l'animation ci-dessous pour accéder à la boite de dialogue de configuration du document R Markdown/R Notebook.

![](images/annexe_a4/table_contents.gif)


### Introduction

L'introduction d'un rapport (ou d'un mémoire) a pour principal objectif de replacer l'étude scientifique réalisée dans son contexte.  La règle la plus importante est qu'**un lecteur n’ayant jamais entendu parler de cette étude doit comprendre l’intégralité du rapport.** L'introduction doit donc permettre de : 

- Remettre l'expérience dans son contexte,
- Décrire l'organisme étudié
      + description de l'organisme, distribution géographique, biotope,...
      
Notez que l'ajout d'images ou d'une carte de distribution est un plus dans l'introduction.


### But

Le but permet de synthétiser la question posée dans cette étude en fonction du contexte de l'expérience expliqué dans l'introduction.


### Matériel & méthodes

Le matériel & méthodes permettent de décrire les aspects techniques de l'étude comme le matériel employé et les méthodes utilisées (protocole) afin d'acquérir les données. Cette section est également le lieu de descriptions des méthodes statistiques utilisées pour analyser ces données, des programmes informatiques utilisés, ...


### Résultats

Les résultats vont généralement contenir 2 parties : 

- Description des données : exploration des données récoltées (avec graphiques et/ou estimateurs statistiques)
- Application des outils statistiques pertinents pour répondre à la question posée 


### Discussion

Cette section comprend l'interprétation biologique des résultats et les remettre dans un contexte plus général, notamment en les comparant à des observations connexes réalisées pr d'autres auteurs scientifiques. Il est d'une importance capitale d'avoir un regard critique sur les résultats obtenus. Cette mise en contexte aide en ce sens.

Exemple : 

- Variation du pH de l'eau de mer de 8 à 6 

Lors de la mesure des paramètres physico-chimiques de l'eau de mer, une étude suit le pH avec différents instruments et propose le graphique suivant :

<img src="A4-redaction_files/figure-html/unnamed-chunk-2-1.svg" width="672" />

Vous observez que les eaux de deux aquariums différents sont mesurées (les aquariums nommés A0 et B0) et que cinq instruments différents sont employés. Ce graphique vous semble-t-il pertinent ? Aucune information qui y figure ne vous choque ?  Si ce n'est pas le cas, il faut encore exercer votre oeil de biologiste. La sonde pH sur le graphique propose une valeur de pH proche de 6.5 alors que les autres instruments indiquent des valeurs de pH comprises entre 7.2 et 8. 

**Nous sommes donc passés d'un pH légérement basique, classique en eau de mer, à un pH acide inhabituel. Les organismes présents dans les aquariums serait mort à cette valeur de pH.**


### Conclusion(s) & perspective(s)

Cette section va résumer les principaux résultats à retenir de notre étude et, éventuellement, proposer des perspectives afin de poursuivre la recherche dans cette thématique.


### Bibliographie (ou références)

La rédaction de travaux s'appuye toujours sur une recherche bibliographique au préalable. Cependant, il est capital d'insérer convenablement les sources du travail au sein de la section bibliographie afin d'éviter le **plagiat** volontaire ou involontaire. Il existe une multitude de programmes permettant la gestion d'une bibliographie comme [Mendeley](https://www.mendeley.com/), [Zotero](https://www.zotero.org/) ou encore [Endnote](https://endnote.com/). 

- Pour générer correctement ses références bibliographiques dans un document R Markdown/R Notebook, [consulter ceci](https://rmarkdown.rstudio.com/authoring_bibliographies_and_citations.html#citation_styles). Il s'agit d'un manuel en anglais de RStudio qui explique comment faire dans le détail.


## Nom des espèces

Le nom complet d'une espèce en biologie suit une convention particulière, propre à la nomenclature binomiale de Linné) que vous devez appliquer dans tous vos travaux. Partons de l'exemple de l'oursin violet. Il s'agit ici du **nom vernaculaire** en français. Mais ce nom n'est pas assez préci pour être utilisé seul dans un travail scientifique. En effet, d'une part, le nom vernaculaire d'une espèce change d'une langue à la'autre, mais peut aussi varier d'une région géographique à l'aoutre, ou prie, peut désiger plusieurs espèces différentes. Seul le **nom latin** fait référence ! Une espèce est classée de la manière suivante (Les niveaux de classification les plus importants sont mis en gras) :

- **Règne** : Animalia
- Sous-Embranchement : Echinozoa
- **Embranchement** : Echinodermata
- **Classe** : Echinoidea
- Super-ordre : Echinacea
- **Ordre** : Camarodonta
- Infra-ordre : Echinidae
- **Famille** : Parachinidae
- **Genre** : *Paracentrotus*
- **Espèce** : *lividus*

Afin de former le nom binomial de l'oursin violet, on utilise le genre et l'espèce de la classification proprosée ci-dessus : 

- *Paracentrotus lividus*

En toute riguer, il faut aussi associer le **nom du naturaliste** qui a nommé et décrit l'espèce et l'année de la publication de la description (on parle de diagnose en biologie), et ce, uniquement la première fois qu'on cite cette espèce dans notre rapport.

- *Paracentrotus lividus* Lamarck 1816

Lors de la première citation de l'espèce étudiée dans un rapport, il est indispensable de spécifier le nom latin complet de l'espèce (genre espèce) qui pourra être éventuellement abbrégé par la suite en indiquant la première lettre du genre. Dans l'exemple, on pourra écrire ensuite *P. lividus* (pour autant que cela ne prette pas à confusion, bien sûr).
