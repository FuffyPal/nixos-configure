{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;
    userName = specialArgs.GitUserName;
    userEmail = specialArgs.GitUserEmail;
  };
}
