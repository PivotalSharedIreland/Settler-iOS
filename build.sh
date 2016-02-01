#!/bin/sh

xcodebuild -workspace Settler.xcodeproj/project.xcworkspace -scheme "Full Test Suite" -sdk iphonesimulator -destination 'platform=iOS Simulator,name=iPhone 6,OS=9.2' test