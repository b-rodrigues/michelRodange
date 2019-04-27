# michelRodange

<!-- badges: start -->
<!-- badges: end -->

The goal of michelRodange is to provide three important national texts of the Luxembourguish language
as data frames. This will facilitate the study of these texts with the R programming language.

## Installation

You can install the released version of michelRodange from [CRAN](https://CRAN.R-project.org) with:

``` r
install.packages("michelRodange")
```

You can also install the package from Github:

``` r
remotes::install_github("b-rodrigues/michelRodange")
```

## Example

``` r
library(michelRodange)
library(tidyverse)

data(renert)

renert %>% 
  group_by(gesank) %>% 
  summarise(total_lines = n())
```