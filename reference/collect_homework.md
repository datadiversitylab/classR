# Collect students submission

Clones each student's repository into a local folder, or pulls the
latest commits if it has already been cloned. Submissions land under
dest/prefix/student.

## Usage

``` r
collect_homework(roster_csv, prefix = "hw1", dest = ".")
```

## Arguments

- roster_csv:

  Path to a CSV with a column named "handle".

- prefix:

  Assignment prefix. Each repo is named prefix-student.

- dest:

  Folder to collect into. Defaults to the working directory.

## Value

A data frame with one row per student: student, repo, status. Status is
"cloned", "pulled", or "error".

## Details

This function uses git, not the API. git must be available on the
system. The token is read from GITHUB_PAT and passed to git for the
duration of each clone or pull.

## Examples

``` r
if (FALSE) { # \dontrun{
set_org("ISTA421INFO521")
collect_homework("roster.csv", prefix = "hw1", dest = "submissions")
} # }
```
