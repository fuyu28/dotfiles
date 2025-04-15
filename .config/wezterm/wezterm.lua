local wezterm = require("wezterm")
local config = wezterm.config_builder()

----------------------------------------------------
-- 基本設定
----------------------------------------------------

-- コンフィグを自動でリロードする
config.automatically_reload_config = true

-- フォントの設定
config.font = wezterm.font("JetBrainsMonoNL Nerd Font")
config.font_size = 12.0

-- imeを有効化
config.use_ime = true

-- 背景の透過率(0~1) 数値が小さいほど透明度が高い
-- ノートだと表示がおかしくなるので注意
-- config.window_background_opacity = 0.7

-- 背景のぼかし(Windows用)
-- config.win32_system_backdrop = "Acrylic"

-- 背景画像の設定
config.background = {
  {
    source = {
      File = wezterm.config_dir .. "./background.png",
    },
    opacity = 0.5,
  }
}

-- 保持する行数
config.scrollback_lines = 3500

-- スクロールを有効化
config.enable_scroll_bar = true

-- シェルをNuShellに変更
config.default_prog = { "cmd" }

-- 閉じる際の確認を無効化
config.window_close_confirmation = "NeverPrompt"

-- カーソルのスタイルを変更
config.default_cursor_style = "BlinkingBar"

----------------------------------------------------
-- 色設定
----------------------------------------------------
local purple = '#9c7af2'
local blue = '#6EADD8'
local light_green = "#7dcd5d"
local orange = "#e19500"
local red = "#E50000"
local yellow = "#D7650C"

config.colors = {
    foreground = 'silver',
    selection_fg = 'red',
    cursor_bg = blue,
    cursor_fg = "white",
    cursor_border = purple,
    tab_bar = {         
        inactive_tab_edge = "none",
    },
    ansi = {
        'black', red, purple, light_green, blue, yellow, 'teal', 'silver',
    },
    brights = {
        'grey', 'red', 'lime', 'yellow', 'blue', 'fuchsia', 'aqua', 'white',
    },
}

----------------------------------------------------
-- Tab
----------------------------------------------------
-- タイトルバーを非表示
config.window_decorations = "RESIZE"
-- タブバーの表示
config.show_tabs_in_tab_bar = true
-- タブが一つの時は非表示
config.hide_tab_bar_if_only_one_tab = true

-- タブバーの透過
config.window_frame = {
  inactive_titlebar_bg = "none",
  active_titlebar_bg = "none",
}

-- タブバーを背景色に合わせる
config.window_background_gradient = {
  colors = { "#000000" },
}

-- タブの追加ボタンを非表示
config.show_new_tab_button_in_tab_bar = false
-- nightlyのみ使用可能
-- タブの閉じるボタンを非表示
-- config.show_close_tab_button_in_tabs = false

-- タブ同士の境界線を非表示
config.colors = {
  tab_bar = {
    inactive_tab_edge = "none",
  },
}

-- タブの形をカスタマイズ
-- タブの左側の装飾
local SOLID_LEFT_ARROW = wezterm.nerdfonts.ple_lower_right_triangle
-- タブの右側の装飾
local SOLID_RIGHT_ARROW = wezterm.nerdfonts.ple_upper_left_triangle

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
  local background = "#5c6d74"
  local foreground = "#FFFFFF"
  local edge_background = "none"
  if tab.is_active then
    background = "#ae8b2d"
    foreground = "#FFFFFF"
  end
  local edge_foreground = background
  local title = "   " .. wezterm.truncate_right(tab.active_pane.title, max_width - 1) .. "   "
  return {
    { Background = { Color = edge_background } },
    { Foreground = { Color = edge_foreground } },
    { Text = SOLID_LEFT_ARROW },
    { Background = { Color = background } },
    { Foreground = { Color = foreground } },
    { Text = title },
    { Background = { Color = edge_background } },
    { Foreground = { Color = edge_foreground } },
    { Text = SOLID_RIGHT_ARROW },
  }
end)

----------------------------------------------------
-- keybinds
----------------------------------------------------
config.disable_default_key_bindings = true
config.keys = require("keybinds").keys
config.key_tables = require("keybinds").key_tables
config.leader = { key = "q", mods = "CTRL", timeout_milliseconds = 2000 }

return config
