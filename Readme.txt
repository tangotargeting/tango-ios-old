———— Description —————

———— Optain API Key —————

———— Instalation —————

Manually:
You should add to your project Tango.framework and Tango.bundle files from here [https://github.com/tangotargeting/tango-ios.git] by drag and drop. After that follow "How to use" guide.

Add framework using CocoaPods:
CocoaPods is a dependency manager for Objective-C, which automates and simplifies the process of using 3rd-party libraries in your projects. See the "Getting Started" guide (https://guides.cocoapods.org/using/getting-started.html) for more information. You can install it with the following command:

$ gem install cocoapods

After installing go to your project directory and type this commad:

$ pod init

In project folder it will appear a file called Podfile. Open it and integrate Tango by typing:

target 'TargetName' do
pod 'Tango', :git => 'https://github.com/tangotargeting/tango-ios.git'

end

After filling Podfile save it and run following command:

$ pod install

Close your project , go to your project location on disk and open the workspace (yourProjectName.xcworkspace). Now the framework can be used, and for that please follow "How to use" guide.

———— How to use —————

After adding the framework into the project by following the installation guide, for using the framework you should follow this steps:

1) Open your project AppDelegate.m file and in didFinishLaunchingWithOptions method register for local notifications:
 	ex: 

	UIUserNotificationType types = UIUserNotificationTypeBadge | UIUserNotificationTypeSound | 								 UIUserNotificationTypeAlert;
    UIUserNotificationSettings *mySettings = [UIUserNotificationSettings settingsForTypes:types 											                          categories:nil];
    [[UIApplication sharedApplication] registerUserNotificationSettings:mySettings];

2) After that, you should create an array with your campaign tags:

	NSArray *tags = @[@"myCampaignTag1",@"myCampaignTag2"];

3) Next step is to initialize SDK with API key and tags by using initializeWithAPIKey method. If you don't have an API Key please follow "Optain API Key" guide.
	For using the library you should add the following import: #import <Tango/Tango.h>

	// Initialize with API key
	[Tango initializeWithAPIKey:@"yourApiKey" tags:tags];

4) Now that the sdk is initialized we should Handle launching from a notification by adding:

	 [Tango application:application didFinishLaunchingWithOptions:launchOptions];

5) In application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)localNotification method we should handle tango notification by adding: 

	[Tango application:application didReceiveLocalNotification:localNotification]; // TODO: Handle this in tango SDK.

6) If you are going to use a location campaign you need to add in your plist this key NSLocationAlwaysUsageDescription, for allowing the app to use location service.

7) Final step is for allowing SDK to refresh campaign, for this add the following method to AppDelegate.m file:

	- (void)application:(UIApplication *)application performFetchWithCompletionHandler:(void (^)	(UIBackgroundFetchResult))completionHandler {
  	  // Allow tango SDK to refresh campaing
   	 [Tango syncCampaingsWithCompletion:^{
        	completionHandler(UIBackgroundFetchResultNewData);
    		}];
	}

Build and run.
