# System Patterns

## System Architecture
The NixOS configuration will be structured around a [Nix flake](https://nixos.wiki/wiki/Flakes) as the central entry point. This flake will manage all system-wide configurations, user-specific settings, and installed applications.

flowchart TD
    A[flake.nix] --> B(inputs: nixpkgs, home-manager, etc.)
    A --> C(outputs: nixosConfigurations, homeConfigurations, devShells, packages, etc.)
    C --> D[nixosConfigurations.myhostname]
    D --> E[./hosts/myhostname/configuration.nix]
    E --> F(imports: ./modules/hardware, ./modules/desktop, ./modules/users, etc.)
    E --> G(host-specific overrides)
    F --> H(shared configuration modules)
    C --> I[homeConfigurations.myuser]
    I --> J[./home/myuser/home.nix]
    J --> K(imports: ./modules/home/desktop, ./modules/home/tools, etc.)
    J --> L(user-specific overrides)

## Key Technical Decisions

### 1. Flake as Single Source of Truth
*   `flake.nix` will define all inputs (e.g., `nixpkgs`, `home-manager`, custom overlays) and outputs (e.g., `nixosConfigurations`, `homeConfigurations`, `devShells`, custom packages).
*   All system and user configurations will originate from this `flake.nix`.

### 2. Modular Configuration
*   **Hosts Directory (`hosts/`)**: Each distinct NixOS machine (e.g., `desktop`, `laptop`, `server`) will have its own subdirectory within `hosts/`. This directory will contain the primary `configuration.nix` for that host, which imports shared modules and applies host-specific settings.
*   **Modules Directory (`modules/`)**: Shared configuration logic will reside in `modules/`. This includes:
    *   `hardware/`: Hardware-specific configurations (e.g., bootloader, kernel modules, file systems).
    *   `desktop/`: Desktop environment configurations (e.g., Plasma, GNOME, XMonad).
    *   `users/`: User account definitions and global user settings.
    *   `services/`: System services (e.g., networking, printing, security).
    *   `programs/`: Configuration for system-wide programs.
    *   `home/`: Home-Manager specific modules for user-level configurations (e.g., shell, editor, git).
*   **Overlays Directory (`overlays/`)**: Custom package definitions or modifications to `nixpkgs` will be placed here.
*   **Packages Directory (`pkgs/`)**: Custom Nix expressions for packages not available in `nixpkgs` or for local development tools.

### 3. Home-Manager for User Configuration
*   `home-manager` will be integrated as a flake input to manage user-specific packages, dotfiles, and environmental settings.
*   Each user will have a dedicated `home.nix` file (e.g., `home/myuser/home.nix`), importing shared home modules from `modules/home/`.

### 4. Git for Version Control
*   The entire Nix flake repository will be managed with Git, allowing for detailed history tracking, easy rollbacks, and collaborative development.

### 5. Impermanence (Optional, Future Consideration)
*   For advanced setups, consider integrating solutions for impermanence (e.g., `tmpfs` for `/tmp`, `impermanence` module) to further enhance reproducibility and system cleanliness.

## Design Patterns in Use

*   **Modular Design**: Breaking down the configuration into small, reusable Nix modules.
*   **Convention Over Configuration**: Establishing clear directory structures and naming conventions (e.g., `hosts/hostname/`, `modules/category/`) to reduce boilerplate and improve discoverability.
*   **Input Pinning**: Using `flake.lock` to pin all flake inputs, ensuring deterministic builds.
*   **Abstraction**: Encapsulating complex configurations within modules, exposing only necessary options.

## Component Relationships

*   `flake.nix` orchestrates all other components.
*   `nixosConfigurations` link specific host configurations (`hosts/hostname/configuration.nix`) to the flake outputs.
*   `homeConfigurations` link specific user home configurations (`home/username/home.nix`) to the flake outputs, managed by `home-manager`.
*   Modules are imported into host and home configurations.
*   Overlays are applied globally to `nixpkgs`.

## Critical Implementation Paths

1.  **Initial Flake Setup**: Creating `flake.nix` and `flake.lock`.
2.  **Basic NixOS Host Configuration**: Defining a minimal `configuration.nix` for a single host.
3.  **User Setup with Home-Manager**: Integrating `home-manager` and defining a user's home configuration.
4.  **Adding Shared Modules**: Creating and importing common modules for hardware, desktop, and services.
5.  **Applying Updates**: Using `nixos-rebuild switch --flake .#myhostname` for system updates.