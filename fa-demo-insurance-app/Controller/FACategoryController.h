//
//  FACategoryController.h
//  fa-demo-insurance-app
//
//  Created by Raphaël El Beze on 24/04/2016.
//  Copyright © 2016 FollowAnalytics. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FANavigationBar.h"

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


typedef enum : NSUInteger {
    FAtypeViewCars,
    FAtypeViewFamily,
    FAtypeViewInsurance,
} FAtypeView;

@interface FACategoryController : UIViewController

@property (nonatomic, retain) NSString *contractRef;
@property (nonatomic, retain) NSString *dateString;
@property (nonatomic, retain) NSString *priceString;
@property (nonatomic, retain) UIImage *navBarBackground;
@property (weak, nonatomic) IBOutlet UIView *headerNavView;

@property (nonatomic, assign) FAtypeView typeView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;




@end
