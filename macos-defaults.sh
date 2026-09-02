#!/usr/bin/env zsh
# Common macOS system tweaks. Safe to re-run.
# Run standalone or via bootstrap-mac.sh.
set -euo pipefail

log() { print -P "%F{cyan}==>%f $*"; }

log "Applying macOS defaults — close System Settings first if open"
osascript -e 'tell application "System Settings" to quit' 2>/dev/null || true

###############################################################################
# Keyboard
###############################################################################
# Fastest key repeat (lower = faster). System Settings minimum is 2/15.
defaults write NSGlobalDomain InitialKeyRepeat -int 15
defaults write NSGlobalDomain KeyRepeat -int 2
# Disable press-and-hold accent picker (so vim hjkl works)
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false
# Disable smart quotes/dashes/autocorrect (annoying in code)
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false
defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false

###############################################################################
# Trackpad / Mouse
###############################################################################
# Tap to click
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
# Disable "natural" (reversed) scroll direction
defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false

###############################################################################
# Finder
###############################################################################
# Show hidden files, file extensions, path bar, status bar
defaults write com.apple.finder AppleShowAllFiles -bool true
defaults write NSGlobalDomain AppleShowAllExtensions -bool true
defaults write com.apple.finder ShowPathbar -bool true
defaults write com.apple.finder ShowStatusBar -bool true
# Search current folder by default
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"
# Disable .DS_Store on network/USB volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true
# No warning when changing file extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

###############################################################################
# Dock
###############################################################################
# Auto-hide, faster animation, no recent apps
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock autohide-time-modifier -float 0.4
defaults write com.apple.dock autohide-delay -float 0
defaults write com.apple.dock show-recents -bool false
# Smaller icons
defaults write com.apple.dock tilesize -int 42

###############################################################################
# Hot corners
###############################################################################
# Bottom-right corner -> Quick Note
defaults write com.apple.dock wvous-br-corner -int 14
defaults write com.apple.dock wvous-br-modifier -int 0

###############################################################################
# Keyboard shortcuts — Mission Control
###############################################################################
# Ctrl+1 / Ctrl+2 / Ctrl+3 / Ctrl+4 -> Switch to Desktop 1-4 (Ctrl+4 is unchecked by default)
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 118 '<dict><key>enabled</key><true/><key>value</key><dict><key>parameters</key><array><integer>65535</integer><integer>18</integer><integer>262144</integer></array><key>type</key><string>standard</string></dict></dict>'
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 119 '<dict><key>enabled</key><true/><key>value</key><dict><key>parameters</key><array><integer>65535</integer><integer>19</integer><integer>262144</integer></array><key>type</key><string>standard</string></dict></dict>'
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 120 '<dict><key>enabled</key><true/><key>value</key><dict><key>parameters</key><array><integer>65535</integer><integer>20</integer><integer>262144</integer></array><key>type</key><string>standard</string></dict></dict>'
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 121 '<dict><key>enabled</key><true/><key>value</key><dict><key>parameters</key><array><integer>65535</integer><integer>21</integer><integer>262144</integer></array><key>type</key><string>standard</string></dict></dict>'

###############################################################################
# Menu bar clock
###############################################################################
defaults write com.apple.menuextra.clock ShowDate -int 0
defaults write com.apple.menuextra.clock ShowDayOfWeek -bool true
defaults write com.apple.menuextra.clock ShowAMPM -bool true

###############################################################################
# Screenshots
###############################################################################
mkdir -p "$HOME/Pictures/Screenshots"
defaults write com.apple.screencapture location -string "$HOME/Pictures/Screenshots"
defaults write com.apple.screencapture type -string "png"
# No shadow on window screenshots
defaults write com.apple.screencapture disable-shadow -bool true

###############################################################################
# Misc
###############################################################################
# Save to disk (not iCloud) by default
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false
# Expand save/print panels by default
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true

###############################################################################
# Restart affected apps
###############################################################################
for app in Finder Dock SystemUIServer; do
  killall "$app" &>/dev/null || true
done

log "Done. Some changes require logout/restart to fully apply."
