complete <- function(directory, id = 1:332) {
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  
  ## 'id' is an integer vector indicating the monitor ID numbers
  ## to be used
  
  ## Return a data frame of the form:
  ## id nobs
  ## 1  117
  ## 2  1041
  ## ...
  ## where 'id' is the monitor ID number and 'nobs' is the
  ## number of complete cases
  setwd("C:/rprojects/coursera_verified/rprogramming/week2/")
  thedir <- paste(getwd(), "/", directory, sep="")
  setwd(thedir)
  nobs <- numeric()
  
  #loop through the monitor id numbers we're interested in, stringify them, and pad them to 3 characters
  #so we can get the right filename
  #then for each one, process it
  for (i in id){
    fileid<-sprintf("%03d",i)
    
    #get the file into a data.frame
    survey <- read.csv(list.files(pattern=fileid))
    #remove all rows with an NA
    survey <- na.omit(survey)
    #Append the complete rows to our result vector
    nobs<-append(nobs, nrow(survey))
  }
  df <- data.frame(id,nobs)
  return(df)
}
