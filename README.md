dummy change

# nvim-textmate-macos

A fork of [icedman/nvim-textmate]() to work on Mac OS.

A textmate-based syntax highlighter to nvim - Uses VS code syntax themes/syntax extensions.

![Screen Shot](https://raw.githubusercontent.com/jakenvac/nvim-textmate-macos/main/screenshots/Screenshot%20from%202022-08-18%2010-15-03.png)

# Setup

## Building

This plugin uses a native module and must first be compiled.

> [!NOTE]
> If you use the lazy.nvim example below, this will all be done for you.

> [!WARNING]
> Run these commands in the installed location of your plugin.
> For example with lazy.nvim as your plugin manager: `~/share/nvim/lazy/nvim-textmate-macos`

Firstly, ensure you have `python`, `luajit`, `cmake` & `pkg-config` installed:

```sh
brew install luajit cmake pkg-config python
```

Next, make sure homebrew libraries are available to pkg-config:

```sh
export PKG_CONFIG_PATH="$(brew --prefix)"/lib/pkg-config:$PKG_CONFIG_PATH"
```

Now we're ready to build:

```sh
make
```

You can make sure the build output is in the right place with:
```sh
stat ./lua/nvim-textmate-macos/textmate.dylib
```

## Config with lazy.nvim

```lua
return {
	"jakenvac/nvim-textmate-macos",
    -- these are the default options
    -- when using a different plugin manager use the setup function outlined below
	opts = {
        quick_load = false,
        theme_name = "Monokai",
        override_colorscheme = false,
        debug_scopes = false,
        custom_scope_map = nil,
        extension_paths = {
        	"~/.vscode/extensions/",
        	"~/.editor/extensions/",
        }
    },
    build = {
        "brew install luajit cmake pkg-config",
        'export PKG_CONFIG_PATH="$(brew --prefix)"/lib/pkg-config:$PKG_CONFIG_PATH',
        "make"
        "stat ./lua/nvim-textmate-macos/textmate.dylib"
    },
    -- It is recommended to only load for required file types due to potential slowdown
    ft = {
        "d2",
        "lua"
    }
}
```

## Other plugin managers

```lua
require('nvim-textmate').setup({
    quick_load = true,
    -- ...
})
```

## setup options

- quick_load - defers loading of grammar and theme at the opening of a buffer
- theme_name - select a textmate format or vscode compatible theme
- override_colorscheme - apply colorscheme from textmate theme
- custom_scope_map - add more scope to namespace mapping (see colormap.lua)
- extension_paths - set vscode extension search path
- debug_scopes - print scope name under cursor

# extensions

Copy vscode theme and grammar extensions to any of these directories:

```sh
~/.config/nvim/lua/nvim-textmate/
~/.editor/extensions/
~/.vscode/extensions/
```

# commands

- TxMtEnable
- TxMtDisable
- TxMtToggle
- TxMtTheme
- TxMtDebugScopes

# known issues

- a colorscheme must be loaded prior to running nvim-textmate
- cpp - Some grammars take a bit of time to load. cpp, the largest grammar file causes a visible lag on first load; hence the _quick_load_ option is available.
- markdown - Other grammars - like markdown will load other grammar languages for inline code and will re-render after the other languages are loaded.
- scrolling and text editing - syntax highlighting is currently done at these events as a debounced (defer_fn) function.

# warning

- This plugin is just a proof of concept - from a novice lua coder, and much worse - from a non neovim user (not yet at least)
