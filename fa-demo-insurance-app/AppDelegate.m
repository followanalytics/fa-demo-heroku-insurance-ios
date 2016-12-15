//
//  AppDelegate.m
//  fa-demo-insurance-app
//
//  Created by Raphaël El Beze on 21/04/2016.
//  Copyright © 2016 FollowAnalytics. All rights reserved.
//

#import "AppDelegate.h"
#import "FALoginView.h"
#import "FAHomeViewController.h"
#import "FAConstants.h"
#import "FACategoryController.h"

@interface AppDelegate ()

@property (nonatomic, retain) FALoginView *loginView;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [FAFollowApps configureWithId:FAInsuranceSDKAPIKey debugStateOn:NO options:launchOptions];
    [FAFollowApps registerForPush];
    // make data reach the server as soon as possible
    [FAFollowApps setMaxBackgroundTimeWithinSession:0];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
    if (![[NSUserDefaults standardUserDefaults] valueForKey:FAInsuranceUserId])
    {
        [self showLogin];

    }
    
    [FAFollowApps logEventWithName:@"interstitial" details:nil];
    
    if ([UIMutableApplicationShortcutItem instancesRespondToSelector:@selector(initWithType:)]) {
        UIMutableApplicationShortcutItem *shortCutItemAuto = [[UIMutableApplicationShortcutItem alloc] initWithType:@"openAuto" localizedTitle:@"Auto"];
        
        [shortCutItemAuto setUserInfo:[NSDictionary dictionaryWithObject:@"ok" forKey:@"auto"]];
        
        UIApplicationShortcutIcon *icon = [UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeFavorite];
        [shortCutItemAuto setIcon:icon];
        
        UIMutableApplicationShortcutItem *shortCutItemProperty = [[UIMutableApplicationShortcutItem alloc] initWithType:@"openProperty" localizedTitle:@"Property"];
        
        [shortCutItemProperty setUserInfo:[NSDictionary dictionaryWithObject:@"ok" forKey:@"property"]];
        
        [shortCutItemProperty setIcon:icon];
        
        
        UIMutableApplicationShortcutItem *shortCutItemTravel = [[UIMutableApplicationShortcutItem alloc] initWithType:@"openTravel" localizedTitle:@"Travel"];
        
        [shortCutItemTravel setUserInfo:[NSDictionary dictionaryWithObject:@"ok" forKey:@"travel"]];
        [shortCutItemTravel setIcon:icon];
        
        application.shortcutItems = @[shortCutItemAuto,shortCutItemProperty,shortCutItemTravel];
        

    }
    
    return YES;
}



- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
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


- (void)followAppsShouldHandleParameters:(NSDictionary *)customParameters actionIdentifier:(NSString *)actionIdentifier actionTitle:(NSString *)actionTitle completionHandler:(void (^)())completionHandler
{
    NSString *segueString = nil;
    NSString *senderString = nil;
    
    if ([customParameters valueForKey:@"travel"])
    {
        [[NSUserDefaults standardUserDefaults] setObject:@"OK" forKey:FAInsuranceReceiveNotificationTravel];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        segueString = @"showTravel";
        
        [FAFollowApps logEventWithName:@"travel_btn" details:nil];
    }
    else if ([customParameters valueForKey:@"auto"])
    {
        [[NSUserDefaults standardUserDefaults] setObject:@"OK" forKey:FAInsuranceReceiveNotificationCar];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        segueString = @"showCategory";
        senderString = @"auto.DL";
        
        [FAFollowApps logEventWithName:@"carDetail_btn" details:@"John's car"];
    }
    else if ([customParameters valueForKey:@"property"])
    {
        [[NSUserDefaults standardUserDefaults] setObject:@"OK" forKey:FAInsuranceReceiveNotificationProperty];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        segueString = @"showCategory";
        senderString = @"property.DL";
        
        [FAFollowApps logEventWithName:@"propertyDetail_btn" details:@"Vacation residence"];
    }
    if (segueString)
    {
        if ([((UINavigationController *)self.window.rootViewController).visibleViewController isKindOfClass:[FAHomeViewController class]])
        {
            [self.window.rootViewController.childViewControllers.firstObject performSegueWithIdentifier:segueString sender:senderString];
        }
        else
        {
            [self.window.rootViewController dismissViewControllerAnimated:NO completion:^{
            [self.window.rootViewController.childViewControllers[0] performSegueWithIdentifier:segueString sender:senderString];
                
            }];

        }
    }
}

- (void)followAppsShouldHandleWebViewUrl:(NSURL *)url withTitle:(NSString *)webviewTitle
{
    
}

#pragma mark - Login View

- (void)showLogin
{
    UINavigationController *navC = (UINavigationController *)self.window.rootViewController;
    if (navC.viewControllers.count > 1) {
        [navC popToRootViewControllerAnimated:NO];
    }
    
    if (nil == self.loginView)
    {
        
        self.loginView = [[NSBundle mainBundle] loadNibNamed:@"FALoginView" owner:nil options:nil][0];
        FAHomeViewController *homeController = self.window.rootViewController.childViewControllers.firstObject;
        self.loginView.delegate = homeController;
    }
    
    [self.window.rootViewController.view addSubview:self.loginView];
}

- (void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void (^)(BOOL))completionHandler {
    
    
    [[NSUserDefaults standardUserDefaults] synchronize];
    if ([[NSUserDefaults standardUserDefaults] valueForKey:FAInsuranceUserId])
    {
        NSString *segueString = nil;
        NSString *senderString = nil;
        
        if ([shortcutItem.userInfo valueForKey:@"travel"])
        {
            [[NSUserDefaults standardUserDefaults] setObject:@"OK" forKey:FAInsuranceReceiveNotificationTravel];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            segueString = @"showTravel";
            
            [FAFollowApps logEventWithName:@"travel_btn" details:nil];
        }
        else if ([shortcutItem.userInfo valueForKey:@"auto"])
        {
            [[NSUserDefaults standardUserDefaults] setObject:@"OK" forKey:FAInsuranceReceiveNotificationCar];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            segueString = @"showCategory";
            senderString = @"auto";
            
            [FAFollowApps logEventWithName:@"carDetail_btn" details:@"John's car"];
        }
        else if ([shortcutItem.userInfo valueForKey:@"property"])
        {
            [[NSUserDefaults standardUserDefaults] setObject:@"OK" forKey:FAInsuranceReceiveNotificationProperty];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            segueString = @"showCategory";
            senderString = @"property";
            
            [FAFollowApps logEventWithName:@"propertyDetail_btn" details:@"Vacation residence"];
        }
        if (segueString)
        {
            if ([((UINavigationController *)self.window.rootViewController).visibleViewController isKindOfClass:[FAHomeViewController class]])
            {
                [self.window.rootViewController.childViewControllers.firstObject performSegueWithIdentifier:segueString sender:senderString];
            }
            else
            {
                [self.window.rootViewController dismissViewControllerAnimated:NO completion:^{
                    [self.window.rootViewController.childViewControllers[0] performSegueWithIdentifier:segueString sender:senderString];
                    
                }];
                
            }
        }

    }
    
    if (completionHandler) {
        completionHandler(YES);
    }

}

- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler
{
    if (completionHandler)
    {
        completionHandler(UNNotificationPresentationOptionAlert);
    }
}

@end
