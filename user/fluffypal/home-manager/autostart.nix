{ config , ... }:
{
  xdg.autostart = {
    enable = true;
    entries = [
      "${config.home.homeDirectory}/.local/share/flatpak/exports/share/applications/com.github.wwmm.easyeffects.desktop"
      "${config.home.homeDirectory}/.local/share/flatpak/exports/share/applications/dev.deedles.Trayscale.desktop"
      "${config.home.homeDirectory}/.local/share/flatpak/exports/share/applications/org.mozilla.Thunderbird.desktop"
    ];
  };
}
