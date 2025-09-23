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
  version = "0-unstable-2025-09-23";

  src = fetchFromGitHub {
    owner = "deadlock-api";
    repo = "deadlock-api-ingest";
    rev = "5536816e2b9afa227c6ba9771f54b61a5cc63ab8";
    hash = "sha256-h9k1VlpZ7uvSoJX30LjnB+kLYJ6juLEr5lv/jPqGQn8=";
  };

  cargoHash = "sha256-LL4sd1VmsU890GdpeDB1yEdpJUBJZ4kpY85kYPneB3U=";

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
