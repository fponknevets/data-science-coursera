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

**dput** and **dget**

```R
> y <- data.frame(a = 1, b = "a")
> dput(y)
structure(list(a = 1, b = "a"),
class = "data.frame",
row.names = c(NA, -1L))
> dput(y, file = "y.R")
> new.y <- dget("y.R")
> new.y
  a b
1 1 a
```

**dump**

Also writes objects to file but can output multiple objects at the same time. You pass it a character vector coantaining the names of the objects you want to write to file.

```R
> x <- "foo"
> y <- data.frame(a = 1 , b = "a")
> dump(c("x", "y"), file = "data.R")
> rm("x", "y")                        ## remove x and y before reading them back from file
> x
Error: object 'x' not found
> y
Error: object 'y' not found
> source("data.R")
> x
[1] "foo"
> y
  a b
1 1 a
```

<br><br>

#### Opening up connections to data

+ ```file``` - opens a connection to to file
+ ```gzfile``` - opens a connection to a file compressed with gzip
+ ```bzfile``` - opens a connection to a file compressed with bzip2
+ ```url``` - opens a connection to a webpage.


```R
> str(file)                                               ## get a look at the signature of file
function (
          description = "",                               ## name of the file to open
          open = "",                                      ## r=read / w=write / a=apend / rb wb ab = binary
          blocking = TRUE,
          encoding = getOption("encoding"),
          raw = FALSE,
          method = getOption("url.method", "default")
         )
```

You can open connections manually instead of using a function like ```read.csv()```.
```R
> conn <- file("data.R")
> x <- readLines(conn, 1)
> x
[1] "x <-"
```

<br><br>

#### Subsetting

Three types of subsetting operators:

+ ```[``` - single square bracket always returns an object of the same class as the original; can extract more than one element

+ ```[[``` - double square bracket operator can extract of a lit or a data frame; only extracts a single element; the class or the returned object wil not necessarily be a list or a data frame

+ ```$``` - dollar sign operator similar to the double square bracket operator but extracts object by name


**Extracting objects using the single square bracket operator**

```R
> x <- c("a", "b", "c", "c", "d", "A", "C", "E")
> x[1]
[1] "a"
> x[2]
[1] "b"
```

Extracting a sequence of objects
```R
> x[1:5]
[1] "a" "b" "c" "c" "d"
> x[5:1]
[1] "d" "c" "c" "b" "a"
> x[-1]
[1] "b" "c" "c" "d" "A" "C" "E"
> x[-5]
[1] "a" "b" "c" "c" "A" "C" "E"
> x[-5:-1]
[1] "A" "C" "E"
```

Extracting using logical indices
```R
> x[x > "a"]
[1] "b" "c" "c" "d" "A" "C" "E"
> x[x > "A"]
[1] "b" "c" "c" "d" "C" "E"
> x[x > "c"]
[1] "d" "C" "E"
```

Creating a logical vector
```R
> u <- x > "b"
> u
[1] FALSE FALSE  TRUE  TRUE  TRUE FALSE  TRUE  TRUE
> x[u]
[1] "c" "c" "d" "C" "E"
```

<br><br>

**Sub-setting lists**

```R
> x <- list(foo = 1:4, bar = 0.6, baz = "hello")
```

Sub-setting with the single square brackets gets a single element
```R
> x[1]             ## single bracket always returns an element the same class as
$foo               ## original, so x[1] returns a list that has an element named
[1] 1 2 3 4        ## "foo" which is the sequence 1, 2, 3, 4.
> x["bar"]         ## or if you use the single square bracket operator with the
$bar               ## name you get a list returned
[1] 0.6
```

Sub-setting with the double square brackets
```R
> x[[1]]           ## using the double square brackets extracts not a list, but
[1] 1 2 3 4        ## just the sequence 1, 2, 3, 4
> name <- "bar"    
> x[[name]]        ## you can sub-set using the result of a calculation
[1] 0.6            ## or the valuable stored in a variable
```
Sub-setting with the dollar operator
```R
> x$bar            ## can use the name of an element in the list with the dollar
[1] 0.6            ## operator
> x$name           ## you cannot sub-set using the result of a calcuation
NULL               ## or the value stored in a variable
```
Extracting multiple elements from a list you need to using the single square bracket operator
```R
> x[c(1,3)]
$foo
[1] 1 2 3 4

$baz
[1] "hello"
```

Sub-setting nested elements of a list
```R
> x <- list(a = list(10,12,14), b = c(3.14, 2.81))
> x[[c(1,3)]]  ## can use double square brackets to index into an element of a
[1] 14         ## list that is an element of a list
> x[[1]][[3]]  ## which is equivalent to specifying the nested position using
[1] 14         ## double square bracket operator
> x[[c(2,1)]]
[1] 3.14
```

<br><br>

**Sub-setting matrices**

```R
> x <- matrix(
+     1:6     ## values
+     ,2      ## rows
+     ,3      ## columns
+ )
> x
     [,1] [,2] [,3]
[1,]    1    3    5
[2,]    2    4    6
```
Matrices can be sub-setted using the single square bracket operator
```R
> x[1,2]                    ## first row second column
[1] 3                       ## when single element retrieved returns a vector
                            ##  with one element and not a one-by-one matrix
> x[1,2, drop = FALSE]      ## to change this behaviour use the argument
     [,1]                   ## 'drop = FALSE'
[1,]    3
```

