{ stdenv
, lib
, fetchFromGitHub
, gcc
, pkg-config
, wine
, wsp
}:

stdenv.mkDerivation rec {
  pname = "winestreamproxy";
  version = "2.0.1";

  src = wsp;

  nativeBuildInputs = [ pkg-config wine ];

  installFlags = [ "PREFIX=${placeholder "out"}" ];

  meta = {
    description = "Program for Wine that forwards messages between a named pipe client and a unix socket server";
    homepage = "https://github.com/openglfreak/winestreamproxy";
    license = lib.licenses.mpl20;
    maintainers = with lib.maintainers; [ fufexan ];
    platforms = with lib.platforms; [ "i686-linux" "x86_64-linux" ];
  };
}
