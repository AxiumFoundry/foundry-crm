#!/bin/bash
# Setup BWS environment variables globally in the devcontainer

if [ -n "$BWS_ACCESS_TOKEN" ] && command -v bws >/dev/null 2>&1; then
  echo "Setting up BWS environment variables..."

  # Create a temporary file with proper permissions
  BWS_ENV_FILE="/tmp/bws-env-$$.sh"
  touch "$BWS_ENV_FILE"
  chmod 600 "$BWS_ENV_FILE"

  # Export BWS secrets to a shell script with proper quoting
  # Use bws run to execute a command with secrets injected
  bws run -- sh -c 'env | grep -E "^AXIUM_FOUNDRY_" | while IFS= read -r line; do
    key="${line%%=*}"
    value="${line#*=}"
    printf "export %s=\"%s\"\n" "$key" "$value"
  done' > "$BWS_ENV_FILE"

  # Add mapping for AXIUM_FOUNDRY_ prefixed variables
  echo '# Map AXIUM_FOUNDRY_ prefixed variables' >> "$BWS_ENV_FILE"
  echo '[ -n "$AXIUM_FOUNDRY_RAILS_MASTER_KEY" ] && export RAILS_MASTER_KEY="$AXIUM_FOUNDRY_RAILS_MASTER_KEY"' >> "$BWS_ENV_FILE"
  echo '[ -n "$AXIUM_FOUNDRY_HONEYBADGER_API_KEY" ] && export HONEYBADGER_API_KEY="$AXIUM_FOUNDRY_HONEYBADGER_API_KEY"' >> "$BWS_ENV_FILE"

  # Copy to the standard location
  cp "$BWS_ENV_FILE" /tmp/bws-env.sh
  chmod 644 /tmp/bws-env.sh
  rm -f "$BWS_ENV_FILE"

  # Source the BWS env file in bashrc if not already added
  if ! grep -q "bws-env.sh" ~/.bashrc; then
    echo '# Load BWS environment variables' >> ~/.bashrc
    echo '[ -f /tmp/bws-env.sh ] && . /tmp/bws-env.sh' >> ~/.bashrc
  fi

  # Also source it immediately for the current session
  . /tmp/bws-env.sh

  echo "BWS environment variables configured successfully"
else
  echo "BWS not available or BWS_ACCESS_TOKEN not set - skipping BWS setup"
fi
