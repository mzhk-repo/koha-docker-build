#!/usr/bin/env bash
# Fail if the retired automatic Koha schema import is reintroduced.
set -euo pipefail

step_path="scripts/koha-setup/steps/07-db-import.sh"

[[ -f "${step_path}" ]] || { printf 'ERROR: missing %s\n' "${step_path}" >&2; exit 1; }

if grep -Ein 'kohastructure[.]sql|DROP[[:space:]]+TABLE|koha-mysql' "${step_path}"; then
  printf 'ERROR: automatic Koha schema import is forbidden in %s\n' "${step_path}" >&2
  exit 1
fi

grep -Fq 'Automatic Koha schema import is disabled' "${step_path}" || {
  printf 'ERROR: %s must explain the disabled schema import policy\n' "${step_path}" >&2
  exit 1
}

printf 'OK: automatic Koha schema import remains disabled.\n'
