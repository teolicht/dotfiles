#!/bin/bash

# Many good commands: https://github.com/mathiasbynens/dotfiles/blob/main/.macos

# Quit System Preferences to avoid it from overriding these settings
osascript -e 'tell application "System Preferences" to quit'

# Disable accents popup when holding down key
defaults write -g ApplePressAndHoldEnabled -bool false 

# 'Key repeat rate' slider in Keyboard settings (min. there is 15) 
defaults write -g InitialKeyRepeat -int 10

# 'Delay until repeat' slider in Keyboard settings (min. there is 2 i think)
defaults write -g KeyRepeat -int 2 

# Enable ctrl+cmd+click to drag from anywhere on a window
defaults write -g NSWindowShouldDragOnGesture -bool true 

# Set to false to disable bounce when ctrl+cmd+click dragging
defaults write -g NSWindowShouldDragOnGestureFeedback -bool true 

# Should increase Bluetooth headphones audio quality
defaults write com.apple.BluetoothAudioAgent "Apple Bitpool Min (editable)" -int 40

# Show /Volumes folder
sudo chflags nohidden /Volumes

echo "Success!"
echo "Remember that a restart is needed for the changes to take effect."
