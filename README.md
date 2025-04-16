# Terminal Dotfiles

This repository contains my personal configuration files for:

- [WezTerm](https://wezterm.org/)
- [Starship Prompt](https://starship.rs/ja-JP/)

These configurations are intended for **Windows**.

## 📦 Installation

### 1. Install WezTerm

```sh
winget install wezterm
```

### 2. Install Starship

```sh
winget install starship
```

### 3. Install Nerd Font

Download and install a Nerd Font from:

> <https://www.nerdfonts.com/>

I use **JetBrainsMonoNL Nerd Font** by default.

---

## 🔧 Setup

### 1. Configure Files

Place your configuration files as follows:

Put `.config` in: `%USERPROFILE%`

---

## ⚙️ Using Starship in CMD

### 1. Install Clink

```sh
winget install clink
```

### 2. Setup Clink with Starship

Place `starship.lua` in: `%LocalAppData%\clink\`

---

## ⚙️ Using Starship in PowerShell

### 1. Check the location of your PowerShell profile

Run the following command in PowerShell to find the profile file path:

```sh
$PROFILE
```

### 2. Add the following line to the end of your `Microsoft.PowerShell_profile.ps1` file

```sh
Invoke-Expression (&starship init powershell)
```
