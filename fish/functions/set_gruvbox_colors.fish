

# set -xg _gruvbox_red     cc241d
# set -xg _gruvbox_green   98971a
# set -xg _gruvbox_yellow  d79921
# set -xg _gruvbox_blue    458588
# set -xg _gruvbox_purple  b16286
# set -xg _gruvbox_aqua    689d6a
# set -xg _gruvbox_gray    7c6f64
# set -xg _gruvbox_orange  d65d0e


function set_gruvbox_colors_base
    set -g _gruvbox_neutral_d0 282828
    set -g _gruvbox_neutral_d1 3c3836
    set -g _gruvbox_neutral_d2 504945
    set -g _gruvbox_neutral_d3 665c54
    set -g _gruvbox_neutral_d4 7c6f64

    set -g _gruvbox_neutral_b0 fbf1c7
    set -g _gruvbox_neutral_b1 edbbb2
    set -g _gruvbox_neutral_b2 d5c4a1
    set -g _gruvbox_neutral_b3 bdae93
    set -g _gruvbox_neutral_b4 a89984
    
    set -g _gruvbox_red_d    9d0006
    set -g _gruvbox_green_d  79740e
    set -g _gruvbox_yellow_d b57614
    set -g _gruvbox_blue_d   076678
    set -g _gruvbox_purple_d 8f3f71
    set -g _gruvbox_aqua_d   427b58
    set -g _gruvbox_orange_d af3a03
    set -g _gruvbox_gray_d   7c6f64

    
    set -g _gruvbox_red_b    fb4934
    set -g _gruvbox_green_b  b8bb26
    set -g _gruvbox_yellow_b fabd2f
    set -g _gruvbox_blue_b   83a598
    set -g _gruvbox_purple_b d3869b
    set -g _gruvbox_aqua_b   8ec07c
    set -g _gruvbox_orange_b fe8019
    set -g _gruvbox_gray_b   a89984
end



function set_colors_gruvbox_light
    set -g cc_red      $_gruvbox_red   
    set -g cc_green    $_gruvbox_green  
    set -g cc_yellow   $_gruvbox_yellow 
    set -g cc_blue     $_gruvbox_blue  
    set -g cc_purple   $_gruvbox_purple  
    set -g cc_aqua     $_gruvbox_aqua  
    set -g cc_orange   $_gruvbox_orange

    set -g cc_red_e    $_gruvbox_red_d
    set -g cc_green_e  $_gruvbox_green_d
    set -g cc_yellow_e $_gruvbox_yellow_d
    set -g cc_blue_e   $_gruvbox_blue_d 
    set -g cc_purple_e $_gruvbox_purple_d 
    set -g cc_aqua_e   $_gruvbox_aqua_d  
    set -g cc_orange_e $_gruvbox_orange_d

    set -g cc_fg0 $cc_gruvbox_neutral_d0
    set -g cc_fg1 $cc_gruvbox_neutral_d1
    set -g cc_fg2 $cc_gruvbox_neutral_d2
    set -g cc_fg3 $cc_gruvbox_neutral_d3
    set -g cc_fg4 $cc_gruvbox_neutral_d4

    set -g cc_bg0 $cc_gruvbox_neutral_b0 
    set -g cc_bg1 $cc_gruvbox_neutral_b1 
    set -g cc_bg2 $cc_gruvbox_neutral_b2 
    set -g cc_bg3 $cc_gruvbox_neutral_b3 
    set -g cc_bg4 $cc_gruvbox_neutral_b4 
end

function set_colors_gruvbox_dark
    set -g cc_red_e    $_gruvbox_red_b
    set -g cc_green_e  $_gruvbox_green_b
    set -g cc_yellow_e $_gruvbox_yellow_b
    set -g cc_blue_e   $_gruvbox_blue_b 
    set -g cc_purple_e $_gruvbox_purple_b 
    set -g cc_aqua_e   $_gruvbox_aqua_b  
    set -g cc_orange_e $_gruvbox_orange_b

    
    set -g cc_fg0 $cc_gruvbox_neutral_b0
    set -g cc_fg1 $cc_gruvbox_neutral_b1
    set -g cc_fg2 $cc_gruvbox_neutral_b2
    set -g cc_fg3 $cc_gruvbox_neutral_b3
    set -g cc_fg4 $cc_gruvbox_neutral_b4

    set -g cc_bg0 $cc_gruvbox_neutral_d0 
    set -g cc_bg1 $cc_gruvbox_neutral_d1 
    set -g cc_bg2 $cc_gruvbox_neutral_d2 
    set -g cc_bg3 $cc_gruvbox_neutral_d3 
    set -g cc_bg4 $cc_gruvbox_neutral_d4 
    
end


function set_gruvbox_colors
    
    set -g cc_red     cc241d
    set -g cc_green   98971a
    set -g cc_yellow  d79921
    set -g cc_blue    458588
    set -g cc_purple  b16286
    set -g cc_aqua    689d6a
    set -g cc_gray    924374
    set -g cc_orange  d65d0e

    set_gruvbox_colors_base
    
    switch "$_colors_theme"
        case gruvbox_dark
            set_colors_gruvbox_dark
        case gruvbox_light 
            set_colors_gruvbox_light
        case \*
            printf "set_gruvbox_colors : Unknown option %s\n" $option
            printf "defaulting to gruvbox_light"
            set_colors_gruvbox_light
    end

    set -g fish_color_normal fg1
end
