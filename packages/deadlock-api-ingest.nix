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
  version = "0-unstable-2026-02-10";

  src = fetchFromGitHub {
    owner = "deadlock-api";
    repo = "deadlock-api-ingest";
    rev = "537a64c507c7588dd254484125d20b09077fd27b";
    hash = "sha256-RKJmggIyGs9WiI9MUhGf91KGUmYim6T3m34vR450V2Y=";
  };

  cargoHash = "sha256-YiJjehMQmwWKInHmeomj7fw7s2av8HlFDqhE/zUahoo=";

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
