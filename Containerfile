FROM scratch AS build_files
COPY build_files /

FROM scratch AS repo_files
COPY repo_files /

# Base Image
FROM quay.io/fedora/fedora-bootc:43

# Make /opt immutable and able to be used by the package manager.
RUN rm -r /opt && mkdir /opt

RUN --mount=type=bind,from=build_files,source=/,target=/build_files \
    --mount=type=bind,from=repo_files,source=/,target=/repo_files \
    --mount=type=cache,dst=/var/cache \
    --mount=type=cache,dst=/var/log \
    --mount=type=tmpfs,dst=/tmp \
    /build_files/build.sh

# Verify final image and contents are correct.
RUN bootc container lint
