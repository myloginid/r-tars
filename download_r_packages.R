
# On Server with Internet
getPackages <- function(packs){
  packages <- unlist(
    tools::package_dependencies(packs, available.packages(),
                                which=c("Depends", "Imports"), recursive=TRUE)
  )
  packages <- union(packs, packages)
  packages
}

unlink("/tmp/R/*")
unlink("/tmp/R")
dir.create("/tmp/R", showWarnings = FALSE)
setwd("/tmp/R")

packages <- getPackages(c("sas7bdat", "RJDBC"))

# packages <- getPackages(c("caret","caretEnsemble","cluster","colorspace","coreNLP","d3heatmap","d3Network","data.table","dplyr","e1071","hexbin","plotly","wordcloud"))
download.packages(packages, destdir="/tmp/R", type="source")

l = list.files(path = "/tmp/R" , recursive = TRUE, full.names = TRUE)
l

# On Target Server
l = list.files(path = "/tmp/R" , recursive = TRUE, full.names = TRUE)
for(i in l){
  print(i);
  install.packages( i ,repos = NULL, type="source", verbose = FALSE, quiet = TRUE);
  }





