# Record a video of the currently booted iOS simulator
rec () {
	xcrun simctl io booted recordVideo -f --codec=h264  ~/Desktop/$1.mp4
	ffmpeg -i ~/Desktop/$1.mp4 -profile:v baseline ~/Desktop/$1-comp.mp4
	open ~/Desktop
}

# Compress a video
comp () {
	ffmpeg -i $1 -profile:v baseline ~/Desktop/compress.mp4 
}

# Boot an iOS simulator
ios () {
	xcrun simctl boot A02E834D-110D-4260-9113-5BE82E8DEDCB && open -a Simulator
}

# Boot an android simulator
android () {
	~/Library/Android/sdk/emulator/emulator @nexus -gpu on -no-boot-anim -no-snapshot-load
}

# Notify user that task has been completed
notify () { 
	osascript -e 'tell application "Terminal" to display notification "Task Complete" with title "Task Complete"' 
	say "Task Complete"
}

# Change to the react-native directory
rn-dir () {
	cd $RN_DIRECTORY 
}

# Run all react-native unit tets	
rn-test () {
	rn-dir && npm test -- --watchAll --bail=1 --forceExit --reporters=jest-silent-reporter --silent
}

# Run all react-native unit tets with verbose output
rn-test-v () {
	rn-dir && npm test -- --watchAll --bail=1 --forceExit 
}

# Kill the audio process
killaudio () {
	sudo pkill coreaudiod
}

# Prepare a merge request message
rn-mr () {
	rn-dir
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
	open /Applications/Slack.app
}

# Cafe ambience
cafe () {
	browser "https://www.youtube.com/watch?v=c0_ejQQcrwI"
}

# Google something
google () { 
	browser "https://www.google.com/search?q=$1"
}

# Open broswer
browser () {
	open /Applications/Google\ Chrome.app/ $@
}

# Print the hash of the current commit
commithash () {
	git rev-parse HEAD
}

rn-dev () {
	osascript -e 'tell app "Simulator" to activate'
	osascript -e 'tell application "System Events" to keystroke "z" using {control down, command down}'
}

rn-rebuild () {
	rn-dir && npm i && cd ios && pod install && rn-dir && notify
}

xc-clear () {
	rm -rf ~/Library/Developer/Xcode/DerivedData
}

c () {
	clear
}
