# iBunnySparks 🐰✨

A cross-platform creative writing and idea recording app built with [Skip](https://skip.tools).

## Features
- 📝 Record and organize creative ideas
- 🔍 Search through your ideas  
- 📱 Works on both iOS and Android
- 💾 Automatic local storage

## Built With
- [Skip](https://skip.tools) - Cross-platform Swift development
- SwiftUI - Modern UI framework

## Building
```bash
skip build --platform ios
skip build --platform android  
skip test
skip export

## Building

This project is both a stand-alone Swift Package Manager module,
as well as an Xcode project that builds and translates the project
into a Kotlin Gradle project for Android using the skipstone plugin.

Building the module requires that Skip be installed using
[Homebrew](https://brew.sh) with `brew install skiptools/skip/skip`.

This will also install the necessary Skip prerequisites:
Kotlin, Gradle, and the Android build tools.

Installation prerequisites can be confirmed by running
`skip checkup`. The project can be validated with `skip verify`.

## Running

Xcode and Android Studio must be downloaded and installed in order to
run the app in the iOS simulator / Android emulator.
An Android emulator must already be running, which can be launched from
Android Studio's Device Manager.

The project can be opened and run in Xcode from
`Project.xcworkspace`, which also enabled parallel
development of any Skip libary dependencies.

To run both the Swift and Kotlin apps simultaneously,
launch the "IBunnySparks App" target from Xcode.
A build phases runs the "Launch Android APK" script that
will deploy the Skip app to a running Android emulator or connected device.
Logging output for the iOS app can be viewed in the Xcode console, and in
Android Studio's logcat tab for the transpiled Kotlin app, or
using `adb logcat` from a terminal.

## Testing

The module can be tested using the standard `swift test` command
or by running the test target for the macOS destination in Xcode,
which will run the Swift tests as well as the transpiled
Kotlin JUnit tests in the Robolectric Android simulation environment.

Parity testing can be performed with `skip test`,
which will output a table of the test results for both platforms.
