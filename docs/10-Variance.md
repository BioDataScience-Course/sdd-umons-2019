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

Nous allons donc travailler différemment... Ci-après nous verrons qu'une simplification des hypothèses et l'approche par décomposition de la variance est une option bien plus intéressante. Ensuite, nous reviendrons vers ces comparaisons multiples deux à deux, mais en prenant des précautions pour éviter l'inflation du risque global de nous tromper.


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

Mais qu'est-ce que cette propriété d'additivité des variances vient faire ici\ ? Nous souhaitons comparer des moyennes, non\ ? Effectivement, mais considérons le **modèle mathématique suivant** le graphique à la Fig. \@ref(fig:anova1).


Variance, ANOVAs, test de Bartlett. Graphiques associés. 


##### Pour en savoir plus {-}

- [L'ANOVA expliquée en trois minutes](https://www.youtube.com/watch?v=lITNHx2z5FE)

- Introduction to ANOVA (en anglais). [Part I](https://youtu.be/QUQ6YppWCeg), [part II](https://youtu.be/fFnOD7KBSbw), [part III](https://youtu.be/XdZ7BRqznSA), [part IV](https://youtu.be/WUoVftXvjiQ), and [part V](https://youtu.be/kO8t_q-AXHE).

- Explication de l'analyse de variance en détaillant le calcul par la Kahn academy. [Partie I](https://www.youtube.com/watch?v=tjolTrwJhjM), [partie II](https://youtu.be/DMo9yofC5C8) et [partie III](https://youtu.be/y8nRhsixBPs). Assez long\ : près de 3/4h en tout. Ne regardez que si vous n'avez pas compris ce que sont les sommes des carrés.


## Les sciences des données dans la littérature

Petite recherche biblio concernant l’application en pratique de ces tests à faire par les étudiants...
