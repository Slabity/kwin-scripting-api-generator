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
        
        # Use the actual Saxon 8.8 package (saxonb_8_8)
        saxon8 = pkgs.saxonb_8_8;
        
        # Create a saxon8 script that points to the correct executable
        saxon8Script = pkgs.writeScriptBin "saxon8" ''
          #!${pkgs.bash}/bin/bash
          exec ${saxon8}/bin/saxonb "$@"
        '';
      in
      {
        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            doxygen
            saxon8        # Include the actual Saxon 8.8 package
            saxon8Script  # Add our custom saxon8 wrapper
            libxml2       # For xmllint
            libxslt       # For xsltproc
            bash
            dos2unix      # In case of line ending issues
          ];

          shellHook = ''
            echo "KWin API generator environment ready!"
            echo "Run: bash ./kwin-scripting-api-generator.sh <kwin-source-dir> <output-file>"
            echo "Using Saxon version: $(${saxon8}/bin/saxonb -? | grep -i saxon)"
          '';
        };
      }
    );
}
