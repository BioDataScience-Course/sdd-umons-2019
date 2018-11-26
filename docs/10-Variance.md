# Variance {#variance}



##### Objectifs {-}

- Pouvoir comparer plus de deux populations simultanément en utilisant des techniques de décomposition de la variance
 
- Découvrir le modèle linéaire, anciennement analyse de variance (ANOVA)
 
- Savoir effectuer des tests de comparaison multiples

- Connaitre l'équivalent non paramétrique à un facteur (test de Kruskal-Wallis)


##### Prérequis {-}

Ce module continue la comparaison de moyennes entamée, pour deux populations au module \@ref(moyenne). Assurez-vous d'avoir bien compris le test *t* de Student et les subtilités des tests d'hypothèse avant d'entamer la présente section.


## Le danger des tests multiples

Les tests *t* de Student et de Wilcoxon sont limités à la comparaison de deux populations. Poursuivons notre analyse des crabes *L. variegatus*. Rappelez-vous, nous avons deux variétés (variable `species`, `B` pour bleue et `O`pour orange). Si nous voulons comparer simultanément les mâles et les femelles des deux variétés, cela nous fait quatre sous-populations à comparer (nous utilisons ici la fonction `paste()` qui rassemble des chaînes de caractère avec trait comme caractère séparateur `sep ="-"` pour former une variable facteur à quatre niveaux, `B-F`, `B-M`, `O-F`, `O-M`). Nous en profitons également pour essayer l'astuce proposée au module précédent. Au lieu de travailler sur la variable `rear` seule, nous allons étudier l'aspect ratio entre largeur à l'arrière (`rear`) et largeur maximale (`width`) de la carapace afin de nous débarrasser d'une source de variabilité triviale qui est qu'un grand crabe est grand partout, et de même un petit crabe est petit pour toutes ses mesures. Nous prenons soin également de libellé ces nouvelles variables correctement\ :


```r
crabs <- read("crabs", package = "MASS", lang = "fr")
crabs %>.%
  mutate(.,
    group  = labelise(
      factor(paste(species, sex, sep = "-")),
      "Groupe espèce - sexe", units = NA),
    aspect = labelise(
      as.numeric(rear / width),
      "Ratio largeur arrière / max", units = NA)) %>.%
  select(., group, aspect) ->
  crabs2
skimr::skim(crabs2)
```

```
# Skim summary statistics
#  n obs: 200 
#  n variables: 2 
# 
# ── Variable type:factor ──────────────────────────────────────────────────────────────────────────────────
#  variable missing complete   n n_unique                         top_counts
#     group       0      200 200        4 B-F: 50, B-M: 50, O-F: 50, O-M: 50
#  ordered
#    FALSE
# 
# ── Variable type:numeric ─────────────────────────────────────────────────────────────────────────────────
#  variable missing complete   n mean   sd   p0  p25  p50  p75 p100     hist
#    aspect       0      200 200 0.35 0.03 0.28 0.32 0.36 0.38 0.41 ▂▅▅▃▅▇▆▁
```

Nous avons 50 individus dans chacun des quatre groupes. **Lorsqu'il y a le même nombre de réplicats dans tous les groupes, on appelle cela un plan balancé**. C'est une situation optimale. Nous devons toujours essayer de nous en rapprocher le plus possible car, si le nombre d'individus mesurés diffère fortement d'un groupe à l'autre, nous aurons forcément moins d'information disponible dans le ou les groupes moins nombreux, ce qui déforcera notre analyse.

Nous voyons également que la variable `aspect` semble avoir une distribution bimodale d'après le petit histogramme représenté dans le résumé. Une représentation graphique adéquate avant de réaliser notre analyse ici lorsque le nombre de répliquats est important est le graphique en violon sur lequel nous superposons au moins les moyennes, et de préférence, les points également, voir Fig. \@ref(fig:anova0). Si le nombre de répliquats est plus faible, mais toujours supérieur à 7-8, nous pourrions utiliser le même type de graphique mais avec des boites de dispersion plutôt. Avec encore moins de répliquats nous présenterons les points et les moyennes uniquement.


