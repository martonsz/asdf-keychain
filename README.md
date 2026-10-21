<div align="center">

# asdf-keychain [![Build](https://github.com/martonsz/asdf-keychain/actions/workflows/build.yml/badge.svg)](https://github.com/martonsz/asdf-keychain/actions/workflows/build.yml) [![Lint](https://github.com/martonsz/asdf-keychain/actions/workflows/lint.yml/badge.svg)](https://github.com/martonsz/asdf-keychain/actions/workflows/lint.yml)

[keychain](https://github.com/martonsz/asdf-keychain) plugin for the [asdf version manager](https://asdf-vm.com).

</div>

# Contents

- [Dependencies](#dependencies)
- [Install](#install)
- [Contributing](#contributing)
- [License](#license)

# Dependencies

**TODO: adapt this section**

- `bash`, `curl`, `tar`, and [POSIX utilities](https://pubs.opengroup.org/onlinepubs/9699919799/idx/utilities.html).
- `SOME_ENV_VAR`: set this environment variable in your shell config to load the correct version of tool x.

# Install

Plugin:

```shell
asdf plugin add keychain
# or
asdf plugin add keychain https://github.com/martonsz/asdf-keychain.git
```

keychain:

```shell
# Show all installable versions
asdf list-all keychain

# Install specific version
asdf install keychain latest

# Set a version globally (on your ~/.tool-versions file)
asdf global keychain latest

# Now keychain commands are available
keychain version
```

Check [asdf](https://github.com/asdf-vm/asdf) readme for more instructions on how to
install & manage versions.

# Contributing

Contributions of any kind welcome! See the [contributing guide](contributing.md).

[Thanks goes to these contributors](https://github.com/martonsz/asdf-keychain/graphs/contributors)!

# License

See [LICENSE](LICENSE) © [Marton Szucs](https://github.com/martonsz/)
