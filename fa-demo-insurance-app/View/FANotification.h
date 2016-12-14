//
//  FANotification.h
//  fa-demo-insurance-app
//
//  Created by Raphaël El Beze on 26/04/2016.
//  Copyright © 2016 FollowAnalytics. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FANotificationDelegate <NSObject>

- (void)notificationDidPushOnFooter:(BOOL)footerIsPush;

@end

@interface FANotification : UIView

@property(nonatomic, weak) id<FANotificationDelegate> delegate;

- (void)loadWithTitle:(NSString *)title Description:(NSString *)description Footer:(NSString *)footer LeftImageView:(UIImageView *)imageView IsEnable:(BOOL)isEnable;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *footerLabel;

@property (weak, nonatomic) IBOutlet UIImageView *leftImageView;
@property (weak, nonatomic) IBOutlet UITapGestureRecognizer *pushFooterGesture;

@property (weak, nonatomic) IBOutlet UIView *leftView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topHeightConstraint;

@end
