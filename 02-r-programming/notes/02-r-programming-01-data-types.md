# Data Science Specialism
[Coursera / John Hopkins University](https://www.coursera.org/learn/r-programming)

---

## **R Programming**

---

### Objects

---

#### Classes of Objects

+ character
+ numeric (real numbers)
+ integer
+ complex
+ logical (True / False)

#### Object Attributes

+ names / dimnames
+ dimensions (matrices / arrays)
+ class
+ length
+ user-defined attributes

Attributes can be accessed using the ```attributes()``` function.

---

#### Vector

+ can only contain objects of the class (except lists which can contain different classes)
+ create an empty vector with the ```vector()``` function.

##### Creating Vectors

```R
x <- c(0.5, 0.6)      # numeric
x <- c(TRUE, FALSE)   # logical
x <- c(T, F)          # logical
x <- c("a", "b", "c") # character
x <- c(9:29)          # integer
x <- c(1+0i, 2+4i)    # complex

x <- vector("numeric", length = 10)
x
[1] 0 0 0 0 0 0 0 0 0 0
```


##### Explicit Coercion

```R
x <- 0:6
x
[1] 0 1 2 3 4 5 6
class(x)
[1] "integer"
as.numeric(x)
[1] 0 1 2 3 4 5 6
as.logical(x)
[1] FALSE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
as.character(x)
[1] "0" "1" "2" "3" "4" "5" "6"
as.integer(x)
[1] 0 1 2 3 4 5 6
```

---

#### Lists

Can contain data of different classes. Lists are indexed using double-brackets ```[[1]]```.

```R
x <- list(1, "a", TRUE, 1 + 4i)
x
[[1]]
[1] 1

[[2]]
[1] "a"

[[3]]
[1] TRUE

[[4]]
[1] 1+4i
```

---

#### Matrices

Vectors with a dimensions attribute. Dimensions attribute is an integer vector with length 2 (nrow, ncol).

```R
> m <- matrix(nrow = 2, ncol = 3)
> m
     [,1] [,2] [,3]
[1,]   NA   NA   NA
[2,]   NA   NA   NA
> dim(m)
[1] 2 3
> attributes(m)
$dim
[1] 2 3
```

Matrices are created **column-wise**.
```R
> m <- matrix(1:6, nrow = 2, ncol = 3)
> m
     [,1] [,2] [,3]
[1,]    1    3    5
[2,]    2    4    6
```

Matrices can be created from Vectors.
```R
> m <- 1:6
> dim(m) <- c(2,3)
> m
     [,1] [,2] [,3]
[1,]    1    3    5
[2,]    2    4    6
```

Creating Matrices by **cbind**ing and **rbind**ing
```R
> x <- 1:3
> y <- 10:12
> cbind(x, y)
     x  y
[1,] 1 10
[2,] 2 11
[3,] 3 12
> rbind(x, y)
  [,1] [,2] [,3]
x    1    2    3
y   10   11   12
```

---

#### Factors

Used to represent categorical data - ordered or unordered.

```R
> x <- factor(c("yes", "yes", "no", "yes", "no"))
> x
[1] yes yes no  yes no 
Levels: no yes
```

You can get a frequency count of factors by calling table on the factor.
```R
> table(x)
x
 no yes 
  2   3 
```

Underlying it is an integer vector which you can see if you use ```unclass()``` on the factor.
```R
> unclass(x)
[1] 2 2 1 2 1
attr(,"levels")
[1] "no"  "yes"
```

You can set the order of the levels by using the ```levels``` argument to the ```factor()``` function.
```R
> x <- factor(c("yes", "yes", "no", "yes"), levels = c("yes", "no"))
> x
[1] yes yes no  yes
Levels: yes no
```

---

#### Missing Values

+ ```NA``` a missing value; can be any class; can be checked with ```is.na(x)```.
+ ```NaN``` a mising numerical value or is not a number; can be checked with ```is.nan(x)```.

```NaN``` values are also ```NA``` values, but the converse is not necessarily true.

```R
> x <- c(1, 2, NaN, NA, 10, 3)
> is.na(x)
[1] FALSE FALSE  TRUE  TRUE FALSE FALSE
> is.nan(x)
[1] FALSE FALSE  TRUE FALSE FALSE FALSE
```

---

#### **Data Fames**

Used to store tabular data; can be different data classes in different columns. Rerpresented as a list where every member of the list has the same length.

Each element of the list can be thought of as a column and the length of the elements can be thought of as the number of rows.

Each row can have a row name ```attribute(row.names)```.

Data frames can be created by:

+ ```read.table()``` or ```read.csv()```
+ ```data.matrix() ## converts a matrix to a data frame```
+ and can be created directly by using ```data.frame()```.

```R
> x <- data.frame(foo = 1:4, bar = c(T, T, F, T))
> x
  foo   bar
1   1  TRUE
2   2  TRUE
3   3 FALSE
4   4  TRUE
> nrow(x)
[1] 4
> ncol(x)
[1] 2
```

---

#### Names

Objects can have names - useful for readable code and self-describing objects.

```R
> x <- 1:3
> names(x)
NULL
> names(x) <- c("foo", "bar", "norf")
> x
 foo  bar norf 
   1    2    3 
> names(x)
[1] "foo"  "bar"  "norf"
```

Creating a list with names.

```R
> x <- list(a = 1, b = 2, c = 3)
> x
$a
[1] 1

$b
[1] 2

$c
[1] 3
```

Matrices can have vectors of row and column names.

```R
> m <- matrix(1:4, nrow = 2, ncol = 2)
> dimnames(m) <- list(c("a","b"), c("c","d"))
> m
  c d
a 1 3
b 2 4
```