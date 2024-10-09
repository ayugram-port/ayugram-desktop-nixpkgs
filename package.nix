{ lib
, stdenv
, fetchFromGitHub
, fetchgit
, fetchpatch
, telegram-desktop
, nix-update-script
}: 

let
  tg_owt = fetchgit {
    url = "https://github.com/kaeeraa/tg_owt";
    hash = lib.fakeHash;
  };
in

telegram-desktop.overrideAttrs rec {
  pname = "AyuGramDesktop";
  version = "5.4.1";
  src = fetchFromGitHub {
    owner = "AyuGram";
    repo = "${pname}";
    rev = "v${version}";

    fetchSubmodules = true;
    hash = "sha256-7KmXA3EDlCszoUfQZg3UsKvfRCENy/KLxiE08J9COJ8=";
  };

  patches = [
    ./desktop.patch
    ./macos.patch
    ./scheme.patch
  ];

  passthru.updateScript = nix-update-script {};

  meta = with lib; {
    description = "Desktop Telegram client with good customization and Ghost mode.";
    license = licenses.gpl3Only;
    platforms = platforms.all;
    homepage = "https://github.com/AyuGram/AyuGramDesktop";
    changelog = "https://github.com/AyuGram/AyuGramDesktop/releases/tag/v${version}";
    maintainers = with maintainers; [ s0me1newithhand7s ];
    mainProgram = "ayugram-desktop";
    broken = stdenv.isDarwin;
  };
}
