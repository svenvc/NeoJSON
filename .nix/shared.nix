# .nix/shared.nix
#
# This file provides functions used by NeoJSON's Nix flake.
#
# MIT License
#
# Copyright (C) 2012 Sven Van Caekenberghe
#
# Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
rec {
  shellHook-for = { nixpkgs-release, org, package, repo, tag }:
    ''
      export PS1="\033[37m[\[\033[01;34m\]${org}/${repo}\033[01;37m|\033[01;33m${tag}[\033[00m\] "
      echo -e "\033[36m▗▖  ▗▖▗▞▀▚▖ ▄▄▄ \033[31m ▗▖ ▗▄▄▖ ▗▄▖ ▗▖  ▗▖  \033[32mhttps://github.com/${org}\033[0m"
      echo -e "\033[36m▐▛▚▖▐▌▐▛▀▀▘█   █\033[31m ▐▌▐▌   ▐▌ ▐▌▐▛▚▖▐▌  \033[33mhttps://github.com/${org}/${repo}:${tag}\033[0m"
      echo -e "\033[36m▐▌ ▝▜▌▝▚▄▄▖▀▄▄▄▀\033[31m ▐▌ ▝▀▚▖▐▌ ▐▌▐▌ ▝▜▌  \033[34mhttps://pharo.org\033[0m"
      echo -e "\033[36m▐▌  ▐▌ \033[0m       \033[31m▗▄▄▞▘▗▄▄▞▘▝▚▄▞▘▐▌  ▐▌  \033[35mhttps://github.com/nixos/nixpkgs/tree/${nixpkgs-release}\033[0m"
      echo
      echo -e "Thank you for using \033[32m${package.pname}\033[0m \033[33m${package.version}\033[0m \033[31m(${org}/${repo}-${tag})\033[0m and for your appreciation of Smalltalk."
    '';
  devShell-for = { nixpkgs-release, org, package, pkgs, repo, tag}:
    pkgs.mkShell {
      shellHook = shellHook-for {
          inherit nixpkgs-release org package repo tag;
      };
    };
  app-for = { package, entrypoint }: {
    type = "app";
    program = "${package}/bin/${entrypoint}.sh";
  };
}
