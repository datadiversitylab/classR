# Create repositories for a whole roster

Reads a roster CSV and runs
[`create_student_repo()`](https://datadiversitylab.github.io/classR/reference/create_student_repo.md)
for each student, then returns a data frame summarizing the status for
each repo.

## Usage

``` r
assign_homework(
  roster_csv,
  files_dir,
  prefix = "hw1",
  permission = "push",
  pause = 1
)
```

## Arguments

- roster_csv:

  Path to a CSV with a column named "handle".

- files_dir:

  Local folder with contents that will pushed into each repo.

- prefix:

  Assignment prefix. Each repo is named prefix-student.

- permission:

  Collaborator permission, "push" or "admin".

- pause:

  Seconds to wait between students, to stay clear of rate limits.

## Value

A data frame with one row per student: student, repo, status.

## Examples

``` r
if (FALSE) { # \dontrun{
set_org("ISTA421INFO521")
res <- assign_homework("roster.csv", "hw1_files", prefix = "hw1")
table(res$status)
} # }
```
