{ ... }:
{
  imports = [
    ./config.nix
  ];

  userConfig = {
    userName = "alexdrydew";
    hostName = "alexdrydew";
    email = "alexdrydew@toloka.ai";
    timeZone = "Europe/Belgrade";
  };
}
