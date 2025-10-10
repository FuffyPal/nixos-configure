{ pkgs, ... }:

{
  programs.git = {
    enable = true;
    userName = specialArgs.myUserName;
    userEmail = specialArgs.myUserEmail;
  };
}
