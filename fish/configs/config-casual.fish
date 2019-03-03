set -xg _colors_theme gruvbox_light
set -xg PATH $HOME/.local/bin $PATH
status --is-interactive; and source (pyenv init -|psub)
