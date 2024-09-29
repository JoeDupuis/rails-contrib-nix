{ config, pkgs, ... }:
{
  env = {
    LD_LIBRARY_PATH = "${config.devenv.profile}/lib";
    NIX_HARDENING_ENABLE = "";
  };

  enterShell = ''
    export C_INCLUDE_PATH="$C_INCLUDE_PATH:${pkgs.libxml2.dev}/include/libxml2"
  '';

  services = {
    postgres = {
      enable = true;
      initialDatabases = [
        { name = "activerecord_unittest";}
        { name = "activerecord_unittest2";}
      ];
    };
    mysql = {
      enable = true;
      settings = {
        mysqld = {
          default-time-zone = "+00:00";
        };
      };
      initialDatabases = [
        { name = "activerecord_unittest";}
        { name = "activerecord_unittest2";}
      ];
      ensureUsers = [
        {
          name = "rails";
          password = "";
          ensurePermissions = {
            "*.*" = "ALL PRIVILEGES";
          };
        }
      ];

    };
    redis.enable = true;
    memcached.enable = true;
  };

  scripts.start-services.exec = ''
    OVERMIND_PROCFILE="${config.procfile}" ${pkgs.overmind}/bin/overmind s
  '';

  packages = with pkgs; [
    docker-compose
    docker
    git
    glib
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
  languages.ruby.version = "3.3.5";

}
