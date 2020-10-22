library(pacman)
p_load(readr, dplyr, data.table)

URL <- "https://bit.ly/hadcrutv4"
gtemp <- data.table(read_delim(URL, delim = ' ', col_types = 'nnnnnnnnnnnn', col_names = FALSE))
gtemp <- gtemp[, .(Year=X1, Temperature=X2)]

