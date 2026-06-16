#' Collect students submission
#'
#' Clones each student's repository into a local folder, or pulls the
#' latest commits if it has already been cloned. Submissions land under
#' dest/prefix/student.
#'
#' This function uses git, not the API. git must be available on the system.
#' The token is read from GITHUB_PAT and passed to git for the duration
#' of each clone or pull.
#'
#' @param roster_csv Path to a CSV with a column named "handle".
#' @param prefix Assignment prefix. Each repo is named prefix-student.
#' @param dest Folder to collect into. Defaults to the working directory.
#'
#' @return A data frame with one row per student: student, repo, status.
#'   Status is "cloned", "pulled", or "error".
#' @export
#'
#' @examples
#' \dontrun{
#' set_org("ISTA421INFO521")
#' collect_homework("roster.csv", prefix = "hw1", dest = "submissions")
#' }
collect_homework <- function(roster_csv, prefix = "hw1", dest = ".") {
  org <- ghc_org()
  token <- Sys.getenv("GITHUB_PAT")
  if (!nzchar(token)) stop("GITHUB_PAT not set.", call. = FALSE)
  if (!nzchar(Sys.which("git"))) stop("git not found on the system.", call. = FALSE)

  roster <- utils::read.csv(roster_csv, stringsAsFactors = FALSE)
  if (!"handle" %in% names(roster)) {
    stop("Roster must have a column named 'handle'.", call. = FALSE)
  }

  base <- file.path(dest, prefix)
  dir.create(base, showWarnings = FALSE, recursive = TRUE)
  message("Collecting ", prefix, " into ", base)

  n <- nrow(roster)
  results <- vector("list", n)
  for (i in seq_len(n)) {
    s <- roster$handle[i]
    repo <- ghc_repo_name(prefix, s)
    local <- file.path(base, s)
    url <- paste0("https://", token, "@github.com/", org, "/", repo, ".git")

    if (dir.exists(file.path(local, ".git"))) {
      code <- system2("git", c("-C", shQuote(local), "pull", "--quiet"))
      status <- if (code == 0) "pulled" else "error"
      message("  ", status, ": ", repo)
    } else {
      code <- system2("git", c("clone", "--quiet", shQuote(url), shQuote(local)))
      status <- if (code == 0) "cloned" else "error"
      message("  ", status, ": ", repo)
    }

    results[[i]] <- data.frame(student = s, repo = repo, status = status,
                               stringsAsFactors = FALSE)
  }

  out <- do.call(rbind, results)
  message("Finished. ",
          sum(out$status %in% c("cloned", "pulled")), " collected, ",
          sum(out$status == "error"), " with errors.")
  out
}
