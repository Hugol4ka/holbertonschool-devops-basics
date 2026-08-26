# Multi-Stage Observations

- Single-stage output: {"service":"greeter","status":"ok"}
- Multi-stage output: {"service":"greeter","status":"ok"}
- Single-stage size in bytes: 76210670 bytes
- Multi-stage size in bytes: 1271843 bytes
- Configured runtime user: 65532:65532
- `/bin/sh` override result: exec: "/bin/sh": stat /bin/sh: no such file or directory

## Explanation

Explain why the missing shell is expected and why application behavior still requires a separate test.

**Why failure is expected:** `scratch` contains no files other than those explicitly copied — in this case, just the `greeter` binary. `/bin/sh` was never copied into the image, so it literally does not exist on disk, and Docker cannot execute a file that isn't there. This also reflects a security benefit: with no shell present, an attacker who compromised the running binary would have no interactive tool to explore the container.

**Why this does not replace functional testing:** This test only checks for the absence of a shell — it never touches the `greeter` binary, its output, or its logic. The real functional guarantees come from elsewhere: `go test ./...` in the builder stage, and the `docker run multistage-lab:optimized` check confirming the exact `{"service":"greeter","status":"ok"}` output.
