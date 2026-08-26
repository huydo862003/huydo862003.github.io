This folder documents all the research I've conducted to converge on a solution for designing filesystem APIs on dbdocs/dbdiagram. This is to support the multifile DBML feature (which I have shipped in the compiler quite ago) on the cloud.

The compiler intentionally just needs a file system interface to resolve imports, etc. So the task of designing filesystem is quite isolated with the compiler's internals.

[[directory-index]]

There are a few constraints our systems have:

- Each user has multiple workspaces, each of which has a logical file system, in which files are stored.
- Each file can have permission settings.
- Almost every files are plain texts, not binary.
- Files can be very large, up to 20k LOC.
- A workspace can have tens or hundreds of files.
- Almost likely, we won't use specialized cloud-based storage solutions like S3, etc. We usually don't want the hussle of contacting devops and allocate more unique resources. Adding more servers is OK though, but need some justifications.
