#!/usr/bin/env python3

import colorsys
import json
import os
import shutil
import subprocess
import sys
from pathlib import Path

HOME = Path.home()
CONFIG_HOME = Path(os.environ.get("XDG_CONFIG_HOME", HOME / ".config"))
CACHE_HOME = Path(os.environ.get("XDG_CACHE_HOME", HOME / ".cache"))
WALLPAPER_DEFAULT = CONFIG_HOME / "wallpapers" / "current"
THEME_DIR = CONFIG_HOME / "archdev" / "theme"

CATPPUCCIN = {
    "rosewater": "#f5e0dc",
    "flamingo": "#f2cdcd",
    "pink": "#f5c2e7",
    "mauve": "#cba6f7",
    "red": "#f38ba8",
    "maroon": "#eba0ac",
    "peach": "#fab387",
    "yellow": "#f9e2af",
    "green": "#a6e3a1",
    "teal": "#94e2d5",
    "sky": "#89dceb",
    "sapphire": "#74c7ec",
    "blue": "#89b4fa",
    "lavender": "#b4befe",
}


def run(cmd, **kwargs):
    return subprocess.run(cmd, check=False, text=True, **kwargs)


def hex_to_rgb(value: str):
    value = value.lstrip("#")
    return tuple(int(value[i : i + 2], 16) for i in (0, 2, 4))


def saturation(value: str) -> float:
    r, g, b = hex_to_rgb(value)
    return colorsys.rgb_to_hsv(r / 255, g / 255, b / 255)[1]


def distance(a: str, b: str) -> int:
    ar, ag, ab = hex_to_rgb(a)
    br, bg, bb = hex_to_rgb(b)
    return (ar - br) ** 2 + (ag - bg) ** 2 + (ab - bb) ** 2


def choose_accent(colors: dict) -> tuple[str, str]:
    candidates = [colors[f"color{i}"] for i in [1, 2, 3, 4, 5, 6, 9, 10, 11, 12, 13, 14]]
    vivid = max(candidates, key=saturation)
    accent_name = min(CATPPUCCIN, key=lambda name: distance(vivid, CATPPUCCIN[name]))
    return accent_name, CATPPUCCIN[accent_name]


def rgba(hex_value: str, alpha: str) -> str:
    return f"rgba({hex_value.lstrip('#')}{alpha})"


def css_rgba(hex_value: str, alpha: float) -> str:
    r, g, b = hex_to_rgb(hex_value)
    return f"rgba({r}, {g}, {b}, {alpha:.2f})"


def choose_panel_background(bg_alt: str, bg: str) -> str:
    return bg_alt if bg_alt != bg else bg


def existing_path(*candidates: Path) -> str:
    for candidate in candidates:
        if candidate.exists():
            return str(candidate)
    return str(candidates[-1])


def write(path: Path, content: str):
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(content, encoding="utf-8")


def notify(message: str):
    if shutil.which("dunstify"):
        run(["dunstify", "ArchDev Theme", message])
    elif shutil.which("notify-send"):
        run(["notify-send", "ArchDev Theme", message])


def restart_waybar():
    if shutil.which("waybar") and run(["pgrep", "-x", "waybar"], capture_output=True).returncode == 0:
        run(["pkill", "-x", "waybar"])
        subprocess.Popen(["waybar"], stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)


def hypr_reload():
    if shutil.which("hyprctl"):
      run(["hyprctl", "reload"])


def apply_gsettings(gtk_theme: str, icon_theme: str, cursor_theme: str):
    if not shutil.which("gsettings"):
        return
    run(["gsettings", "set", "org.gnome.desktop.interface", "gtk-theme", gtk_theme])
    run(["gsettings", "set", "org.gnome.desktop.interface", "icon-theme", icon_theme])
    run(["gsettings", "set", "org.gnome.desktop.interface", "cursor-theme", cursor_theme])
    run(["gsettings", "set", "org.gnome.desktop.interface", "color-scheme", "prefer-dark"])


