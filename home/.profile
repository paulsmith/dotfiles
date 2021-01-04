#!/bin/bash

# Added by Nix
if [ -f "$HOME/.nix-profile/etc/profile.d/nix.sh" ]; then
    # shellcheck source=/dev/null
    source "$HOME/.nix-profile/etc/profile.d/nix.sh"
fi

if [ -f "$HOME/.bashrc" ]; then
    # shellcheck source=/dev/null
    source "$HOME/.bashrc"
fi

setup_paths() {
    # Add additional paths here
    local paths=(
        "/opt/homebrew/bin"
        "/opt/homebrew/sbin"
        "$HOME/.cargo/bin"
        "$HOME/go/bin"
        "$HOME/local/bin"
        "$HOME/local/zig"
    )

    for path in "${paths[@]}"; do
        [ -d "$path" ] && export PATH="$path:$PATH"
    done
}

setup_paths
