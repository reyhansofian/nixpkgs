{ config, pkgs, lib, modulesPath, inputs, ... }:

{
  users.defaultUserShell = pkgs.zsh;
  environment.shells = with pkgs; [ zsh ];
  fonts.fonts = with pkgs; [
    (nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" ]; })
  ];

  virtualisation.docker.enable = true;

  services.xserver.enable = true;
  services.sshd.enable = true;
#   ssh.startAgent = true;
  services.ssh = {
    startAgent = true;
    knownHosts = [
      {
        hostNames = "github.com";
        publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOMqqnkVzrm0SdG6UOoqKLsabgH5C9okWi0dh2l9GKJl";
      }
    ];
  };
}