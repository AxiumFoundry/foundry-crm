# Build stage for bws
FROM rust:latest AS bws-builder
RUN cargo install --locked --git https://github.com/bitwarden/sdk-sm bws

# Use official Ruby image as base
FROM ruby:3.4.7-trixie

# Install essential dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    curl \
    chromium \
    chromium-driver \
    git \
    gnupg2 \
    libpq-dev \
    postgresql-client \
    jq \
    sudo \
    unzip \
    vim \
    wget \
    # For Active Storage variants
    libvips \
    # For nokogiri
    libxml2-dev \
    libxslt-dev \
    && rm -rf /var/lib/apt/lists/*

# Copy pre-built bws binary from build stage
COPY --from=bws-builder /usr/local/cargo/bin/bws /usr/local/bin/bws
RUN chmod +x /usr/local/bin/bws

# Create non-root user
RUN useradd -m -s /bin/bash -G sudo vscode && \
    echo "vscode ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Set up the application directory
WORKDIR /workspaces/axium-foundry

# Copy Gemfile and Gemfile.lock for dependency installation
COPY --chown=vscode:vscode Gemfile Gemfile.lock ./

# Install Ruby dependencies as root to ensure proper permissions
USER root
RUN bundle config set --global system 'true' && \
    bundle config set --global jobs 4 && \
    bundle config set --global retry 3 && \
    bundle install && \
    chown -R vscode:vscode /usr/local/bundle

# Switch to vscode user
USER vscode

# Set up shell
RUN echo 'export PATH="/workspaces/axium-foundry/bin:$PATH"' >> ~/.bashrc
