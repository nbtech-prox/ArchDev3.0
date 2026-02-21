#!/bin/bash

# Define os temas - Catppuccin Mocha
gnome_schema="org.gnome.desktop.interface"
gtk_theme="catppuccin-mocha-mauve-standard+default"
icon_theme="Papirus-Dark"
cursor_theme="Catppuccin-Mocha-Dark-Cursors"
font_name="JetBrainsMono Nerd Font 11"

# Aplica as configurações via gsettings
gsettings set "$gnome_schema" gtk-theme "$gtk_theme" 2>/dev/null
gsettings set "$gnome_schema" icon-theme "$icon_theme" 2>/dev/null
gsettings set "$gnome_schema" cursor-theme "$cursor_theme" 2>/dev/null
gsettings set "$gnome_schema" font-name "$font_name" 2>/dev/null
gsettings set "$gnome_schema" color-scheme "prefer-dark" 2>/dev/null
