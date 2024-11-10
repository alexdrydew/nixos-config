final: prev: {
  pnpm_8 = prev.pnpm_8.overrideAttrs (old: {
    version = "8.15.2";
    src = prev.fetchurl {
      url = "https://registry.npmjs.org/pnpm/-/pnpm-8.15.2.tgz";
      hash = "sha256-kLtdY4LLLLi41JWaB2s5U9hNHZQSFxcJe81BxxNE+hQ=";
    };
  });
}
