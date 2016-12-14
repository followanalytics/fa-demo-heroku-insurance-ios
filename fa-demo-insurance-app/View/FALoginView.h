//
//  FALoginView.h
//  fa-demo-insurance-app
//
//  Created by Raphaël El Beze on 21/04/2016.
//  Copyright © 2016 FollowAnalytics. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FollowApps/FAFollowApps.h>


@protocol FALoginViewDelegate <NSObject>

- (void)receiveUserName:(NSString *)userNameString;

@end

@interface FALoginView : UIView

@property (nonatomic, assign) id<FALoginViewDelegate> delegate;

@end
