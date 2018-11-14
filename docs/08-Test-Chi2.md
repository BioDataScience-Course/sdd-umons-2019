# Test Chi carré {#chi2}



Dans ce module, nous entrons dans le monde de l'inférence statistique et des tests d'hypothèses qui nous permettront de répondre à des questions biologiques sur base de données empiriques malgré une incertitude inévitables (hasard de l'échantillonnage, variabilité individuelle, erreurs de mesure, ...).


##### Objectifs {-}

- Appréhender l'inférence statistique

- Être capable d'effectuer un échantillonnage correctement

- Comprendre ce qu'est un test d'hypothèse

- Connaitre la distribution Chi^2^ et les tests d'hypothèses basés sur cette distribution

- Développer un regard critique (positif\ !) sur le travail de ses collègues via l'évaluation d'un rapport par les pairs (initiation au "peer reviewing")


##### Prérequis {-}

Les probabilités et lois de distributions statistiques vues au module \@ref(proba) doivent être comprises avant d'attaquer cette section.

## Échantillonnage

Si nous pouvions mesurer **tous** les individus d'une population statistique à chaque fois, nous n'aurions pas besoin des statistiques. Mais ce n'est pratiquement jamais possible. Tout d'abord, le nombre d'individus est potentiellement très grand. Le travail nécessaire risque alors d'être démesuré. Afin de limiter les mesures à un nombre raisonnable de cas, nous effectuons un **échantillonnage** qui consiste à prélever un petit sous-ensemble de taille $n$ donné depuis la population de départ. Il existe différentes stratégies d'échantillonnage, mais la plus fréquente est l'**échantillonnage aléatoire** pour lequel\ :

- chaque individu dans la population a la même probabilité d'être pris dans l'échantillon,
- les mesures et les individu sont indépendants les uns des autres.

Nous n'avons pas forcément accès à tous les individus d'une population. Dans ce cas, nous devons la limiter à un sous-ensemble raisonnable. Par exemple, il est impossible de mesurer *toutes* les souris. Par contre, nous pouvons décider d'étudier la ou les souches de souris disponibles dans l'animalerie, ou chez nos fournisseurs.

Quoi qu'il en soit, l'échantillon n'est qu'un petit sous-ensemble sélectionné par un mécanisme faisant intervenir le hasard. Donc, deux échantillons de la même population ont un très forte probabilité d'être différents l'un de l'autre. Il en va également des statistiques calculées sur ces échantillons, comme les effectifs observés pour chaque niveau de variables qualitatives ou les valeurs moyennes pour les variables quantitatives, par exemple. **Cette variabilité d'un échantillon à l'autre ne nous intéresse pas car elle n'apporte pas d'information sur la population elle-même.** Ce qui nous intéresse, c'est d'estimer au mieux les valeurs (effectifs, moyennes, etc.) dans la population.

<div class="note">
<p>L'estimation de paramètres d'une population par le biais de calculs sur un échantillon représentatif issu de cette population s'appelle l'<strong>inférence statistique.</strong></p>
<div class="figure">
<img src="images/sdd1_08/inference.png" />

</div>
</div>


##### Travail préliminaire {-}

Avant de vous lancer dans l'inférence statistique, assurez-vous d'avoir effectué soigneusement les trois étapes suivantes\ :

1. Vous comprenez bien la question posée, en termes biologiques. Vous connaissez ou vous êtes documenté sur l'état de l'art en la matière (bibliographie). Que sait-on déjà du phénomène étudié\ ? Quels sont les aspects encore inconnus ou à l'état de simples hypothèses\ ?

2. Vous avez vérifié que la façon dont les mesures ont été prises permettra effectivement de répondre à la question posée. *En particulier, vous avez vérifié que l'échantillonnage a été réalisé dans les règles pour qu'il soit représentatif de la population étudiée.* En outre, vous cernez clairement quelle est la population effectivement étudiée. C'est important pour éviter plus tard de sur-généraliser les résultats obtenus (les attribuer à une population plus large que celle effectivement étudiée).

3. Vous avez effectué une analyse exploratoire des données. Vous avez représenté les données à l'aide de graphiques appropriés et vous avez interprété ces graphiques afin de comprendre ce que le jeu de données contient. Vous avez également résumé les données sous forme de tableaux synthétiques et vous avez, si nécessaire, remaniés et nettoyés vos données.


## Test d'hypothèse

Le test d'hypothèse ou test statistique est l'outil le plus simple pour répondre à une question via l'inférence. Il s'agit ici de réduire la question à sa plus simple expression en la réduisant à deux **hypothèses** contradictoires (en gros, la réponse à la question est soit "oui", soit "non" et rien d'autre).

- L'**hypothèse nulle**, notée $H_0$ est l'affirmation de base ou de référence que l'on cherchera à réfuter,
- L'**hypothèse alternative**, notée $H_1$ ou $H_a$ représente une autre affirmation qui doit nécessairement être vraie si $H_0$ est fausse.

Les deux hypothèses ne sont pas symétriques. Notre intention est de **rejeter $H_0$**. Dans ce cas, nous pourrons considérer que $H_1$ est vraie, avec un certain degré de certitude que nous pourrons également quantifier. Si nous n'y arrivons pas, nous dirons que nous ne pouvons pas rejeter $H_0$, mais nous ne pourrons jamais dire que que nous l'**acceptons** car dans ce cas, deux explications resteront possibles\ : (1) $H_0$ est effectivement vraie, ou (2) $H_0$ est fausse mais nous n'avons pas *assez* de données à disposition pour le démontrer avec le niveau de certitude recherché.

##### A vous de jouer ! {-}

\BeginKnitrBlock{bdd}<div class="bdd">
Ouvrez RStudio dans votre SciViews Box, puis exécutez l'instruction suivante dans la fenêtre console :

    BioDataScience::run("08a_chi2")
</div>\EndKnitrBlock{bdd}

### Becs croisés des sapins

Tout cela reste très abstrait. Prenons un exemple concret simple. Le bec-croisé des sapins *Loxia curvirostra* Linné 1758 est un passereau qui a la particularité d'avoir un bec dont les deux parties se croisent, ce qui donne un outil particulièrement adapté pour extraire les graines de conifères dont il se nourrit.

![Bec-croisés des sapins mâles montrant les deux variétés (bec croisé à gauche ou à droite). Photo\ : Elaine R. Wilson (license CC BY-SA 3.0).](images/sdd1_08/red-crossbills-male.jpg)

Comme des individus à bec croisé à gauche et d'autres à bec croisé à droite se rencontrent dans la même population, Groth (1992) a comptabilisé les deux types dans un échantillon aléatoire et représentatif de plus de 3000 oiseaux. Il a obtenu les résultats suivants\ :


```r
(crossbill <- as.table(c(left = 1895, right = 1752)))
```

```
#  left right 
#  1895  1752
```

Les scientifiques pensent que les variétés gauches et droites se rencontrent avec un ratio 1:1 dans la population étudiée suite à une sélection présumée basée sur le rapport des deux variétés. La question se traduit sous forme d'un test d'hypothèse comme ceci\ :

- $H_0: \mathrm{P}(left) = \frac{1}{2}\ \mathrm{et}\ \mathrm{P}(right) = \frac{1}{2}$
- $H_1: \mathrm{P}(left) \neq \frac{1}{2}\ \mathrm{ou}\ \mathrm{P}(right) \neq \frac{1}{2}$ 

Pouvons-nous rejeter $H_0$ ici\ ?


### Test Chi^2^ univarié

Le test Chi^2^ (ou $\chi^2$) de Pearson est un test d'hypothèse qui permet de comparer des effectifs observés notés $a_i$ à des effectifs théoriques $\alpha_i$ sous l'hypothèse nulle pour les différents niveaux $i$ allant de 1 à $n$ d'une variable qualitative (version dite univariée du test). A noter que par rapport à la définition des hypothèses ci-dessus, ce ne sont **pas** les probabilités qui sont testées, mais les effectifs.


Notre tableau de contingence à simple entrée `crossbill` contient nos $a_i$. Nous devons donc calculer quels sont les effectifs théoriques $\alpha_i$. Le nombre total d'oiseaux observés est\ :


```r
sum(crossbill)
```

```
# [1] 3647
```
... et les effectifs attendus sous $H_0$ sont\ :


```r
(alpha_i <- c(left = sum(crossbill)/2, right = sum(crossbill)/2))
```

```
#   left  right 
# 1823.5 1823.5
```

Les hypothèses du test $\chi^2$ univarié se définissent comme ceci\ :

- $H_0: a_i = \alpha_i$ pour tout $i$
- $H_1: a_i \neq \alpha_i$ pour au moins un $i$ 

Le principe de la **statistique $\chi^2$** consiste à sommer les écarts au carré par rapport aux $\alpha_i$ de référence divisés par ces mêmes $\alpha_i$ pour quantifier l'écart entre les valeurs observées et les valeurs théoriques. Donc\ :

$$\chi^2_\mathrm{obs} = \sum_{i=1}^n\frac{(a_i - \alpha_i)^2}{\alpha_i}$$

Notez que cette statistique prend la valeur nulle lorsque tous les $a_i$ sont strictement égaux aux $\alpha_i$. Dans tous les autres cas, des termes positifs (le carré de différences est toujours une valeur positive) apparaissent. Donc la statistique $\chi^2$ est d'autant plus grande que les observations s'éloignent de la théorie.

Calculons $\chi^2_\mathrm{obs}$ dans notre cas^[Faites également le calcul manuellement à la calculatrice pour vérifier que vous avez bien compris.]\ :


```r
(chi2_obs <- sum((crossbill - alpha_i)^2 / alpha_i))
```

```
# [1] 5.607074
```

Pour répondre à la question, il nous faut une loi de distribution statistique qui permette d'associer une probabilité au quantile $\chi^2_\mathrm{obs}$ sous $H_0$. C'est là que le statisticien Karl Pearson vient à notre secours. Il a, en effet, modélisé la distribution statistique du $\chi^2$. La loi du même nom admet un seul paramètre, les **degrés de libertés** (ddl) qui sont égaux au nombre de niveaux de la variable facteur étudiée $n$ moins un. Ici, ddl = 2 - 1 = 1. La Fig. \@ref(fig:chi2plot) représente la densité de probabilité d'une loi $\chi^2$ typique^[Les fonctions qui permettent les calculs relatifs à la distribution $\chi^2$ dans R sont `<x>chisq()`, et les snippets correspondants dans la SciViews Box sont disponibles à partir de `.ic`. Leur utilisation est similaire à celle des distributions vues au module \@ref(proba).]. C'est une distribution qui démarre à zéro, passe par un maximum et est asymptotique horizontale à $+\infty$.

<div class="figure" style="text-align: center">
<img src="08-Test-Chi2_files/figure-html/chi2plot-1.svg" alt="Allure typique de la densité de probabilité de la distribution Chi^2^ (ici ddl = 3)." width="672" />
<p class="caption">(\#fig:chi2plot)Allure typique de la densité de probabilité de la distribution Chi^2^ (ici ddl = 3).</p>
</div>


### Seuil α du test

Le raisonnement du test d'hypothèse pour répondre à notre question est le suivant. Connaissant la densité de probabilité théorique sous $H_0$, nous savons que, plus le $\chi^2_\mathrm{obs}$ est grand, moins il est plausible. Nous devons décider d'une limite à partir de laquelle nous considèrerons que la valeur observée est suffisamment grande pour que $H_0$ devienne trop peu plausible et nous pourrons alors la rejeter. Cette limite se définit sous la forme d'une **probabilité** correspondant à une zone ou aire de rejet définie dans la distribution théorique de référence sous $H_0$. Cette limite s'appelle le **seuil $\alpha$ du test**.

<div class="note">
<p><strong>Choix du seuil <span class="math inline">\(\alpha\)</span> d'un test d'hypothèse.</strong> Le seuil <span class="math inline">\(\alpha\)</span> est choisi <em>avant</em> de réaliser le test. Il est un savant compromis entre le risque de se tromper qui diminue plus <span class="math inline">\(\alpha\)</span> est petit, et la possibilité d'obtenir le rejet de <span class="math inline">\(H_0\)</span> lorsqu'elle est fausse qui augmentera avec <span class="math inline">\(\alpha\)</span>. Si on veut être absolument certain du résultat, on prend <span class="math inline">\(\alpha = 0\)</span>, mais dans ce cas on ne rejete jamais <span class="math inline">\(H_0\)</span> et on ne tire donc jamais aucune conclusion utile. Donc, nous devons assouplir les règles et accepter un petit risque de se tromper. <strong>Généralement, les statisticiens choisissent <span class="math inline">\(\alpha\)</span> = 5% dans les cas courants</strong>, et prennent 1%, ou même 0,1% dans les cas où il faut être plus strict (par exemple, si des vies dépendent du résultat). Nous pouvons nous baser sur ces références, même si nous verrons plus loin que cette pratique est de plus en plus remise en cause dans la littérature scientifique.</p>
</div>

Poursuivons. Nous choisissons notre seuil $\alpha$ = 5%. Cela définit l'aire la plus extrême de 5% à droite de la distribution $\chi^2$ à 1 ddl comme zone de rejet (remplie en rouge sur la Fig. \@ref(fig:chi2plot2)). Il nous suffit maintenant de voir où se place notre $\chi^2_\mathrm{obs}$. S'il se situe dans la zone en rouge, nous rejeterons $H_0$, sinon, nous ne la rejeterons pas.

<div class="figure" style="text-align: center">
<img src="08-Test-Chi2_files/figure-html/chi2plot2-1.svg" alt="Densité de probabilité sous *H*~0~ (distribution Chi^2^ à 1 ddl), zone de rejet de 5% en rouge et position de la valeur observée (trait vertical rouge)." width="672" />
<p class="caption">(\#fig:chi2plot2)Densité de probabilité sous *H*~0~ (distribution Chi^2^ à 1 ddl), zone de rejet de 5% en rouge et position de la valeur observée (trait vertical rouge).</p>
</div>

Où se situe la limite\ ? Nous pouvons facilement la calculer\ :


```r
qchisq(0.05, df = 1, lower.tail = FALSE)
```

```
# [1] 3.841459
```

Notre $\chi^2_\mathrm{obs}$ = 5,61 est plus grand que cette limite à 3,84 et se situe donc dans la zone de rejet de $H_0$ du test. **Nous rejetons donc $H_0$ ici**. Nous dirons que les becs croisés à gauche sont significativement plus nombreux que ceux à droite au seuil $\alpha$ de 5% (test $\chi^2$ = 5,61, ddl = 1, valeur *P* = 0,018). **Notez bien la façon particulière de reporter les résultats d'un test d'hypothèse\ !**

Il nous manque encore juste un élément... qu'est-ce que cette "valeur *P*" de 0,018 reportée dans le résultat\ ? En fait, c'est la valeur de probabilité associée au test et correspond ici à l'aire à droite définie depuis le $\chi^2_\mathrm{obs}$. Calculons-la\ :


```r
pchisq(5.61, df = 1, lower.tail = FALSE)
```

```
# [1] 0.01785826
```

Le test d'hypothèse reporte la valeur *P* afin qu'un lecteur qui aurait choisi un autre seuil $\alpha$ pourrait effectuer immédiatement sa propre comparaison sans devoir refaire les calculs. La règle est simple\ :

- valeur *P* < seuil $\alpha$, $=> \mathrm{R}H_0$ (on rejete $H_0$),
- valeur *P* ≥ seuil $\alpha$, $=> \rlap{\mathrm{R}} \diagup H_0$ (on ne rejete pas $H_0$).

Pour finir, nous ne devons heureusement pas refaire tous les calculs à la main à chaque fois que nous voulons faire un test du $\chi^2$ dans R. La fonction `chisq.test()` fait tout cela pour nous^[Avec `chisq.test()`, l'argument `p = ` est la liste des probabilités attendues sous $H_0$ et dont la somme vaut un. On peut aussi donner les effectifs attendus, mais il faut alors préciser `rescale.p = TRUE`.]. Elle est également disponible dans les snippets à partir du menu `hypothesis test : contingency` ou `.hc` (test Chi^2^ univarié).


```r
chisq.test(crossbill, p = c(1/2, 1/2), rescale.p = FALSE)
```

```
# 
# 	Chi-squared test for given probabilities
# 
# data:  crossbill
# X-squared = 5.6071, df = 1, p-value = 0.01789
```


##### Conditions d'application {-}

Tout test d'hypothèse impose des **conditions d'application** qu'il faudra vérifier avant d'effectuer le test. Pour le test $\chi^2$, ce sont\ :

- échantillonnage aléatoire et observations indépendantes,
- aucun effectif théorique sous $H_0$ nul,
- aucun effectif observé, si possible, inférieur à 5 (pas condition stricte).

C'est bien le cas ici.


### Effet de l'effectif étudié

En inférence, la qualité des données (échantillons *représentatifs*) est importante, mais la quantité aussi. **Plus vous pourrez mesurer d'individus, mieux c'est.** Par contre, dès que la taille de l'échantillon (ici, l'effectif total mesuré) est suffisant pour rejeter $H_0$, vous n'avez plus besoin d'augmenter la taille de votre échantillon^[Attention\ ! Vous devez fixer la taille de l'échantillon dès le départ *a priori*. Vous ne pouvez pas accumuler des données jusqu'à obtenir un rejet de $H_0$, sans quoi votre analyse sera biaisée.]. Voyons l'effet de la taille de l'échantillon sur l'étude des becs croisés des sapins. Nous n'avons pas besoin d'un effectif plus grand que celui mesuré, car nous rejetons $H_0$ ici. Qu'aurait donné notre test $\chi^2$, par contre, si l'auteur avait mesuré disons 10 fois moins d'oiseaux, les proportions restant par ailleurs identiques entre becs croisés à gauche et à droite\ ?


```r
# Proportions équivalentes, mais échantillon 10x plus petit
(crossbill2 <- as.table(c(left = 190, right = 175)))
```

```
#  left right 
#   190   175
```

```r
chisq.test(crossbill2, p = c(1/2, 1/2), rescale.p = FALSE)
```

```
# 
# 	Chi-squared test for given probabilities
# 
# data:  crossbill2
# X-squared = 0.61644, df = 1, p-value = 0.4324
```

Nous constatons que la valeur du $\chi^2_{obs}$ dépend de l'effectif. Sa valeur est plus petite ici. Par conséquent, la valeur *P* a également changé et elle vaut à présent 43%. Cette valeur est *supérieure* maintenant à notre seuil $\alpha$ de 5%. Donc, nous ne pouvons pas rejeter $H_0$. Dans un pareil cas, nous conclurons que les becs croisés à gauche ne sont **pas significativement** plus nombreux que ceux à droite au seuil $\alpha$ de 5% (test $\chi^2$ = 0,62, ddl = 1, valeur *P* = 0,43). Notez, c'est important, que nous n'avons pas écrit "ne sont **pas**", mais nous avons précisé "ne sont **pas significativement**" plus nombreux. C'est un détail très important. En effet, cela veut dire que l'on ne peut pas conclure qu'il y ait des différences sur base de l'échantillon utilisé, mais il se peut aussi que l'échantillon ne soit pas suffisamment grand pour mettre en évidence une différence. Or, nous avons analysé en réalité un plus grand échantillon (`crossbill`), et nous savons bien que c'est effectivement le cas. Est-ce que vous saisissez bien ce que le mot **significativement** veut dire, et la subtilité qui apparait lorsqu'un test d'hypothèse ne rejette **pas** $H_0$\ ? Les conclusions tirées avec `crossbill` et `crossbill2` et le même test d'hypothèse sont diamétralement opposées car l'un rejete et l'autre ne rejete pas $H_0$. Pourtant ces deux analyses ne se contredisent pas\ ! Les deux interprétations sont *simultanément* correctes. C'est l'interprétation asymétrique du test qui permet cela, et l'adverbe **significativement** est indispensable pour introduire cette nuance dans le texte.


### Test Chi^2^ d'indépendance

##### A vous de jouer ! {-}

\BeginKnitrBlock{bdd}<div class="bdd">Une séance d'exercice vous est proposée en lien avec le Test Chi^2^ d'indépendance
Ouvrez RStudio dans votre SciViews Box, puis exécutez l'instruction suivante dans la fenêtre console :

    BioDataScience::run("08b_chi2")
</div>\EndKnitrBlock{bdd}

Dans le cas d'un tableau de contingence à **double entrée**, qui croise les niveaux de deux variables qualitatives, nous pouvons effectuer également un test $\chi^2$. Celui-ci sera calculé légèrement différemment et surtout, les hypothèses testées sont différentes. Reprenos le jeu de données concernant le test d'une molécule potentiellement anti-cancéreuse, le timolol\ :


```r
timolol <- tibble(
  traitement = c("timolol", "timolol", "placebo", "placebo"),
  patient    = c("sain",    "malade",  "sain",    "malade"),
  freq       = c(44,        116,       19,        128)
)
# Création du tableau de contingence 
timolol_table <- xtabs(data = timolol, freq ~ patient + traitement)
timolol_table
```

```
#         traitement
# patient  placebo timolol
#   malade     128     116
#   sain        19      44
```

Nous avons ici un tableau de contingence à double entrée qui répertorie le nombre de cas attribués aléatoirement au traitement avec placebo (somme de la première colonne, soit 128 + 19 = 147 patients) et le nombre de cas qui ont reçu du timolol (116 + 44 = 160), tout autre traitement étant par ailleurs équivalent. Nous avons donc un total général de 307 patients étudiés.

La répartition dans le tableau selon les ligne est, elle, tributaire des effets respectifs des deux traitements\ ? La clé ici est de **considérer comme $H_0$ un partitionnement des cas équivalent entre les deux traitements.** Ceci revient au même que de dire que l'effet d'une variable (le traitement administré) est *indépendant* de l'effet de l'autre variable (le fait d'être guéri ou non). C'est pour cette raison qu'on parle de **test $\chi^2$ d'indépendance.** Les hypothèses sont\ :

- $H_0:$ indépendance entre les deux variables
- $H_1:$ dépendance entre les deux variables

Toute la difficulté est de déterminer les $\alpha_i$, les effectifs qui devraient être observés sous $H_0$. Si le partitionnement était identique selon tous les niveaux des deux variables, nous aurions autant de cas dans chaque cellule du tableau, soit 307/4 = 76,75. Mais n'oublions pas que nous avons attribués plus de patients au traitement timolol qu'au traitement placébo. De même, nous ne contrôlons pas le taux de guérison de la malide qui n'est d'ailleurs généralement pas d'un patient sur 2. Il faut donc *pondérer* les effectifs dans les lignes et les colonnes par rapprt aux totals dans les différents niveaux des variables (en colonne pour la variable `traitement`, en ligne pour la variable `patient`). Donc, si nous indiçons les lignes avec $i = 1 ..m$ et les colonnes avec $j = 1..n$, nos effectifs théoriques $\alpha_{i,j}$ sous hypothèse d'indépendance entre les deux variables sont\ :

$$\alpha_{i, j} =\frac{total\ ligne_i \times total\ colonne_j}{total\ général}$$

Nous pouvons dès lors calculer le $\chi^2_{obs}$ pratiquement comme d'habitude via\ :

$$\chi^2_{obs} = \sum_{i=1}^m{\sum_{j=1}^n{\frac{(a_{i,j} - \alpha_{i,j})^2}{\alpha_{i,j}}}}$$

Enfin, nous comparons cette valeur à la distribution théorique de $\chi^2$  à $(m - 1) \times (n - 1)$ degrés de liberté. Dans le cas d'un tableau 2 par 2, nous avons 1 degré de liberté. Voici le test effectué à l'aide de la fonction `chisq.test()` suivi de l'affichage des effectifs théoriques. Vous accédez facilement à ce code depuis le snippet `Chi2 test (independence)` dans le menu `hypothesis tests: contingency` à partir de `.hc`. Mais avant toute chose, nous devons choisir le seuil $\alpha$ **avant de réaliser le test**. Nous prendrons ici, par exemple, 1% puisque l'analyse est effectuée dans un contexte critique (maladie mortelle).


```r
(chi2. <- chisq.test(timolol_table)); cat("Expected frequencies:\n"); chi2.[["expected"]]
```

```
# 
# 	Pearson's Chi-squared test with Yates' continuity correction
# 
# data:  timolol_table
# X-squared = 9.1046, df = 1, p-value = 0.00255
```

```
# Expected frequencies:
```

```
#         traitement
# patient    placebo   timolol
#   malade 116.83388 127.16612
#   sain    30.16612  32.83388
```

##### Interprétation {-}

La valeur *p* de 0,0026 est inférieure au seuil $\alpha$ choisi de 0,01. Donc, nous rejetons $H_0$. Il n'y a pas indépendance entre les deux variables. Pour voir quels sont les effets de la dépendance entre les variables, nous devons comparer les effectifs théoriques affichés ci-dessus avec les effectifs observés. Dans le cas du placébo, sous $H_0$, nous aurions du obtenir 117 malades contre 30 patients guéris. Or, nous en avons 128 malades et seulement 19 guéris. D'un autre côté, sous $H_0$ nous aurions du observer 127 patients malades et 33 sains avec le timolol. Or, nous en observons 116 malades et 44 sains. Donc, les valeurs observées sont en faveur d'un meilleur effet avec le timolol. Nous pourrons dire\ : le timolol a un effet positif significatif sur la guérison de la maladie au seuil $\alpha$ de 1% ($\chi^2$ d'indépendance = 9,10, ddl = 1, valeur *P* - 0,0026).

##### Correction de Yates {-}

Si nous calculons le $\chi^2_{obs}$ à la main, nous obtenons\ :


```r
alpha_ij <- chi2.[["expected"]]
# Les a_i,j sont dans timolol_table
sum((timolol_table - alpha_ij)^2 / alpha_ij)
```

```
# [1] 9.978202
```

Cela donne 9,98. Or notre test renvoie la valeur de 9,10. A quoi est dûe cette différence\ ? Lisez bien l'intitulé du test réalisé. Il s'agit de "Pearson's Chi-squared test **with Yates' continuity correction**". Il s'agit d'une correction introduite par R dans le cas d'un tableau 2 par 2 uniquement et qui tient compte de ce que la distribution sous $H_0$ est estimée à partir des mêmes données que celle utilisées pour le test, ce qui introduit un biais ainsi corrigé. Il est donc déconseillé de désactiver cette correction, même si nous pouvons le faire en indiquant `correct = FALSE` (ci-dessous, juste pour vérifier notre calcul du $\chi^2_{obs}$ qui est maintenant identique, 9,98).


```r
# Test d'indépendance sans correction de Yates
chisq.test(timolol_table, correct = FALSE)
```

```
# 
# 	Pearson's Chi-squared test
# 
# data:  timolol_table
# X-squared = 9.9782, df = 1, p-value = 0.001584
```


##### Conditions d'application {-}

- échantillon représentatif (échantillonnage aléatoire et individus indépendants les uns des autres),
- attribution des traitements aux individus de manière aléatoire,
- aucun effectif théorique nul,
- Si possible, aucun effectif observé inférieur à 5 (pas règle strict, mais voir à utiliser un test exact de Fisher ci-dessous dans ce cas).


### Autres tests Chi^2^

Les test du $\chi^2$ est également utilisé, dans sa forme univariée, pour comparer les effectifs observés par rapport à des effectifs théoriques suivant un loi de distribution discrète. Ce test s'appelle un **test de qualité d'ajustement** ("goodness-of-fit test" en anglais). Dans ce cas, le nombre de degrés de liberté est le nombre de catégories moins le monbre de paramètres de la distribution moins un.

Pour l'ajustement à une loi de distribution continue, il est possible de découper les données en classes et d'appliquer un test $\chi^2$ dessus ensuite. Il existe cependant d'autres tests considérés comme plus efficaces dans ce cas, comme le test de [Komogorov-Smirnov](https://mistis.inrialpes.fr/software/SMEL/cours/ts/node7.html), notamment avec les corrections introduites par [Lillefors](http://www.statsoft.fr/concepts-statistiques/glossaire/t/test-lilliefors.html). Pour l'ajustement à une distribution normale, des tests spécialisés existent comme le test de [Shapiro-Wilk](http://www.sthda.com/french/wiki/test-de-normalite-avec-r-test-de-shapiro-wilk). Ce dernier est disponible depuis les snippets de la SciViews Box dans le menu `Hypothesis tests: distribution` ou `.hd`, et puis `Shapiro-Wilk test of normality`.

<div class="info">
<p>Gardez toujours à l'esprit que, quelle que soit la qualité d'un test d'ajustement, vous n'aurez jamais qu'une réponse binaire (oui ou non l'échantillon s'ajuste à telle distribution théorique). Les causes de dérive sont innombrables et seules des bonnes représentations graphiques (histogramme, graphe en violon, et surtout, graphique quantile-quantile) sont suffisamment riche en information pour explorer <em>pourquoi</em> et <em>comment</em> la distribution différe d'une distribution théorique.</p>
</div>


##### Pour en savoir plus {-}

- Le [test de Chi2 avec R](http://www.sthda.com/french/wiki/test-de-chi2-avec-r),

- Le [test G](http://www.biostathandbook.com/gtestgof.html) est considéré comme une bonne alternative dans certains cas (voir aussi [Chi-square vs. G-test](http://www.biostathandbook.com/gtestgof.html#chivsg)).

- Le [test exact de Fisher](http://www.sthda.com/french/wiki/test-exact-de-fisher-avec-r) comme test alternatif, en particulier lorsque les effectifs sont faibles.

##### A vous de jouer ! {-}

\BeginKnitrBlock{bdd}<div class="bdd">
Employez le test d'hypothèse que vous venez d'apprendre dans votre rapport sur la biométrie humaine :
  sdd1_biometry-...(nom du groupe)</div>\EndKnitrBlock{bdd}

## Evaluation par les pairs

En science, l'évaluation par les pairs ("peer-reviewing" en anglais) est le mécanisme le plus efficace pour améliorer la qualité des travaux publiés (articles scientifiques ou ouvrages plus conséquents). Par définition, les résultats publiés en science sont à la frontière de l'inconnu. Il est donc difficile de vérifier si le travail est correct. Les personnes les plus à même de le faire sont les collègues qui travaillent sur le même sujet, ou dans un domaine proche, les "pairs".

Avant d'être rendus publics, les travaux scientifiques font l'objet d'un ou plusieurs rapports par des pairs. Cette phase est la **révision** de l'article. Le rapport se veut constructif dans le but d'améliorer la qualité du travail. Il ne s'agit pas d'"enfoncer" les auteurs initiaux, mais le "referee" se doit d'être honnête et donc, de mettre le doigt sur les défauts et lacunes du travail également.

##### A vous de jouer ! {-}

<div class="bdd">
<p>Vous allez vous initier au travail de referee sur base du rapport sur la biométrie de l'oursin violet. Vous partagerez votre dépôt Github avec un de vos collègue, et vous recevrez également un accès au dépôt de quelqu'un d'autre. Votre travail consistera à lire avec un oeil critique et constructif le travail que vous recevrez.</p>
<p>Vous ajouterez un fichier <code>review.md</code> à la racine du projet où vous consignerez vos remarques générales. Pour les remarques particulières directement dans le rapport, utilisez la balise de citation de Markdown (commencez le paragraphe par <code>&gt;</code>), par exemple :</p>
<blockquote>
<p>Ceci est un commentaire dans le texte.</p>
</blockquote>
<p>N'effacer, ni ne modifiez aucun texte directement dans ce rapport. Si vous devez suggérer l'élimination de texte, utilisez la balise Markdown qui sert à biffer ce texte sous forme de deux tildes devant et derrière (<code>~~~</code>, ce qui donne <del>texte biffé</del>). Ensuite, effectuez un commit de vos commentaires sur le dépôt Github de votre collègue.</p>
<p>De votre côté, lorsque vous recevrez le rapport relatif à votre propre projet, lisez les commentaires (ne modifiez <strong>pas</strong> le fichier <code>review.md</code>, mais par contre, éditez le texte et éliminez les commentaires directement dans le rapport au fur et à mesure que vous le corriger en tenant compte de ces remarques). Vous pourrez éventuellement apporter des réponses ou des justifications aux commentaires globaux du fichier <code>review.md</code>.</p>
<p>suivez les intructions suivantes : <a href="https://github.com/BioDataScience-Course/sdd_lesson/blob/master/sdd1_08/presentations/correction.md" class="uri">https://github.com/BioDataScience-Course/sdd_lesson/blob/master/sdd1_08/presentations/correction.md</a></p>
</div>
