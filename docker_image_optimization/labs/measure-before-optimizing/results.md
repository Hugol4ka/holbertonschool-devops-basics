# Baseline Observations

- Image size in bytes: 371384114
- Largest non-base instruction and evidence: 8.44MB for build with "python:3.12-bookworm".
- Configured runtime user: empty string (""), meaning the container runs as root by default
- Unnecessary copied file or directory 1: test/
- Unnecessary copied file or directory 2: docs/

three optimization targets and the evidence supporting each one:
1-Add a .dockerignore — evidence: COPY . . copies 8.44MB including tests/, docs/, local-notes.txt, reports/, results.md, none of which the running API needs.
2- Configure a non-root USER — evidence: docker image inspect --format '{{json .Config.User}}' = "", docker exec image-lab-baseline whoami = root
3- change FROM python:3.12-bookworm to python:3.12-slim — evidence: base image layers include :592MB/200MB for apt-get/wget installs, versus final image size of 354MB

## Evidence-Based Optimization Targets

1.
2.
3.
