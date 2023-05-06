{ pkgs, ... }:
{


  env = {
    OVERMIND_PROCFILE = config.procfile;
  };

  enterShell = ''
    export C_INCLUDE_PATH="$C_INCLUDE_PATH:${pkgs.libxml2.dev}/include/libxml2"
  '';

  services = {
    postgres = {
      enable = true;
      initialDatabases = [
        { name = "activerecord_unittest"; }
        { name = "activerecord_unittest2"; }
      ];
    };
    mysql = {
      enable = true;
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
    git
    openssl_1_1
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
    vips
    overmind
  ];

  languages.ruby.enable = true;
  languages.ruby.version = "3.1.0";

}