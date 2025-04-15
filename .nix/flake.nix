{
  description = "Flake for svenvc/neojson";

  inputs = rec {
    flake-utils.url = "github:numtide/flake-utils/v1.0.0";
    nixpkgs.url = "github:NixOS/nixpkgs/release-24.11";
    pharo-vm-12 = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:rydnr/nix-flakes/pharo-vm-12.0.1519.2?dir=pharo-vm";
    };
  };
  outputs = inputs:
    with inputs;
    flake-utils.lib.eachDefaultSystem (system:
      let
        org = "svenvc";
        repo = "neojson";
        pname = "${repo}";
        tag = "v18";
        baseline = "NeoJSON";
        pkgs = import nixpkgs { inherit system; };
        description = "An elegant and efficient Smalltalk framework to read and write JSON converting to or from Smalltalk objects";
        license = pkgs.lib.licenses.mit;
        homepage = "https://github.com/svenvc/neojson";
        maintainers = with pkgs.lib.maintainers; [ ];
        nixpkgsVersion = builtins.readFile "${nixpkgs}/.version";
        nixpkgsRelease =
          builtins.replaceStrings [ "\n" ] [ "" ] "nixpkgs-${nixpkgsVersion}";
        shared = import ./shared.nix;
        svenvc-neojson-for = { bootstrap-image-name, bootstrap-image-sha256, bootstrap-image-url, pharo-vm }:
          let
            bootstrap-image = pkgs.fetchurl {
              url = bootstrap-image-url;
              sha256 = bootstrap-image-sha256;
            };
            src = ./../repository;
          in pkgs.stdenv.mkDerivation (finalAttrs: {
            version = tag;
            inherit pname src;

            strictDeps = true;

            buildInputs = with pkgs; [
            ];

            nativeBuildInputs = with pkgs; [
              pharo-vm
              pkgs.unzip
            ];

            unpackPhase = ''
              unzip -o ${bootstrap-image} -d image
              # cp -r ${src} src
            '';

            configurePhase = ''
              runHook preConfigure

              # load baseline
              ${pharo-vm}/bin/pharo image/${bootstrap-image-name} eval --save "EpMonitor current disable. NonInteractiveTranscript stdout install. [ Metacello new repository: 'filetree://${src}'; baseline: '${baseline}'; onConflictUseLoaded; load ] ensure: [ EpMonitor current enable ]"

              runHook postConfigure
            '';

            buildPhase = ''
              runHook preBuild

              # assemble
              ${pharo-vm}/bin/pharo image/${bootstrap-image-name} save "${pname}"

              mkdir dist
              mv image/${pname}.* dist/

              runHook postBuild
            '';

            installPhase = ''
              runHook preInstall

              mkdir -p $out
              cp -r ${pharo-vm}/bin $out
              cp -r ${pharo-vm}/lib $out
              cp -r dist/* $out/
              cp image/*.sources $out/
              mkdir $out/share
              pushd ${src}
              ${pkgs.zip}/bin/zip -r $out/share/src.zip .
              popd

              runHook postInstall
             '';

            meta = {
              longDescription = ''
                    NeoJSON is an elegant and efficient standalone Smalltalk framework to read and write JSON converting to or from Smalltalk objects.
              '';
              inherit description homepage license maintainers;
              mainProgram = "pharo";
              platforms = pkgs.lib.platforms.linux;
            };
        });
      in rec {
        defaultPackage = packages.default;
        devShells = rec {
          default = svenvc-neojson-12;
          svenvc-neojson-12 = shared.devShell-for {
            package = packages.svenvc-neojson-12;
            inherit org pkgs repo tag;
            nixpkgs-release = nixpkgsRelease;
          };
        };
        packages = rec {
          default = svenvc-neojson-12;
          svenvc-neojson-12 = svenvc-neojson-for rec {
            bootstrap-image-url = pharo-vm-12.resources.${system}.bootstrap-image-url;
            bootstrap-image-sha256 = pharo-vm-12.resources.${system}.bootstrap-image-sha256;
            bootstrap-image-name = pharo-vm-12.resources.${system}.bootstrap-image-name;
            pharo-vm = pharo-vm-12.packages.${system}.pharo-vm;
          };
        };
      });
}
