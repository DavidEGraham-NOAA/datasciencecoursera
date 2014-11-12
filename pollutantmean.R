pollutantmean <- function(directory, pollutant, id = 1:332) {
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  
  ## 'pollutant' is a character vector of length 1 indicating
  ## the name of the pollutant for which we will calculate the
  ## mean; either "sulfate" or "nitrate".
  
  ## 'id' is an integer vector indicating the monitor ID numbers
  ## to be used
  
  ## Return the mean of the pollutant across all monitors list
  ## in the 'id' vector (ignoring NA values)
  
  #Get the file(s)
  setwd("C:/rprojects/coursera_verified/rprogramming/week2/")
  thedir <- paste(getwd(), "/", directory, sep="")
  #print(thedir)
  setwd(thedir)

  #vector to hold the data we're interested in
  mastervec <- vector()
  
  #loop through the monitor id numbers we're interested in, stringify them, and pad them to 3 characters
  #so we can get the right filename
  #then for each one, process it
  for (i in id){
    fileid<-sprintf("%03d",i)
    
    #get the file into a data.frame
    surveydata <- read.csv(list.files(pattern=fileid))
    #get the column we're interested in into a vector
    mastervec<-c(mastervec,surveydata[[pollutant]])
  }
  return(mean(mastervec,na.rm=TRUE))
  
}
