# Data Science Specialism
[Coursera / John Hopkins University](https://www.coursera.org/learn/r-programming)

---

## **R Programming**

---

### Reading and Writing data

---

<br><br>

#### Functions for reading / writing Data

<br>

|Reading function|Writing function|Notes|
|---|---|---|
|```read.table```|```write.table```|reading / writing tabular data|
|```read.csv```|```write.table```|reading / writing csv data|
|```readLines```|```writeLines```|reading / writing lines of text|
|```source```|```dump```|reading / writing R code files|
|```dget```|```dput```|reading / writing R code files of objects de-parsed in to text files|
|```unserialize```|```serialize```|reading / writing single R objects in binary format|
|```load```|```save```|reading / writing workspaces|

<br><br>

#### Reading tabular data

<br>

```R
read.table( file = "file.path",             ## all arguments except file are optional for small files
            header = TRUE,
            sep = ",",
            colClasses = classOfEachColumn, ## a character vector (e.g. "numeric", "integer", "character")
            nrows = 10,
            comment.char = "#", 
            skip = 5,                       ## number of lines to skip at the beginning of the file
            stringsAsFactors = FALSE        ## should character vectors be treated as factors, default TRUE
          )                                 ## RETURNS A DATAFRAME
```

<br><br>

#### Non-tubular text data formats




