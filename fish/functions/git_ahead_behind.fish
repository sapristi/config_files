
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
set -g fish_prompt_git_show_count_untracked "false"
set -g fish_prompt_git_show_count_clean "true"

set -g fish_prompt_git_status_git_dir "*"
set -g fish_prompt_git_remote_space ""

set -g fish_prompt_git_status_order staged conflicted changed untracked



function __informative_git_prompt --description 'Write out the git prompt'

    set -l is_inside_work_tree (git rev-parse --is-inside-work-tree ^/dev/null )

    if test -z $is_inside_work_tree
        return
    end

    if test "true" = $is_inside_work_tree
        set git_status_info (___fish_git_print_status_info)
    else
        set git_status_info (set_color -o $fish_color_git_clean)$fish_prompt_git_status_git_dir(set_color $fish_color_normal)
    end

    printf "(%s|%s)" (___fish_git_print_branch_info) $git_status_info

end



function ___fish_git_print_remote_info

    set color_remote (set_color -o $fish_color_git_remote)
    set color_normal (set_color $fish_color_normal)

    set -l branch $argv[1]
    set -l remote (____fish_git_remote_info $branch)
    set -l ahead $remote[1]
    set -l behind $remote[2]
    set -l remote_info


    if [ $ahead != "0" ]
        set remote_info $color_remote$fish_prompt_git_remote_ahead_of$color_normal$ahead
    end

    if [ $behind != "0" ]
        set remote_info $remote_info$color_remote$fish_prompt_git_remote_behind$color_normal$behind
    end

    if test -n "$remote_info"
        echo "$fish_prompt_git_remote_space$remote_info"
    end

end



function ____fish_git_remote_info

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
    if test $status != "0"
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

