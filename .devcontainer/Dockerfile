ARG RUBY_VERSION=4

# Build stage for bws
FROM rust:latest AS bws-builder
RUN cargo install --locked --git https://github.com/bitwarden/sdk-sm bws

# Use devcontainer Ruby image as base
FROM mcr.microsoft.com/devcontainers/ruby:${RUBY_VERSION}

# Install dependencies
RUN apt-get update && apt-get install -y \
    chromium \
    chromium-driver \
    libvips \
    && rm -rf /var/lib/apt/lists/*

# Copy pre-built bws binary from build stage
COPY --from=bws-builder /usr/local/cargo/bin/bws /usr/local/bin/bws
RUN chmod +x /usr/local/bin/bws

# Ensure binding is always 0.0.0.0
ENV BINDING="0.0.0.0"
