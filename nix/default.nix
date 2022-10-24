
{ pkgs ? import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/3590f02e7d5760e52072c1a729ee2250b5560746.tar.gz") {} }:

pkgs.mkShell {
  buildInputs = [
	pkgs.kubectl
	pkgs.htop
	pkgs.tree
	pkgs.ansible
	pkgs.curl
	pkgs.mlocate
	pkgs.wget
	pkgs.make
	pkgs.feh
  ];
}
