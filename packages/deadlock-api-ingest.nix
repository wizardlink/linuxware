{
  lib,
  rustPlatform,
  fetchFromGitHub,
  pkg-config,
  libpcap,
  openssl,
}:

rustPlatform.buildRustPackage rec {
  pname = "deadlock-api-ingest";
  version = "v0.2.6";

  src = fetchFromGitHub {
    owner = "deadlock-api";
    repo = "deadlock-api-ingest";
    rev = version;
    hash = "sha256-w21stADZ0uLhYwx6lCqYH6eG9wEgMs3YUamUgB+SC1Q=";
  };

  cargoHash = "sha256-6R8wf7GQo7+D5Ez4xsXeBu4P3R9jm1nYKMIX2aD8jEc=";

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
