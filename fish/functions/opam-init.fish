
function opam-init
    ## OPAM init
    . /home/sapristi/.opam/opam-init/init.fish > /dev/null 2> /dev/null or true
    ## keep build files for merlin
    set -x OPAMKEEPBUILDDIR true
    set -x OCAMLPARAM "_,bin-annot=1"
end
