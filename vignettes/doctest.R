## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----instl, eval = FALSE------------------------------------------------------
#  library('devtools')
#  devtools::install_github("time-to-MaBo/doctest")

## ----setup--------------------------------------------------------------------
library(doctest)
?doctest
help(package = "doctest")

## ----summary------------------------------------------------------------------
fars_summarize_years(2013:2015)

## ----state--------------------------------------------------------------------
fars_map_state(1,2013)

