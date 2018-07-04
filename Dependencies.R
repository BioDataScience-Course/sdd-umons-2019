# This bookdown needs the following R packages
#  R 3.4.4

# From CRAN
install.packages(c("knitr", "bookdown", # The bases!
  "gdtools", "svglite", # SVG graphs
  "htmltools", "vembedr", # To embed videos easily
  "devtools")) # To install packages from Github

# From Github (latest devel version)
devtools::install_github("SciViews/flow")
devtools::install_github("SciViews/data")
devtools::install_github("SciViews/chart")
devtools::install_github("SciViews/SciViews")
