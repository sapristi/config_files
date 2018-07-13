function ___disp_diff
    set -l diff $argv[1]
    set -l unit $argv[2]

    printf "%s %s" $diff $unit
    if [ $diff != 1 ]
        echo -n "s"
    end
    echo -n " ago"
end


function __fuzzy_date -d "Prints a date (seconds from epoch) with precision depending on time elapsed from now"

    
    set -l then $argv[1]

    set -l then_year   (date "+%Y" -d @$then)
    set -l then_month  (date "+%m" -d @$then)
    set -l then_day    (date "+%j" -d @$then)
    set -l then_hour   (date "+%H" -d @$then)
    set -l then_min    (date "+%M" -d @$then)
    set -l then_sec    (date "+%s" -d @$then)

    set -l this_year   (date "+%Y") 
    set -l this_month  (date "+%m")
    set -l this_day    (date "+%j")
    set -l this_hour   (date "+%H")
    set -l this_min    (date "+%M")
    set -l this_sec    (date "+%s")

    set -l units year month day hour min sec

    for unit in $units
        set -l now "this_$unit"
        set -l then "then_$unit"
        set -l diff (math $$now - $$then)

        if [ $diff -gt 1 ]
            echo (___disp_diff $diff $unit)
            return 0
        end
    end

    echo "now"
end
    
    
