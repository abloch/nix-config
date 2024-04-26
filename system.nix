{ nixpkgs, pkgs, ... }:

let
  isLinux = pkgs.stdenv.hostPlatform.isLinux;
  isDarwin = pkgs.stdenv.hostPlatform.isDarwin;
  unsupported = builtins.abort "Unsupported platform";
in
{
  environment.systemPackages = with pkgs; [ tailscale ];
  services.openssh = {
    enable = true;
    listenAddresses = [ {addr = "0.0.0.0"; port = 22;}];
    startWhenNeeded = true;
  };
  services.tailscale.enable = true;

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.users.akiva = import ./home.nix;
  nixpkgs.config.permittedInsecurePackages = [
    "electron-25.9.0"
  ];
  nix.extraOptions = '' experimental-features = nix-command flakes '';
  hardware.opengl.enable = true;
  services.xserver = if isLinux then {
    enable = true;
    displayManager.sddm.enable = true ;
    windowManager.hypr.enable = true;
  } else {} ;
}
