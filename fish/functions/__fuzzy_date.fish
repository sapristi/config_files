function __fuzzy_date -d "Prints a date (seconds from epoch) with precision depending on time elapsed from now"

    
    set -l then $argv[1]

    set -l then_year   (date "+%Y" -d @$then)
    set -l then_month  (date "+%m" -d @$then)
    set -l then_day    (date "+%j" -d @$then)
    set -l then_hour    (date "+%H" -d @$then)
    set -l then_minute    (date "+%M" -d @$then)
    set -l then_second    (date "+%s" -d @$then)

    set -l this_year   (date "+%Y") 
    set -l this_month  (date "+%m")
    set -l this_day    (date "+%j")
    set -l this_hour    (date "+%H")
    set -l this_minute    (date "+%M")
    set -l this_second    (date "+%s")

    
    
    if [ $this_year != $then_year ]
        echo (math $this_year -  $then_year)" years ago"
    else

        if [ $this_month != $then_month ]
        echo (math $this_month -  $then_month)" month ago"
        else

            if [ $this_day != $then_day ]
                echo (math $this_day -  $then_day)" days ago"
            else
                
                if [ $this_hour != $then_hour ]
                    echo (math $this_hour -  $then_hour)" hours ago"
                else
                    if [ $this_minute != $then_minute ]
                        echo (math $this_minute -  $then_minute)" minutes ago"
                    else
                        echo (math $this_second -  $then_second)" seconds ago"
                    end
                end
            end
        end
    end
end
