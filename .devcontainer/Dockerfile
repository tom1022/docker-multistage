# Go development container (use Go 1.24+ so dlv installs cleanly)
FROM golang:1.24-bookworm

ARG USERNAME=vscode
ARG USER_UID=1000
ARG USER_GID=${USER_UID}

# Keep base image as-is; avoid extra apt packages for a minimal footprint

# Create non-root user for VS Code Remote - Containers
RUN groupadd --gid ${USER_GID} ${USERNAME} \
 && useradd -s /bin/bash --uid ${USER_UID} --gid ${USER_GID} -m ${USERNAME}

ENV GOPATH=/go
ENV PATH=${GOPATH}/bin:/usr/local/go/bin:${PATH}

# Pre-create Go directories and hand off ownership
RUN mkdir -p ${GOPATH}/bin ${GOPATH}/pkg ${GOPATH}/src \
 && chown -R ${USERNAME}:${USERNAME} ${GOPATH}

USER ${USERNAME}
WORKDIR /workspace

# Helpful Go tools for debugging and linting
RUN go install github.com/go-delve/delve/cmd/dlv@latest \
 && go install golang.org/x/tools/cmd/godoc@latest \
 && go install honnef.co/go/tools/cmd/staticcheck@latest

EXPOSE 8080

CMD ["sleep", "infinity"]
