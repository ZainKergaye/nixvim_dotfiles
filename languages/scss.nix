{ pkgs, ... }:
let
  # Not in nixpkgs. The npm release is a self-contained bundle with no
  # runtime dependencies, so it only needs node to run.
  some-sass-language-server = pkgs.stdenvNoCC.mkDerivation rec {
    pname = "some-sass-language-server";
    version = "2.3.9";

    src = pkgs.fetchurl {
      url = "https://registry.npmjs.org/${pname}/-/${pname}-${version}.tgz";
      hash = "sha512-9/w+pBSKrcZQKBO56k6DoMDk/1G6Q6214zTXcIM9ObsAZ5ic2qESk3BorCrd+fZNsCTH+KQlQIXCv5nCR606lw==";
    };

    nativeBuildInputs = [ pkgs.makeWrapper ];

    installPhase = ''
      runHook preInstall
      mkdir -p $out/lib/${pname}
      cp -r bin dist package.json $out/lib/${pname}
      makeWrapper ${pkgs.lib.getExe pkgs.nodejs} $out/bin/${pname} \
        --add-flags $out/lib/${pname}/bin/${pname}
      runHook postInstall
    '';

    meta = {
      description = "Language server for SCSS, Sass indented and SassDoc";
      homepage = "https://wkillerud.github.io/some-sass/";
      license = pkgs.lib.licenses.mit;
      mainProgram = pname;
    };
  };
in
{
  # Cross-file SCSS variables and mixins; cssls only sees one file.
  plugins.lsp.servers.somesass_ls = {
    enable = true;
    package = some-sass-language-server;
  };
}
