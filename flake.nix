{
  description = "KWin scripting API generator environment";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            doxygen
            saxon
            libxml2  # For xmllint
            libxslt  # For xsltproc
            bash
          ];

          shellHook = ''
            echo "KWin API generator environment ready!"
            echo "Run: ./kwin-scripting-api-generator.sh <kwin-source-dir> <output-file>"
          '';
        };
      }
    );
}
