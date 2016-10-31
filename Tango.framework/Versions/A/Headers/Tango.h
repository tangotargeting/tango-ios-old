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

+ (void)initializeWithAPIKey:(NSString *)apiKey tags:(NSArray *)tags;

+ (void)initializeWithAPIKey:(NSString *)apiKey tags:(NSArray *)tags requestLocationAuthorization:(BOOL)requestLocationAuthorization;

+ (void)initializeWithAPIKey:(NSString *)apiKey tags:(NSArray *)tags debug:(BOOL)debug;

+ (void)syncCampaingsWithCompletion:(void (^)())completion;

+ (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)localNotification;

+ (void)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions;

+ (void)trigger:(NSString *)triggerKey;

+ (void)infoPage;

+ (void)requestLocationAlwaysAuthorization;

@end

@interface UILocalNotification (Tango)
- (BOOL)isTangoNotification;
@end
