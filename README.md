# NixOS N64 Emulation Module

A plug-and-play NixOS module for Nintendo 64 emulation using simple64.

## Features

- 🎮 Simple64 emulator (modern, user-friendly N64 emulator)
- 🔊 Fixed audio configuration (no distortion or crackling)
- 🖥️ OpenGL acceleration enabled
- 🎯 USB controller support configured automatically
- 🔧 32-bit graphics support for compatibility
- 📦 Single file, drop-in module

## Quick Start

### Option 1: Download and Import (Easiest)

1. Download `n64.nix` to your NixOS configuration directory:
```bash
sudo curl -o /etc/nixos/n64.nix https://raw.githubusercontent.com/dnova02/nixos-config/refs/heads/main/n64.nix
```

2. Add it to your `configuration.nix` imports:
```nix
imports = [
  ./hardware-configuration.nix
  ./n64.nix  # Add this line
];
```

3. Rebuild your system:
```bash
sudo nixos-rebuild switch
```

4. Launch simple64 from your application menu or terminal:
```bash
simple64-gui
```

### Option 2: Copy-Paste

1. Create `/etc/nixos/n64.nix` with the contents from this repo
2. Follow steps 2-4 above

### Option 3: Use as a Flake (Recommended for Git Workflows)

1. Add this module to your NixOS configuration's `flake.nix`:
```nix
{
  description = "NixOS configuration with N64 emulation";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    # Or use a specific branch: nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";

    n64-emulation = {
      url = "github:dnova02/nixos-config";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, n64-emulation, ... }: {
    nixosConfigurations.YOUR-HOSTNAME = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./configuration.nix
        n64-emulation.nixosModules.n64
      ];
    };
  };
}
```

2. Enable flakes in your `configuration.nix` if not already enabled:
```nix
nix.settings.experimental-features = [ "nix-command" "flakes" ];
```

3. Rebuild your system:
```bash
sudo nixos-rebuild switch --flake .#YOUR-HOSTNAME
```

## What's Included

- **simple64**: A modern fork of Mupen64Plus with better UI and defaults
- **Audio fix**: Wrapper script that prevents audio distortion/crackling
- **OpenGL support**: Hardware-accelerated graphics rendering
- **USB controller support**: Automatic udev rules for game controllers
- **32-bit compatibility**: Ensures maximum game compatibility

## Customization

This module focuses exclusively on simple64 for the best N64 experience. Controller support and audio fixes are already configured automatically.

If you need to customize the audio driver, you can set the `SDL_AUDIODRIVER` environment variable before launching:
```bash
SDL_AUDIODRIVER=alsa simple64-gui
```

Available audio drivers: `pulseaudio`, `alsa`, `pipewire`

## Troubleshooting

### Graphics Issues
If you encounter graphics problems, ensure your GPU drivers are properly configured in NixOS.

For NVIDIA:
```nix
services.xserver.videoDrivers = [ "nvidia" ];
```

For AMD:
```nix
services.xserver.videoDrivers = [ "amdgpu" ];
```

### Audio Issues
If you experience audio problems, the module automatically sets `SDL_AUDIODRIVER=pulseaudio` which works with both PulseAudio and PipeWire. If issues persist, try manually setting a different driver (see Customization section above).

## Requirements

- NixOS 23.05 or later
- GPU with OpenGL support
- N64 ROM files (not included)

## ROM Management

Place your ROM files in a dedicated directory, for example:
```bash
mkdir -p ~/Games/N64
```

Simple64 can open ROMs from any location through its file browser.

## About Simple64

Simple64 is a modern, actively-maintained N64 emulator that:
- Has a clean, intuitive UI
- Supports high-resolution rendering
- Includes performance optimizations
- Works great out of the box

## License

This module is provided as-is under the MIT License. The emulator software has its own licensing terms.

## Contributing

Found an issue or want to improve this module? Open an issue or PR!
