{ config, pkgs, ... }:
{
  cachix.enable = false;
  env = {
    LD_LIBRARY_PATH = "${config.devenv.profile}/lib";
    NIX_HARDENING_ENABLE = "";
    OVERMIND_PROCFILE="${config.procfile}";
    OBJC_DISABLE_INITIALIZE_FORK_SAFETY = "YES";
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
    ncurses
  ];

  languages.ruby.enable = true;
  languages.ruby.versionFile = ./.ruby-version;
}
