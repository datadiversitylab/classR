# Set up and verify a GitHub token

Opens the GitHub token page with the right scopes pre-selected, takes
the token you paste back, checks that it authenticates and that it
carries the scopes this package needs (repo and admin:org), then saves
it to ~/.Renviron so it loads in future sessions.

## Usage

``` r
setup_github_token(description = "classR")
```

## Arguments

- description:

  Label shown on GitHub for the new token.

## Value

The authenticated login, invisibly.

## Examples

``` r
if (FALSE) { # \dontrun{
setup_github_token()
} # }
```
