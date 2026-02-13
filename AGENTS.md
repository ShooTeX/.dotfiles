# AGENTS.md - Development Guide for AI Coding Agents

This repository contains a Nix-based system configuration using nix-darwin for macOS and NixOS for Linux servers. It manages system configurations, home-manager settings, and service deployments.

## Repository Structure

```
.
├── flake.nix                 # Main flake with system configurations
├── hosts/                    # Host-specific configurations
│   ├── common/              # Shared configurations
│   │   ├── core/           # Core Nix settings, fonts
│   │   ├── darwin/         # macOS-specific settings
│   │   └── home/           # home-manager configurations
│   ├── STX-MacBook-Pro/    # macOS host config
│   ├── Eriks-MacBook-Pro/  # macOS host config
│   └── heisenberg/         # NixOS server config
└── pkgs/                   # Custom package definitions
```

## Build & Deployment Commands

### macOS (nix-darwin)
```bash
# Build and activate system configuration
darwin-rebuild switch --flake .#STX-MacBook-Pro
darwin-rebuild switch --flake .#Eriks-MacBook-Pro

# Build without activating
darwin-rebuild build --flake .#STX-MacBook-Pro

# Check configuration before applying
nix flake check
```

### NixOS (heisenberg)
```bash
# Build NixOS configuration
nixos-rebuild switch --flake .#heisenberg

# Deploy remotely using deploy-rs
nix run github:serokell/deploy-rs -- .#heisenberg

# Initial deployment with hardware detection
nixos-anywhere --flake .#heisenberg --generate-hardware-config nixos-facter facter.json <hostname>
```

### Testing & Validation
```bash
# Check flake syntax and evaluation
nix flake check

# Show flake outputs
nix flake show

# Update flake lock file
nix flake update

# Format Nix files
nixfmt **/*.nix

# Lint Nix files with statix
statix check .

# Update specific input
nix flake lock --update-input nixpkgs
```

### Secrets Management (SOPS)
```bash
# Edit encrypted secrets
sops hosts/heisenberg/secrets/main.enc.yaml

# Rotate encryption keys
sops updatekeys hosts/heisenberg/secrets/main.enc.yaml
```

## Code Style Guidelines

### File Structure
- Use modular configuration: split functionality into separate `.nix` files
- Place shared configs in `hosts/common/`
- Place host-specific configs in `hosts/<hostname>/`
- Group related services in subdirectories with `default.nix` importing them

### Nix Code Style

#### Formatting
- Use **2 spaces** for indentation (never tabs)
- Format all Nix files with `nixfmt` before committing
- Line length: prefer breaking at ~100 characters but not enforced

#### Imports and Structure
```nix
{ config, pkgs, lib, ... }:
{
  imports = [
    ./module1.nix
    ./module2.nix
  ];

  # Configuration here
}
```

#### Package References
```nix
# Use 'with pkgs' for multiple packages from same set
home.packages = with pkgs; [
  fd
  gitleaks
  git-crypt
];

# Avoid 'with' for single packages or when clarity needed
nativeBuildInputs = [
  pkgs.installShellFiles
  pkgs.unzip
];
```

#### Naming Conventions
- File names: lowercase with hyphens (e.g., `disk-config.nix`, `homepage-dashboard.nix`)
- Variables: camelCase (e.g., `secretKeyBaseFile`, `localDomain`)
- Attribute sets: use descriptive names matching their purpose
- Custom packages: use `pname` and `version` attributes

#### Attribute Ordering
1. Imports
2. Core settings (enable, basic config)
3. Complex nested configurations
4. Environment variables
5. File paths and secrets

Example:
```nix
{
  imports = [ ./monitoring ];
  
  services.dawarich = {
    enable = true;
    webPort = 5897;
    localDomain = "example.com";
    secretKeyBaseFile = config.sops.secrets."app/secret".path;
    
    database = {
      passwordFile = config.sops.secrets."app/password".path;
    };
    
    environment = {
      API_HOST = "api.example.com";
    };
  };
}
```

#### String Formatting
- Use double quotes for simple strings: `"example"`
- Use double single-quotes for multi-line: `''multi-line string''`
- Interpolation: `"${variable}"` or `''${expression}''`

