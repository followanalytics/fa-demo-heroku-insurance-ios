//
//  FAConstants.h
//  fa-demo-insurance-app
//
//  Created by Raphaël El Beze on 03/05/2016.
//  Copyright © 2016 FollowAnalytics. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


UIKIT_EXTERN NSString *const FAInsuranceUserId;
UIKIT_EXTERN NSString *const FAInsuranceReceiveNotificationTravel;
UIKIT_EXTERN NSString *const FAInsuranceReceiveNotificationCar;
UIKIT_EXTERN NSString *const FAInsuranceReceiveNotificationProperty;

UIKIT_EXTERN NSString *const FAInsuranceSDKAPIKey;
