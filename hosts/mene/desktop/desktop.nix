{
  ...
}: {
    networking = {
      hostName = "apollopc";
    };
    
    hardware = {
      graphics = {
        enable = true;
        enable32Bit = true;
      };

      nvidia = {
        open = false;
        nvidiaSettings = true;
        modesetting = {
          enable = true;
        };
        powerManagement = {
          enable = false;
          finegrained = false;
        };
      };
    };

    services = {
      xserver = {
        videoDrivers = [ "nvidia" ];
      };
    };
  }
