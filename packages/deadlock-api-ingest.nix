{
  lib,
  rustPlatform,
  fetchFromGitHub,
  pkg-config,
  libpcap,
  openssl,
}:

rustPlatform.buildRustPackage {
  pname = "deadlock-api-ingest";
  version = "0-unstable-2025-11-13";

  src = fetchFromGitHub {
    owner = "deadlock-api";
    repo = "deadlock-api-ingest";
    rev = "f068f6d08b38310ad74a560a997763c04cd5c049";
    hash = "sha256-rbzdIsqf92o7p5QDdYI4TpAKyq52YQfSxjhcZ7YmtKA=";
  };

  cargoHash = "sha256-Xir+/TNQ9C9QZFZWbEBZlndyPoPvW55cXaS3oQYe9sk=";

  nativeBuildInputs = [
    pkg-config
  ];

  buildInputs = [
    libpcap
    openssl
  ];

  meta = {
    description = "A network packet capture tool that monitors HTTP traffic for Deadlock game replay files and ingests
    metadata to the Deadlock API.";
    homepage = "https://github.com/deadlock-api/deadlock-api-ingest";
    license = lib.licenses.mit;
    maintainers = [ lib.maintainers.wizardlink ];
  };
}
