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

# Boot an iOS simulator
ios () {
	xcrun simctl boot $DEFAULT_IOS_SIM_ID && open -a Simulator
}

# Boot an android simulator
android () {
	~/Library/Android/sdk/emulator/emulator @$DEFAULT_ANDROID_SIM_ID -gpu on -no-boot-anim -no-snapshot-load
}

# Notify user that task has been completed
notify () { 
	osascript -e 'tell application "Terminal" to display notification "Task Complete" with title "Task Complete"' 
	afplay /System/Library/Sounds/Purr.aiff
}

# Change to the react-native directory
rn () {
	cd $RN_DIRECTORY 
}

# Run all react-native unit tets	
rn-test-silent () {
	rn && npm test -- --watchAll --bail=1 --forceExit --reporters=jest-silent-reporter --silent
}

# Run all react-native unit tets with verbose output
rn-test () {
	rn && npm test -- --watchAll --bail=1 --forceExit --maxWorkers=100% $1
}

# Kill the audio process
killaudio () {
	sudo pkill coreaudiod
}

# Prepare a merge request message
rn-mr () {
	rn
	commit_message=$(git log -1 --pretty=%B)
	commit_message="${commit_message} :pr:"

	echo MR Link:
	read mr_link
	commit_message="${commit_message}\n${mr_link}"

	echo $commit_message | pbcopy

	echo Wrote message to clipboard.

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

# Instantly 'bin' large folders and files
trash () {
	if [[ $1 == '--empty' ]]; then
		rm -rf ~/.quick-delete-cache
		echo 'Trash emptied'
	else
		mv $1 ~/.quick-delete-cache/$1
	fi;
}

# Clear metro cache
metro-clear () {
	watchman watch-del-all
	rm -rf /tmp/metro-*
}
