//
//  AppDelegate.h
//  fa-demo-insurance-app
//
//  Created by Raphaël El Beze on 21/04/2016.
//  Copyright © 2016 FollowAnalytics. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FollowApps/FAFollowApps.h>
#import <UserNotifications/UserNotifications.h>


@interface AppDelegate : UIResponder <UIApplicationDelegate, FAFollowAppsDelegate, UNUserNotificationCenterDelegate>

@property (strong, nonatomic) UIWindow *window;

@end

