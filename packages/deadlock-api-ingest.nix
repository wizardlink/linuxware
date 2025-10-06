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
  version = "0-unstable-2025-10-05";

  src = fetchFromGitHub {
    owner = "deadlock-api";
    repo = "deadlock-api-ingest";
    rev = "2338773e4578017bafa0b15c5dd23883f9d74b19";
    hash = "sha256-skiRDJzCcVHDyZK+KvO8Kl/Pu8/E9ySixi1wd6UWuTg=";
  };

  cargoHash = "sha256-KEFr/2hIef2hzj20NHoMSnUil+loiG5KkZ3uALS6bvA=";

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
