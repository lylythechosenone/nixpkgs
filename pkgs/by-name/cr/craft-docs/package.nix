{ lib, stdenvNoCC, fetchurl, undmg, }:

stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "craft-docs";
  version = "2.8.8";

  src = fetchurl {
    name = "Craft.dmg";
    url = "https://res.craft.do/native/sparkle/Craft.dmg";
    hash = "sha256-5IlzPLzUZmMFEyL2tNDXjvb86/CW4dscVzbnNipKrek=";
  };

  dontPatch = true;
  dontConfigure = true;
  dontBuild = true;
  dontFixup = true;

  nativeBuildInputs = [ undmg ];

  sourceRoot = "Craft.app";

  installPhase = ''
    runHook preInstall

    mkdir -p $out/Applications/Craft.app
    cp -R . $out/Applications/Craft.app

    runHook postInstall
  '';

  meta = {
    description = "Craft the best docs in the world";
    homepage = "https://craft.do/";
    license = lib.licenses.unfree;
    maintainers = with lib.maintainers; [ lylythechosenone ];
    platforms = [ "aarch64-darwin" "x86_64-darwin" ];
    sourceProvenance = with lib.sourceTypes; [ binaryNativeCode ];
  };
})
