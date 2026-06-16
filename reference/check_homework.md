# Check which student repositories exist

Looks up each student's repository in the organization and reports
whether it is present. Use this to confirm an assignment went out
cleanly, or to find who is missing before collecting work.

## Usage

``` r
check_homework(roster_csv, prefix = "hw1")
```

## Arguments

- roster_csv:

  Path to a CSV with a column named "handle".

- prefix:

  Assignment prefix. Each repo is named prefix-student.

## Value

A data frame with one row per student: student, repo, exists (logical).

## Examples

``` r
if (FALSE) { # \dontrun{
set_org("ISTA421INFO521")
status <- check_homework("roster.csv", prefix = "hw1")
status[!status$exists, ]
} # }
```
