{ config, pkgs, ... }:

#
# NixOS N64 Emulation Module
#
# A plug-and-play module for Nintendo 64 emulation on NixOS.
# This module installs simple64 (a modern N64 emulator) and enables
# necessary graphics acceleration.
#
# Usage:
#   1. Copy this file to /etc/nixos/n64.nix
#   2. Add './n64.nix' to your configuration.nix imports
#   3. Run: sudo nixos-rebuild switch
#   4. Launch simple64 from your app menu or run 'simple64-gui' in terminal
#
# Requirements:
#   - GPU with OpenGL support
#   - N64 ROM files (provide your own legally obtained ROMs)
#

{
  # Install simple64 emulator
  # Simple64 is a modern, user-friendly fork of Mupen64Plus with:
  #   - Clean UI and good defaults
  #   - High-resolution rendering support
  #   - Active development and bug fixes
  environment.systemPackages = with pkgs; [
    simple64
    xorg.xcbutil
    xorg.xcbutilcursor  # Required for Qt xcb platform plugin

    # Optional: Uncomment to add alternative emulators
    # mupen64plus      # Classic N64 emulator
    # retroarch        # Multi-system emulator (includes N64 cores)
  ];

  # Enable graphics hardware acceleration
  # Required for proper graphics rendering and performance
  # The 32-bit support ensures maximum game compatibility
  #
  # Note: In NixOS 24.11+, hardware.opengl was renamed to hardware.graphics
  # and driSupport options are now enabled by default
  hardware.graphics = {
    enable = true;
    enable32Bit = true;  # Important for some N64 plugins
  };

  # Optional: USB controller support
  # Uncomment if you're using USB N64 controllers or adapters
  # services.udev.extraRules = ''
  #   SUBSYSTEM=="usb", ATTRS{idVendor}=="057e", MODE="0666"
  #   KERNEL=="js[0-9]*", MODE="0666"
  #   KERNEL=="event[0-9]*", MODE="0666"
  # '';

  # Optional: Add user to input group for controller access
  # Replace 'yourusername' with your actual username
  # users.users.yourusername.extraGroups = [ "input" ];
}
