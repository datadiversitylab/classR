# Create one student's repository and push starter files

Creates a fresh private repository in the organization, pushes every
file in a local folder into it through the contents API, and adds the
student as a collaborator. If the repository already exists it is left
alone and the function reports that, so the call is safe to repeat.

## Usage

``` r
create_student_repo(student, files_dir, prefix = "hw1", permission = "push")
```

## Arguments

- student:

  GitHub username (handle).

- files_dir:

  Local folder whose contents are pushed into the repo.

- prefix:

  Assignment prefix. The repo is named prefix-student.

- permission:

  Collaborator permission. "push" lets the student commit work. "admin"
  also lets them manage the repo.

## Value

A one row data frame with student, repo, and status. Status is one of
"ok", "exists", "create_error", or "setup_error".

## Examples

``` r
if (FALSE) { # \dontrun{
set_org("ISTA421INFO521")
create_student_repo("octocat", "hw1_files", prefix = "hw1")
} # }
```
