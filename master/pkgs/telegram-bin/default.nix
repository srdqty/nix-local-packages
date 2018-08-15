{ stdenv
, fetchurl
, makeWrapper
, lib
, alsaLib
, dbus
, glib
, glibc
, libX11
, libxcb
, xkeyboardconfig
}:
let
  dynamic-linker = stdenv.cc.bintools.dynamicLinker;
  url-prefix = "https://github.com/telegramdesktop/tdesktop/releases/download";
in
stdenv.mkDerivation rec {
  name = "telegram-${version}";
  version = "1.3.12";

  # TODO: support osx too
  src = fetchurl {
    url = "${url-prefix}/v${version}/tsetup.${version}.alpha.tar.xz";
    sha256 = "014a17wjyrnm99n8il1c9j63pzq07dbhvwzffs5zyf39rmj5ij1l";
  };

  doBuild = false;

  buildInputs = [makeWrapper];

  installPhase = ''
    mkdir -p $out/bin
    install -D -m555 -T Telegram $out/bin/telegram
  '';

  postFixup = let
    libPath = lib.makeLibraryPath [
      dbus.lib
      glib
      glibc
      libxcb
      libX11
    ];
  in ''
    patchelf --set-interpreter ${dynamic-linker} $out/bin/telegram
    patchelf --shrink-rpath $out/bin/telegram
    patchelf --set-rpath "${libPath}" $out/bin/telegram

    wrapProgram $out/bin/telegram \
      --set QT_XKB_CONFIG_ROOT "${xkeyboardconfig}/share/X11/xkb" \
      --set QTCOMPOSE "${libX11}/share/X11/locale" \
      --set LD_LIBRARY_PATH "${alsaLib}/lib"
  '';
}
