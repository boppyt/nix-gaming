{ lib
, makeDesktopItem
, symlinkJoin
, writeShellScriptBin

, jdk8
, src ? builtins.fetchurl {
    url = "https://launcher.technicpack.net/launcher4/671/TechnicLauncher.jar";
    sha256 = "sha256-6b9rBzMmKHdYR0ph6gzvrlG5Jzpsg7mHAxBWQweH3+M=";
  }
, steam-run
, withSteamRun ? false

, pname ? "technic-launcher"
}:

let
  desktopItems = makeDesktopItem {
    name = pname;
    exec = pname;
    inherit icon;
    comment = "Technic Platform Launcher";
    desktopName = "Technic Launcher";
    categories = "Game;";
  };

  icon = builtins.fetchurl {
    url = "https://worldvectorlogo.com/download/technic-launcher.svg";
    sha256 = "sha256-hZpqxNGCPWDGw1v2y1vMnvo6qGfqI9AfcmU+Q2u/KBc=";
  };


  script = writeShellScriptBin pname ''
    ${if withSteamRun then steam-run + "/bin/steam-run" else ""} ${jdk8}/bin/java -jar ${src}
  '';
in

symlinkJoin {
  name = pname;
  paths = [ desktopItems script ];

  meta = {
    description = "Minecraft Launcher with support for Technic Modpacks";
    homepage = "https://technicpack.net";
    maintainers = lib.maintainers.fufexan;
    platforms = lib.platforms.linux;
  };
}
