#!/bin/bash

###
## Build and test the project
##
## Created by yukonblue on 07/06/2022
##

function RunDefaultBuild() {
    echo "Begin running default build .."
    xcodebuild -project src/CoreColor/CoreColor.xcodeproj -scheme CoreColor -destination 'platform=iOS Simulator,name=iPhone 13' || exit 1
    echo "Finished running default build .."
}

function RunDefaultBuildAndTests() {
    echo "Begin running default build and tests .."
    xcodebuild test -project src/CoreColor/CoreColor.xcodeproj -scheme CoreColorTests -destination 'platform=iOS Simulator,name=iPhone 13' || exit 1
    echo "Finished running default build and tests .."
}

if [ "$GITHUB_ACTIONS" = true ] ; then
    echo "Running CI build configuration ..."
    RunDefaultBuildAndTests
else
    echo "Running local build configuration ..."
    RunDefaultBuildAndTests
fi
