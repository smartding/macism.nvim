# macism.nvim

A plugin to auto-restore macOS input source on entering INSERT mode in neovim.

Before leaving INSERT state, the plugin records current input source and switches to default input source, which is usually ABC. It restores previous input source on entering INSERT mode if it is different than the default input source.

## Requirement

1. neovim >= 0.7: for the lua APIs.
1. laishulu/macism: for switching input source on macOS, it should be in your PATH
1. macOS Sequoia: I only have Sequoia(15.x) for testing, not sure if everyting works in other versions

## Installation

Using [lazy.nvim](https://github.com/folke/lazy.nvim), set an empty `opts` to call `setup` automatically:

```lua
{
  "smartding/macism.nvim",
  event = "InsertEnter",
  opts = {}
},
```

## Configuration

The following is the default configuration, the value of `default_input_source` should be input source ID. No need to set this option if the default 'com.apple.keylayout.ABC' works for you.

```lua
{
  default_input_source = 'com.apple.keylayout.ABC',
}
```

You can get input source IDs by running macism after switching to that input source. Other common input sources:

1. 鼠须管：im.rime.inputmethod.Squirrel.Rime
1. 搜狗输入法：com.sogou.inputmethod.sogou.pinyin
