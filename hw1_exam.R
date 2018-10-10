handleError <- function ( stateCode ){
  #To show common Errors on passing arguemnts, and terminate the script. 
  if ( stateCode != 666 ) {
    if ( stateCode == 0 ) {#The number of arguments too few
      
      cat ( 'Error  -  Too few arguments: The passing arguments form 
            from command line should look like this, \n')
      cat ( 'Rscript filename.r --input [path] --output [path]\n' )
      cat ( 'Hint**: You may change the order of --input or --output, 
            and also using "--" or "-" is fine either way before every argument name title.\n' )
      
    } else if ( stateCode == 1) {#The number of arguments too many
      
      cat ( 'Error  -  Too many arguments: The passing arguments form 
            from command line should look like this, \n')
      cat ( 'Rscript filename.r --input [path] --output [path]\n' )
      cat ( 'Hint**: You may change the order of --input or --output, 
            and also using "--" or "-" is fine either way before every argument name title.\n' )
      
    } else if ( stateCode == 10 ) { #The First Argument name incorrect
      
      cat ( 'Error - First argument name incorrect: The first Argument title should be either "--input" 
            or "-input", or, "--output" or "-output".\n' )
      
    } else if ( stateCode == 11 ) { #Input path Error
      
      cat ( 'Error - The input path is invalid or non-existent.\n' )
      
    } else if ( stateCode == 20 ) { #The Second Argument name incorrect
      
      cat ( 'Error - Second argument name incorrect: The second Argument title should be either "--input" 
            or "-input", or, "--output" or "-output".\n' )
      
    } else if ( stateCode == 21 ) { #Output path Error
      
      cat ( 'Error - The output path is invalid or non-existent.\n')
      
    } 
    
    stop( call.=FALSE ) #Put session terminal code here.
    
  } else { #code 666: Means all is well that ends well
    cat( 'Looks fine so far...\n' )
    cat( 'Progressing...\n' )
  }
}

checkCmdArgument <-  function  ( arg ) { 
  #To Check completion of the passed Argument and assign paths correspondingly. 
  ErrorState <- 666
  argLength <- length( arg )
  pathPair <- list(inputPATH = '%%%', outputPATH = '%%%')
  
  if ( argLength == 4 ){
    #flow as: check the -- or - arugents correction ->
    #get the IO paths
    if ( arg[[1]] == '--input' || arg[[1]] == '-input' ) {
      #input first, output second
      if ( arg[[3]] == '--output' || arg[[3]] == '-output' ){
        
        pathPair$inputPATH <- arg[[2]]
        pathPair$outputPATH <- arg[[4]]
        
      } else {
        
        ErrorState = 20 
        
      }
      
    } else if ( arg[[1]] == '--output' || arg[[1]] == '-output' ) {
      #output first
      if (arg[[3]] == '--input' || arg[[3]] == '-input' ){
        
        pathPair$outputPATH <- arg[[2]]
        pathPair$inputPATH <- arg[[4]]
        
      } else {
        
        ErrorState = 20
        
      }
      
    } else {
      
      ErrorState = 10
      
    }
    
  } else if ( argLength < 4 ) {
    
    ErrorState = 0
    
  } else {
    
    ErrorState = 1
    
  }
  
  handleError( ErrorState )
  return ( pathPair )
}


getCleanFileName <- function( fullpath ){
  cleanName <- basename( fullpath ) #get the last file name with its file type
  cleanName <- tools::file_path_sans_ext( cleanName ) #remove file type
  cleanName <- noquote( cleanName ) #remove quotes
  
  return (cleanName) 
} 

findTheMaxValuesInFormattedCSV <- function( inputPath, outputPath ){
  
  if(file.exists(inputPath) == TRUE){#check if the  input path is reacheable 
    mycsv <- read.csv(inputPath, header = TRUE, sep = ',')
    cat('Read the file from: \n')
    cat(inputPath)
  }else{
    handleError(11)
  }
  
  cat('\n\n')
  
  finalFileContent <- data.frame( #send all values into this frame compulsively
    set = c( noquote( getCleanFileName( inputPath ) ) ),
    weight = c( noquote( round( max( mycsv[[2]], na.rm = TRUE ), 2 ) ) ),
    height = c( noquote( round( max( mycsv[[3]], na.rm = TRUE ), 2 ) ) ),
    stringsAsFactors=FALSE
  )
  cat('Fill in the data ... \n')
  
  #Write the final results to the given csv path if the path does exist
  writtenResult<-try(write.csv(finalFileContent, file = outputPath, row.names=FALSE, quote = FALSE), silent = TRUE)
  if(class(writtenResult) == 'try-error' ){
    handleError(21) 
  }else{
    cat('Wrote the file out successfully! \n')
    cat('You may check the file at: \n')
    cat(outputPath)
    cat('\n')
  }
  
}

##########################MAIN##########################
argPassed <- commandArgs(trailingOnly = TRUE) #get all arguments required 
IOargs <- checkCmdArgument(argPassed) # get input/output paths
findTheMaxValuesInFormattedCSV(IOargs[[1]], IOargs[[2]]) 
#do the job: find the max values and export it to specific directory
cat('\n')
