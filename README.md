# FakeCallApp1

Even if you are a bit shy and not a good talker, you won't need to fret about awkward situations such as pushy sales talk or boring party anymore.   FakeCallApp1 lets you generate fake incoming call toward your iPhone whenever you want to.

Just tap the button, the native call UI of iOS appears with the native ringtone and vibration.   Then you simply pretend as if you are talking on the phone, you can save your precious time.

# Features

* Realistic fake incoming call with native call UI, ringtone and vibration of iOS.
* Customisable caller name
* Call history which you can check in the native Phone app

# Demonstration

<img src="https://user-images.githubusercontent.com/84314868/119223281-68bee800-bb33-11eb-8d30-d54db9370efc.gif" width="320px">

# System Flow

### Prerequisite
![slide1 001](https://user-images.githubusercontent.com/84314868/119223365-f8649680-bb33-11eb-8504-67c5e2bd01d6.jpeg)


### VoIP Push Flow
![slide2 001](https://user-images.githubusercontent.com/84314868/119223397-319d0680-bb34-11eb-92f4-db62588ea865.jpeg)


1. User triggers `AWSPinpointTargeting.default().sendMessages(_ request: AWSPinpointTargetingSendMessagesRequest)` with valid device token.
2. Amazon Pinpoint requests APNs (Apple Push Notification service) to send VoIP (Voice over Internet Protocol) Push Notification.
3. APNs sends VoIP Push Notification toward user's device.
4. Device responds to VoIP Notification through Pushkit and Callkit.

# Requirement
* iOS 10.0 or later

# Download
Beta version is now available in TestFlight.  
You can download the app from the link below.

<https://testflight.apple.com/join/SCFk96GA>

# Development Environment
* macOS Big Sur 11.3
* Xcode 12.5
* CocoaPods 1.10.0
* Swift 5.4
* Python 3.8
* AWS Amplify
* Amazon Cognito
* AWS Lambda
* Amazon Pinpoint
* amplify-cli 4.50.2
* aws-cli 2.1.27
* Pushkit
* Callkit
