function __smart_date -d "Prints a date (seconds from epoch) with precision depending on time elapsed from now"

    set -l this_year   (date "+%Y") 
    set -l this_month  (date "+%m")
    set -l this_day    (date "+%j")

    set -l then $argv[1]

    
    set -l then_year   (date "+%Y" -d @$then)
    set -l then_month  (date "+%m" -d @$then)
    set -l then_day    (date "+%j" -d @$then)
    
    if [ $this_year != $then_year ]
        echo (date "+%m/%Y" -d @$then)
    else

        if [ $this_month != $then_month ]
            echo (date "+%d/%m" -d @$then)
        else

            if [ $this_day != $then_day ]
                echo (date "+%d/%m" -d @$then)
            else
                
                echo "today "(date "+%H:%M" -d @$then)
            end
        end
    end
end
