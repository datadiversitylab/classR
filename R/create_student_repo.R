#' Create one student's repository and push starter files
#'
#' Creates a fresh private repository in the organization, pushes every
#' file in a local folder into it through the contents API, and adds the
#' student as a collaborator. If the repository already exists it is left
#' alone and the function reports that, so the call is safe to repeat.
#'
#' @param student GitHub username (handle).
#' @param files_dir Local folder whose contents are pushed into the repo.
#' @param prefix Assignment prefix. The repo is named prefix-student.
#' @param permission Collaborator permission. "push" lets the student
#'   commit work. "admin" also lets them manage the repo.
#'
#' @return A one row data frame with student, repo, and status. Status is
#'   one of "ok", "exists", "create_error", or "setup_error".
#' @export
#'
#' @examples
#' \dontrun{
#' set_org("ISTA421INFO521")
#' create_student_repo("octocat", "hw1_files", prefix = "hw1")
#' }
create_student_repo <- function(student, files_dir,
                                prefix = "hw1",
                                permission = "push") {
  org <- ghc_org()
  repo <- ghc_repo_name(prefix, student)

  message("Creating repo ", org, "/", repo, " for ", student)

  created <- tryCatch({
    gh::gh("POST /orgs/{org}/repos",
           org = org, name = repo, private = TRUE, auto_init = FALSE)
    TRUE
  }, error = function(e) {
    if (grepl("already exists", conditionMessage(e))) {
      message("Repo already exists, skipping creation: ", repo)
      "exists"
    } else {
      message("Repo creation failed for ", student, ": ", conditionMessage(e))
      "create_error"
    }
  })

  if (!isTRUE(created)) {
    return(data.frame(student = student, repo = repo, status = created,
                      stringsAsFactors = FALSE))
  }

  status <- tryCatch({
    files <- list.files(files_dir, recursive = TRUE)
    if (length(files) == 0) {
      message("Warning: no files found in ", files_dir)
    }
    for (f in files) {
      message("  pushing ", f)
      ghc_push_file(org, repo, file.path(files_dir, f), f)
    }

    message("  adding ", student, " as ", permission)
    gh::gh("PUT /repos/{owner}/{repo}/collaborators/{user}",
           owner = org, repo = repo, user = student, permission = permission)

    message("Done: ", repo, " ready for ", student)
    "ok"
  }, error = function(e) {
    message("Setup failed for ", student, ": ", conditionMessage(e))
    "setup_error"
  })

  data.frame(student = student, repo = repo, status = status,
             stringsAsFactors = FALSE)
}
