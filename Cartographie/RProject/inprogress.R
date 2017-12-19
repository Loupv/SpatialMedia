fillDatabase <- function(dbName){

  db <- read.csv(dbName,sep=",", header = T, fill = T)
  database <- data.frame(matrix(nrow = nrow(db), ncol = 10))
  colnames(database) <- c("Oeuvres",
                         "Auteur",
                         "Date",
                         "Immersion",
                         "Libertee_action",
                         "Libertee_perception",
                         "Socialisation",
                         "Peripherique_entree",
                         "Peripherique_sortie",
                         "URL")
  
  database$Oeuvres                  <- db[1:nrow(db),1]
  database$Auteur                   <- db[1:nrow(db),2]
  database$Date                     <- db[1:nrow(db),3]
  database$Immersion                <- db[1:nrow(db),4]
  database$`Libertee_action`        <- db[1:nrow(db),5]
  database$`Libertee_perception`    <- db[1:nrow(db),6]
  database$Socialisation            <- db[1:nrow(db),7]
  database$`Peripherique_entree`    <- db[1:nrow(db),8]
  database$`Peripherique_sortie`    <- db[1:nrow(db),9]
  database$URL                      <- db[1:nrow(db),10]

  return(database)
}

numToDeviceIn <- function(ns){
  l <- list()
  for(n in ns){
    if(n == 1) l <- c(l,"Tactile")
    else if(n == 2) l <- c(l,"Clavier/Souris")
    else if(n == 3) l <- c(l,"Mouvement")
    else if(n == 4) l <- c(l,"Son")
    else if(n == 5) l <- c(l,"Aucun")
  }
  return(l)
}

numToDeviceOut <- function(ns){
  l <- list()
  for(n in ns){
    if(n == 1) l <- c(l,"Ecran portable")
    else if(n == 2) l <- c(l,"Ecran ordinateur/TV")
    else if(n == 3) l <- c(l,"Casque VR")
    else if(n == 4) l <- c(l,"Ecran Projection")
    else if(n == 5) l <- c(l,"Ecouteurs")
  }
  
  return(l)
}