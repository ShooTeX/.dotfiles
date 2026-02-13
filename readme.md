# 🏠 STX/DOTTEX Dotfiles

[![Nix](https://img.shields.io/badge/Nix-Flakes-blue?logo=nixos)](https://nixos.org)
[![macOS](https://img.shields.io/badge/macOS-nix--darwin-black?logo=apple)](https://github.com/LnL7/nix-darwin)
[![NixOS](https://img.shields.io/badge/NixOS-24.05-blue?logo=nixos)](https://nixos.org)

A declarative, reproducible system configuration for macOS and NixOS using Nix Flakes. This repository manages complete system configurations including packages, services, dotfiles, and custom AI coding agents.

## ✨ Features

- **🔄 Declarative Configuration**: Everything defined in code, version-controlled and reproducible
- **🍎 macOS Support**: Full nix-darwin integration for macOS systems
- **🐧 NixOS Server**: Complete server configuration with automated deployments
- **🏠 Home Manager**: User-level configurations for shells, editors, and development tools
- **🔐 Secrets Management**: Encrypted secrets using SOPS (SOPS-nix)
- **🤖 AI Agents**: Custom AI coding agents with specialized capabilities
- **📦 Custom Packages**: Custom Nix derivations for tools not in nixpkgs
- **🚀 Remote Deployment**: Automated deployment with deploy-rs and nixos-anywhere

## 📋 Prerequisites

### For macOS

1. **Install Nix** (multi-user installation recommended):
   ```bash
   sh <(curl -L https://nixos.org/nix/install)
   ```

2. **Enable Flakes** (add to `~/.config/nix/nix.conf` or `/etc/nix/nix.conf`):
   ```
   experimental-features = nix-command flakes
   ```

3. **Install nix-darwin**:
   ```bash
   nix run nix-darwin -- switch --flake ~/.dotfiles#STX-MacBook-Pro
   ```

### For NixOS

NixOS comes with Nix pre-installed. Enable flakes in your configuration:

```nix
nix.settings.experimental-features = [ "nix-command" "flakes" ];
```

## 🚀 Quick Start

### Initial Setup

1. **Clone this repository**:
   ```bash
   git clone https://github.com/yourusername/dotfiles.git ~/.dotfiles
   cd ~/.dotfiles
   ```

2. **Choose your deployment method**:

   **For macOS (STX-MacBook-Pro or Eriks-MacBook-Pro)**:
   ```bash
   darwin-rebuild switch --flake .#STX-MacBook-Pro
   ```

   **For NixOS (heisenberg server)**:
   ```bash
   nixos-rebuild switch --flake .#heisenberg
   ```

3. **Verify installation**:
   ```bash
   nix flake check
   ```

### Daily Usage

**Apply configuration changes**:
```bash
# macOS
darwin-rebuild switch --flake .#STX-MacBook-Pro

# NixOS
nixos-rebuild switch --flake .#heisenberg
```

**Update dependencies**:
```bash
nix flake update
darwin-rebuild switch --flake .#STX-MacBook-Pro
```

**Test before applying**:
```bash
# Build without activating
darwin-rebuild build --flake .#STX-MacBook-Pro

# Check for errors
nix flake check
```

## 📁 Repository Structure

```
.
├── flake.nix                      # Main flake configuration
├── flake.lock                     # Locked dependency versions
├── AGENTS.md                      # AI agent development guide
│
├── hosts/
│   ├── common/                    # Shared configurations
│   │   ├── core/                 # Core Nix settings, fonts, system defaults
│   │   ├── darwin/               # macOS-specific settings (Homebrew, etc.)
│   │   └── home/                 # Home Manager configurations
│   │       ├── core/             # Shell, git, editor configs
│   │       └── dev/              # Development tools and AI agents
│   │           └── ai/           # AI agent definitions
│   │               └── agents/   # Individual agent .md files
│   │
│   ├── STX-MacBook-Pro/          # Primary macOS configuration
│   │   └── darwin/               # Host-specific macOS settings
│   │
│   ├── Eriks-MacBook-Pro/        # Secondary macOS configuration
│   │
│   └── heisenberg/               # NixOS server configuration
│       ├── configuration.nix     # Main system config
│       ├── disk-config.nix       # Disk partitioning (disko)
│       ├── users.nix             # User accounts
│       ├── sops.nix              # Secrets configuration
│       ├── secrets/              # Encrypted secrets (SOPS)
│       └── services/             # Service configurations
│           ├── caddy.nix         # Reverse proxy
│           ├── immich.nix        # Photo management
│           ├── dawarich.nix      # Location tracking
│           └── ...               # Other services
│
└── pkgs/                          # Custom package definitions
    ├── aerospace.nix              # Window manager
    ├── distant.nix                # Remote development
    ├── http4k.nix                 # Kotlin HTTP toolkit
    └── lazygit.nix                # Git TUI
```

## 🎯 Key Components

### System Configurations

- **STX-MacBook-Pro**: Primary development machine (Apple Silicon)
- **Eriks-MacBook-Pro**: Secondary macOS machine (Apple Silicon)
- **heisenberg**: NixOS server running self-hosted services

### Managed Services (NixOS)

The heisenberg server runs several self-hosted services:
- **Caddy**: Reverse proxy with automatic HTTPS
- **Immich**: Photo and video management
- **Dawarich**: Location tracking and visualization
- **Homepage Dashboard**: Service dashboard
- **Borgmatic**: Automated backups

### Home Manager

User-level configurations managed by home-manager:
- Shell environments (zsh, bash)
- Development tools (neovim, git, tmux)
- Terminal emulators (WezTerm)
- Programming languages (Node.js, Python, Rust, Go)
- Custom AI coding agents

### Custom AI Agents

This repository includes custom AI coding agents with specialized capabilities:

- **agent-creator**: Creates new AI agents with proper configuration
- **brainstorm**: Creative ideation without code execution
- **docs-writer**: Technical documentation specialist
- **eslint-expert**: ESLint configuration and debugging
- **readme-writer**: Comprehensive README generation (you're reading its work!)
- **security-auditor**: Security analysis and vulnerability detection

**Using AI Agents**:
```bash
# Agents are automatically available after rebuilding
# See AGENTS.md for detailed usage and creation guide
```

## 🛠️ Common Tasks

### Adding Packages

**System-wide packages** (requires sudo/rebuild):
```nix
# Edit hosts/common/darwin/default.nix (macOS)
# or hosts/heisenberg/configuration.nix (NixOS)
environment.systemPackages = with pkgs; [
  your-package
];
```

**User packages** (via home-manager):
```nix
# Edit hosts/common/home/default.nix
home.packages = with pkgs; [
  your-package
];
```

**Custom packages**:
```nix
# Create pkgs/your-package.nix
{ pkgs, lib }:
pkgs.stdenvNoCC.mkDerivation {
  pname = "your-package";
  version = "1.0.0";
  # ... derivation details
}
```

### Adding Services (NixOS)

1. Create service configuration:
   ```nix
   # hosts/heisenberg/services/myservice.nix
   { config, pkgs, ... }:
   {
     services.myservice = {
       enable = true;
       # ... configuration
     };
   }
   ```

2. Import in `hosts/heisenberg/services/default.nix`

3. Configure reverse proxy in `hosts/heisenberg/services/caddy.nix` if web-accessible

4. Deploy:
   ```bash
   nixos-rebuild switch --flake .#heisenberg
   ```

### Managing Secrets

This repository uses SOPS for encrypted secrets:

```bash
# Edit secrets (requires GPG key)
sops hosts/heisenberg/secrets/main.enc.yaml

# Reference in configuration
config.sops.secrets."service/password".path
```

### Creating Custom AI Agents

See [AGENTS.md](AGENTS.md) for comprehensive guide. Quick example:

```markdown
<!-- hosts/common/home/dev/ai/agents/my-agent.md -->
---
description: My custom agent
mode: primary
temperature: 0.7
tools:
  bash: false
---

Agent instructions here...
```

Register in `hosts/common/home/dev/ai/default.nix` and rebuild.

## 🚢 Deployment

### macOS Deployment

```bash
# Build and activate
darwin-rebuild switch --flake .#STX-MacBook-Pro

# Build without activating (test first)
darwin-rebuild build --flake .#STX-MacBook-Pro

# Check for issues
nix flake check
```

### NixOS Deployment

**Local deployment**:
```bash
nixos-rebuild switch --flake .#heisenberg
```

**Remote deployment** (using deploy-rs):
```bash
nix run github:serokell/deploy-rs -- .#heisenberg
```

**Initial deployment** (using nixos-anywhere):
```bash
nixos-anywhere --flake .#heisenberg \
  --generate-hardware-config nixos-facter facter.json \
  <hostname-or-ip>
```

## 🔧 Maintenance

### Update Dependencies

```bash
# Update all inputs
nix flake update

# Update specific input
nix flake lock --update-input nixpkgs

# Apply updates
darwin-rebuild switch --flake .#STX-MacBook-Pro
```

### Garbage Collection

```bash
# Remove old generations (macOS)
nix-collect-garbage -d

# Remove old generations (NixOS)
sudo nix-collect-garbage -d

# Optimize Nix store
nix-store --optimise
```

### Code Quality

```bash
# Format Nix files
nixfmt **/*.nix

# Lint with statix
statix check .

# Check flake
nix flake check

# Show flake outputs
nix flake show
```

## 📚 Documentation

- **[AGENTS.md](AGENTS.md)**: Comprehensive guide for AI agents and development workflows
- **[Nix Manual](https://nixos.org/manual/nix/stable/)**: Official Nix documentation
- **[nix-darwin Manual](https://daiderd.com/nix-darwin/manual/)**: macOS-specific documentation
- **[Home Manager Manual](https://nix-community.github.io/home-manager/)**: User configuration guide
- **[NixOS Options](https://search.nixos.org/options)**: Search available configuration options

## 🤝 Contributing

This is a personal dotfiles repository, but contributions are welcome:

1. Fork the repository
2. Create a feature branch
3. Make your changes following the code style in [AGENTS.md](AGENTS.md)
4. Test with `nix flake check` and `darwin-rebuild build`
5. Submit a pull request

### Code Style

- **2 spaces** for indentation
- Format with `nixfmt` before committing
- Use modular configuration (split into logical files)
- Follow naming conventions in [AGENTS.md](AGENTS.md)
- Test builds before committing

## 🐛 Troubleshooting

### Common Issues

**"error: experimental Nix feature 'flakes' is disabled"**
```bash
# Add to ~/.config/nix/nix.conf or /etc/nix/nix.conf
experimental-features = nix-command flakes
```

**"error: getting status of '/nix/store/...': No such file or directory"**
```bash
# Rebuild the flake lock
nix flake update
```

**Build fails with "hash mismatch"**
```bash
# Update the hash in the derivation
nix-prefetch-url <url>
```

**macOS: "error: refusing to create Nix store volume"**
```bash
# Reinstall Nix with proper volume creation
sh <(curl -L https://nixos.org/nix/install) --daemon
```

### Getting Help

- Check [AGENTS.md](AGENTS.md) for development guidelines
- Search [NixOS Discourse](https://discourse.nixos.org/)
- Browse [nix-darwin issues](https://github.com/LnL7/nix-darwin/issues)
- Review [Home Manager issues](https://github.com/nix-community/home-manager/issues)

## 📝 License

This project is personal configuration and is provided as-is for reference and inspiration. Feel free to use, modify, and adapt for your own needs.

## 🙏 Acknowledgments

- [NixOS](https://nixos.org/) - The Nix package manager and NixOS
- [nix-darwin](https://github.com/LnL7/nix-darwin) - Nix modules for macOS
- [Home Manager](https://github.com/nix-community/home-manager) - User environment management
- [SOPS-nix](https://github.com/Mic92/sops-nix) - Secrets management
- [deploy-rs](https://github.com/serokell/deploy-rs) - NixOS deployment tool

---

**Note**: This README was generated by a custom AI agent. See the `readme-writer` agent in `hosts/common/home/dev/ai/agents/` for details.
