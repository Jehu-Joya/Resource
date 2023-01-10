#！/bin/bash
COMMAND="$1"

UANMEA=$(uname -a)
ARCH="arm64"
DEST=$HOME/.config/clash/service
PLIST=/Library/LaunchDaemons/com.lbyczf.cfw.helper.plist

if [[ $UANMEA == *"x86_64" ]]; then
  ARCH="x64"
fi

SOURCE=/Applications/Clash\ for\ Windows.app/Contents/Resources/static/files/darwin/$ARCH/service

read -r -d '' PLIST_CONTENT << EOM
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
    <dict>
        <key>Label</key>
        <string>com.lbyczf.cfw.helper</string>
        <key>Program</key>
        <string>$DEST/clash-core-service</string>
        <key>RunAtLoad</key>
        <true/>
        <key>KeepAlive</key>
        <true/>
        <key>HardResourceLimits</key>
        <dict>
            <key>NumberOfFiles</key>
            <integer>10240</integer>
        </dict>
        <key>SoftResourceLimits</key>
        <dict>
            <key>NumberOfFiles</key>
            <integer>10240</integer>
        </dict>
    </dict>
</plist>
EOM

if [ "$COMMAND" = "install" ]; then
  rm -rf "$DEST"
  cp -R "$SOURCE" "$DEST"
  echo $PLIST_CONTENT > $PLIST
  launchctl unload $PLIST &>/dev/null
  launchctl load $PLIST
fi

if [ "$COMMAND" = "uninstall" ]; then
  launchctl unload $PLIST
  rm -rf "$DEST"
  rm -rf $PLIST
fi