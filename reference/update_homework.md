# Update files in existing student repositories

Pushes the contents of a local folder into each student's existing
repository, creating files that are not there or overwriting files that
are. Use this to fix or add starter files after the initial assignment.
This overwrites files at the given paths.

## Usage

``` r
update_homework(roster_csv, files_dir, prefix = "hw1", pause = 1)
```

## Arguments

- roster_csv:

  Path to a CSV with a column named "handle".

- files_dir:

  Local folder whose contents are pushed into each repo.

- prefix:

  Assignment prefix. Each repo is named prefix-student.

- pause:

  Seconds to wait between students.

## Value

A data frame with one row per student: student, repo, status. Status is
"updated" or "error".

## Examples

``` r
if (FALSE) { # \dontrun{
set_org("ISTA421INFO521")
update_homework("roster.csv", "hw1_fixes", prefix = "hw1")
} # }
```
