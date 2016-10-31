//
//  Tango.h
//  Tango
//
//  Created by Hahn, Raul on 7/28/16.
//  Copyright © 2016 Tango Targeting Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/** This notification is triggered when user press on a notification view or on a campaign and there is a custom action defined for a campaign. Notification object contains the URI predefined when campaign was created.
 */
extern NSString *const TANCustomActionNotification;

@interface Tango : NSObject

/** This method is used for initialize the sdk with apiKey and tags
 *  @param apiKey a string with apiKey
 *  @param tags an array of strings representing the tags for the campaign.
 */
+ (void)initializeWithAPIKey:(NSString *)apiKey tags:(NSArray *)tags;

/** This method is used for initialize the SDK. Use this method if you want to requestLocationAuthorization when you initiliaze SDK for a location campaign. You can stil requestLocationAuthorization after by calling [Tango requestLocationAlwaysAuthorization].
 *
 *  @param apiKey a string with apiKey
 *  @param tags an array of strings representing the tags for the campaign.
 *  @param requestLocationAuthorization a boolean that indicates if you should request location authorization when SDK is initialize.
 */
+ (void)initializeWithAPIKey:(NSString *)apiKey tags:(NSArray *)tags requestLocationAuthorization:(BOOL)requestLocationAuthorization;

/** Use this method to sync campaigns with your device.
 *  @param completionBlock.
 */
+ (void)syncCampaingsWithCompletion:(void (^)())completion;

/** Call this method in your AppDelegate method for handling Tango notification inside the SDK.
 *
 *  @param application the application
 *  @param localNotification received notification
 */
+ (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)localNotification;

/** Call this method in your AppDelegate method for handling Tango notification inside the SDK when app is lauched.
 *
 *  @param application the application
 *  @param launchOptions
 */
+ (void)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions;

/** Use this method when you have a custom trigger campaign on your device an you want to trigger it on your acction.
 *
 * @param triggerKey the string that you defined as a triggerKey when you created the campaign.
 */
+ (void)trigger:(NSString *)triggerKey;

/** Use this method to see the profile page were you cand enable/disable functionalities.Or opt in/out for Tango notifications.
 */
+ (void)infoPage;

/** Use this method when you want to request location authorization for location campaigns.
 */
+ (void)requestLocationAlwaysAuthorization;

@end

@interface UILocalNotification (Tango)

/// Method used to verify if local notification is Tango notification.
- (BOOL)isTangoNotification;
@end
