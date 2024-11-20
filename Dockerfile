# Start with a minimal base image for building Go applications
FROM golang:latest as builder

# Define an argument for the tag name, with an empty default
ARG tag_name=""

# Set the working directory
WORKDIR /app

# Install Git for cloning the repository
RUN apt-get update && apt-get install -y --no-install-recommends git && \
    rm -rf /var/lib/apt/lists/*

# Clone the croc repository
RUN git clone https://github.com/schollz/croc.git /app/croc

# Determine the latest tag if no tag_name is provided
RUN if [ -z "$tag_name" ]; then \
      tag_name=$(cd /app/croc && git fetch --tags && git tag -l | sort -V | tail -n 1); \
      echo "Using tag: $tag_name"; \
    fi && \
    git -C /app/croc checkout tags/$tag_name -b build;

# Build the application
RUN cd /app/croc && go build -o /app/croc/croc .

# Create a smaller final image
FROM debian:stable-slim

# Set up certificates and dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates && \
    rm -rf /var/lib/apt/lists/*

# Copy the croc binary from the builder stage
COPY --from=builder /app/croc/croc /usr/local/bin/croc

# Set the entrypoint to the croc binary
ENTRYPOINT ["croc"]

# Default command (can be overridden)
CMD ["--help"]
