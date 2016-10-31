//
//  Publistats.h
//  Publistats
//
//  Created by Hahn, Raul on 7/28/16.
//  Copyright © 2016 Publistats. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Publistats : NSObject

+ (void)initializeWithAPIKey:(NSString *)apiKey tags:(NSArray *)tags debug:(BOOL)debug;

+ (void)syncCampaingsWithCompletion:(void (^)())completion;


+ (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)localNotification;

+ (void)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions;

@end


@interface UILocalNotification (Publistats)
- (BOOL)isPublistatsNotification;
@end
