rankall <- function(outcome, num = "best") {

        # turn off warnings that would otherwise pollute the programme's output
        oldw <- getOption("warn")
        options(warn = -1)

        # Read outcome data
        setwd("~/repositories/learning/data-science-coursera/programming-assignment-3")
        outcomes <- read.csv("outcome-of-care-measures.csv")

        # Check that outcome is valid
        outcome_col <- switch(outcome,
                              "heart attack" = 11,
                              "heart failure" = 17,
                              "pneumonia" = 23,
                              stop("invalid outcome")
        )



        ## For each state, find the hospital of the given rank

        # setup the dataframe that we will be returning
        results <- data.frame(matrix(ncol = 2, nrow = 0))

        # split the outcomes into state outcomes
        split_outcomes <- split(outcomes, outcomes$State)

        # for each state sort on the outcome and hospital name whilst removing NA
        for (state in split_outcomes) {
                state[, outcome_col] <- as.numeric(state[, outcome_col])

                state <- state[order(state[,outcome_col],
                                           state$Hospital.Name,
                                           na.last = NA),]
                interpreted_num <-
                        if (is.numeric(num)) {
                                if (num >= 1 & num <= nrow(state)){
                                        num
                                } else {
                                        NA
                                }
                        } else {
                                switch(num,
                                       "best" = 1,
                                       "worst" = nrow(state),
                                       NA)
                        }

                new_result <- data.frame(state[interpreted_num, c(2,7)])
                results <- rbind(results, new_result)


        }
        ## Return a data frame with the hospital names and the
        ## (abbreviated) state name

        col_names <- c("hospital", "state")
        colnames(results) <- col_names

        results
}
