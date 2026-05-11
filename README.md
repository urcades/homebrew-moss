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

If runtime config does not exist yet and you want Codex sessions to default to a
specific working directory, run `mossctl configure` from that directory before
`moss-open`, or launch the Homebrew wrapper with:

```sh
MOSS_CODEX_CWD=/path/to/workspace moss-open
```

## Uninstall

```sh
mossctl stop --remove-plist
brew uninstall moss
```

Homebrew removes the formula-managed app, `mossctl`, and `moss-open`. Runtime
config, state, logs, and the app-support runtime app copy are preserved at:

```text
~/Library/Application Support/MessagesLLMBridge/
~/Library/Logs/MessagesLLMBridge/
```

Remove those directories manually only if you want to delete trusted senders,
state, permission-broker events, and logs. See the main repository's uninstall
guide for full runtime cleanup.
