{ stdenv
, buildBazelPackage
, fetchgit
, bazel_7
, lib
, cctools
, git
}:
buildBazelPackage {
  pname = "bazel-lsp";
  version = "0.6.3";

  src = fetchgit {
    url = "https://github.com/cameron-martin/bazel-lsp.git";
    rev = "43d80e64bd80dcae07274a06867a92297dfd6863";
    sha256 = "sha256-BzSyUw+m7Kfp32fUCuCHtACAFrg+O0Y4pMLqKzcnLaE=";
  };

  bazel = bazel_7;

  LIBTOOL = lib.optionalString stdenv.hostPlatform.isDarwin "${cctools}/bin/libtool";

  nativeBuildInputs = [ git ];

  bazelTargets = [ "bazel-lsp" ];
  bazelBuildFlags = [
    "-c"
    "opt"
  ] ++ lib.optionals stdenv.cc.isClang [ "--cxxopt=-x" "--cxxopt=c++" "--host_cxxopt=-x" "--host_cxxopt=c++" ];

  removeRulesCC = false;
  removeLocalConfigCC = false;

  fetchAttrs = {
    sha256 = lib.fakeSha256;
  };

  buildAttrs.installPhase = ''
    runHook preInstall
    mkdir -p $out/bin
    install -Dm755 bazel-bin/bazel-lsp $out/bin/
    runHook postInstall
  '';
}
