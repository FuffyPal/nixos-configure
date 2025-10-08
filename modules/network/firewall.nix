{ config , ... }:
{
  networking.firewall = {
    enable = true;
    logRefusedConnections = true;
    logRefusedUnicastsOnly = true;
    logReversePathDrops = true;
    logRefusedPackets = true;
    allowedUDPPorts = [ 
    53317
    ];
    allowedUDPPortRanges = [
    {
     from = 1714;
     to = 1764;
    }
    ];
    allowedTCPPorts = [ 
    53317
    ];
    allowedTCPPortRanges = [
    {
     from = 1714;
     to = 1764;
    }
    ];
    allowPing = false;
  };

}
