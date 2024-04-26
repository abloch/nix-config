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
  home.packages = with pkgs; [
    bash git kitty tmux tmate pet gum fzf vim silver-searcher bat less curl wget axel dua liquidprompt obsidian dropbox rambox github-cli stow
  ] ++ lib.optionals isLinux [ 
    google-chrome waybar mako libnotify rofi-wayland tofi
  ] ++ lib.optionals isDarwin [
  ];
  programs.bash.enable = if isLinux then true else false;
  programs.wofi.enable = if isLinux then true else false;
  programs.git = {
    userName = "Akiva";
    userEmail = "bloch.akiva@gmail.com";
    enable = true;
  };
  home.shellAliases = {
    l = "ls -alh";
    nrb = if isLinux then "sudo nixos-rebuild switch --flake ~/personal-projects#default --impure" else "sudo darwin-restart switch --flake ~/personal-projects#default --impure";
  };
  wayland.windowManager.hyprland.enable = if isLinux then true else false;
}
