# Install dependencies
setup-automations () {
	if [[ $(command -v brew) == "" ]]; then
    		echo "Homebrew not installed"
	else
		brew install ffmpeg
	fi	
}

# Open desktop in finder
desk () {
	open ~/Desktop
}

# Record a video of the currently booted iOS simulator
rec () {
	xcrun simctl io booted recordVideo -f --codec=h264  ~/Desktop/$1-ios-src.mp4
	ffmpeg -i ~/Desktop/$1-ios-src.mp4 -profile:v baseline ~/Desktop/$1-ios-comp.mp4
}

# Compress a video
comp () {
	echo "Ouput filename:"
	read fileName
	ffmpeg -i $1 -profile:v baseline ~/Desktop/$fileName.mp4 && desk
}

# Notify user that task has been completed
notify () { 
	osascript -e 'tell application "Terminal" to display notification "Task Complete" with title "Task Complete"' 
	afplay /System/Library/Sounds/Purr.aiff
}

# Kill the audio process
killaudio () {
	sudo pkill coreaudiod
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

# Clear terminal
c () {
	clear
}

# List files
l () {
	ls
}

# List files with details
ll () {
	ls -la
}

# Clear metro cache
metro-clear () {
	watchman watch-del-all
	rm -rf /tmp/metro-*
}
