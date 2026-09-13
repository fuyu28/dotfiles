# Attribution

The Lua configuration and Tree-sitter queries are derived from LazyVim 15.15.0,
commit 83d90f339defdb109a6ede333865a66ffc7ef6aa.
Source: https://github.com/LazyVim/LazyVim
License: Apache-2.0, preserved in LazyVim.txt.

Local changes: configuration and custom overrides were merged into lua/config,
plugin definitions into lua/plugins, and shared helpers into lua/util. Module
references and the helper global were renamed; remote distribution loading,
Extras management, news, and distribution-specific import checks were removed.
Only the enabled plugin modules were retained. Go linter and register mappings
are incorporated directly. These files are maintained as local configuration.
