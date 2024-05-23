{ config, pkgs, lib, ... }:
let
  isLinux = pkgs.stdenv.hostPlatform.isLinux;
  isDarwin = pkgs.stdenv.hostPlatform.isDarwin;
in
{
  imports = [];

  home.username = "akiva";
  home.homeDirectory = if isLinux then "/home/akiva" else "/Users/akiva";

  home.stateVersion = "23.11";

  programs.home-manager.enable = true;
  home.packages =  with pkgs; [bash git kitty tmux tmate pet gum fzf vim silver-searcher bat less curl wget axel dua liquidprompt obsidian dropbox rambox github-cli chezmoi kitty pinentry bitwarden-cli neovim fx ] ++ lib.optionals isLinux [ google-chrome libnotify rofi-wayland tofi pinentry ] ++ lib.optionals isDarwin [ ];
  programs.bash.enable = if isLinux then true else false;
  programs.wofi.enable = if isLinux then true else false;
  programs.git = {
    userName = "Akiva";
    userEmail = "bloch.akiva@gmail.com";
    enable = true;
  };
  home.shellAliases = {
    l = "ls -alh";
    nixswitch = if isLinux then "sudo nixos-rebuild switch --flake ~/personal-projects/nix-config#default --impure" else "sudo darwin-restart switch --flake ~/personal-projects/nix-config#default --impure";
    nixcheck = if isLinux then "sudo nixos-rebuild test --flake ~/personal-projects/nix-config#default --impure" else "sudo darwin-restart test --flake ~/personal-projects/nix-config#default --impure";
  };
  wayland.windowManager.hyprland.enable = if isLinux then true else false;
}
