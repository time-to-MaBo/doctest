This is the vignette for the 'doctest' package. The 'doctest' package
was build for the Coursera cours 'buidling R package'. It includes
accident data form the years 2013, 2014, 2015 and may be used to create
summary statistics and plots of the US accident data.

The user-level functions are `fars_summarize_years` and `fars_map_state`
which we will demonstrate below. See the help files for
function-specific help.

Please note that the functions were slightly adapted as compared to the
original versions from the Coursera course. This wass mainly because I
preferred to have the datasets within thew package itself instead of
relying having the data in an appropriate folder structure outside of
the package.

## Load the package

Once the package is downloaded from Github and installed it may be
loaded by

    library('devtools')
    devtools::install_github("time-to-MaBo/doctest")

    library(doctest)
    ?doctest
    help(package = "doctest")

## `fars_summarize_years`

The function gives counts of accidents by year and month.

    fars_summarize_years(2013:2015)
    #> # A tibble: 12 × 4
    #>    MONTH `2013` `2014` `2015`
    #>    <int>  <int>  <int>  <int>
    #>  1     1   2230   2168   2368
    #>  2     2   1952   1893   1968
    #>  3     3   2356   2245   2385
    #>  4     4   2300   2308   2430
    #>  5     5   2532   2596   2847
    #>  6     6   2692   2583   2765
    #>  7     7   2660   2696   2998
    #>  8     8   2899   2800   3016
    #>  9     9   2741   2618   2865
    #> 10    10   2768   2831   3019
    #> 11    11   2615   2714   2724
    #> 12    12   2457   2604   2781

## `fars_summarize_years`

The function plots the location of the accidents within a chosen state
and year

    fars_map_state(1,2013)

![](/tmp/Rtmp9bvE3k/preview-f5d82d386d30.dir/doctest_files/figure-markdown_strict/state-1.png)
