function __last_git_update

    set -l last_update
    set -l head_file (git rev-parse --show-toplevel)"/.git/FETCH_HEAD"
    
    set_color $cc_fg4

    
    if [ -e $head_file ]
        set last_update (stat -c "%Y" $head_file)
        echo -n (__fuzzy_date $last_update)
    else
        echo -n "?"
    end
end
