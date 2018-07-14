
#set -g fish_color_normal $cc_fg1

set -g fish_color_git_clean $cc_aqua
set -g fish_color_git_branch $cc_purple
set -g fish_color_git_remote $cc_orange_e

set -g fish_color_git_staged $cc_yellow
set -g fish_color_git_conflicted $cc_red
set -g fish_color_git_changed $cc_yellow_e
set -g fish_color_git_untracked $cc_fg4


set -g fish_prompt_git_remote_ahead_of "↑"
set -g fish_prompt_git_remote_behind  "↓"

set -g fish_prompt_git_status_staged "●"
set -g fish_prompt_git_status_conflicted '✖'
set -g fish_prompt_git_status_changed '✚'
set -g fish_prompt_git_status_untracked "…"
set -g fish_prompt_git_status_clean "✔"
set -g fish_prompt_git_update "⇅"

set -g fish_prompt_git_show_count_staged "true"
set -g fish_prompt_git_show_count_conflicted "true"
set -g fish_prompt_git_show_count_changed "true"
set -g fish_prompt_git_show_count_untracked "true"
set -g fish_prompt_git_show_count_clean "true"

set -g fish_prompt_git_status_git_dir "*"
set -g fish_prompt_git_remote_space ""

set -g fish_prompt_git_status_order staged conflicted changed untracked

set -g git_prompt_check_remote_update true

set -g git_prompt_remote_update_delay 60



function __informative_git_prompt --description 'Write out the git prompt'
    set -l is_inside_work_tree (git rev-parse --is-inside-work-tree ^/dev/null )

    if test -z $is_inside_work_tree
        return
    end

    
    set -l head_file (git rev-parse --show-toplevel)/.git/FETCH_HEAD
    
    if [ -f $head_file ]
        
        set -l last_update (stat -c "%Y" $head_file)

        if [ $git_prompt_check_remote_update = "true" ]
            
            set -l now (date "+%s")
            
            if [ (math  $now - $last_update) -gt $git_prompt_remote_update_delay ]
                git remote update > /dev/null ^ /dev/null &
                set_color normal
                echo -n "git remote update… "
            end
            
        end
    else
        echo -n "git remote fetch"
        git remote update > /dev/null ^ /dev/null &
    end
        


    set -l color_normal (set_color normal)
    
    echo -n $color_normal"(" 
    

    printf "%s" (___fish_git_print_branch_info)

    echo -n $color_normal"|"
    
    if [ $is_inside_work_tree = "true" ]
        printf "%s" (___fish_git_print_status_info)
    else
        set_color -o $fish_color_git_clean
        echo -n $fish_prompt_git_status_git_dir
    end

    echo -n $color_normal"|"

    echo -n $color_normal"⇅ "
    
    set_color $cc_fg4
    echo -n (__fuzzy_date $last_update)
    
    echo -n $color_normal")"

end

function ___fish_git_print_branch_info


    set -l branch (git symbolic-ref -q HEAD | cut -c 12-)
    set -l remote_info

    if test -z $branch
        
        set -l hash (git rev-parse --short HEAD | cut -c 2-)
        set branch ":"$hash
    else
        
        set remote_info (___fish_git_print_remote_info $branch)
    end

    set_color -o $fish_color_git_branch
    echo -n $branch
    set_color normal
    echo -n $remote_info
    
    
end

function ___fish_git_print_status_info

    set -l changedFiles (git diff --name-status | cut -c 1-2)
    set -l stagedFiles (git diff --staged --name-status | cut -c 1-2)

    set -l changed (math (count $changedFiles) - (count (echo $changedFiles | grep "U")))
    set -l conflicted (count (echo $stagedFiles | grep "U"))
    set -l staged (math (count $stagedFiles) - $conflicted)
    set -l untracked (count (git ls-files --others --exclude-standard))

    if [ (math $changed + $conflicted + $staged) = 0 ]
        set_color $fish_color_git_clean
        echo -n $fish_prompt_git_status_clean
        set_color normal
    end
        
    
    for i in $fish_prompt_git_status_order
        if [ $$i != "0" ]
            
            set -l color_name fish_color_git_"$i"
            set -l status_name fish_prompt_git_status_"$i"
            
            set_color $$color_name
            
            set -l visible fish_prompt_git_show_count_"$i"
            if [ "true" = $$visible ]
                echo -n $$status_name$$i
            else
                echo -n $$status_name
            end
            
            echo -n $info
            
        end
    end
    
    set_color normal

end

function ___fish_git_print_remote_info


    set -l branch $argv[1]

    set -l remote (git config branch.$branch.remote)
    set -l ahead (git rev-list --left-only --count "$branch"..."$remote"/"$branch")
    set -l behind (git rev-list --right-only --count "$branch"..."$remote"/"$branch")
    

    if [ $ahead != "0" ]
        set_color -o $fish_color_git_remote
        echo -n $fish_prompt_git_remote_ahead_of
        set_color normal
        echo -n $ahead
    end

    if [ $behind != "0" ]
        set_color -o $fish_color_git_remote
        echo -n $fish_prompt_git_remote_behind
        set_color normal
        echo -n $behind
    end

    set_color normal
end
