#' Url Exists
#'
#' @param x A string with the url to check if exist
#' @param quiet A logic if quiets
#' @param ... Ellipsis
#'
#' @return A logic value if url exists
#' @keywords internal
url_exists <- function(x, quiet = FALSE, ...) {

  capture_error <- function(code, otherwise = NULL, quiet = TRUE) {
    tryCatch(
      list(result = code, error = NULL),
      error = function(e) {
        list(result = otherwise, error = e)
      }
    )
  }

  safely <- function(.f, otherwise = NULL, quiet = TRUE) {
    function(...) capture_error(.f(...), otherwise, quiet)
  }

  sHEAD <- safely(httr::HEAD)
  sGET <- safely(httr::GET)

  if (!stringr::str_detect(x, "http")) {
    x <- paste0("https://", x)
  }

  res <- sHEAD(x, ...)

  if (is.null(res$result)) {

    res <- sGET(x, ...)

    if (is.null(res$result)) {
      return(FALSE)
    }
  }

  return(TRUE)

}
