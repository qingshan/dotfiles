# Helix

Development environment for Rust, Go and Markdown.

## Setup

lsp for rust
```shell
rustup component add rust-analyzer
```

debugger for rust

```
brew install llvm
ln -s $(brew --prefix)/opt/llvm/bin/lldb-vscode $(brew --prefix)/bin/
```

lsp for go
```shell
go install golang.org/x/tools/gopls@latest
```

formatter for go
```shell
go install golang.org/x/tools/cmd/goimports@latest
```

debugger for go
```shell
go install github.com/go-delve/delve/cmd/dlv@latest
```

lsp for markdown
```shell
brew install marksman
```

lsp for toml
```shell
brew install taplo
```

lsp for protobuf
```shell
go install github.com/bufbuild/buf-language-server/cmd/bufls@latest
```

formatter for markdown, json, toml and yaml.

```shell
brew install dprint
```

## Configuration

updates lanuages.toml & .dprint.json

## Keymap

### Default Keymap

[Default Keymap](https://docs.helix-editor.com/keymap.html)

### Project Menu

<kbd>Command + r</kbd> to launch project menu.

- <kbd>f</kbd>: Test function
- <kbd>F</kbd>: Test file
- <kbd>t</kbd>: Test package
- <kbd>T</kbd>: Test all
- <kbd>b</kbd>: Build package
- <kbd>B</kbd>: Build all
- <kbd>r</kbd>: Run package
- <kbd>R</kbd>: Run all

### Command Selector

<kbd>Command + Shift + r</kbd> to launch project command selector.

### Markdown Keymap

Markdown Keymap: <kbd>Alt + m</kbd> in NORMAL and INSERT mode.
