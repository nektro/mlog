---
title: "I've Switched to NixOS"
date: 2022-01-18T02:54:09-08:00
---

The original creation date on this article is 17 Jan 2022 and I've been running NixOS 21.05 since then. Previously I'd been running a mix of Debian and Ubuntu and I don't think I'll be switching back anytime soon. Granted, I have not officially performed an update in that time, though I do not suspect it going badly in the ways that other distributions have bricked my Linux installs in the past.

While only time will tell how long NixOS will stay with us, the ideas it brings to system management are incredible and I hope they stay around. I can confidently say that the system update to Nix 22.05 will likely go smoothly because I've already gotten my system to a brick-like state and recovered it in the past with ease.

NixOS is built on top of a custom purely functional programming language and interpreter aptly named Nix. In a system, the base file (which rarely ever needs to be changed beyond the initial setup) is `/etc/nixos/configuration.nix`. Mine is as follows (with a few comments removed for brevity):

```nix
{ config, pkgs, callPackage, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; 

  time.timeZone = "America/Los_Angeles";

  networking.useDHCP = false;
  networking.interfaces.eno1.useDHCP = true;
  networking.firewall.allowedTCPPorts = [ 8000 80 443 ];

  i18n.defaultLocale = "en_US.UTF-8";

  services.xserver.enable = true;
  services.xserver.displayManager.defaultSession = "none+i3";
  services.xserver.desktopManager.xterm.enable = false;
  services.xserver.layout = "us";
  services.xserver.xkbOptions = "eurosign:e";
  services.xserver.windowManager.i3 = {
    enable = true;
    extraPackages = with pkgs; [
      dmenu
      i3status
      i3lock
    ];
  };
  services.gvfs.enable = true;
  services.tumbler.enable = true;
  services.dbus.enable = true;

  sound.enable = true;
  hardware.pulseaudio.enable = true;

  users.users.meghan = {
    isNormalUser = true;
    extraGroups = [ "wheel" "docker" "kvm" ];
  };

  environment.systemPackages = with pkgs; [
    vim
    gnome3.adwaita-icon-theme
    virt-manager
  ];
  environment.pathsToLink = [ "/libexec" ];

  programs.dconf.enable = true;

  virtualisation.docker.enable = true;
  virtualisation.libvirtd.enable = true;

  system.stateVersion = "21.05"; 
}
```

Most of this file isn't too consequential, it setups my hardware and i3 window manager configuration, as well as my user and system services. I do want to bring our attention to one section in particular though that sets up my user account,

```nix
  users.users.meghan = {
    isNormalUser = true;
    extraGroups = [ "wheel" "docker" "kvm" ];
  };
```

This creates my account ensures it is a member of all the groups in `[ "wheel" "docker" "kvm" ]`. However one day I made the fateful 1-line mistake when editing this file.

```patch
   users.users.meghan = {
     isNormalUser = true;
-    extraGroups = [ "wheel" "docker" "kvm" ];
   };
```

After performing this change and commiting it with a `sudo nixos-rebuild switch` and a reboot, my user was no longer in any of those groups. The latter two don't mean much in this case, but not being in `wheel` meant I could no longer `sudo`, and there were no other accounts on my system!

On almost any other linux this would have been a fatal mistake, requireing booting into my computer with another OS and recovering my files. However with Nix, this was no issue at all. Thanks to the Nix language being declarative and purely functional, NixOS is able to perform perfect rollbacks and prompts the user to select which "generation" they'd like to boot into.

![](https://miro.medium.com/max/1322/0*N-0qKZwmEtqVMQ0V.png)

So my solution here was to reboot again and simply select the previous generation and continue on my way as if the mistake had never been made :D

Between that, and the perfect dependency management solution `shell.nix` brings to app development, I'm definitely a fan.

Some other must-have commands that make my Nix workflow an ease:

- `nix-collect-garbage`
- `nix-locate`

I'll be sure to post an update once I boot into 22.05 for the first time.

That’s all for today. Until next time!
