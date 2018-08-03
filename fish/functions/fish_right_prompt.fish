
function fish_right_prompt -d "Prints right prompt"

    set -g __fish_git_prompt_color_upstream_ahead $cc_orange_e
    set -g __fish_git_prompt_color_upstream_behind $cc_orange_e
    set -g __fish_git_prompt_color_dirtystate $cc_yellow_e
    set -g __fish_git_prompt_color_invalidstate $cc_orange
    set -g __fish_git_prompt_color_stagedstate $cc_yellow
    set -g __fish_git_prompt_color_untrackedfiles $cc_fg4
    set -g __fish_git_prompt_color_cleanstate $cc_aqua
    
    set -g __fish_git_prompt_color_branch $cc_purple
    set -g __fish_git_prompt_color_upstream $cc_red
    set -g __fish_git_prompt_color_bare $cc_fg4
    set -g __fish_git_prompt_color_merging $cc_green
    
    set -g  __fish_git_prompt_showcolorhints true
    set -g __fish_git_prompt_show_informative_status true
    echo (__fish_git_prompt_custom)

    # echo (__informative_git_prompt)

end
