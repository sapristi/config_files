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
    set -l then    (date "+%s" -d @$then)
    set -l now     (date "+%s")

    set -l indexes 1   2   3    4   5     6
    set -l units   sec min hour day month year
    set -l factors  60  60  24   30  12    1

    if [ $then = $now ]
        echo "now"
        return 0
    end

    set -l diff (math $now - $then)
        
    for i in $indexes
        
        if [ $diff -lt $factors[$i] ]
            
            echo ( ___disp_diff $diff $units[$i] )
            return 0
        else
            set now  ( math $now / $factors[$i] )
            set then ( math $then / $factors[$i] )
            set diff ( math $now - $then )
        end
    end

end
    
    
