function display_git_untracked
    set -l untracked (command git status -s --ignore-submodules=untracked | grep "^??*" | wc -l | sed -e 's/^ *//' -e 's/ *$//' 2> /dev/null)

    if [ $untracked != "0" ]
        set_color -b normal
        set_color yellow
        echo "$untracked untracked "
        set_color normal
    end
end

function display_git_dirty
    set -l dirty (command git status -s --ignore-submodules=untracked | grep "^ M*" | wc -l | sed -e 's/^ *//' -e 's/ *$//' 2> /dev/null)

    if [ $dirty != "0" ]
        set_color -b normal
        set_color red
        echo "$dirty dirty "
    end
end        

function display_git_branch
    set -l ref (command git describe --tags --exact-match ^/dev/null ; or command git symbolic-ref --short HEAD 2> /dev/null ; or command git rev-parse --short HEAD 2> /dev/null)
        
    set_color -b brcyan
    set_color black
    echo " $ref "
    set_color normal
end


function fish_right_prompt -d "Prints right prompt"
    
    if command git rev-parse --is-inside-work-tree >/dev/null 2>&1

        display_git_untracked
        display_git_dirty
        display_git_branch
        
    end
end
