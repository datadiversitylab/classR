#' Update files in existing student repositories
#'
#' Pushes the contents of a local folder into each student's existing
#' repository, creating files that are not there or overwriting files
#' that are. Use this to fix or add starter files after the initial
#' assignment. This overwrites files at the given paths.
#'
#' @param roster_csv Path to a CSV with a column named "handle".
#' @param files_dir Local folder whose contents are pushed into each repo.
#' @param prefix Assignment prefix. Each repo is named prefix-student.
#' @param pause Seconds to wait between students.
#'
#' @return A data frame with one row per student: student, repo, status.
#'   Status is "updated" or "error".
#' @export
#'
#' @examples
#' \dontrun{
#' set_org("ISTA421INFO521")
#' update_homework("roster.csv", "hw1_fixes", prefix = "hw1")
#' }
update_homework <- function(roster_csv, files_dir,
                            prefix = "hw1",
                            pause = 1) {
  org <- ghc_org()
  roster <- utils::read.csv(roster_csv, stringsAsFactors = FALSE)
  if (!"handle" %in% names(roster)) {
    stop("Roster must have a column named 'handle'.", call. = FALSE)
  }

  n <- nrow(roster)
  message("Updating ", prefix, " for ", n, " student(s) from ", files_dir)

  results <- vector("list", n)
  for (i in seq_len(n)) {
    s <- roster$handle[i]
    repo <- ghc_repo_name(prefix, s)
    message("[", i, "/", n, "] ", repo)

    status <- tryCatch({
      files <- list.files(files_dir, recursive = TRUE)
      if (length(files) == 0) message("  Warning: no files found in ", files_dir)
      for (f in files) {
        message("  updating ", f)
        ghc_push_file(org, repo, file.path(files_dir, f), f)
      }
      message("  done: ", repo)
      "updated"
    }, error = function(e) {
      message("  update failed for ", s, ": ", conditionMessage(e))
      "error"
    })

    results[[i]] <- data.frame(student = s, repo = repo, status = status,
                               stringsAsFactors = FALSE)
    Sys.sleep(pause)
  }

  out <- do.call(rbind, results)
  message("Finished. ",
          sum(out$status == "updated"), " updated, ",
          sum(out$status == "error"), " with errors.")
  out
}
