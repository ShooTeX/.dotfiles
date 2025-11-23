{
  programs.zellij.layouts.dotfiles = {
    layout = {
      _children = [
        {
          tab = {
            _props = {
              name = "dotfiles";
            };
            _children = [
              {
                pane = {
                  _props = {
                    split_direction = "horizontal";
                  };
                  _children = [
                    {
                      pane = {
                        _props = {
                          stacked = true;
                        };
                        _children = [
                          {
                            pane = {
                              _props = {
                                name = "System Config";
                              };
                              command = "nvim";
                              args = [ "." ];
                              cwd = "~/.dotfiles";
                            };
                          }
                          {
                            pane = {
                              _props = {
                                name = "Neovim Config";
                              };

                              command = "nvim";
                              args = [ "." ];
                              cwd = "~/Dev/init.lua";
                              start_suspended = true;
                            };
                          }
                        ];
                      };
                    }
                    {
                      pane = {
                        _props = {
                          split_direction = "vertical";
                          size = "20%";
                        };
                        _children = [
                          {
                            pane = {
                              _props = {
                                name = "Darwin Rebuild";
                              };
                              command = "sudo";
                              args = [
                                "darwin-rebuild"
                                "switch"
                                "--flake"
                                "."
                              ];
                              cwd = "~/.dotfiles";
                              start_suspended = true;
                            };
                          }
                          {
                            pane = {
                              _props = {
                                name = "Update nvim-config flake";
                              };
                              command = "nix";
                              args = [
                                "flake"
                                "update"
                                "nvim-config"
                              ];
                              cwd = "~/.dotfiles";
                              start_suspended = true;
                            };
                          }
                        ];
                      };
                    }
                  ];
                };
              }
              {
                pane = {
                  size = 1;
                  borderless = true;
                  plugin = {
                    location = "zellij:compact-bar";
                  };
                };
              }
            ];
          };
        }
      ];
    };
  };
}
