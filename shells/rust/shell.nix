{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  strictDeps = true;

  nativeBuildInputs = with pkgs; [
    rustc
    cargo
    rustfmt
    clippy
    rust-analyzer
  ];

  RUST_BACKTRACE = "1";
  RUST_SRC_PATH = "${pkgs.rustPlatform.rustLibSrc}";
}