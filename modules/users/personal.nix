{ ... }:
{
  imports = [
    ./config.nix
  ];

  userConfig = {
    userName = "alexdrydew";
    hostName = "alexdrydew";
    email = "aleksey.suhorosov@gmail.com";
    timeZone = "Europe/Belgrade";
  };
}
