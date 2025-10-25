# Tech Context

## Technologies Used

*   **NixOS**: The Linux distribution that is entirely configured in a declarative manner using the Nix package manager.
*   **Nix Package Manager**: The foundational technology for NixOS, used for declarative package management, system configuration, and reproducible builds.
*   **Nix Flakes**: The modern, experimental feature of Nix that provides a more structured and reproducible way to define Nix projects, inputs, and outputs. It enables easy sharing and composition of Nix configurations.
*   **Home-Manager**: A Nix module system that allows users to declaratively manage their user-specific configurations (dotfiles, user-level packages, services) using Nix. It integrates seamlessly with NixOS flakes.
*   **Git**: Version control system for managing the flake repository, tracking changes, and collaborating.

## Development Setup

*   **Operating System**: NixOS (for the target system), or any Linux distribution with Nix installed (for development/testing).
*   **Nix Installation**: A working Nix installation with `flakes` and `nix-command` enabled. This typically means setting `extra-experimental-features = nix-command flakes` in `~/.config/nix/nix.conf` or `/etc/nix/nix.conf`.
*   **Editor**: Any text editor compatible with Nix syntax highlighting (e.g., VS Code with Nix extension, Neovim with `nix-mode` or `nixd`).
*   **Terminal**: A shell environment (e.g., Bash, Zsh) capable of running Nix commands.

## Technical Constraints

*   **Nix Flakes are Experimental**: While widely used, Nix flakes are still considered experimental. This means their interface might change slightly in future Nix versions. However, the benefits of reproducibility and structure outweigh this risk for this project.
*   **Learning Curve**: Nix and NixOS have a steep learning curve due to their functional programming paradigm and unique approach to system configuration.
*   **Build Times**: Initial builds or significant changes can sometimes lead to long build times, especially for large packages or when the Nix store cache is not populated.
*   **Network Access**: Building new packages or updating `nixpkgs` inputs requires internet access to download sources and pre-built binaries from the Nix cache.

## Dependencies

*   **Nixpkgs**: The official Nix package collection, serving as the primary source for packages and NixOS modules.
*   **Home-Manager (as a flake input)**: To manage user environments declaratively.
*   Potentially other flake inputs for specific tools or modules (e.g., custom overlays, `nixos-hardware` for specific hardware configurations, `impermanence` for impermanent setups).

## Tool Usage Patterns

*   **`nixos-rebuild switch --flake .#myhostname`**: The primary command for applying system configuration changes. `--flake .#myhostname` specifies to use the current directory as the flake and target the `myhostname` configuration defined in `flake.nix`.
*   **`home-manager switch --flake .#myusername`**: Used for applying user-level configuration changes managed by Home-Manager.
*   **`nix flake update`**: To update all flake inputs (e.g., `nixpkgs`, `home-manager`) to their latest versions, updating `flake.lock`.
*   **`nix flake lock --override