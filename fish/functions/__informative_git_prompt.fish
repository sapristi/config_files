
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

set -g fish_prompt_git_show_count_staged "true"
set -g fish_prompt_git_show_count_conflicted "true"
set -g fish_prompt_git_show_count_changed "true"
set -g fish_prompt_git_show_count_untracked "true"
set -g fish_prompt_git_show_count_clean "true"

set -g fish_prompt_git_status_git_dir "*"
set -g fish_prompt_git_remote_space ""

set -g fish_prompt_git_status_order staged conflicted changed untracked


function __informative_git_prompt --description 'Write out the git prompt'

    set -l is_inside_work_tree (git rev-parse --is-inside-work-tree ^/dev/null )

    if test -z $is_inside_work_tree
        return
    end
    set_color normal
    echo -n "("
    printf "%s" (___fish_git_print_branch_info)

    set_color normal
    echo -n "|"
    
    if [ $is_inside_work_tree = "true" ]
        printf "%s" (___fish_git_print_status_info)
    else
        set_color -o $fish_color_git_clean
        echo -n $fish_prompt_git_status_git_dir
        
    end
    set_color normal
    echo -n ")"

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
    set -l remote (____fish_git_remote_info $branch)
    set -l ahead $remote[1]
    set -l behind $remote[2]
    set -l remote_info


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


function  ____fish_git_remote_info
    
    set -l branch $argv[1]
    set -l remote_name  (git config branch.$branch.remote)

    set -l diffs (git rev-list --left-right --count "$branch"..."$remote_name"/"$branch")
    set -l ahead (echo $diffs | cut -f1)
    set -l behind (echo $diffs | cut -f2)
    
    echo $ahead
    echo $behind
end

function ____fish_git_remote_info_old

    set -l branch $argv[1]
    set -l remote_name  (git config branch.$branch.remote)

    if test -n "$remote_name"
        set merge_name (git config branch.$branch.merge)
        set merge_name_short (echo $merge_name | cut -c 12-)
    else
        set remote_name "origin"
        set merge_name "refs/heads/$branch"
        set merge_name_short $branch
    end

    if [ $remote_name = '.' ]  # local
        set remote_ref $merge_name
    else
        set remote_ref "refs/remotes/$remote_name/$merge_name_short"
    end

    set -l rev_git (eval "git rev-list --left-right $remote_ref...HEAD" ^/dev/null)
    if [ $status != "0" ]
        set rev_git (eval "git rev-list --left-right $merge_name...HEAD" ^/dev/null)
    end

    for i in $rev_git
        if echo $i | grep '>' >/dev/null
           set isAhead $isAhead ">"
        end
    end

    set -l remote_diff (count $rev_git)
    set -l ahead (count $isAhead)
    set -l behind (math $remote_diff - $ahead)

    echo $ahead
    echo $behind

end
