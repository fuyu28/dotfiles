# Dotfiles

These are the configuration files for my development environment. This repository includes settings for:

- **AtCoder CLI (inside WSL)**
- **LaTeX**
- **NuShell**
- **Starship**
- **Visual Studio Code**
- **VSCode NeoVim Extension**
- **WezTerm**
- **NeoVim**
- **Z Shell**

---

## Directory Structure

Below is where each file should be placed on a Windows system:

| Application                  | File(s)                                         | Destination Path                    |
| ---------------------------- | ----------------------------------------------- | ----------------------------------- |
| **AtCoder CLI (inside WSL)** | `main.cpp`                                      | `~/.config/atcoder-cli-nodejs/cpp/` |
| **LaTeX**                    | `.chktexrc`, `.latexmkrc`                       | `%USERPROFILE%\`                    |
| **NuShell**                  | `config.toml`                                   | `%APPDATA%\nushell\`                |
| **Starship** (cmd init)      | `starship.lua`                                  | `%LocalAppData%\clink\`             |
| **Starship** (cross-shell)   | `starship.toml`                                 | `%USERPROFILE%\.config\`            |
| **Visual Studio Code**       | `keybindings.json`, `settings.json`, `snippets` | `%APPDATA%\Code\User\`              |
| **VSCode NeoVim**            | `init.lua`                                      | `%LOCALAPPDATA%\vscode-nvim\`       |
| **WezTerm**                  | `background.png`, `keybinds.lua`, `wezterm.lua` | `%USERPROFILE%\.config\wezterm\`    |
| **NeoVim** | `lua`, `.neoconf.json`, `init.lua`, `lazy-lock.json`, `lazyvim.json`, `LICENSE`, `README.md`, `stylua.toml` | `%LOCALAPPDATA\nvim` |
| **Z Shell** | `.zshrc` | `~/` |
