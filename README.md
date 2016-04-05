# Plist to CloudKit
![CloudKit](cloudkit_2x.png)

Upload your Plist files instantly to CloudKit using this tool. You do not need to manually enter your data to CloudKit.

## Installation

Add the file [PlistCloud.swift](PlistToCloudkit/PlistCloud.swift) to your project

## Usage

1. In the [iCloud dashboard](https://icloud.developer.apple.com/dashboard/), add your Record type and attributes.
![Dashboard example](cloudkitDashboard.png?raw=true "Dashboard example")
2. Turn on iCloud in the Capabilities tab for your build target. Make sure to enable CloudKit using the checkbox that shows up.
![iCloud Entitlements](entitlements.png?raw=true "Entitlement example")
3. Set the container name `PlistCloud.setContainer("iCloud.com.carrotApps.plist")`
4. Set the Record Type name `PlistCloud.setRecord("contact")`
5. Set the field names `PlistCloud.setFields(["id","name"])`
6. Set your Plist file name `PlistCloud.setFileName("contact")`
![Plist File](plistFile.png?raw=true "Plist file example")

## Example Project

Run the program and check the [ExampleViewController.swift](PlistToCloudkit/ExampleViewController.swift) file to see how this works!

##Feedback and Contribution

##Copyrights

* Copyright (c) 2016 - Dawand Sulaiman.
