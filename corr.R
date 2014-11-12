corr <- function(directory, threshold=0) {
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
  
  files <- list.files(pattern = "\\.csv$")
  cors <- numeric()
  for(i in files){
    #get the file into a data.frame
    survey <- read.csv(i)
    #remove all rows with an NA
    survey <- na.omit(survey)
    counter<-nrow(survey)
    #calculate the correlation between sulfate and nitrate for each row of survey where the threshold is exceeded
    if(counter>threshold){
      cors<-append(cors, cor(survey$sulfate,survey$nitrate))
    }
  }
  return(cors)
}
