best <- function (state, outcome) {

        oldw <- getOption("warn")
        options(warn = -1)

        # read outcome data
        setwd("~/repositories/learning/data-science-coursera/programming-assignment-3")
        outcomes <- read.csv("outcome-of-care-measures.csv")

        # check state and outcome are valid
        if (!(state %in% outcomes$State)){
                stop("invalid state")
        }

        outcome_col <- switch(outcome,
                              "heart attack" = 11,
                              "heart failure" = 17,
                              "pneumonia" = 23,
                              stop("invalid outcome")
                              )

        # return hospital name in the state with the lowest 30-day death rate
        outcomes <- subset(outcomes, outcomes[,7] == state)
        outcomes[, outcome_col] <- as.numeric(outcomes[, outcome_col])
        min_val <- min(outcomes[,outcome_col], na.rm = TRUE)
        outcomes <- subset(outcomes, outcomes[,outcome_col] == min_val)

        result <- sort(outcomes$Hospital.Name)
        print(result[1])

        options(warn = oldw)
}
