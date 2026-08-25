# Base Image Decision

| Candidate | Size in bytes | Runtime result | Notes |
|---|---:|---|---|
| Ubuntu 24.04 | 28890846 | {"runtime":"posix-shell","status":"ok"}| use glibc, package manager apt |
| Debian 12 slim | 28120329 | {"runtime":"posix-shell","status":"ok"} | use glibc, 
but lighter than basic Ubuntu, good compatibility/size compromise|
| Alpine 3.22 | 4123676 | {"runtime":"posix-shell","status":"ok"} | use musl libc,7x lighter, but potentially incompatible with libs that specifically rely on glibc |

## Selected Base

- Selection: Alpine 3.22
- Compatibility evidence: for this application, we don't need glibc, so we prefer Alpine beacause is lighter. 
- Why this is not a universal choice: Debian slim would be safer than Alpine for an application that depends on precompiled Python libraries with native C extensions (e.g.psycopg2), because these are often compiled against glibc and may fail or behave unpredictably when run against Alpine's musl libc.
- Version tag versus digest: A version tag (e.g. 3.22) can change silently over time without any action on the Dockerfile, since the maintainer can republish a patched image under the same tag — so two builds at different dates aren't guaranteed to use the exact same content. A digest (sha256:...) is immutable: it always resolves to the exact same content. Tags are still preferred during development because they are human-readable and let the image benefit from maintainer patches automatically. However, a digest is required when true reproducibility matters (e.g. production or security audits), since it's the only way to guarantee the base image never changes underneath you
