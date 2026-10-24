# asdf-keychain [![Build](https://github.com/martonsz/asdf-keychain/actions/workflows/build.yml/badge.svg)](https://github.com/martonsz/asdf-keychain/actions/workflows/build.yml) [![Lint](https://github.com/martonsz/asdf-keychain/actions/workflows/lint.yml/badge.svg)](https://github.com/martonsz/asdf-keychain/actions/workflows/lint.yml)

[keychain](https://github.com/danielrobbins/keychain) plugin for the [asdf version manager](https://asdf-vm.com).

</div>

## Contents

- [Dependencies](#dependencies)
- [Install](#install)
- [Versions](#versions)
- [How it works](#how-it-works)
- [Contributing](#contributing)
- [License](#license)

## Dependencies

- `bash`, `curl`, `git`, and [POSIX utilities](https://pubs.opengroup.org/onlinepubs/9699919799/idx/utilities.html).
- `python3` 3.9 or newer, to run the keychain zipapp.
- `ssh-agent` and `ssh-add`; `gnupg` as well for the GPG key features.

## Install

Plugin:

```shell
asdf plugin add keychain https://github.com/martonsz/asdf-keychain.git
```

keychain:

```shell
# Show all installable versions
asdf list all keychain

# Install specific version
asdf install keychain latest

# Set a version in ~/.tool-versions
asdf set -u keychain latest

# Now keychain commands are available
keychain version
```

Check [asdf](https://github.com/asdf-vm/asdf) readme for more instructions on how to
install & manage versions.

## Versions

`asdf list all keychain` lists the release tags from the
[keychain repository](https://github.com/danielrobbins/keychain), oldest first.

Only keychain `3.0.0` and newer are listed: those releases ship the `.pyz`
zipapp this plugin installs. Keychain 2.x is distributed as a plain shell
script instead and is not supported.

Pre-releases (`3.0.0_beta1` and friends) are listed and sort before their final
release. `asdf latest keychain` resolves to the newest stable release.

## How it works

### /bin/download

`bin/download` fetches the `keychain-<version>.pyz` zipapp from the release
assets and places it in `ASDF_DOWNLOAD_PATH` as an executable named `keychain`.
The zipapp is self-contained, so nothing is extracted.

The file is downloaded to a scratch directory first and only moved into place
once the download succeeds, so a failed download leaves `ASDF_DOWNLOAD_PATH`
empty.

### /bin/install

`bin/install` runs `keychain version` on the downloaded zipapp and only then
copies it to `$ASDF_INSTALL_PATH/bin/keychain`, so a version that cannot run
leaves the install path untouched. asdf creates the `keychain` shim from that
`bin` directory.

Because the zipapp is executed as part of the install, `python3` 3.9 or newer
must be on `PATH`. Only `version` installs are supported, not `ref` installs.

Both scripts can be run on their own against the `sandbox` directory; see the
[contributing guide](contributing.md).

## Contributing

Contributions of any kind welcome! See the [contributing guide](contributing.md).

[Thanks goes to these contributors](https://github.com/martonsz/asdf-keychain/graphs/contributors)!

## License

See [LICENSE](LICENSE) © [Marton Szucs](https://github.com/martonsz/)
