require(readr)

this <- tempfile()
let_dl <- download('https://github.com/WJC-Data-Science/DTS350/raw/master/randomletters.txt',this) 
rand_l <- read_lines(this)

that <- tempfile()
num_dl <- download('https://github.com/WJC-Data-Science/DTS350/raw/master/randomletters_wnumbers.txt',that)
rand_n <- read_lines(that)

#1
newlist <- c()

for (i in seq(1, str_length(rand_l)/1700)) {
  newlist <- str_c(newlist, str_sub(rand_l, start = i*1700, end = i*1700))
}
newlist

#this hidden quote is, 'the plural of anecdote is not data.'

#2
singledouble <- str_extract_all(rand_n,"\\d\\d|\\d")
singledouble

y <- str_replace_all(singledouble, c("10" = "j","11" = "k","12" = "l","13" = "m","14" = "n","15" = "o","16" = "p","17" = "q","18" = "r","19" = "s","20" = "t","21" = "u","22" = "v","23" = "w","24" = "x","25" = "y","26" = "z","1" = "a","2" = "b","3" = "c","4" = "d","5" = "e","6" = "f","7" = "g","8" = "h","9" = "i"))
writeLines(y)

#experts often posess more data than judgment 

#3
no_punc <- str_remove_all(rand_l, '[\\s.]')
no_punc

str_locate_all(no_punc,'a{4}') #one string of 4 a's at [16556,16559]
str_locate_all(no_punc,'e{2}')
str_locate_all(no_punc,'i{4}')
str_locate_all(no_punc,'o{4}') #one string of 4 o's at [8564,8567]
str_locate_all(no_punc,'u{4}')
str_locate_all(no_punc,'y{4}')
str_locate_all(no_punc,'[aeiou]{7}')
str_extract_all(no_punc, '[aeiou]{7}')
