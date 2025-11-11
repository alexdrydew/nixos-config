final: prev: {
  pnpm_9 = prev.pnpm_9.overrideAttrs (old: {
    version = "9.15.4";
    src = prev.fetchurl {
      url = "https://registry.npmjs.org/pnpm/-/pnpm-9.15.4.tgz";
      hash = "sha256-m+5ZxzE6IWciwHnB4iFg3qf4jfTgw0ULHXsBuIIzbGo=";
    };
  });
}
