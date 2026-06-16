#' Check which student repositories exist
#'
#' Looks up each student's repository in the organization and reports
#' whether it is present. Use this to confirm an assignment went out
#' cleanly, or to find who is missing before collecting work.
#'
#' @param roster_csv Path to a CSV with a column named "handle".
#' @param prefix Assignment prefix. Each repo is named prefix-student.
#'
#' @return A data frame with one row per student: student, repo, exists
#'   (logical).
#' @export
#'
#' @examples
#' \dontrun{
#' set_org("ISTA421INFO521")
#' status <- check_homework("roster.csv", prefix = "hw1")
#' status[!status$exists, ]
#' }
check_homework <- function(roster_csv, prefix = "hw1") {
  org <- ghc_org()
  roster <- utils::read.csv(roster_csv, stringsAsFactors = FALSE)
  if (!"handle" %in% names(roster)) {
    stop("Roster must have a column named 'handle'.", call. = FALSE)
  }

  n <- nrow(roster)
  results <- vector("list", n)
  for (i in seq_len(n)) {
    s <- roster$handle[i]
    repo <- ghc_repo_name(prefix, s)
    exists <- tryCatch({
      gh::gh("GET /repos/{owner}/{repo}", owner = org, repo = repo)
      TRUE
    }, error = function(e) FALSE)
    message(if (exists) "  ok      " else "  MISSING ", repo)
    results[[i]] <- data.frame(student = s, repo = repo, exists = exists,
                               stringsAsFactors = FALSE)
  }

  out <- do.call(rbind, results)
  message("Present: ", sum(out$exists), " of ", n, ".")
  out
}
