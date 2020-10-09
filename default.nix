{ mkDerivation, base, bytestring, stdenv, text, unix-bytestring
, word8
}:
mkDerivation {
  pname = "posix-fd-io";
  version = "0.1.0.0";
  src = ./.;
  libraryHaskellDepends = [
    base bytestring text unix-bytestring word8
  ];
  description = "IO with posix file descriptors";
  license = stdenv.lib.licenses.mit;
}
