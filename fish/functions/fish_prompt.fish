

function fish_prompt
    if not set -q VIRTUAL_ENV_DISABLE_PROMPT
        set -g VIRTUAL_ENV_DISABLE_PROMPT true
    end
    
    set_colors_gruvbox_light
    
    set_color normal
    echo -n "("
    if set -q SCHROOT_CHROOT_NAME
        set_color $cc_purple
        echo -n (SCHROOT_CHROOT_NAME)
        set_color normal
        echo -n ">"
    end
    
    set_color $cc_aqua
    echo -n (prompt_hostname)
    set_color normal
    echo -n ")"

    set_color $cc_orange
    printf '%s' (whoami)
    
    set_color normal
    printf ' in '

    set_color -o $cc_blue
    printf '%s' (prompt_pwd)
    set_color normal

    # Line 2
    echo
    if test $VIRTUAL_ENV
        printf "(%s) " (set_color blue)(basename $VIRTUAL_ENV)(set_color normal)
    end
    printf '↪ '
    set_color normal
end
