# corr.R

corr <- function(directory, threshold = 0) {
        start_dir <- getwd()
        setwd(directory)

        # create a vector to hold correlations
        correlations <- vector("numeric")

        # loop through each of the files
        for (file in 1:332) {
                file_name = paste(formatC(file, width=3, flag="0"),"csv", sep=".")
                file_obs <- read.csv(file = file_name)
                # count the complete.cases in this file
                complete_file_obs <- complete.cases(file_obs)
                count_complete_file_obs <- sum(complete_file_obs == TRUE)

                if (count_complete_file_obs > threshold) {
                        correlations <-
                                append(correlations,
                                       cor(file_obs[complete_file_obs,]$nitrate,
                                           file_obs[complete_file_obs,]$sulfate))
                }
        }
        setwd(start_dir)
        correlations
}
