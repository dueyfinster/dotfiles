# Running manually
1. Need to install [Karabiner Virtual Device Driver](https://github.com/pqrs-org/Karabiner-DriverKit-VirtualHIDDevice)
2. Need to activate it:
```
sudo /Applications/.Karabiner-VirtualHIDDevice-Manager.app/Contents/MacOS/Karabiner-VirtualHIDDevice-Manager activate
```
3. Need to start it as a daemon:
```
sudo '/Library/Application Support/org.pqrs/Karabiner-DriverKit-VirtualHIDDevice/Applications/Karabiner-VirtualHIDDevice-Daemon.app/Contents/MacOS/Karabiner-VirtualHIDDevice-Daemon'
```
4. Need to install Kanata with CMD key allowed and run it withg the config file:
```
sudo ./kanata_macos_cmd_allowed_arm64 --cfg kanata-mac.kbd
```

# TODO: Kanata on MacOS with plist

Take the plist in this directory and install it:
```
sudo cp ./com.neilgrogan.kanata.plist /Library/LaunchDaemons/
```

Then load it:
```
sudo launchctl load /Library/LaunchDaemons/com.neilgrogan.kanata.plist
sudo launchctl start com.neilgrogan.kanata
```

You might have to specifically allow the executable `kanata` the permission for `input monitoring` (if you didn't get this GUI popup guiding you to do so already). To do this go to Settings > Privacy & Security > Input Monitoring, and click the `+` icon, navigate to the place your kanata executable is (should match the same path in the `*.plist` above, `~/.cargo/bin/kanata`), and add it.

Now, kanata should be running whenever your macbook starts up!

To help with debugging any potential issues, you can look in the error log specified by the `*.plist`:

```
sudo tail -f /Library/Logs/Kanata/kanata.err.log
```

If you use multiple keyboards, you may want to limit this to only showing up on your MacBooks internal keyboard.
