

function fish_prompt
    if not set -q VIRTUAL_ENV_DISABLE_PROMPT
        set -g VIRTUAL_ENV_DISABLE_PROMPT true
    end
    
    set_gruvbox_colors
    
    set_color $fish_color_normal
    echo -n "("
    set_color $cc_aqua
    echo -n (prompt_hostname)
    if set -q SCHROOT_CHROOT_NAME
        set_color $fish_color_normal
        echo -n ">"
        set_color $cc_aqua_e
        echo -n $SCHROOT_CHROOT_NAME
    end
    set_color $fish_color_normal
    echo -n ") "

    set_color $cc_aqua
    printf '%s' (whoami)
    
    set_color $fish_color_normal
    printf ': '

    set_color -o $fish_color_normal
    printf '%s… ' (prompt_pwd)
    set_color $fish_color_normal

    # Line 2

    if test $VIRTUAL_ENV
        printf "(%s) " (set_color blue)(basename $VIRTUAL_ENV)(set_color $fish_color_normal)
    end
end
