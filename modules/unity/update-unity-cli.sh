#!/usr/bin/env bash
# Bump the Unity CLI in ./default.nix to the latest release.
# Usage: ./update-unity-cli.sh [version]   (defaults to latest)
set -euo pipefail

cd "$(dirname "$0")"
file=default.nix
cdn=https://public-cdn.cloud.unity3d.com/hub/prod/cli

if [ -n "${1:-}" ]; then
    manifest=$(curl -fsSL "$cdn/$1/latest.json")
else
    manifest=$(curl -fsSL "$cdn/latest.json")
fi

version=$(jq -r .version <<<"$manifest")
current=$(sed -n '/pname = "unity-cli"/,/version/ s/.*version = "\(.*\)";/\1/p' "$file")

if [ "$version" = "$current" ]; then
    echo "unity-cli already at $current"
    exit 0
fi

sri() {
    nix hash convert --hash-algo sha256 --to sri \
        "$(jq -r ".binaries[\"$1\"].sha256" <<<"$manifest")"
}
x64=$(sri linux-x64)
arm64=$(sri linux-arm64)

sed -i \
    -e "/pname = \"unity-cli\"/,/version/ s/version = \".*\";/version = \"$version\";/" \
    -e "s|\(x86_64-linux = { name = \"x64\"; hash = \"\)[^\"]*|\1$x64|" \
    -e "s|\(aarch64-linux = { name = \"arm64\"; hash = \"\)[^\"]*|\1$arm64|" \
    "$file"

echo "unity-cli $current -> $version"
