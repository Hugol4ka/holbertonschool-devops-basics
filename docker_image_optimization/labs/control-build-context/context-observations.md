# Build Context Observations

- Unfiltered context size: 2.10MB
- Filtered context size: 174 bytes
- Runtime result before `.dockerignore`: context-contains-local-only-data
- Runtime result after `.dockerignore`: context-clean

## Explanation

Explain why `.dockerignore` changes both the data transferred to the builder and the files available to later `COPY` or `ADD` instructions.

.dockerignore reduces the transfer size because excluded files are never sent as part of the build context, so less data travels to the Docker daemon. But more importantly, it also affects which files COPY can access: .dockerignore filters the build context before the daemon executes any Dockerfile instruction. Since excluded files never enter the context in the first place, COPY . . cannot copy them — not because it skips them, but because they simply don't exist in the space COPY operates on.