You can having missing indices
```R
> x[1,]                     ## first row all columns
[1] 1 3 5                   ## returns a vector not a matrix
> x[,2]                     ## second column all rows
[1] 3 4                     ## returns a vector not a matrix
> x[1, , drop = FALSE]      ## and this time as a matrix
     [,1] [,2] [,3]
[1,]    1    3    5
> x[, 2, drop = FALSE]      ## and again as a matrix
     [,1]
[1,]    3
[2,]    4
```

<br><br>

**Partial matching**

Partial matching is particularly useful at the command line to save typing
```R
> x <- list(aardvark = c(1:5), antelope = c(6:10), baboon = c("a", "b", "c", "d", "e"))
> x$aa
[1] 1 2 3 4 5
> x$an
[1]  6  7  8  9 10
> x$b
[1] "a" "b" "c" "d" "e"
> x$a
NULL
> x[["a"]]
NULL
> x[["aa"]]
NULL
> x[["aa", exact = FALSE]]
[1] 1 2 3 4 5
> x[["a", exact = FALSE]]
NULL
```

<br><br>

**Filtering out missing values**

```R
> x <- c(1, 2, NA, 4, 5)
> y <- c("a", NA, "c", "d", "e")
> x
[1]  1  2 NA  4  5
> y
[1] "a" NA  "c" "d" "e"
> bad_x = is.na(x)
> bad_y = is.na(y)
> bad_x
[1] FALSE FALSE  TRUE FALSE FALSE
> bad_y
[1] FALSE  TRUE FALSE FALSE FALSE
> x[!bad_x]
[1] 1 2 4 5
> y[!bad_y]
[1] "a" "c" "d" "e"
> x[!is.na(x)]
[1] 1 2 4 5
> y[!is.na(y)]
[1] "a" "c" "d" "e"
```

<br><br>

**Getting complete cases**

You can get complete cases when combining a number of vectors with random missing data
```R
> countries <- c("England", "Scotland", NA, "Northern Ireland", "France", "Italy", NA)
> capitals <- c("London", "Edinburgh", "Cardiff", NA, "Paris", NA, NA)
> good = complete.cases(countries, capitals)
> good <- complete.cases(countries, capitals)
> m_all <- matrix(c(countries, capitals),7,2)
> m_good <- matrix(c(countries[good], capitals[good]),3,2)
> m_all
     [,1]               [,2]       
[1,] "England"          "London"   
[2,] "Scotland"         "Edinburgh"
[3,] NA                 "Cardiff"  
[4,] "Northern Ireland" NA         
[5,] "France"           "Paris"    
[6,] "Italy"            NA         
[7,] NA                 NA         
> m_good
     [,1]       [,2]       
[1,] "England"  "London"   
[2,] "Scotland" "Edinburgh"
[3,] "France"   "Paris"    
```

Can also use complete cases on data frames
```R
> airquality[1:6,]                        ## using the builtin data frane
  Ozone Solar.R Wind Temp Month Day       ## airquality and subsetting the
1    41     190  7.4   67     5   1       ## the first six rows, wwhich have
2    36     118  8.0   72     5   2       ## multiple NA values in various
3    12     149 12.6   74     5   3       ## columns
4    18     313 11.5   62     5   4
5    NA      NA 14.3   56     5   5
6    28      NA 14.9   66     5   6
> good <- complete.cases(airquality)      ## using complete.cases function on
                                          ## the airquality data frame
> airquality[good,][1:6,]                 ## then subsetting the rows twice
  Ozone Solar.R Wind Temp Month Day       ## first to return only the complete
1    41     190  7.4   67     5   1       ## cases and second to get the first
2    36     118  8.0   72     5   2       ## six of those
3    12     149 12.6   74     5   3
4    18     313 11.5   62     5   4
7    23     299  8.6   65     5   7
8    19      99 13.8   59     5   8
```

<br><br>

**Vectorised Operations**

R automatically performs looping operations on vectors where in other languages you might have to right your own loops.
```R
> x <- 1:4; y<- 6:9
> x + Y
Error: object 'Y' not found
> x + y
[1]  7  9 11 13
> x > 2
[1] FALSE FALSE  TRUE  TRUE
> x >= 2
[1] FALSE  TRUE  TRUE  TRUE
> y == 8                                    ## == tests for equality
[1] FALSE FALSE  TRUE FALSE
> x * y
[1]  6 14 24 36
> x / y
[1] 0.1666667 0.2857143 0.3750000 0.4444444
```

You can also do vector operations on matrices
```R
> x <- matrix(1:4, 2, 2); y <- matrix(rep(10,4), 2, 2)
> x
     [,1] [,2]
[1,]    1    3
[2,]    2    4
> y
     [,1] [,2]
[1,]   10   10
[2,]   10   10
> x * y           ## element-wise multiplication
     [,1] [,2]
[1,]   10   30
[2,]   20   40

> x / y
     [,1] [,2]
[1,]  0.1  0.3
[2,]  0.2  0.4

> x %*% y         ## true matrix mutliplication
     [,1] [,2]
[1,]   40   40
[2,]   60   60

## Matrix multiplication is the inner products of the rows of one matrix with
## the columns of the other.
## For z <- x %*% y, x must have as many rows as y has columns.
## In that case, z[i,j] is the inner product of the ith row of x
## with the jth column of y.
```