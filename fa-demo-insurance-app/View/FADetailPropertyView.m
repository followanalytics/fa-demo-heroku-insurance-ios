//
//  FADetailPropertyView.m
//  fa-demo-insurance-app
//
//  Created by Raphaël El Beze on 27/04/2016.
//  Copyright © 2016 FollowAnalytics. All rights reserved.
//

#import "FADetailPropertyView.h"
#import "FANotification.h"
#import <FollowApps/FAFollowApps.h>
#import "FAConstants.h"



@interface FADetailPropertyView ()

@property (weak, nonatomic) IBOutlet UIView *notificationView;
@property (weak, nonatomic) IBOutlet UITapGestureRecognizer *magicTricksGesture;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topHeightConstraint;

@property (nonatomic, retain) FANotification *notification;

@end

@implementation FADetailPropertyView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)awakeFromNib
{
    [FAFollowApps setBoolean:NO forKey:@"Central heating"];
    [FAFollowApps setBoolean:NO forKey:@"Garage door"];
    [FAFollowApps setBoolean:YES forKey:@"Washer dryer"];
    [FAFollowApps setBoolean:NO forKey:@"front door"];
    [FAFollowApps setBoolean:NO forKey:@"Windows"];
    
    [self layoutIfNeeded];
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:FAInsuranceReceiveNotificationProperty])
    {
        [self didMagicTricks:nil];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:FAInsuranceReceiveNotificationProperty];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }

}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        self.frame = CGRectMake(0, 0, width, 600);
        
    }
    return self;
}


#pragma mark - IBoutlet Action

- (IBAction)didMagicTricks:(UITapGestureRecognizer *)sender
{
    

    self.topHeightConstraint.constant = 16;
    
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"weatherNotif"]];
    imageView.backgroundColor = UIColorFromRGB(0x225cac);
    
    self.notification = [[NSBundle mainBundle] loadNibNamed:@"FANotification" owner:self options:nil][0];
    [self.notification loadWithTitle:@"Cold weather in Vail!" Description:@"The temperature will drop below zero. It is recommended to empty your water pipes to avoid freezing." Footer:nil LeftImageView:imageView IsEnable:NO];
 

    [self.notificationView addSubview:self.notification];
    
    self.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height + self.notificationView.frame.size.height + 16 + 60);
    ((UIScrollView *)self.superview).contentSize = self.frame.size;
    
    
    self.notification.frame = CGRectMake(0, -self.notificationView.frame.size.height, self.notificationView.frame.size.width, self.notificationView.frame.size.height);

    
    [UIView animateWithDuration:0.5
                     animations:^{
                         
                         [self layoutIfNeeded]; // Called on parent view
                         self.notification.frame = CGRectMake(0, 0, self.notificationView.frame.size.width, self.notificationView.frame.size.height);
                         
                     }];
    self.magicTricksGesture.enabled = NO;
    
}

- (IBAction)switchChanged:(UISwitch *)sender
{
    switch (sender.tag)
    {
        case 0:
            [FAFollowApps setBoolean:sender.isOn forKey:@"Central"];
            break;
        case 1:
            [FAFollowApps setBoolean:sender.isOn forKey:@"Garage door"];

            break;
        case 2:
            [FAFollowApps setBoolean:sender.isOn forKey:@"Washer dryer"];

            break;
            
        default:
            break;
    }
}


@end
