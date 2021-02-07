rankhospital <- function(state, outcome, num = "best"){

        # turn off warnings that would otherwise pollute the programme's output
        oldw <- getOption("warn")
        options(warn = -1)

        # Read outcome data
        setwd("~/repositories/learning/data-science-coursera/programming-assignment-3")
        outcomes <- read.csv("outcome-of-care-measures.csv")

        # Check that state and outcome are valid
        if (!(state %in% outcomes$State)){
                stop("invalid state")
        }

        outcome_col <- switch(outcome,
                              "heart attack" = 11,
                              "heart failure" = 17,
                              "pneumonia" = 23,
                              stop("invalid outcome")
        )

        ## Return hospital name in that state with the given rank
        ## 30-day death rate

        # subset outcomes by specified state
        outcomes <- subset(outcomes, outcomes[,7] == state)


        # sort the outcomes by 30 day death rate and then by hospital name
        # and remove any NA values
        outcomes[, outcome_col] <- as.numeric(outcomes[, outcome_col])

        outcomes <- outcomes[order(outcomes[,outcome_col],
                           outcomes$Hospital.Name,
                           na.last = NA),]

        # interpret the num input into a numeric


        interpreted_num <-
                if (is.numeric(num)) {
                        if (num >= 1 & num <= nrow(outcomes)){
                                num
                        } else {
                                return(NA)
                        }
                } else {
                        switch(num,
                               "best" = 1,
                               "worst" = nrow(outcomes),
                               return(NA))
                }

        # exit if the interpreted num is less than 1 or more than the number of
        # hospitals in that state with numeric outcomes
        if ( interpreted_num > nrow(outcomes) || interpreted_num < 1) {
                return(NA)
        }

        # return the hospital name of the ranked hospital
        outcomes[interpreted_num,2]

}
