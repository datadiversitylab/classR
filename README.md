# classR

A minimal GitHub Classroom replacement in R. Run a course on GitHub
without GitHub Classroom: each student gets a private repo in a given
organization, starter files get pushed in, and the student is added
as a collaborator.

## Install

```r
# install.packages("remotes")
remotes::install_github("datadiversitylab/classR")
```

## How to use

```r
library(classR)

setup_github_token() # once: makes, checks, and saves a token
set_org("ISTA421INFO521") # each session

res <- assign_homework("roster.csv", "hw1_files", prefix = "hw1")
check_homework("roster.csv", prefix = "hw1")
update_homework("roster.csv", "hw1_fixes", prefix = "hw1")
collect_homework("roster.csv", prefix = "hw1", dest = "submissions")
```

Your roster is a CSV with a column named `handle`:

```
student1
student2
student3
```

## What each function does

- `setup_github_token()` opens the token page with the right scopes,
  verifies the token authenticates and carries `repo` and `admin:org`,
  and saves it to `~/.Renviron`.
- `set_org()` sets the organization used downstream.
- `assign_homework()` creates a repo per student, pushes starter files,
  adds the student.
- `check_homework()` reports which repos exist.
- `update_homework()` pushes file changes into existing repos.
- `collect_homework()` clones or pulls every submission locally.

## Limitations

- The organization must already exist.
- Files are pushed through the contents API, one file per commit.
- `update_homework()` overwrites files at the given paths.
- Collecting needs git on the system.
- Adding a collaborator sends an invitation the student must accept
  before they can push.

