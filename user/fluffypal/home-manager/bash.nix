{ config , ... }:
{
  programs.bash = {
    enable = true;
    historyControl = [ "erasedups" "ignoredups" ];
    historyFileSize = 2000;
    historySize = 1000;
    shellAliases = {
      ls = "ls --color=auto";
      l = "ls --color=auto";
      ll = "ls -lh --color=auto";
      la = "ls -lha --color=auto";
      grep = "grep --color=auto";
      cat = "lolcat";
    };
    enableCompletion = true;
    initExtra = "shopt -s histappend";
    bashrcExtra = ''
        PS1="\[\e[38;2;255;171;185m\]\u@\h \[\e[38;2;180;200;255m\]\w\[\e[0m\]\$ "

        case "$TERM" in
          xterm*|vte*)
              PS1='\[\e]0;\u@\h: \w\a\]'$PS1
              ;;
        esac
      '';
  };
}
