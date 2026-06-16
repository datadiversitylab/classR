# classR: a minimal GitHub Classroom replacement in R

Runs a course on GitHub from R without GitHub Classroom. Each student
gets a fresh private repository in an organization, a set of starter
files is pushed into it, and the student is added as a collaborator.

## Details

Typical flow:
[`setup_github_token()`](https://datadiversitylab.github.io/classR/reference/setup_github_token.md)
once, then
[`set_org()`](https://datadiversitylab.github.io/classR/reference/set_org.md)
each session, then
[`assign_homework()`](https://datadiversitylab.github.io/classR/reference/assign_homework.md)
to create repos,
[`check_homework()`](https://datadiversitylab.github.io/classR/reference/check_homework.md)
to verify,
[`update_homework()`](https://datadiversitylab.github.io/classR/reference/update_homework.md)
to push fixes, and
[`collect_homework()`](https://datadiversitylab.github.io/classR/reference/collect_homework.md)
to pull submissions.

## See also

Useful links:

- <https://cromanpa94.github.io/ghclassroom/>

- Report bugs at <https://github.com/cromanpa94/ghclassroom/issues>

## Author

**Maintainer**: Cristian Roman-Palacios <cromanpa@arizona.edu>
