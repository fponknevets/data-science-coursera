# complete.R

complete <- function(directory, id = 1:332) {
        start_dir <- getwd()
        setwd(directory)

        # create a vector to hold counts of complete observations
        compile_complete_obs <- vector("numeric")

        # loop through each of the files
        for (file in id) {
                file_name = paste(formatC(file, width=3, flag="0"),"csv", sep=".")
                file_obs <- read.csv(file = file_name)
                # count the complete.cases in this file
                complete_file_obs <- complete.cases(file_obs)
                count_complete_file_obs <- sum(complete_file_obs == TRUE)
                # add the id and the complete cases count to the vector
                compile_complete_obs <- append(compile_complete_obs,
                                               count_complete_file_obs)
        }
        setwd(start_dir)
        df <- data.frame(id,compile_complete_obs)
        names(df) <- c("id", "nobs")
        df
}
