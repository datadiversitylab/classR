#' Create repositories for a whole roster
#'
#' Reads a roster CSV and runs [create_student_repo()] for each student,
#' then returns a data frame summarizing the status for each repo.
#'
#' @param roster_csv Path to a CSV with a column named "handle".
#' @param files_dir Local folder with contents that will pushed into each repo.
#' @param prefix Assignment prefix. Each repo is named prefix-student.
#' @param permission Collaborator permission, "push" or "admin".
#' @param pause Seconds to wait between students, to stay clear of rate
#'   limits.
#'
#' @return A data frame with one row per student: student, repo, status.
#' @export
#'
#' @examples
#' \dontrun{
#' set_org("ISTA421INFO521")
#' res <- assign_homework("roster.csv", "hw1_files", prefix = "hw1")
#' table(res$status)
#' }
assign_homework <- function(roster_csv,
                            files_dir,
                            prefix = "hw1",
                            permission = "push",
                            pause = 1) {
  roster <- utils::read.csv(roster_csv, stringsAsFactors = FALSE)
  if (!"handle" %in% names(roster)) {
    stop("Roster must have a column named 'handle'.", call. = FALSE)
  }

  n <- nrow(roster)
  message("Assigning ", prefix, " to ", n, " student(s).")

  results <- vector("list", n)
  for (i in seq_len(n)) {
    s <- roster$handle[i]
    message("[", i, "/", n, "] ", s)
    results[[i]] <- create_student_repo(s, files_dir, prefix, permission)
    Sys.sleep(pause)
  }

  out <- do.call(rbind, results)
  message("Finished. ",
          sum(out$status == "ok"), " ok, ",
          sum(out$status == "exists"), " existed, ",
          sum(out$status %in% c("create_error", "setup_error")), " with errors.")
  out
}
