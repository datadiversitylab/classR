# Set the GitHub organization

Stores the organization login used by all other functions in the
package. Call this once per session before creating or collecting
repositories.

## Usage

``` r
set_org(org)
```

## Arguments

- org:

  Organization login, for example "ISTA421INFO521".

## Value

The organization login, invisibly.

## Examples

``` r
if (FALSE) { # \dontrun{
set_org("ISTA421INFO521")
} # }
```
