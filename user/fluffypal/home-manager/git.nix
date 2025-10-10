{ config , pkgs, ... }:

{
  programs.git = {
    enable = true;
    userName = specialArgs.userName;
    userEmail = specialArgs.userEmail;
  };
}