### Custom Package Derivations
```nix
{ pkgs, lib }:

pkgs.stdenvNoCC.mkDerivation rec {
  pname = "package-name";
  version = "1.0.0";

  src = pkgs.fetchurl {
    url = "https://example.com/package-${version}.zip";
    hash = "sha256-...";
  };

  nativeBuildInputs = with pkgs; [ unzip ];

  installPhase = ''
    runHook preInstall
    mkdir -p $out/bin
    install -D package $out/bin/package
    runHook postInstall
  '';

  meta = with lib; {
    description = "Package description";
    homepage = "https://example.com";
    license = licenses.mit;
    platforms = platforms.darwin;
  };
}
```

## Git Workflow

### Git Configuration
- Default branch: `main`
- Merge strategy: fast-forward only (`merge.ff = only`)
- Pull strategy: fast-forward only (`pull.ff = only`)
- Auto-prune on fetch
- Auto setup remote on push

### Commit Guidelines
- Use conventional commit style when appropriate
- Keep commits focused and atomic
- Reference configuration paths in commit messages

## Common Tasks

### Adding a New Package
1. For system packages: add to `environment.systemPackages` in relevant config
2. For user packages: add to `home.packages` in home-manager config
3. For custom packages: create derivation in `pkgs/` directory

### Adding a New Service (NixOS)
1. Create service file in `hosts/heisenberg/services/<service>.nix`
2. Configure service with `services.<service>` attributes
3. Add secrets if needed in `.sops.yaml` and reference paths
4. Import in `hosts/heisenberg/services/default.nix`
5. Configure reverse proxy in `caddy.nix` if web-accessible

### Modifying Home Manager Settings
1. Edit files in `hosts/common/home/`
2. Use programs.<name>.enable = true pattern
3. Keep user-specific overrides in `hosts/<hostname>/`

### Creating Custom AI Agents
Agents are defined in `hosts/common/home/dev/ai/` using markdown files with YAML frontmatter.

#### Agent Structure
Location: `hosts/common/home/dev/ai/agents/<agent-name>.md`

```markdown
---
description: Brief description of agent's purpose
mode: primary|subagent
temperature: 0.7  # Optional: 0.0-1.0, higher = more creative
tools:
  bash: false     # Disable command execution
  write: false    # Disable file creation
  edit: false     # Disable file editing
---

Agent instructions and personality description here.
```

#### Agent Modes
- **primary**: Standalone agent that can be invoked directly by users
- **subagent**: Helper agent invoked by other agents via Task tool

#### Temperature Settings
- `0.0-0.3`: Focused, deterministic responses (security audits, code analysis)
- `0.4-0.6`: Balanced creativity and consistency (documentation)
- `0.7-1.0`: Creative, varied responses (brainstorming, ideation)

#### Tool Restrictions
Disable tools to constrain agent behavior:
- `bash: false` - Prevents command execution
- `write: false` - Prevents file creation
- `edit: false` - Prevents file modification
- Omit restrictions to allow all tools

#### Registration
Add agent to `hosts/common/home/dev/ai/default.nix`:

```nix
agents = {
  agent-name = ./agents/agent-name.md;
  # ... other agents
};
```

#### Example Agents
- **brainstorm** (primary, temp 0.7): Creative ideation without execution
- **docs-writer** (subagent, no bash): Technical documentation only
- **security-auditor** (subagent, no write/edit): Read-only security analysis

#### Deployment
After creating or modifying agents:
```bash
darwin-rebuild switch --flake .#STX-MacBook-Pro
```

## Error Handling

- Always use `lib.optionalString` for conditional strings
- Use `lib.mkIf` for conditional configuration blocks
- Validate paths with `builtins.pathExists` when necessary
- Throw descriptive errors for missing required files

## Testing Changes

Before committing:
1. Run `nix flake check` to validate syntax
2. Run `statix check .` to lint for common issues
3. Format with `nixfmt **/*.nix`
4. Test build: `darwin-rebuild build --flake .#<host>` (or `nixos-rebuild`)
5. Only deploy if build succeeds

## Notes for AI Agents

- This is a **declarative** system: changes require rebuilding
- Always check existing patterns in `hosts/common/` before creating new modules
- Secrets must be encrypted with SOPS (never commit plaintext secrets)
- Custom packages need proper hashing (use `nix-prefetch-url` for URLs)
- When unsure about module options, check: https://search.nixos.org/options