```r
chart(data = crabs2, aspect ~ group) +
  geom_violin() +
  geom_jitter(width = 0.05, alpha = 0.5) +
  geom_point(data = group_by(crabs2, group) %>.%
    summarise(., means = mean(aspect, na.rm = TRUE)),
    f_aes(means ~ group), size = 3, col = "red")
```

<div class="figure" style="text-align: center">
<img src="10-Variance_files/figure-html/anova0-1.svg" alt="Ratio largeur arrière/largeur max en fonction du groupe de crabes *L. variegatus*. Graphique adéquat pour comparer les moyennes et distributions dans le cas d'un nombre important de répliquat (moyennes en rouge + observations individuelles en noir semi-transparent superposées à des graphiques en violon)." width="672" />
<p class="caption">(\#fig:anova0)Ratio largeur arrière/largeur max en fonction du groupe de crabes *L. variegatus*. Graphique adéquat pour comparer les moyennes et distributions dans le cas d'un nombre important de répliquat (moyennes en rouge + observations individuelles en noir semi-transparent superposées à des graphiques en violon).</p>
</div>

Nous voyons ici beaucoup mieux que la distribution bimodale est essentiellement dûe au dymorphiqme sexuel plutôt qu'à des différences entre les variétés, mais qu'en est-il plus précisément car si nous regardons attentivement, il semble que les moyennes pour les crabes bleus sont légèrement inférieures à ces des crabes oranges.

Comment comparer valablement ces quatre groupes\ ? Comme nous savons maintenant comparer deux groupes à l'aide d'un test *t* de Student, il est tentant d'effectuer toutes les comparaisons deux à deux et de résumer l'ensemble, par exemple, dans un tableau synthétique. Ca fait quant même beaucoup de comparaisons (`B-F` <-> `B-M`, `B-F` <-> `O-F`, `B-F` <-> `O-M`, `B-M` <-> `O-F`, `B-M`<-> `O-M`, et finalement `O-F` <-> `O-M`). Cela fait six comparaisons à réaliser.

N'oublions pas que, à chaque test, nous prenons un risque de nous tromper. **Le risque de se tromper au moins une fois dans l'ensemble des tests est alors décuplé en cas de tests multiples.** Prenons un point de vue naïf, mais qui suffira ici pour démontrer le problème qui apparaît. Admettons que le risque de nous tromper est constant, que nous rejettons ou non $H_0$, et qu'il est de l'ordre de 10% dans chaque test individuellement^[Attention\ ! vous savez bien que c'est plus compliqué que cela. D'une part, le risque de se tromper est probablement différent si on rejette $H_0$ ($\alpha$) ou non ($\beta$), et ces risques sont encore à moduler en fonction de la probabilité *a priori*, un cas similaire au dépistage d'une maladie plus ou moins rare, rappelez-vous, au module \@ref(proba).]. La seule solution acceptable est que *tous* les tests soeijnt corrects. Considérant chaque interprétation indépendante, nous pouvons multiplier les probabilités d'avoir un test correct (90%) le nombre de fois que nous faisons le test, soit $0,9 \times 0,9 \times 0,9 \times 0,9 \times 0,9 \times 0,9 = 0,9^6 = 0,53$. Tous les autres cas ayant au moins un test faux, nous constatons que notre analyse globale sera incorrecte $1 - 0,53 = 47\%$ du temps^[Dans R, vous pouvez utiliser `choose(n, j)` pour calculer le coefficient binomial. Donc votre calcul du risque de se tromper au moins une fois dans un ensemble de `n` tests dont le risque individuel est `r` sera `1 - (1 - r)^choose(n, 2)`.]. **Notre analyse sera incorrecte une fois sur deux envirion.**

<div class="info">
<p>De manière générale, le nombre de combinaisons deux à deux possibles dans un set de <code>n</code> groupes distincts sera calculé à l'aide du coefficient binomial que nous avions déjà rencontré avec la distribution du même nom, ici avec <span class="math inline">\(j\)</span> valant deux.</p>
<p><span class="math display">\[C^j_n = \frac{n!}{j!(n-j)!}\]</span></p>
<p>Toujours avec notre approche naïve du risque d'erreur individuel pour un test <span class="math inline">\(r\)</span> de 10%, le risque de se tromper au moins une fois est alors :</p>
<p><span class="math display">\[1 - (1 - r)^{C^2_n}\]</span></p>
<p>Voici ce que cela donne comme risque de se tromper dans au moins un des tests en fonction du nombre de groupes à comparer  :</p>
<table>
<thead>
<tr class="header">
<th align="left">Groupes comparés 2 à 2</th>
<th align="center">2</th>
<th align="center">3</th>
<th align="center">4</th>
<th align="center">6</th>
<th align="center">8</th>
<th align="center">10</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="left">Risque individuel = 10%</td>
<td align="center">10%</td>
<td align="center">27%</td>
<td align="center">47%</td>
<td align="center">79%</td>
<td align="center">95%</td>
<td align="center">99%</td>
</tr>
</tbody>
</table>
<p>Clairement, on oublie cette façon de faire ! Prendre le risque de se tromper 99 fois sur 100 en comparant 10 groupes différents n'est pas du tout intéressante comme perspective.</p>
</div>

Nous allons donc travailler différemment... Ci-après nous verrons qu'une simplification des hypothèses et l'approche par décomposition de la variance est une option bien plus intéressante (ANalysis Of VAriance ou ANOVA). Ensuite, nous reviendrons vers ces comparaisons multiples deux à deux, mais en prenant des précautions pour éviter l'inflation du risque global de nous tromper.


## ANOVA & modèle linéaire

Au lieu de s'attaquer aux comparaisons deux à deux, nous pouvons aussi considérer une hypothèse unique que les moyennes de $k$ populations (nos quatre groupes différents de crabes, par exemple) sont égales. L'hypothèse alternative sera qu'au moins une des moyennes diffère des autres. En formulation mathématique, cela donne\ :

- $H_0: \mu_1 = \mu_2 = ... = \mu_k$

- $H_1: \exists(i, j) \mathrm{\ tel\ que\ } \mu_i \neq \mu_j$

Notre hypothèse nulle est très restrictive, mais par contre, l'hypothèse alternative est très vague car nous ne savons pas **où** sont les différences à ce stade si nous rejettons $H_0$, mais nous nous en occuperons plus tard.

<div class="info">
<p><strong>Propriété d'additivité des parts de variance</strong>. La variance se calcule comme :</p>
<p><span class="math display">\[var_x = \frac{SCT}{ddl}\]</span></p>
<p>Avec <span class="math inline">\(SCT\)</span>, la somme des carrés totaux, soit <span class="math inline">\(\sum (x_i - \bar{x})^2\)</span>, la somme des carrés des écarts à la moyenne générale. Les ddl sont les degrés de liberté déjà rencontrés à plusieurs reprises qui valent <span class="math inline">\(n - 1\)</span> dans le cas de la variance d'un échantillon.</p>
<p>Cette variance peut être <em>partitionnée</em>. C'est-à-dire que, si la variance totale se mesure d'un point A à un point C, l'on peut mesurer la part de variance d'un point A à un point B, puis l'autre part d'un point B à un point C, et dans ce cas,</p>
<p><span class="math display">\[SCT = SC_{A-C} = SC_{A-B} + SC_{B-C}\]</span></p>
<p>Cette propriété, dite d'additivité des variances, permet de décomposer la variance totale à souhait tout en sachant que la somme des différentes composantes donne toujours la même valeur que la variance totale.</p>
</div>


### Modèle de l'ANOVA

Mais qu'est-ce que cette propriété d'additivité des variances vient faire ici\ ? Nous souhaitons comparer des moyennes, non\ ? Effectivement, mais considérons le **modèle mathématique suivant\ :**

$$y_{ij} = \mu + \tau_j ± \epsilon_i \mathrm{\ avec\ } \epsilon \sim N(0, \sigma)$$

Avec l'indice $j = 1 .. k$ populations et l'indice $i = 1 .. n$ observations du jeu de données. Chaque observation $y_{ij}$ correspond à deux écarts successifs de la moyenne globale $\mu$\ : une constante "tau" par population $\tau_j$ d'une part et un terme $\epsilon_i$ que l'on appelle les **résidus** et qui est propre à chaque observation individuelle. C'est ce dernier terme qui représente la partie statistique du modèle avec une distribution normale centrée sur zéro et avec un écart type $\sigma$ que nous admettrons constant et identique pour toutes les populations par construction.

Le graphique à la Fig. \@ref(fig:anova1) représente une situation typique à trois sous-populations.

<div class="figure" style="text-align: center">
<img src="10-Variance_files/figure-html/anova1-1.svg" alt="Décomposition de la variance dans un cas à trois populations A, B et C fictives." width="672" />
<p class="caption">(\#fig:anova1)Décomposition de la variance dans un cas à trois populations A, B et C fictives.</p>
</div>

Notons que ce modèle à trois termes représente bien la situation qui nous intéresse, mais aussi, qu'il décompose la variance totale (entre $\mu$ et chaque point observé) en deux\ : ce que nous appelerons le terme **inter** représentant l'écart entre la moyenne globale $\mu$ et la moyenne de la sous-population concernées ($\tau_j$) et le terme **intra** depuis cette moyenne de la sous-population jusqu'au point observé ($\epsilon_i$).

D'une part, nous nous trouvons dans une situation d'additivité de la variance si nous décidons de calculer ces "variance inter" et "variance intra". D'autre part, sous $H_0$ nous sommes sensés avoir toutes les moyennes égales à $\mu$, et donc, tous les $\tau_j = 0$. Donc, les valeurs non nulles de $\tau_j$ ne doivent qu'être dus au hasard de l'échantillonnage et être par conséquent largement inférieurs à la variabilité entre les individus, ou variance intra $\epsilon_i$. La Fig. \@ref(fig:anova2) représente deux cas avec à gauche une situation où $H_0$ est plausible, et à droite une situation où elle est très peu plausible. Notez qu'à gauche la variation entre les observations (intra) est bien plus grande que l'écart entre les moyennes (inter), alors qu'à droite c'est l'inverse.

<div class="figure" style="text-align: center">
<img src="10-Variance_files/figure-html/anova2-1.svg" alt="A. Cas fictif avec moyennes probablement égales entre populations (étalement des points bien plus large que l'écart entre les moyennes), B. cas où les moyennes sont probablement différentes (écart des moyennes &quot;inter&quot; bien plus grand que l'étalement des points en &quot;intra&quot;-population)." width="672" />
<p class="caption">(\#fig:anova2)A. Cas fictif avec moyennes probablement égales entre populations (étalement des points bien plus large que l'écart entre les moyennes), B. cas où les moyennes sont probablement différentes (écart des moyennes "inter" bien plus grand que l'étalement des points en "intra"-population).</p>
</div>

Intuitivement, une comparaison de "inter" et "intra" permet de différencier la situation de gauche de celle de droite dans la Fig. \@ref(fig:anova2). Si cette comparaison est faite sous forme d'un ratio "inter"/"intra", alors ce ratio sera faible et tendra vers zéro sous $H_0$ (cas A), alors qu'il sera d'autant plus élevé que $H_0$ devient de moins en moins plausible (cas B).


##### Calcul de l'ANOVA {-}

Calcul des sommes des carrés (inter- et intragroupes). Considérant\ :

- _i_ = indice des observations au sein du jeu de données de 1 à _n_,
- _j_ = facteurs (sous-populations de 1 à _k_),
- $\bar{y}$ = moyenne generale de l'échantillon,
- $\bar{y_j}$ = moyenne de la _j_^ème^ population.

La somme des carrés inter $SC_{inter}$ et la somme des carrés intra $SC_{intra}$ se calculent comme suit\ :

$$
\begin{aligned}
SC_{inter} = \sum_{i=1}^n{(\bar{y_j} - \bar{y})^2} && SC_{intra} = \sum_{i=1}^n{(y_{ij} - \bar{y_j})^2}
\end{aligned}
$$

A ces sommes des carrés, nous pouvons associer les degrés de liberté suivants\ :

- _k_ – 1 pour l’intergroupe
- _n_ – _k_ pour l’intragroupe

Sachant que les parts de variances sont les $\frac{SC}{ddl}$ et sont appelés "carrés moyens", nous construisons ce qu'on appelle le **tableau de l’ANOVA** de la façon suivante\ :

| Type            |    Ddl    | Somme carrés | Carré moyen (_CM_)  |       Statistique _F_~obs~       | P (>_F_) |
|:----------------|:---------:|:------------:|:-------------------:|:----------------------------------:|:-----:|
| Inter (facteur) | _k_ - 1   | _SC~inter~_ | _SC~inter~/ddl~inter~_ | _CM~inter~/CM~intra~_ |  ...  |
| Intra (résidus) | _n_ - _k_ | _SC~intra~_  | _SC~intra~/ddl~intra~_ |  |  |

La **statistique _F_~obs~ est le rapport des carrés moyens inter/intra.** Elle représente donc le ratio que nous avons évoqué plus haut comme moyen de quantifier l'écart par rapport à $H_0$. Le test consiste à calculer la valeur *P* associée à cette statistique. Pour cela, il nous faut une distribution statistique théorique de *F* sous $H_0$. C'est un biologiste - statisticien célèbre nommé Ronald Aylmer Fisher qui l'a calculée. C'est la distribution *F* de Fisher.


### Distribution *F*

La distribution *F* est une distribution asymétrique n’admettant que des valeurs nulles ou positives, d'une allure assez similaire à la distribution du $\chi^2$ que nous avons étudiée au module \@ref(chi2). Elle est appelée loi de Fisher, ou encore, loi de Fisher-Snedecor. Elle a une asymptote horizontale à $+\infty$. La distribution *F* admet deux paramètres, respectivement les degrés de liberté au numérateur (inter) et au dénominateur (intra). La Fig. \@ref(fig:fplot) représente la densité de probabilité d'une loi *F* typique^[Les fonctions qui permettent les calculs relatifs à la distribution *F* dans R sont `<x>f()`, et les snippets correspondants dans la SciViews Box sont disponibles à partir de `.if`. Leur utilisation est similaire à celle des distributions vues au module \@ref(proba).].

<div class="figure" style="text-align: center">
<img src="10-Variance_files/figure-html/fplot-1.svg" alt="Allure typique de la densité de probabilité de la distribution F (ici ddl inter = 5 et ddl intra = 20). Plus *F~obs* est grand, plus l'hypothèse nulle est suspecte. La zone de rejet est donc positionnée à droite (en rouge)." width="672" />
<p class="caption">(\#fig:fplot)Allure typique de la densité de probabilité de la distribution F (ici ddl inter = 5 et ddl intra = 20). Plus *F~obs* est grand, plus l'hypothèse nulle est suspecte. La zone de rejet est donc positionnée à droite (en rouge).</p>
</div>

Nous commençons à avoir l'habitude maintenant. La valeur *P* est calculée comme l'aire à droite du quantile correspondant à *F~obs~*. Enfin, nous rejetterons $H_0$ seulement si la valeur *P* est inférieure au seuil $\alpha$ qui a été choisi préalablement au test. Ceci revient à constater que, graphiquement, *F~obs~* vient se positionner dans la zone de rejet en rouge comme sur la Fig. \@ref(fig:fplot).

##### Conditions d’application {-}

- échantillon représentatif (par exemple, aléatoire),
- observations indépendantes,
- variable dite **réponse** quantitative,
- une variable dite **explicative** qualitative à trois niveaux ou plus,
- distribution **normale** des résidus $\epsilon_i$,
- **homoscédasticité** (même variance intragroupes, "homoscedasticity" en anglais, opposé à hétéroscédasticité = variance différente entre les groupes).

Les deux dernières conditions d'applications doivent être vérifiées. La nomralité des résidus doit être rencontrée aussi bien que possible. Un graphique quantile-quantile des résidus permet de se faire une idée, comme sur la Fig. \@ref(fig:resid1). Néanmoins, le test étant relativement robuste à des petites variations par rapport à la distribution normale, surtout si ces variations sont symétriques, nous ne seront pas excessivement stricts ici.

<div class="figure" style="text-align: center">
<img src="10-Variance_files/figure-html/resid1-1.svg" alt="Graphique quantile-quantile appliqué aux résidus d'une ANOVA pour déterminer si leur distribution se rapproche d'un loi normale." width="672" />
<p class="caption">(\#fig:resid1)Graphique quantile-quantile appliqué aux résidus d'une ANOVA pour déterminer si leur distribution se rapproche d'un loi normale.</p>
</div>

La condition d'homoscédasticité est plus sensible. Elle mérite donc d'être vérifiée systématiquement et précisément. Différents tests d'hypothèse existent pour le vérifier, comme le test de Batlett, le test de Levene, etc. Nous vous proposns ici d'utiliser le test de Batlett. Ses hypothèses sont\ :

- $H_0: homoscédasticité \longrightarrow var_1 = var_2 = ... = var_k$
- $H_1: hétéroscédasticité \longrightarrow \exists(i, j) \mathrm{\ tel\ que\ } var_i \neq var_j$

Si la valeur *P* est inférieure au seuil $\alpha$ fixé au préalable, nous devrons rechercher une transformation des variables qui stabilisera la variance. La première transformation à essayer en biologie et la transformation logarithmique surtout si les valeurs négatives de la variable réponse ne sont pas possibles, signe d'une distribution qui peut être plutôt de type log-normale pour cette variable. Si aucune transformation ne stabilise la variance, nous devrons nous rabattre vers un test non paramétrique équivalent, le test de Kruskal-Wallis que nous aborderons plus loin dans ce module.

La SciViews Box propose des snippets pour accéder à ces différentes analyses. Dans le menu `hypothesis tests: variances` ou `.hv` nous trouvons trois tests dont celui de Bartlett. Dans le menu `hypothesis tests: means` ou `.hm` se trouvent les templates pour l'ANOVA, ainsi que les graphiques d'analyse des résidus dont le graphique quantile-quantile.


##### Résolution de notre exemple {-}

Nous commençons par déterminer si nous avons homoscédasticité. Cosidérons un seuil $\alpha$ de 5% pour tous nos tests. Ensuite\ :


```r
bartlett.test(data = crabs2, aspect ~ group)
```

```
# 
# 	Bartlett test of homogeneity of variances
# 
# data:  aspect by group
# Bartlett's K-squared = 24.532, df = 3, p-value = 1.935e-05
```

Nous rejettons $H_0$. Il n'y a pas homoscédasticité. Calculons par exemple le logarithme népérien de `aspect` et réessayons\ :


```r
crabs2 %>.%
  mutate(., log_aspect = ln(aspect)) ->
  crabs2
bartlett.test(data = crabs2, log_aspect ~ group)
```

```
# 
# 	Bartlett test of homogeneity of variances
# 
# data:  log_aspect by group
# Bartlett's K-squared = 37.891, df = 3, p-value = 2.981e-08
```

Ici cela ne fonctionne pas. Cela fait pire qu'avant. La transformation inverse (`exp()`) peut être essayée mais ne stabilise pas suffisamment la variance. Après divers essais, il s'avère qu'une triple exponentielle arrive à un résultat satisfaisant.


```r
crabs2 %>.%
  mutate(., exp3_aspect = exp(exp(exp(aspect)))) ->
  crabs2
bartlett.test(data = crabs2, exp3_aspect ~ group)
```

```
# 
# 	Bartlett test of homogeneity of variances
# 
# data:  exp3_aspect by group
# Bartlett's K-squared = 2.921, df = 3, p-value = 0.404
```

La Fig. \@ref(fig:crabs1) montre la distribution dans les différents groupes de la variable transformée.


```r
chart(data = crabs2, exp3_aspect ~ group) +
  geom_violin() +
  geom_jitter(width = 0.05, alpha = 0.5) +
  geom_point(data = group_by(crabs2, group) %>.%
    summarise(., means = mean(exp3_aspect, na.rm = TRUE)),
    f_aes(means ~ group), size = 3, col = "red")
```

<div class="figure" style="text-align: center">
<img src="10-Variance_files/figure-html/crabs1-1.svg" alt="Transformation tripe exponentielle du ratio largeur arrière/largeur max en fonction du groupe de crabes *L. variegatus*." width="672" />
<p class="caption">(\#fig:crabs1)Transformation tripe exponentielle du ratio largeur arrière/largeur max en fonction du groupe de crabes *L. variegatus*.</p>
</div>

Nous poursuivons sur une description des données utile pour l'ANOVA^[Un snippet dédié est disponible dans le menu `hypothesis tests: means` à partir de `.hm`.]\ :


```r
crabs2 %>.%
  group_by(., group) %>.%
  summarise(.,
    mean  = mean(exp3_aspect),
    sd    = sd(exp3_aspect),
    count = sum(!is.na(exp3_aspect)))
```

```
# # A tibble: 4 x 4
#   group  mean    sd count
#   <fct> <dbl> <dbl> <int>
# 1 B-F    71.8  5.26    50
# 2 B-M    53.8  6.52    50
# 3 O-F    75.7  6.27    50
# 4 O-M    57.3  6.54    50
```

Ensuite l'ANOVA prprement dite\ :


```r
anova(anova. <- lm(data = crabs2, exp3_aspect ~ group))
```

```
# Analysis of Variance Table
# 
# Response: exp3_aspect
#            Df Sum Sq Mean Sq F value    Pr(>F)    
# group       3  17225  5741.6  150.75 < 2.2e-16 ***
# Residuals 196   7465    38.1                      
# ---
# Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
```

Nous retrouvons ici le tableau de l'ANOVA. La valeur *P* est très faible et inférieure à $\alpha$. Nous rejettons $H_0$. Nous pouvons dire que le ratio largeur arrière / max diffère significativement entre les groupes (ANOVA, F = 150, ddl = 3 & 196, valeur *P* << 10^-3^).


##### Pour en savoir plus {-}

- [L'ANOVA expliquée en trois minutes](https://www.youtube.com/watch?v=lITNHx2z5FE)

- Introduction to ANOVA (en anglais). [Part I](https://youtu.be/QUQ6YppWCeg), [part II](https://youtu.be/fFnOD7KBSbw), [part III](https://youtu.be/XdZ7BRqznSA), [part IV](https://youtu.be/WUoVftXvjiQ), and [part V](https://youtu.be/kO8t_q-AXHE).

- Explication de l'analyse de variance en détaillant le calcul par la Kahn academy. [Partie I](https://www.youtube.com/watch?v=tjolTrwJhjM), [partie II](https://youtu.be/DMo9yofC5C8) et [partie III](https://youtu.be/y8nRhsixBPs). Assez long\ : près de 3/4h en tout. Ne regardez que si vous n'avez pas compris ce que sont les sommes des carrés.


## Les sciences des données dans la littérature

Petite recherche biblio concernant l’application en pratique de ces tests à faire par les étudiants...
