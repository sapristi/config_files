set -xg _colors_theme gruvbox_light
set -xg PATH $HOME/.local/bin $PATH
set -xg OPAMKEEPBUILDDIR true
set -xg OCAMLPARAM "_,bin-annot=1"


status --is-interactive; and source (pyenv init -|psub)
