{
  pkgs,
  ...
}: {
    networking = {
      hostName = "apollo";
    };

    hardware = {
      enableRedistributableFirmware = true;

      graphics = {
        enable = true;
        enable32Bit = true;
        extraPackages = with pkgs; [ intel-media-driver intel-ocl intel-vaapi-driver ];
      };
    };
  }
