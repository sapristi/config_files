# opam config
bass "eval `opam config env`"
set -x OPAMKEEPBUILDDIR true
set -x  OCAMLPARAM "_,bin-annot=1"
