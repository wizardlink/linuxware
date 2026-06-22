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
  version = "v0.2.9";

  src = fetchFromGitHub {
    owner = "deadlock-api";
    repo = "deadlock-api-ingest";
    rev = version;
    hash = "sha256-EiZo+0+R2C45GwYlwxzXFc9PXKiMo6LxFAlGDz4LPfY=";
  };

  cargoHash = "sha256-FTTed+i91VtzgA7CRHJx0GTKmvO7hAFDzFV4z8+mm0E=";

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
