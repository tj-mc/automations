rec () {
	xcrun simctl io booted recordVideo -f --codec=h264  ~/Desktop/$1.mp4
	ffmpeg -i ~/Desktop/$1.mp4 -profile:v baseline ~/Desktop/$1-comp.mp4
	open ~/Desktop
}

comp () {
	ffmpeg -i $1 -profile:v baseline ~/Desktop/compress.mp4 
}

android () {
	~/Library/Android/sdk/emulator/emulator @nexus -gpu on -no-boot-anim -no-snapshot-load
}

notify () { 
	osascript -e 'tell application "Terminal" to display notification "Task Complete" with title "Task Complete"' 
	say 'Task Complete'
}

rn () {
	cd ~/Documents/dev/react-native
}

killaudio () {
	sudo pkill coreaudiod
}
