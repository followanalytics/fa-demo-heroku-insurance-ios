//
//  FANavigationBar.h
//  fa-demo-insurance-app
//
//  Created by Raphaël El Beze on 24/04/2016.
//  Copyright © 2016 FollowAnalytics. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol FANavigationDelegate <NSObject>

- (void)didLogOut;

@end

@interface FANavigationBar : UIView

- (instancetype)initWithFrame:(CGRect)frame navigationController:(UINavigationController *)navigationController;

@property (weak, nonatomic) IBOutlet UIImageView *userImageView;
@property (weak, nonatomic) IBOutlet UILabel *welcomLabel;
@property (weak, nonatomic) IBOutlet UILabel *welcom2Label;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UIImageView *logoView;

@property (nonatomic, assign) CGFloat height;

@property (nonatomic, assign) id<FANavigationDelegate> delegate;


@end
