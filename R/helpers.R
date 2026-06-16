# Internal helpers. Not exported.

# default when left side is NULL
`%||%` <- function(a, b) if (is.null(a)) b else a

# package-level store for the organization login
.ghc <- new.env(parent = emptyenv())

# resolve the organization, with a clear error if it is not set
ghc_org <- function() {
  org <- get0("ORG", envir = .ghc, ifnotfound = "")
  if (!nzchar(org)) {
    stop("Organization not set. Call set_org(\"your-org\") first, or define ORG.",
         call. = FALSE)
  }
  org
}

# build the repo name from a prefix and a student handle
ghc_repo_name <- function(prefix, student) paste0(prefix, "-", student)

# create or update one file in a repo through the contents API.
# looks up the existing sha so it works whether the file is new or not.
ghc_push_file <- function(org, repo, local_path, repo_path, message = NULL) {
  raw <- readBin(local_path, "raw", file.info(local_path)$size)
  content <- gsub("\n", "", jsonlite::base64_enc(raw))

  sha <- tryCatch(
    gh::gh("GET /repos/{owner}/{repo}/contents/{path}",
           owner = org, repo = repo, path = repo_path)$sha,
    error = function(e) NULL
  )

  args <- list(
    "PUT /repos/{owner}/{repo}/contents/{path}",
    owner   = org,
    repo    = repo,
    path    = repo_path,
    message = message %||% paste(if (is.null(sha)) "Add" else "Update", repo_path),
    content = content
  )
  if (!is.null(sha)) args$sha <- sha

  do.call(gh::gh, args)
}
