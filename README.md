# Homebrew Tap For Moss

This tap installs [moss](https://github.com/urcades/moss), a native macOS Apple
Messages bridge for prompting Codex from trusted senders.

The formula builds the app from source. It does not install a notarized binary
artifact.

## Install

```sh
brew tap urcades/moss
brew install moss
```

Then finish first-run setup:

```sh
cd ~
mossctl configure --safety standard
moss-open
mossctl doctor
```

Open the menu-bar app, add a sender in `Trusted Senders...`, grant the macOS
permissions Doctor reports, then send `/status` from the trusted sender.

## Commands

- `moss-open`: launches the menu-bar app from the Homebrew install.
- `mossctl`: runtime status, Doctor, safety configuration, and maintenance.

If you want fresh runtime config to default Codex sessions to a specific working
directory, run `mossctl configure` from that directory before `moss-open`, or
launch with:

```sh
MOSS_CODEX_CWD=/path/to/workspace moss-open
```

## Uninstall

```sh
brew uninstall moss
```

This removes the Homebrew-built app bundle and `mossctl`. Runtime state under
`~/Library/Application Support/MessagesLLMBridge/` is managed by the app itself;
see the main repository's uninstall guide for full runtime cleanup.
