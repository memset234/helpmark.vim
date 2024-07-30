## Summary

This is a plugin about mark.

The plugin has been upgraded and optimized for Mark.

## Usage

The plugin has been implemented:

- Create a new mark.
- Output all marks at the cursor position.
- Jump to a mark.
- Delete a mark.
- Add mark identifier.

If you want to create a new mark, you can use "m..." to realization.

If you want to jump to a mark, you can use "`..." or "'..." to realization.

These are the same as Vim's key positions.

It will automatically output all marks at the cursor position.

If you want to delete a mark, default configuration is use "dm..." to realization.

If you want to change the configuration, you can enter the following command in _vimrc:

```
for ch in g:zmb
    exec "nmap ..." . ch . " :call DeleteMark('" . ch . "')\<CR>"
endfor
```

You can change `...` part over there.
