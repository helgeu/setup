{ ... }:
{
  # Install iTerm2 and required fonts
  # home.packages = with pkgs; [ 
  #   #iterm2
  # ];

  # Configure iTerm2 preferences
  targets.darwin.defaults."com.googlecode.iterm2" = {
    # Enable Python API for it2 CLI and agent support
    EnablePythonAPI = true;

    "Default Bookmark Guid" = "Dracula-Profile";
    "New Bookmarks" = [{
      Guid = "Dracula-Profile";
      Name = "Dracula Profile";
      "Normal Font" = "MesloLGLNFM-Regular 12";
      "Use Non-ASCII Font" = false;
      Columns = 180;
      Rows = 50;
      "Background Color" = {
        "Red Component" = 0.11;
        "Green Component" = 0.12;
        "Blue Component" = 0.16;
        "Alpha Component" = 1.0;
      };
      "Foreground Color" = {
        "Red Component" = 0.97;
        "Green Component" = 0.97;
        "Blue Component" = 0.95;
        "Alpha Component" = 1.0;
      };
      "Cursor Color" = {
        "Red Component" = 0.97;
        "Green Component" = 0.97;
        "Blue Component" = 0.95;
        "Alpha Component" = 1.0;
      };
      "Selection Color" = {
        "Red Component" = 0.27;
        "Green Component" = 0.28;
        "Blue Component" = 0.35;
        "Alpha Component" = 1.0;
      };
      "Mouse Reporting" = true;
      ShowMarkIndicators = 1;
      "Visual Bell" = true;

      "Option Key Sends" = 2;
      "Right Option Key Sends" = 2;
    }];
  };
}