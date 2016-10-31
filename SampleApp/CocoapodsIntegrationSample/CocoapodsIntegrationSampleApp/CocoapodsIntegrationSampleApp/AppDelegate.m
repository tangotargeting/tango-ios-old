//
//  AppDelegate.m
//  CocoapodsIntegrationSampleApp
//
//  Created by Raul Hahn on 02/09/16.
//  Copyright © 2016 tango. All rights reserved.
//

#import "AppDelegate.h"
#import <Publistats/Publistats.h>

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // This is required by Publistats to show local notifications
    UIUserNotificationType types = UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert;
    UIUserNotificationSettings *mySettings = [UIUserNotificationSettings settingsForTypes:types categories:nil];
    [[UIApplication sharedApplication] registerUserNotificationSettings:mySettings];
    
    NSArray *tags = [[NSUserDefaults standardUserDefaults] valueForKey:@"PublistatsTags"];
    if (tags == nil) {
        tags = @[@"campaignTag", @"anotherCampaignTag"];
        [[NSUserDefaults standardUserDefaults] setObject:tags forKey:@"PublistatsTags"];
    }
    
    [Publistats initializeWithAPIKey:@"PDsgiSa7nW54XCpVe32ZX66eoxwn9AC7" tags:tags debug:YES];
    
    // Handle launching from a notification
    [Publistats application:application didFinishLaunchingWithOptions:launchOptions];
    
    return YES;
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)localNotification {
    
    // handle publistats notifications
    [Publistats application:application didReceiveLocalNotification:localNotification];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)application:(UIApplication *)application performFetchWithCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    // Allow publistats SDK to refresh campaing
    [Publistats syncCampaingsWithCompletion:^{
        completionHandler(UIBackgroundFetchResultNewData);
    }];
}

@end
