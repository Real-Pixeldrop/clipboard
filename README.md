# ClipBoard 📋

A lightweight macOS menu bar clipboard manager. Keeps your last 10 copied items accessible with one click.

![macOS](https://img.shields.io/badge/macOS-13%2B-blue) ![Swift](https://img.shields.io/badge/Swift-5.9-orange) ![License](https://img.shields.io/badge/license-MIT-green)

## Features

- 📋 Stores your last 10 clipboard entries
- 🖱️ One-click to re-copy any item
- 💾 Persistent history (survives app restart)
- 🪶 Native Swift — ultra lightweight, no Electron
- 🚫 No dock icon — lives in your menu bar
- 🇫🇷 French UI

## Install

### From source

```bash
git clone https://github.com/Real-Pixeldrop/clipboard.git
cd clipboard
swift build -c release
cp .build/release/ClipBoard /usr/local/bin/clipboard
```

### Run

```bash
clipboard
```

Or double-click the binary. The app appears in your menu bar with a 📋 icon.

## Usage

1. Copy anything (⌘C)
2. Click the 📋 icon in your menu bar
3. See your last 10 copies
4. Click any item to re-copy it to your clipboard
5. Paste it anywhere (⌘V)

## How it works

- Monitors the system clipboard every 0.5s
- Stores history in `~/Library/Application Support/ClipBoard/history.json`
- No network access, no telemetry, no permissions needed
- Deduplicates entries (moves existing items to the top)

## Build requirements

- macOS 13+
- Swift 5.9+
- Xcode or Swift toolchain

## License

MIT
