#' Set up and verify a GitHub token
#'
#' Opens the GitHub token page with the right scopes pre-selected, takes
#' the token you paste back, checks that it authenticates and that it
#' carries the scopes this package needs (repo and admin:org), then saves
#' it to ~/.Renviron so it loads in future sessions.
#'
#' @param description Label shown on GitHub for the new token.
#'
#' @return The authenticated login, invisibly.
#' @export
#'
#' @examples
#' \dontrun{
#' setup_github_token()
#' }
setup_github_token <- function(description = "classR") {
  url <- paste0(
    "https://github.com/settings/tokens/new?scopes=repo,admin:org&description=",
    utils::URLencode(description)
  )
  message("Opening GitHub. Scopes repo and admin:org are already selected.")
  message("Name the token, generate it, then copy it.")
  utils::browseURL(url)

  token <- trimws(readline("Paste the new token here, then press Enter: "))
  if (!nzchar(token)) stop("No token entered.", call. = FALSE)

  Sys.setenv(GITHUB_PAT = token)

  who <- tryCatch(gh::gh_whoami(), error = function(e) NULL)
  if (is.null(who)) {
    Sys.unsetenv("GITHUB_PAT")
    stop("That token did not authenticate. Nothing saved.", call. = FALSE)
  }
  message("Authenticated as: ", who$login)

  # check scopes
  scopes <- strsplit(who$scopes %||% "", ",\\s*")[[1]]
  needed <- c("repo", "admin:org")
  missing <- needed[!needed %in% scopes]
  if (length(missing) > 0) {
    Sys.unsetenv("GITHUB_PAT")
    stop("Token is missing required scope(s): ", paste(missing, collapse = ", "),
         ". Generate a token with both repo and admin:org. Nothing saved.",
         call. = FALSE)
  }
  message("Scopes verified: repo and admin:org are present.")

  renv <- path.expand("~/.Renviron")
  lines <- if (file.exists(renv)) readLines(renv) else character(0)
  lines <- lines[!grepl("^GITHUB_PAT=", lines)]
  lines <- c(lines, paste0("GITHUB_PAT=", token))
  writeLines(lines, renv)
  message("Saved to ", renv, ". It will load automatically in new sessions.")

  invisible(who$login)
}
