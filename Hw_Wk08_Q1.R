#Create objects
question1Url <- "https://utexas.box.com/shared/static/21vasb3e7b57az1ud8ccuqxlqo361cxn.zip"
question1Filename <- "phalliiFNP_Variants_scrambledSubset.csv"

#creating function for data analysis
variantImport <- function(url,filename){
  #Setup
  zipFileName <- paste0(gsub(".csv","",filename),".zip")
  
  #Download and unzip
  download.file(url,destfile = zipFileName,quiet = T)
  unzip(zipFileName)
  
  #Read csv file
  outCsv <- read.csv(filename)
  
  #Remove missing rows
  rmLogic <- !grepl("Pahal",outCsv$gene)
  outCsv  <- outCsv[!rmLogic,]
  
  #Splitting the pos column into beg and end
  outCsv$begPos <- as.numeric(gsub("->.*","",outCsv$pos))
  outCsv$endPos <- as.numeric(gsub(".*->","",outCsv$pos))
  
  #Sorting the data.frame by chrom first, then begPos, and then endPos...
  outCsv <- outCsv[order(outCsv$chrom,outCsv$begPos,outCsv$endPos),]
  
  return(outCsv)
}