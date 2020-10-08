---
title: "task 12"
output: 
  html_document:
    keep_md: TRUE
---


```
## Loading required package: tidyverse
```

```
## Warning: package 'tidyverse' was built under R version 3.6.3
```

```
## -- Attaching packages -------------------------------------------------------------------------------------- tidyverse 1.3.0 --
```

```
## v ggplot2 3.2.1     v purrr   0.3.4
## v tibble  3.0.3     v dplyr   1.0.2
## v tidyr   1.1.1     v stringr 1.4.0
## v readr   1.3.1     v forcats 0.4.0
```

```
## Warning: package 'ggplot2' was built under R version 3.6.2
```

```
## Warning: package 'tibble' was built under R version 3.6.3
```

```
## Warning: package 'tidyr' was built under R version 3.6.3
```

```
## Warning: package 'purrr' was built under R version 3.6.3
```

```
## Warning: package 'dplyr' was built under R version 3.6.3
```

```
## -- Conflicts ----------------------------------------------------------------------------------------- tidyverse_conflicts() --
## x dplyr::filter() masks stats::filter()
## x dplyr::lag()    masks stats::lag()
```

```
## Loading required package: readxl
```

```
## Warning: package 'readxl' was built under R version 3.6.3
```

```
## Loading required package: downloader
```

```
## Warning: package 'downloader' was built under R version 3.6.3
```

```
## [1] "C:\\Users\\Connor\\AppData\\Local\\Temp\\RtmpuAmeQd\\file31b02fcd31be"
```

```
## New names:
## * `` -> ...1
## * `` -> ...2
## * `` -> ...3
## * `` -> ...4
## * `` -> ...5
## * ...
```

```
## # A tibble: 688 x 7
##     ...1 ...2                   ...5  ...8  ...11 ...14 ...17
##    <dbl> <chr>                  <chr> <chr> <chr> <chr> <chr>
##  1     1 Computer Science       <NA>  A     <NA>  <NA>  <NA> 
##  2     2 Business Analytics     <NA>  <NA>  B+    A     <NA> 
##  3     3 Electrical Engineering A     <NA>  <NA>  <NA>  <NA> 
##  4     4 Computer Science       <NA>  B-    A-    A     B    
##  5     5 Applied Mathematics    A-    A     <NA>  <NA>  <NA> 
##  6     6 Psychology             <NA>  <NA>  A-    A     <NA> 
##  7     7 Software Engineering   <NA>  B-    <NA>  <NA>  <NA> 
##  8     8 Psychology             <NA>  <NA>  B-    <NA>  <NA> 
##  9     9 Biochemistry           A-    <NA>  <NA>  <NA>  <NA> 
## 10    10 Computer Science       <NA>  C     <NA>  <NA>  <NA> 
## # ... with 678 more rows
```

```
## # A tibble: 3,440 x 4
##     ...1 ...2               Class Grades
##    <dbl> <chr>              <chr> <chr> 
##  1     1 Computer Science   ...5  <NA>  
##  2     1 Computer Science   ...8  A     
##  3     1 Computer Science   ...11 <NA>  
##  4     1 Computer Science   ...14 <NA>  
##  5     1 Computer Science   ...17 <NA>  
##  6     2 Business Analytics ...5  <NA>  
##  7     2 Business Analytics ...8  <NA>  
##  8     2 Business Analytics ...11 B+    
##  9     2 Business Analytics ...14 A     
## 10     2 Business Analytics ...17 <NA>  
## # ... with 3,430 more rows
```

```
## # A tibble: 876 x 4
##     ...1 ...2                   Class Grades
##    <dbl> <chr>                  <chr> <chr> 
##  1     1 Computer Science       ...8  A     
##  2     2 Business Analytics     ...11 B+    
##  3     2 Business Analytics     ...14 A     
##  4     3 Electrical Engineering ...5  A     
##  5     4 Computer Science       ...8  B-    
##  6     4 Computer Science       ...11 A-    
##  7     4 Computer Science       ...14 A     
##  8     4 Computer Science       ...17 B     
##  9     5 Applied Mathematics    ...5  A-    
## 10     5 Applied Mathematics    ...8  A     
## # ... with 866 more rows
```

![](task_12_files/figure-html/unnamed-chunk-1-1.png)<!-- -->

```
## # A tibble: 20 x 4
##     ...1 ...2                   Class Grades
##    <dbl> <chr>                  <chr> <chr> 
##  1     1 Computer Science       ...8  A     
##  2     2 Business Analytics     ...11 B+    
##  3     2 Business Analytics     ...14 A     
##  4     3 Electrical Engineering ...5  A     
##  5     4 Computer Science       ...8  B-    
##  6     4 Computer Science       ...11 A-    
##  7     4 Computer Science       ...14 A     
##  8     4 Computer Science       ...17 B     
##  9     5 Applied Mathematics    ...5  A-    
## 10     5 Applied Mathematics    ...8  A     
## 11     6 Psychology             ...11 A-    
## 12     6 Psychology             ...14 A     
## 13     7 Software Engineering   ...8  B-    
## 14     8 Psychology             ...11 B-    
## 15     9 Biochemistry           ...5  A-    
## 16    10 Computer Science       ...8  C     
## 17    11 Data Science           ...5  B     
## 18    11 Data Science           ...11 B-    
## 19    12 Computer Science       ...5  B-    
## 20    13 Computer Science       ...8  A
```
While MAT 325 (...11) and CS 241 (...5) have much more recorded grades in total, all classes have the same relative trend of mostly high scores and a few low scores 
