# Tango targeting

Communication chanel for your existing customers

For more information please see [the website][1].
## Requirements

- iOS 9.0+ if you use only Tango framework
- iOS 10.0+ if you use both Tango and TangoRichNotification framework
- Xcode 8.1+
- Swift 3.0+

## Installation
### Install manually
1. Download latest version of Tango framework from [here](https://github.com/tangotargeting/tango-ios) and latest version of TangoRichNotification framework from [here](https://github.com/tangotargeting/TangoRichNotifications/).
2. Drag Tango.framework file into the project and for iOS10 rich notification after you created an NotificationServiceExtension using iOS 10 Rich Notifications guide from this file, drag TangoRichNotification.framework into your app extension group.
3. Go to your_projectTarget -> General and hit + button from Embedded Binaries and add Tango framework.
4. Before App Store submission you should strip the framework, for that read [this](#strip-framework-before-app-store-submission) guide.

### Install with CocoaPods

CocoaPods is a dependency manager, which automates and simplifies the process of using 3rd-party libraries in your projects. See the [Getting Started](https://guides.cocoapods.org/using/getting-started.html) guide for more information. You can install it with the following terminal command:

```
$ gem install cocoapods
```

After installing go to your project directory and type this commad:

```
$ pod init
```

In project folder it will appear a file called Podfile. Open it and integrate Tango by typing:

```
target 'TargetName' do
use_frameworks!
pod 'Tango', '~> 1.0.0'
end
```

After filling Podfile save it and run following command in the Terminal:

```
$ pod install
```

Close your project, go to your project location on disk and open the workspace the newly created `.xcworkspace` file inside your project directory. Now the framework can be used, and for that please follow "How to use" guide.

## Strip Framework before App Store submission
This is an universal framework, so due to [App Store submission bug](http://www.openradar.me/radar?id=6409498411401216) we need to strip framework for unused architectures, for that go to BuilPhases add a new “Run Script Phase” in your app’s target and paste the following snippet in the script text field:

```
bash "${BUILT_PRODUCTS_DIR}/${FRAMEWORKS_FOLDER_PATH}/Tango.framework/Scripts/strip-simulator-arch.sh"
```

### iOS 10 Rich Notifications

The library has support for iOS 10 notifications attachments, you can add images, animated gifs in a notification. For using this functionality you will need to create a  [notification service extension](https://developer.apple.com/reference/usernotifications/unnotificationserviceextension/). 

Create a new iOS target in Xcode (File -> New -> Target) and select the Notification Service Extension type
![NotificationServiceExtension image](https://github.com/tangotargeting/tango-ios/blob/master/Resources/NotificationServiceExtension.png?raw=true)

Add in your podfile the new target for notification extension and add TangoRichNotification framework, to do this add the following lines to your podspec:
```
target 'NotificationServiceExtesion-Target-Name' do
use_frameworks!
pod 'TangoRichNotification', '~> 1.0.0'
end
```
After filling Podfile save it and run following command in the Terminal:

```
$ pod install
```

Now the framework for iOS 10 notification can be used in notification service extension, and for that please follow “How to use” guide.

### Add capabilities

For using push notifications you should add the following capabilities. Go to Xcode select the target’s Capabilities pane and enable push notifications: 

![PushNotificatioCapabilities image](https://github.com/tangotargeting/tango-ios/blob/master/Resources/PushNotifications.png?raw=true)

You should also enable Backround Modes an Remote notifications capabilities: 

![BackgroundModes image](https://github.com/tangotargeting/tango-ios/blob/master/Resources/BackgroundModes.png?raw=true)

### APNS Setup
After you setup the framework in order to use push notification you should create an APNS Certificate which require membership in the [iOS Developer Program](https://developer.apple.com/programs/).

Go to [Apple Developer Members Center](https://developer.apple.com/account/ios/certificate/) click on App IDs from Identifiers section.

![AppIds image](https://github.com/tangotargeting/tango-ios/blob/master/Resources/App%20IDs.png?raw=true)

1. Select your app id. If you don't have an app id created select +  button and fill out the form, be sure you check Push Notification checkbox.
2. Expand your app by selecting your app id and you will see a field named Push Notifications with yellow or green status icons for development or distribution: ![PushNotificationStatus image](https://github.com/tangotargeting/tango-ios/blob/master/Resources/Push%20Notifications%20Status.png?raw=true)
3. Click edit button, go to Push Notifications section and press the button create certificate for distribution or development.![CreateCertificate image](https://github.com/tangotargeting/tango-ios/blob/master/Resources/Create%20Certificate.png?raw=true) Follow up the instructions to create an Certificate Signing Request (CSR) file from your Mac. And press continue.
4. Upload the CSR and after that press download to get the Certificate.
5. Open the certificate. Opening the certificate will open Keychain Access.
6. Select your certificate from  Keychain Access in My Certificates section, if the certificate is not here try in Certificate section. Right clik on it and then Export "Apple iOS Development/Distribution Push Service: your_app_bundle". 
This command will export the certificate in a .p12 file with a password.

### Add Certificate to Tango
After generating the Push Notification certificate go [here](https://app.tangotargeting.com/app) and create a new iOS app:

![CreateiOSApp image](https://github.com/tangotargeting/tango-ios/blob/master/Resources/Create%20iOS%20App.png?raw=true
)

After that you should fill the form with your app data:
- insert app bundle id
- insert app name
- drag and drop  .p12 file from previous step

![AddCertificate image](https://github.com/tangotargeting/tango-ios/blob/master/Resources/Add%20Certificate.png?raw=true)

# <a name="how-to"></a>How to use

After adding the framework into the project by following the installation guide, for using the framework you should follow this steps:

**1.Tango framework**

*1. Open your project AppDelegate.m file and import the Tango framework*

``` objc
import Tango
```
For iOS 10 you should also make another import: 

``` objc
import UserNotifications
```
Also for iOS 10 only you should add UNUserNotificationCenterDelegate in app delegate: 
``` objc
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {}
```

*2. In the `didFinishLaunchingWithOptions`, setup notification delegate (iOS 10 only) and initialize SDK with API key by using `initialize` method.*

``` objc
// iOS 10 only
UNUserNotificationCenter.current().delegate = self

// Initialize with API key
Tango.initialize(tango: "apiKey")
```

*3. After that you should implement the following delegate methods.*
``` objc
func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
Tango.application(application, didReceiveRemoteNotification: userInfo)
}

func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
Tango.application(application, didRegisterForRemoteNotificationsWithDeviceToken: deviceToken)
}

func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
Tango.application(application, didFailToRegisterForRemoteNotificationsWithError: error)
}

func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) {
Tango.application(application, didReceiveRemoteNotification: userInfo)
}

func application(_ application: UIApplication, didRegister notificationSettings: UIUserNotificationSettings) {
Tango.application(application, didRegister: notificationSettings)
}

func application(_ application: UIApplication, didReceive notification: UILocalNotification) {
Tango.application(application, didReceive: notification)
}
```

And for iOS 10 you should also add: 
``` objc
// MARK: UNUserNotificationCenterDelegate Methods

@available(iOS 10.0, *)
func userNotificationCenter(_ center: UNUserNotificationCenter,
didReceive response: UNNotificationResponse,
withCompletionHandler
completionHandler: @escaping () -> Void) {
Tango.userNotificationCenter(center, didReceive: response, withCompletionHandler: completionHandler)
}

@available(iOS 10.0, *)
func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
Tango.userNotificationCenter(center, willPresent: notification, withCompletionHandler: completionHandler)
}
```

*4. After initilizing the SDK if you want to add a user to a specific segment you should call  `registerSegments(segments: [String])` method, you can add this whenever you want:*

``` objc
func yourCustomMethod() {
Tango.registerSegments(segments: ["firstSegment", "secondSegment"])
}
```

*5. If you are going to use a location campaign you need to add in your plist this key NSLocationAlwaysUsageDescription.*

**2. TangoRichNotification framework**

*1. After creating the Notification service extension, go to NotificationService class:*
``` objc
import TangoRichNotification
```

*2. In `didReceive(_ request: UNNotificationRequest, withContentHandler contentHandler: @escaping (UNNotificationContent)` method remove:*
``` objc
if let bestAttemptContent = bestAttemptContent {
// Modify the notification content here...
bestAttemptContent.title = "\(bestAttemptContent.title) [modified]"
contentHandler(bestAttemptContent)
}
```
and add 
``` objc
if let bestAttemptContent = bestAttemptContent {
TangoRichNotification.setupRichContent(content: bestAttemptContent, completionHandler: { (content) in
contentHandler(content)
})
}
```

**3. Build and run :)**

## License

Copyright 2017 Tango Targeting, Inc.

[1]: http://tangotargeting.com