def main():
    wallpaper = Path(sys.argv[1]).expanduser() if len(sys.argv) > 1 else WALLPAPER_DEFAULT
    wallpaper = wallpaper.resolve() if wallpaper.exists() else wallpaper

    if not wallpaper.exists():
        print(f"Wallpaper not found: {wallpaper}", file=sys.stderr)
        return 1

    THEME_DIR.mkdir(parents=True, exist_ok=True)

    wal = shutil.which("wal")
    if wal is None:
        print("pywal/wal is not installed", file=sys.stderr)
        return 1

    if run([wal, "-q", "-n", "-i", str(wallpaper)]).returncode != 0:
        print("Failed to generate palette with wal", file=sys.stderr)
        return 1

    colors_json = CACHE_HOME / "wal" / "colors.json"
    data = json.loads(colors_json.read_text(encoding="utf-8"))
    colors = data["colors"]
    special = data["special"]

    accent_name, accent = choose_accent(colors)
    bg = special["background"]
    fg = special["foreground"]
    bg_alt = colors["color0"]
    surface = colors["color8"]
    selection = colors["color4"]
    panel_bg = choose_panel_background(bg_alt, bg)
    panel_edge = colors["color8"]
    module_hover = colors["color8"]
    ribbon_bg = css_rgba(bg, 0.72)
    ribbon_edge = css_rgba(panel_edge, 0.75)
    chip_bg = css_rgba(panel_bg, 0.35)
    chip_hover = css_rgba(module_hover, 0.45)

    gtk_theme = f"catppuccin-mocha-{accent_name}-standard+default"
    kvantum_theme = f"catppuccin-mocha-{accent_name}"

    if not Path(f"/usr/share/themes/{gtk_theme}").exists():
        gtk_theme = "catppuccin-mocha-mauve-standard+default"
    if not Path(f"/usr/share/Kvantum/{kvantum_theme}").exists():
        kvantum_theme = "catppuccin-mocha-mauve"

    metadata = {
        "wallpaper": str(wallpaper),
        "accent_name": accent_name,
        "accent": accent,
        "gtk_theme": gtk_theme,
        "kvantum_theme": kvantum_theme,
        "background": bg,
        "foreground": fg,
    }
    write(THEME_DIR / "theme.json", json.dumps(metadata, indent=2) + "\n")

    write(
        THEME_DIR / "kitty-theme.conf",
        f"""foreground {fg}
background {bg}
selection_foreground {bg}
selection_background {accent}
cursor {accent}
cursor_text_color {bg}
url_color {accent}
active_border_color {accent}
inactive_border_color {surface}
bell_border_color {colors['color3']}
active_tab_foreground {bg}
active_tab_background {accent}
inactive_tab_foreground {fg}
inactive_tab_background {bg_alt}
tab_bar_background {bg}
color0 {colors['color0']}
color1 {colors['color1']}
color2 {colors['color2']}
color3 {colors['color3']}
color4 {colors['color4']}
color5 {colors['color5']}
color6 {colors['color6']}
color7 {colors['color7']}
color8 {colors['color8']}
color9 {colors['color9']}
color10 {colors['color10']}
color11 {colors['color11']}
color12 {colors['color12']}
color13 {colors['color13']}
color14 {colors['color14']}
color15 {colors['color15']}
""",
    )

    write(
        CONFIG_HOME / "rofi" / "config.rasi",
        f"""configuration {{
    modi: "drun,run,window,calc,emoji";
    show-icons: true;
    display-drun: "󰀻 Apps";
    display-run: "󰁔 Run";
    display-window: "󱂬 Windows";
    display-calc: "󰃬 Calc";
    display-emoji: "󰞅 Emoji";
    drun-display-format: "{{name}}";
    font: "JetBrainsMono Nerd Font 12";
    terminal: "kitty";
    hover-select: true;
    me-select-entry: "";
    me-accept-entry: "MousePrimary";
}}

@theme "/dev/null"

* {{
    bg: {bg};
    bg-alt: {bg_alt};
    fg: {fg};
    accent: {accent};
    urgent: {colors['color1']};
    background-color: transparent;
    text-color: @fg;
    margin: 0;
    padding: 0;
    spacing: 0;
}}

window {{
    width: 650px;
    height: 450px;
    border: 1px;
    border-color: @accent;
    background-color: @bg;
    border-radius: 12px;
    location: center;
    anchor: center;
}}

mainbox {{
    padding: 20px;
    children: [inputbar, listview];
}}

inputbar {{
    background-color: @bg-alt;
    margin: 0 0 20px 0;
    padding: 12px;
    border-radius: 8px;
    children: [prompt, entry];
}}

prompt {{
    font: "JetBrainsMono Nerd Font 14";
    padding: 0 10px 0 0;
}}

entry {{
    placeholder: "Search applications...";
    placeholder-color: {surface};
}}

listview {{
    columns: 2;
    lines: 8;
    fixed-height: true;
}}

element {{
    padding: 8px;
    border-radius: 6px;
    spacing: 10px;
}}

element selected {{
    background-color: @accent;
    text-color: @bg;
}}

element-icon {{
    size: 32px;
}}

element-text {{
    vertical-align: 0.5;
}}
""",
    )

    write(
        CONFIG_HOME / "waybar" / "style.css",
        f"""@define-color base {bg};
@define-color mantle {bg_alt};
@define-color crust {colors['color0']};
@define-color text {fg};
@define-color subtext0 {colors['color7']};
@define-color subtext1 {colors['color15']};
@define-color surface0 {bg_alt};
@define-color surface1 {colors['color8']};
@define-color surface2 {surface};
@define-color overlay0 {colors['color8']};
@define-color overlay1 {colors['color7']};
@define-color overlay2 {colors['color15']};
@define-color blue {colors['color4']};
@define-color lavender {accent};
@define-color sapphire {colors['color6']};
@define-color sky {colors['color14']};
@define-color teal {colors['color6']};
@define-color green {colors['color2']};
@define-color yellow {colors['color3']};
@define-color peach {colors['color11']};
@define-color maroon {colors['color9']};
@define-color red {colors['color1']};
@define-color mauve {accent};
@define-color pink {colors['color13']};
@define-color flamingo {colors['color9']};
@define-color rosewater {colors['color15']};

* {{
  border: none;
  border-radius: 0;
  font-family: "JetBrainsMono Nerd Font", "Roboto", "Helvetica", "Arial", sans-serif;
  font-size: 13px;
  font-weight: bold;
}}

window#waybar {{
  background-color: {ribbon_bg};
  transition-property: background-color;
  transition-duration: .5s;
  border-bottom: 1px solid {ribbon_edge};
  padding: 4px 10px;
}}

window#waybar.hidden {{ opacity: 0.2; }}

#workspaces {{ background-color: transparent; margin: 0 8px 0 0; padding: 0; border-radius: 999px; border: 1px solid transparent; }}
#workspaces button {{ padding: 0 10px; min-height: 30px; color: @subtext1; border-bottom: 2px solid transparent; transition: all 0.3s ease; border-radius: 999px; margin: 0 4px; }}
#workspaces button.active {{ color: @text; border-bottom: 2px solid @lavender; background-color: transparent; border: 1px solid transparent; }}
#workspaces button.urgent {{ background-color: @red; color: @base; border-radius: 10px; }}
#workspaces button:hover {{ background: {chip_hover}; color: @text; }}

#clock, #cpu, #memory, #disk, #temperature, #backlight, #network, #pulseaudio, #custom-media, #tray, #mode, #idle_inhibitor, #scratchpad, #mpd, #custom-power, #custom-updates, #custom-project, #bluetooth, #custom-nightmode {{
  padding: 0 12px;
  margin: 0 2px;
  background-color: transparent;
  color: @text;
  font-size: 15px;
  min-height: 30px;
  border-radius: 999px;
  border: 1px solid transparent;
}}

#clock {{ color: @rosewater; font-size: 14px; margin-right: 8px; }}
#custom-project {{ color: @lavender; font-style: italic; padding-right: 15px; }}
#network {{ color: @blue; }}
#bluetooth {{ color: @sapphire; }}
#pulseaudio {{ color: @peach; }}
#custom-updates {{ color: @green; }}
#custom-power {{ color: @red; min-width: 18px; }}
#custom-nightmode {{ color: @text; font-size: 16px; padding: 0 12px; min-width: 18px; }}
#custom-nightmode.on {{ color: @yellow; }}
#tray {{ padding-left: 10px; padding-right: 10px; min-width: 18px; }}
#network,
#bluetooth,
#pulseaudio,
#custom-nightmode,
#custom-power,
#tray {{
  min-width: 28px;
  min-height: 30px;
  padding: 0 7px;
  font-size: 14px;
  background-color: transparent;
  border-color: transparent;
}}

#network label,
#bluetooth label,
#pulseaudio label,
#custom-nightmode label,
#custom-power label {{
  min-width: 14px;
}}

#tray > .passive,
#tray > .active,
#tray > .needs-attention {{
  min-width: 16px;
  min-height: 16px;
  margin: 0 1px;
}}

#tray > .passive {{ -gtk-icon-effect: dim; }}
#tray > .needs-attention {{ -gtk-icon-effect: highlight; }}
#window {{ color: @text; padding: 0 15px; font-weight: normal; }}

tooltip {{ background: @base; border-radius: 12px; border: 1px solid @lavender; }}
tooltip label {{ color: @text; padding: 5px; }}
""",
    )

    write(
        THEME_DIR / "hypr-theme.conf",
        f"""general {{
    col.active_border = {rgba(accent, 'ff')}
    col.inactive_border = {rgba(surface, '66')}
}}
decoration {{
    shadow {{
        color = {rgba(bg, '55')}
    }}
}}
""",
    )

    gtk_css = f"""@define-color accent_color {accent};
@define-color accent_fg_color {bg};
@define-color window_bg_color {bg};
@define-color window_fg_color {fg};
@define-color headerbar_bg_color {bg_alt};
@define-color headerbar_fg_color {fg};
@define-color view_bg_color {bg};
@define-color view_fg_color {fg};
@define-color card_bg_color {bg_alt};
@define-color card_fg_color {fg};

*:selected,
row:selected,
treeview.view:selected,
.view:selected,
iconview:selected,
flowboxchild:selected {{
  background-color: @accent_color;
  color: @accent_fg_color;
}}

window, dialog, .background {{
  background-color: @window_bg_color;
  color: @window_fg_color;
}}
"""
    write(CONFIG_HOME / "gtk-3.0" / "gtk.css", gtk_css)
    write(CONFIG_HOME / "gtk-4.0" / "gtk.css", gtk_css)

    gtk_settings = f"""[Settings]
gtk-theme-name={gtk_theme}
gtk-icon-theme-name=Papirus-Dark
gtk-cursor-theme-name=Catppuccin-Mocha-Dark-Cursors
gtk-font-name=Noto Sans 10
gtk-application-prefer-dark-theme=1
"""
    write(CONFIG_HOME / "gtk-3.0" / "settings.ini", gtk_settings)
    write(CONFIG_HOME / "gtk-4.0" / "settings.ini", gtk_settings)

    write(CONFIG_HOME / "Kvantum" / "kvantum.kvconfig", f"[General]\ntheme={kvantum_theme}\n")

    apply_gsettings(gtk_theme, "Papirus-Dark", "Catppuccin-Mocha-Dark-Cursors")
    restart_waybar()
    hypr_reload()
    notify(f"Wallpaper synced with {accent_name} accent")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
