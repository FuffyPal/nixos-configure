{ config , pkgs, ... }:

{
  programs.git = {
    enable = true;
    userName = "secret";
    userEmail = "secret@secret.secret";
  };
}
