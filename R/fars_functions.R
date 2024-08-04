#' @title csv to tibble conversion
#'
#' @description
#' `fars_read` takes a name of package-internal rda dataset as input and
#' converts it to a tibble data frame.
#'
#' @note
#' If your input refers to a file that does not exist in the package, the function
#' will fail.
#'
#' @param filename name or path of dataset saved in csv. Must be of class character.
#'
#' @return a tibble data frame
#'
#' @import tibble
#'
#' @examples doctest:::fars_read('accident_2013')
fars_read <- function(filename){
  tryCatch(tibble::as_tibble((eval(parse(text = filename)))), error = function(e){
    stop("data '", filename, "' does not exist")
  })
}

#' @title Path to accident data
#'
#' @description
#' `make_filename` takes year as an argument and creates the filename for
#' the accident data of the corresponding year
#'
#' @note
#' If ! (year %in% 2013:2015) the function will create a string (or NAs)
#' for which no accident dataset exists.
#'
#' @param year year for which accident data is desired. Must/should be numeric.
#'
#' @return a string of the name of the accident data
#'
#' @examples doctest:::make_filename(2013)
make_filename <- function(year) {
  year <- suppressWarnings(as.integer(year))
  stopifnot(!is.na(year))
  sprintf("accident_%d", year)
}

#' @title Retrieve MONTHS, years accident data
#'
#' @description
#' `fars_read_years` takes years as an argument and outputs the months and years of
#' the corresponding accident data.
#'
#' @note
#' If any(!(years %in% 2013:2015)) the function will issue a warning and output a
#' NULL value.
#'
#' @param years vector of years for which accident data should be retrieved.
#' Must/should be a numeric vector.
#'
#' @return a list of length length(years) of nX2 tibble data frames
#'
#' @export
#' @import dplyr
#' @importFrom dplyr mutate select
#'
#' @examples fars_read_years(2013:2015)
fars_read_years <- function(years) {
  lapply(years, function(year) {
    file <- make_filename(year)
    tryCatch({
      dat <- fars_read(file)
      mutate(dat, year = year) %>%
        select(MONTH, year)
    }, error = function(e) {
      warning("invalid year: ", year)
      return(NULL)
    })
  })
}

#' @title Count accidents
#'
#' @description
#' `fars_summarize_years` counts the accidents by year and month of the accident datasets.
#'
#' @note
#' If any(!(years %in% 2013:2015)) the function will issue a warning and ignore the
#' incorrect input. Will throw an error if all inputs are incorrect.
#'
#' @inheritParams fars_read_years
#'
#' @return tibble data frame of accident counts
#'
#' @export
#' @import dplyr
#' @importFrom dplyr bind_rows group_by summarize
#' @importFrom tidyr spread
#'
#' @examples fars_read_years(2013:2015)
fars_summarize_years <- function(years) {
  dat_list <- fars_read_years(years)
  bind_rows(dat_list) %>%
    group_by(year, MONTH) %>%
    summarize(n = n()) %>%
    spread(year, n)
}

#' @title Plot of accidents
#'
#' @description
#' `fars_map_state` plots where the accidents of a chosen year and state have
#' happend.
#'
#' @note
#' If !(year %in% 2013:2015) the function will throw an error
#'
#' @param state.num integer identifier of the state in accidents data.
#' @return NULL, graphic of the state will be plotted.
#'
#' @export
#' @importFrom dplyr filter
#' @importFrom graphics points
#' @importFrom maps map
#' @inherit make_filename params
#'
#' @examples fars_map_state(1, 2013)
fars_map_state <- function(state.num, year) {
  filename <- make_filename(year)
  data <- fars_read(filename)
  state.num <- as.integer(state.num)

  if(!(state.num %in% unique(data$STATE)))
    stop("invalid STATE number: ", state.num)
  data.sub <- filter(data, STATE == state.num)
  if(nrow(data.sub) == 0L) {
    message("no accidents to plot")
    return(invisible(NULL))
  }
  is.na(data.sub$LONGITUD) <- data.sub$LONGITUD > 900
  is.na(data.sub$LATITUDE) <- data.sub$LATITUDE > 90
  with(data.sub, {
    map("state", ylim = range(LATITUDE, na.rm = TRUE),
              xlim = range(LONGITUD, na.rm = TRUE))
    points(LONGITUD, LATITUDE, pch = 46)
  })
}
