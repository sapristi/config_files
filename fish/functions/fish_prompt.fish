

function fish_prompt
    
    set_gruvbox_colors
    
    set_color $cc_fg4
    echo -n "("
    echo -n (prompt_hostname)
    if set -q SCHROOT_CHROOT_NAME
        set_color normal
        printf ">%s" $SCHROOT_CHROOT_NAME
    end
    set_color $cc_fg4
    echo -n ") "

    printf '%s' (whoami)
    
    set_color -o normal
    printf ': %s' (prompt_pwd)

    set_color $cc_fg4
    echo -n " ▶ "

end
