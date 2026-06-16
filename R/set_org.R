#' Set the GitHub organization
#'
#' Stores the organization login used by all other functions in the
#' package. Call this once per session before creating or collecting
#' repositories.
#'
#' @param org Organization login, for example "ISTA421INFO521".
#'
#' @return The organization login, invisibly.
#' @export
#'
#' @examples
#' \dontrun{
#' set_org("ISTA421INFO521")
#' }
set_org <- function(org) {
  if (!is.character(org) || length(org) != 1 || !nzchar(org)) {
    stop("org must be a single non-empty string.", call. = FALSE)
  }
  assign("ORG", org, envir = .ghc)
  message("Organization set to: ", org)
  invisible(org)
}
