#!/usr/bin/env bash

set -euo pipefail

GH_REPO="https://github.com/danielrobbins/keychain"
TOOL_NAME="keychain"

fail() {
	echo -e "asdf-$TOOL_NAME: $*"
	exit 1
}

curl_opts=(-fsSL)

if [ -n "${GITHUB_API_TOKEN:-}" ]; then
	curl_opts=("${curl_opts[@]}" -H "Authorization: token $GITHUB_API_TOKEN")
fi

sort_versions() {
	sed 'h; s/[+_-]/./g; s/.p\([[:digit:]]\)/.z\1/; s/$/.z/; G; s/\n/ /' |
		LC_ALL=C sort -t. -k 1,1 -k 2,2n -k 3,3n -k 4,4n -k 5,5n | awk '{print $2}'
}

list_github_tags() {
	git ls-remote --tags --refs "$GH_REPO" |
		grep -o 'refs/tags/.*' | cut -d/ -f3- |
		sed 's/^v//'
}

list_all_versions() {
	# Only keychain 3 and newer ship the .pyz zipapp this plugin installs.
	list_github_tags | awk -F. '$1 >= 3'
}

download_release() {
	local version filename url
	version="$1"
	filename="$2"

	url="$GH_REPO/releases/download/${version}/${TOOL_NAME}-${version}.pyz"

	echo "* Downloading $TOOL_NAME release $version..."
	curl "${curl_opts[@]}" -o "$filename" "$url" || fail "Could not download $url"
}

install_version() {
	local install_type="$1"
	local version="$2"
	local install_path="${3%/bin}/bin"
	local download_file="$ASDF_DOWNLOAD_PATH/$TOOL_NAME"

	if [ "$install_type" != "version" ]; then
		fail "asdf-$TOOL_NAME supports release installs only"
	fi

	# Run the zipapp from the download directory first, so nothing is placed in
	# the install path until the version is known to work.
	test -x "$download_file" ||
		fail "No executable $TOOL_NAME at $download_file. Run bin/download with the same ASDF_DOWNLOAD_PATH first."
	"$download_file" version >/dev/null 2>&1 ||
		fail "Could not run $download_file. $TOOL_NAME needs python3 3.9 or newer on PATH."

	mkdir -p "$install_path"
	cp "$download_file" "$install_path/$TOOL_NAME" || {
		rm -rf "$install_path"
		fail "An error occurred while installing $TOOL_NAME $version."
	}
	chmod +x "$install_path/$TOOL_NAME"

	echo "$TOOL_NAME $version installation was successful!"
}
