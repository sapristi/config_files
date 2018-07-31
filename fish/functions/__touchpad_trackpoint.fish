
function __touchpad_trackpoint
    set -l touchpad_id (xinput --list --short | sed  -n "s/.*TouchPad.*id=\([[:digit:]]*\).*/\1/p")
    echo "touchpad_id is "$touchpad_id
    
    set -l touchpad_status (xinput --list-props $touchpad_id | sed -n "s/.*Device Enabled ([1-9]*):[[:blank:]]*\([0-1]\).*/\1/p")
    echo "touchpad_status is "$touchpad_status
    
    if [ $touchpad_status = 1 ]
        echo "disabling"
        xinput disable $touchpad_id
    else
        echo "enabling"
        xinput enable $touchpad_id
    end

end
