{ pkgs, lib, ... }:

# Mojo programming language module for NixOS/Nix flake setups
# Installs Mojo via uv pip as per official installation guide: https://mojolang.org/install/

let
  # Create an environment with Mojo installed using uv pip install
  mkMojoEnvironment =
    python:
    let
      env =
        pkgs.runCommand "mojo-${python.name}"
          {
            buildInputs = [
              python
              pkgs.uv
            ];
          }
          ''
            # Create virtual environment in output directory
            uv venv $out

            # Activate and install Mojo via uv pip (official method)
            source $out/bin/activate
            uv pip install mojo==1.0.0b1

            # Ensure the binary is executable
            chmod +x $out/bin/mojo 2>/dev/null || true
          '';
    in
    env;

in
{
  # Expose Mojo as a package in this module's output
  packages = {
    mojo = mkMojoEnvironment pkgs.python3;

    # Alternative with Python 3.11 if needed
    mojo-py3-11 = mkMojoEnvironment (pkgs.python311.withPackages (_: [ ]));
  };

  # Provide a convenience function for adding Mojo to custom environments
  config = {
    # Example usage in nixosConfigurations or flake outputs:
    # environment.systemPackages = [ modules.languages.mojo ];
    # Or in a development shell:
    # devShells.default = pkgs.mkShell {
    #   packages = with modules.languages; [ mojo ];
    # };
  };

  meta.description = "Mojo - A high-performance systems programming language";
}
