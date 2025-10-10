{ config , pkgs, ... }:

{
  programs.git = {
    enable = true;
    userName = config.specialArgs.myUserName;
    userEmail = config.specialArgs.myUserEmail;
  };
}
