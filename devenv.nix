{ config, pkgs, ... }:

let
  vips = pkgs.callPackage ./vips.nix {
    inherit (pkgs.darwin.apple_sdk.frameworks) ApplicationServices Foundation;
    cgif = pkgs.callPackage ./cgif.nix {};
  };
in {
  env = {
    OVERMIND_PROCFILE = config.procfile;
  };

  enterShell = ''
    export C_INCLUDE_PATH="$C_INCLUDE_PATH:${pkgs.libxml2.dev}/include/libxml2"
  '';

  services = {
    postgres = {
      enable = true;
    };
    mysql = {
      enable = true;
      settings = {
        mysqld = {
          default-time-zone = "+00:00";
        };
      };
      ensureUsers = [
        {
          name = "rails";
          ensurePermissions = {
            "*.*" = "ALL PRIVILEGES";
          };
        }
      ];

    };
    redis.enable = true;
    memcached.enable = true;
  };


  packages = with pkgs; [
    docker-compose
    docker
    git
    glib
    glibc
    openssl
    libyaml
    libxml2
    redis
    sqlite
    yarn
    nodejs
    libmysqlclient
    imagemagick
    memcached
    ffmpeg
    mupdf
    poppler
    poppler_utils
    vips
    overmind
    ctags
    readline
    chromedriver
    chromium

    # Required by stable branches
    ncurses
  ];

  languages.ruby.enable = true;
  languages.ruby.version = "3.2.0";

}
