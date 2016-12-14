//
//  FANavigationBar.m
//  fa-demo-insurance-app
//
//  Created by Raphaël El Beze on 24/04/2016.
//  Copyright © 2016 FollowAnalytics. All rights reserved.
//

#import "FANavigationBar.h"
#import "FANavigationController.h"
#import "UINavigationBar+FANavigationBar.h"
#import "FAConstants.h"


@interface FANavigationBar()

@property (nonatomic, retain) UINavigationController *navigationController;
@property (nonatomic, retain) UINavigationBar *navBar;


@end


@implementation FANavigationBar

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame navigationController:(UINavigationController *)navigationController
{
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat heiht = frame.size.height;
    if (self = [super initWithFrame:frame])
    {
        self.navigationController = navigationController;
        self.navBar = navigationController.navigationBar;
        self.frame = CGRectMake(0, -20, width, heiht);
        [self insertSubview:self.cancelButton atIndex:10];
    }
    
    return self;
}

- (IBAction)popOverModal:(UIButton *)sender
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)logOutPush:(UIButton *)sender
{
    [[NSUserDefaults standardUserDefaults] synchronize];
    if ([[NSUserDefaults standardUserDefaults] valueForKey:FAInsuranceUserId])
    {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:FAInsuranceUserId];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    if ([self.delegate respondsToSelector:@selector(didLogOut)])
    {
        [self.delegate didLogOut];
    }
   
}

@end
