# 01/07/19 have to change every column name's space to "_" to make it work


fillDatabase <- function(dbName){

  db <- read.csv(dbName,sep=",", header = T, fill = T)#, stringsAsFactors = FALSE)
  #names(db)<-str_replace_all(names(db), c(" " = "." , "," = "" ))
  
  
  db$Releaseyear[is.na(db$Releaseyear)] <- NA
  
  db$EmotionalinvolvementAffectivity[is.na(db$EmotionalinvolvementAffectivity)] <- 0
  db$FreedomofscenarioAgencyIcanImust[is.na(db$FreedomofscenarioAgencyIcanImust)] <- 0
  db$HybridityVirtualizationdegree[is.na(db$HybridityVirtualizationdegree)] <- 0
  db$PresenceHowmuchdoIfeelbeinghere[is.na(db$PresenceHowmuchdoIfeelbeinghere)] <- 0
  db$Immersionqualityofthehardware[is.na(db$Immersionqualityofthehardware)] <- 0
  db$Generalsubjectivejudgement[is.na(db$Generalsubjectivejudgement)] <- 0
  db$IflinearDurationinminute[is.na(db$IflinearDurationinminute)] <- 0
  db$IfnonlinearDurationinminuteindicatedbytheproducersdistributors[is.na(db$IfnonlinearDurationinminuteindicatedbytheproducersdistributors)] <- 0
  
  # print(length(rownames(mtcars)))
  # print(length(as.character(db$Titleofthework)))

  db$Time <- as.character(db$Time)
  db$Authorofthisform <- as.character(db$Authorofthisform)
  db$Titleofthework <- as.character(db$Titleofthework)
  db$Authors <- as.character(db$Authors)
  #db$Time <- as.character(db$Time)
  
  #db$Time[is.na(db$Time)] <- as.factor("Unanswered")

  db[db==""] <-NA
    
  #db[db=="NA"] <-"none"
  #db[is.na(db)] <- "none"
  
  
  write.csv(db, "test.csv")
  
  return(db)
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