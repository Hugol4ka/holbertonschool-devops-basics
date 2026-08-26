# Layer Observations

- Unoptimized checksum: a0e8bdd8a312de8e45d2cea454dee228ede781730bfc321d96a6fced1b634090
- Optimized checksum: a0e8bdd8a312de8e45d2cea454dee228ede781730bfc321d96a6fced1b634090
- Unoptimized size in bytes: 10417781
- Optimized size in bytes: 4123418
- Size reduction in bytes: 6294363
- Relevant history entries:
Unoptimized : RUN /bin/sh -c cp /mnt/build-payload.bin /tm…   6.3MB
Optimized: RUN /bin/sh -c cp /mnt/build-payload.bin /tm…   8.19kB

## Explanation

Explain why the final merged filesystem and the image's immutable layer storage report different facts about the deleted temporary file. Also identify which layer retains the temporary payload in the unoptimized image.

Docker images are built as a stack of immutable layers. Once a layer is written, its content is permanently stored and can never be modified — only hidden by a later layer.

In the unoptimized image, the `RUN cp ...` instruction created a separate layer containing the full 6 MiB payload. The later `RUN rm -f ...` instruction created a small marker (a 'whiteout') in a new layer, which tells the merged filesystem to hide the file from view. This is why `docker run` and exploring the container show no file, while `docker image history` still reports the `cp` layer at 6.3MB.

In the optimized image, cp, sha256sum, and rm all run within the same single RUN instruction, so the file is deleted before Docker captures the layer's final state. Its bytes are therefore never written to any layer, which is why the layer's recorded size is only 8.19kB instead of 6.3MB.
