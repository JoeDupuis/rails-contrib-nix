{ pkgs, ... }:
{


  services = {
    postgres = {
      enable = true;
      initialDatabases = [
        { name = "activerecord_unittest"; }
        { name = "activerecord_unittest2"; }
      ];
    };
    mysql.enable = true;
    redis.enable = true;
    memcached.enable = true;
  };


  enterShell = ''
    export C_INCLUDE_PATH="$C_INCLUDE_PATH:${pkgs.libxml2.dev}/include/libxml2"
  '';

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

  ];

  languages.ruby.enable = true;
  languages.ruby.version = "3.1.0";

}
