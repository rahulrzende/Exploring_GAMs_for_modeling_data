# load the required libraries
library(pacman)
p_load(readr, dplyr, data.table, mgcv, ggplot2)

############################################################################################################################################################

# grab the dataset from source URL
URL <- "https://bit.ly/hadcrutv4"
gtemp <- data.table(read_delim(URL, delim = ' ', col_types = 'nnnnnnnnnnnn', col_names = FALSE))
gtemp <- gtemp[, .(Year=X1, Temperature=X2)]

############################################################################################################################################################

# train model on our dataset
model <- mgcv::gam(data = gtemp, 
                   Temperature ~ s(Year), 
                   method = "REML") 
# the other method "ML": does not integrate the unpenalized and parameteric effects out of the marginal likelihood optimized for the smoothing parameters
summary(model)
# Family: gaussian 
# Link function: identity 
# 
# Formula:
#   Temperature ~ s(Year)
# 
# Parametric coefficients:
#   Estimate Std. Error t value Pr(>|t|)   
# (Intercept) -0.025591   0.009812  -2.608  0.00996 **
#   ---
#   Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
# 
# Approximate significance of smooth terms:
#   edf Ref.df     F p-value    
# s(Year) 7.795  8.626 138.7  <2e-16 ***
#   ---
#   Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
# 
# R-sq.(adj) =  0.876   Deviance explained = 88.1%
# -REML = -89.861  Scale est. = 0.016465  n = 171

############################################################################################################################################################

# plot the raw data points
raw_plot <- ggplot(data = gtemp, aes(x=Year, y=Temperature)) + geom_point() + theme_bw() + xlab("Year") + ylab("Temperature")
ggsave(filename = "raw_data_plot.pdf", 
       plot = raw_plot, 
       width = 13, 
       height = 7, 
       device = "pdf")

# now we also plot the fit along with uncertainty therein
plot(model) # this was saved out to disk as a PDF using the Rstudio export function
