{
  programs.nixvim = {
    plugins.avante = {
      enable = true;

      settings = {
        provider = "openai";
        openai = {
          endpoint = "http://192.168.0.171:1234/v1";
          model = "qwen2.5-coder-7b-instruct";
          temperature = 0;
          max_tokens = 4096;
        };

        hints.enabled = true;
        windows = {
          wrap = true;
          width = 30;
          sidebar_header = {
            align = "center";
            rounded = true;
          };
        };

        highlights.diff = {
          current = "DiffText";
          incoming = "DiffAdd";
        };

        diff = {
          debug = false;
          autojump = true;
          list_opener = "copen";
        };
      };
    };
  };
}
