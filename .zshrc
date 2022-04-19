Last login: Tue Apr 19 09:24:43 on ttys003
thomas.mcintosh@K7M593CC60 ~ % vim ~/.automations























        slack
}

# Open Slack
slack () {
        open -a Slack
}

# Google something
google () {
        browser "https://www.google.com/search?q=$1"
}

# Open broswer
browser () {
        open -a 'Google Chrome'
}

# Print the hash of the current commit
commit-hash () {
        git rev-parse HEAD
}

# Open the RN developer menu on an iOS simulator
rn-dev () {

        if [[ $1 == '-a' ]]; then
                adb shell input keyevent 82
        else
                osascript -e 'tell app "Simulator" to activate'
                osascript -e 'tell application "System Events" to keystroke "z" using {control down, command down}'
        fi;

}

# Clear Xcode build data
xcode-clear () {
        rm -rf ~/Library/Developer/Xcode/DerivedData
}

c () {
        clear
}

l () {
        ls
}

ll () {
        ls -la
}

trash () {
        if [[ $1 == '--empty' ]]; then
                rm -rf ~/.quick-delete-cache
                echo 'Cleared'
        else
                mv $1 ~/.quick-delete-cache/$1
        fi;
}

metro-clear () {
        watchman watch-del-all
        rm -rf /tmp/metro-*
}
-- INSERT --
