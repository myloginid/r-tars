
# Remove all packages that R does not provide
# Shamlessly stolen from:
# https://www.r-bloggers.com/how-to-remove-all-user-installed-packages-in-r/

# create a list of all installed packages
 ip <- as.data.frame(installed.packages())
 head(ip)
# if you use MRO, make sure that no packages in this library will be removed
 ip <- subset(ip, !grepl("MRO", ip$LibPath))
# we don't want to remove base or recommended packages either\
 ip <- ip[!(ip[,"Priority"] %in% c("base", "recommended")),]
# determine the library where the packages are installed
 path.lib <- unique(ip$LibPath)
# create a vector with all the names of the packages you want to remove
 pkgs.to.remove <- ip[,1]
 head(pkgs.to.remove)
# remove the packages
 sapply(pkgs.to.remove, remove.packages, lib = path.lib)


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





