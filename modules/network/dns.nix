{ config, ... }:
{
  networking.nameservers = [
    "9.9.9.9#dns.quad9.net"
    "1.1.1.1#one.one.one.one" 
    "1.0.0.1#one.one.one.one"
    "149.112.112.112#dns.quad9.net"
  ];
  services.resolved = {
    enable = true;
    dnssec = "true";
    llmnr = "false";
    domains = [ 
      "~." 
    ];
    fallbackDns = [
      "9.9.9.9#dns.quad9.net"
      "1.1.1.1#one.one.one.one"
      "149.112.112.112#dns.quad9.net"
      "1.0.0.1#one.one.one.one" 
    ];
    dnsovertls = "true";
  };

}
