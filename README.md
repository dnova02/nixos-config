# NixOS N64 Emulation Module

A plug-and-play NixOS module for Nintendo 64 emulation using simple64.

## Features

- 🎮 Simple64 emulator (modern, user-friendly N64 emulator)
- 🖥️ OpenGL acceleration enabled
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
simple64
```

### Option 2: Copy-Paste

1. Create `/etc/nixos/n64.nix` with the contents from this repo
2. Follow steps 2-4 above

## What's Included

- **simple64**: A modern fork of Mupen64Plus with better UI and defaults
- **OpenGL support**: Hardware-accelerated graphics rendering
- **32-bit compatibility**: Ensures maximum game compatibility

## Customization

The module is minimal by design. If you want to customize:

### Add Controllers Support

Add to your `configuration.nix`:
```nix
# USB controller permissions
services.udev.extraRules = ''
  SUBSYSTEM=="usb", ATTRS{idVendor}=="057e", MODE="0666"
'';
```

### Install Additional Emulators

Modify `n64.nix` to add more emulators:
```nix
environment.systemPackages = with pkgs; [
  simple64
  mupen64plus  # (Optional) Alternative N64 emulator
  retroarch    # (Optional) Multi-system emulator
];
```

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

### Permission Issues
If controllers aren't detected, add your user to the input group:
```nix
users.users.YOUR-USERNAME.extraGroups = [ "input" ];
```

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
