//
//  UINavigationBar+FANavigationBar.m
//  fa-demo-insurance-app
//
//  Created by Raphaël El Beze on 24/04/2016.
//  Copyright © 2016 FollowAnalytics. All rights reserved.
//

#import "UINavigationBar+FANavigationBar.h"
#import "FANavigationBar.h"
#import "AppDelegate.h"
#import "objc/runtime.h"

static char const *const heightKey = "Height";


@implementation UINavigationBar (FANavigationBar)

//- (CGSize)sizeThatFits:(CGSize)size
//{
//    
//    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
//    NSLog(@"height: %f",appDelegate.height);
//    return CGSizeMake([UIScreen mainScreen].bounds.size.width, appDelegate.height);
//}
//

- (void)setHeight:(CGFloat)height
{
    objc_setAssociatedObject(self, heightKey, @(height), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSNumber *)height
{
    return objc_getAssociatedObject(self, heightKey);
}

//- (CGSize)sizeThatFits:(CGSize)size
//{
//    CGSize newSize;
//    
//    if (self.height) {
//        newSize = CGSizeMake(self.superview.bounds.size.width, [self.height floatValue]);
//    } else {
//        newSize = [super sizeThatFits:size];
//    }
//    
//    return newSize;
//}

@end
