{ 
  pkgs, 
  ... 
  }: {
  imports =
    [ 
      ../../extras/bluetooth.nix

      ../../extras/flatpak.nix
      ../../extras/gaming/gaming.nix
    ];


  boot.loader = {
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot";
    };
    systemd-boot = {
      enable = false;
      editor = false;
    };
    
    grub = {
      enable = false;
    };

    limine = {
      enable = true;
    };
  };

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
  };

  networking = {
    networkmanager = {
      enable = true;
    };
    firewall = {
      enable = true;
    };
  };

  time = {
    timeZone = "America/Sao_Paulo";
  };
   
  i18n = {
    defaultLocale = "en_US.UTF-8";

    extraLocaleSettings = {
      LC_ADDRESS = "pt_BR.UTF-8";
      LC_IDENTIFICATION = "pt_BR.UTF-8";
      LC_MEASUREMENT = "pt_BR.UTF-8";
      LC_MONETARY = "pt_BR.UTF-8";
      LC_NAME = "pt_BR.UTF-8";
      LC_NUMERIC = "pt_BR.UTF-8";
      LC_PAPER = "pt_BR.UTF-8";
      LC_TELEPHONE = "pt_BR.UTF-8";
      LC_TIME = "pt_BR.UTF-8";
    };
  };

  services = {
    xserver = {
      enable = true;
      xkb = {
        layout = "br";
        variant = "";
      };
    };

    ratbagd = {
      enable = true;
    };

    displayManager = {
      sddm = {
        enable = true;
        wayland = {
          enable = true;
        };
      };
    };

    desktopManager = {
      plasma6 = {
        enable = true;
      };
    };

    printing = {
      enable = true;
    };

    pulseaudio = {
      enable = false;
    };

    pipewire = { 
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };

      pulse = {
        enable = true;
      };
      wireplumber = {
        enable = true;
      };
    };
  };

  security = {
    rtkit = {
      enable = true;
    };
  };
  

  users.users.mene = {
    isNormalUser = true;
    description = "mene";
    extraGroups = [ "networkmanager" "wheel" "adbusers"];
    packages = with pkgs; [
      kdePackages.kate
    ];
  };

  programs = {
    firefox = {
      enable = true;
    };

    niri = {
      enable = true;
    };
  };

  environment.systemPackages = with pkgs; [
     wget
     kitty
     vscodium
     fastfetch
     vim
     pavucontrol
  ];

  system.stateVersion = "25.11";   
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = ["nix-command" "flakes"];
  nix.settings.trusted-users = ["@wheel"];
}
