# pollutantmean.R

pollutantmean <- function(directory, pollutant, id = 1:322) {
        start_dir <- getwd()
        setwd(directory)

        # create a 'collected_values' vector to store the values to be averaged
        collected_values <- vector("numeric")

        # loop through the files in id and add the values to the collected set
        for (file in id) {
                file_name = paste(formatC(file, width=3, flag="0"),"csv", sep=".")
                file_values <- read.csv(file = file_name)
                file_pollutant <- file_values[[pollutant]]
                collected_values <- append(collected_values, file_pollutant)
        }
        setwd(start_dir)
        mean(collected_values, na.rm = TRUE)
}
