# Editor enhancement plugins configuration
{ pkgs, ... }: {
  plugins = {
      nvim-autopairs = {
        enable = true;
        settings = {
          check_ts = true;  # Use treesitter for better pairing
        };
      };

      comment = {
        enable = true;
      };

      indent-blankline = {
        enable = true;
        settings = {
          scope = {
            enabled = true;
            show_start = true;
            show_end = true;
            highlight = "Function";  # Use existing highlight group
          };
          indent = {
            highlight = "LineNr";    # Use existing highlight group
          };
        };
      };
    };
}