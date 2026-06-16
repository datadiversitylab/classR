#' classR: a minimal GitHub Classroom replacement in R
#'
#' Runs a course on GitHub from R without GitHub Classroom. Each student
#' gets a fresh private repository in an organization, a set of starter
#' files is pushed into it, and the student is added as a collaborator.
#'
#' Typical flow: [setup_github_token()] once, then [set_org()] each
#' session, then [assign_homework()] to create repos, [check_homework()]
#' to verify, [update_homework()] to push fixes, and [collect_homework()]
#' to pull submissions.
#'
#' @keywords internal
"_PACKAGE"
