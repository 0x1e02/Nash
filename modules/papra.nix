{ config, pkgs, ... }:
{
  services.papra = {
    enable = true;
    # baseUrl = "http://nash:1221";   # must match the URL you type in the browser
    # listenAddress = "0.0.0.0";          # default is 127.0.0.1
    # persistRoot = "/persist";           # only if you use impermanence, see below
    # environment.AUTH_IS_REGISTRATION_ENABLED = "false";  # set after you've created your account
    environment = {
      APP_BASE_URL = "http://nash:1221";
      DOCUMENTS_OCR_LANGUAGES = "eng,deu";
      DOCUMENT_STORAGE_FILESYSTEM_ROOT= "/data/ell/Papra/documents";
      DATABASE_URL = "file:/data/ell/Papra/db.sqlite";
    };
  };
}