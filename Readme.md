# Description

# <a name="obtain-api-key"></a>Obtain the API key

You can find the API Key in on the [iOS integration page](https://app-demo.tangotargeting.com/integration/ios) in the Tango Console. 

# Installation

## Manually

Download the Tango archive [here](https://github.com/tangotargeting/tango-ios/archive/0.0.1.zip), unzip it and than add it to `Tango.framework` and `Tango.bundle` files to your project by drag and drop. After that follow our [How to use](#how-to) guide.

## Install with CocoaPods

CocoaPods is a dependency manager for Objective-C, which automates and simplifies the process of using 3rd-party libraries in your projects. See the [Getting Started](https://guides.cocoapods.org/using/getting-started.html) guide for more information. You can install it with the following terminal command:

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

pod 'Tango', '~> 0.0.1'

end
```

After filling Podfile save it and run following command in the Terminal:

```
$ pod install
```

Close your project, go to your project location on disk and open the workspace the newly created `.xcworkspace` file inside your project directory. Now the framework can be used, and for that please follow "How to use" guide.

# <a name="how-to"></a>How to use

After adding the framework into the project by following the installation guide, for using the framework you should follow this steps:

1) Open your project AppDelegate.m file and import the Tango framework

```
#import <Tango/Tango.h>
```

2) In the `didFinishLaunchingWithOptions` method register for local notifications:

```
UIUserNotificationType types = UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert;
UIUserNotificationSettings *mySettings = [UIUserNotificationSettings settingsForTypes:types categories:nil];
[[UIApplication sharedApplication] registerUserNotificationSettings:mySettings];
```

3) After that, you should create an array with your campaign tags:

```
NSArray *tags = @[@"myCampaignTag1",@"myCampaignTag2"];
```

4) Next step is to initialize SDK with API key and tags by using `initializeWithAPIKey` method. If you don't have an API Key please follow [Optain API Key](#obtain-api-key) guide.	

```
// Initialize with API key
[Tango initializeWithAPIKey:@"yourApiKey" tags:tags];
```

5) Now that the sdk is initialized, add the following method:

```
[Tango application:application didFinishLaunchingWithOptions:launchOptions];
```

6) In `application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)localNotification` method we should handle Tango notifications by adding:

```
- (void)application:(UIApplication) application didReceiveLocalNotification:(UILocalNotification )localNotification {
   [Tango application:application didReceiveLocalNotification:localNotification];
}
```

7) If you are going to use a location campaign you need to add in your `info.plist` file this key `NSLocationAlwaysUsageDescription`, for allowing the app to use location service.

8) Allow the SDK to refresh the campaigns, by adding the following method in the `AppDelegate.m` file:

```
- (void)application:(UIApplication *)application performFetchWithCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
  	  // Allow tango SDK to refresh campaing
    [Tango syncCampaingsWithCompletion:^{
        completionHandler(UIBackgroundFetchResultNewData);
    }];
}
```

9) Build and run :)
