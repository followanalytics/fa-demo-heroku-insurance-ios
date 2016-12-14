//
//  FADetailCarView.m
//  fa-demo-insurance-app
//
//  Created by Raphaël El Beze on 26/04/2016.
//  Copyright © 2016 FollowAnalytics. All rights reserved.
//

#import "FADetailCarView.h"
#import <FollowApps/FAFollowApps.h>
#import "FAConstants.h"


@interface FADetailCarView () <FANotificationDelegate>

@property (weak, nonatomic) IBOutlet UIView *notificationView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topViewConstraint;

@property (nonatomic, retain) FANotification *notification;
@property (weak, nonatomic) IBOutlet UITapGestureRecognizer *magicTricksGesture;

@end

@implementation FADetailCarView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/



- (void)awakeFromNib
{
    [FAFollowApps setString:@"Daily" forKey:@"Usage frequency"];
    [FAFollowApps setString:@"75 Km/h" forKey:@"Average speed"];
    [FAFollowApps setString:@"6,3L/100" forKey:@"Fuel consumption"];
    [FAFollowApps setString:@"Soft" forKey:@"Driving style"];
    [FAFollowApps setString:@"Mainly urbain" forKey:@"Usage"];
    [FAFollowApps setString:@"Toyota Prius C" forKey:@"Car Model"];
    
    [self layoutIfNeeded];
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:FAInsuranceReceiveNotificationCar])
    {
        [self didMagicTricks:self.magicTricksGesture];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:FAInsuranceReceiveNotificationCar];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }

}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    CGFloat width = [UIScreen mainScreen].bounds.size.width;

    self = [super initWithCoder:aDecoder];
    if (self)
    {
        self.frame = CGRectMake(0, 0, width, self.frame.size.height);
        
    }
    return self;
}

- (void)loadNotificationView
{
    self.notificationView.hidden = YES;
    
}

- (IBAction)didMagicTricks:(UITapGestureRecognizer *)sender
{
    
    self.topViewConstraint.constant = 16;

    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"dollars"]];
    imageView.backgroundColor = UIColorFromRGB(0x04C27D);
    
    self.notification = [[NSBundle mainBundle] loadNibNamed:@"FANotification" owner:self options:nil][0];
    [self.notification loadWithTitle:@"Eligible for new price" Description:@"Because your usage is mainly urbain, you are eligible for our new Flex Insurance Service." Footer:@"Read More" LeftImageView:imageView IsEnable:YES];
    self.notification.delegate = self;

    
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

#pragma mark - FANotification Delegate


- (void)notificationDidPushOnFooter:(BOOL)footerIsPush
{
    NSURL *url = [NSURL URLWithString:@"https://followanalytics.com"];
    
    [[UIApplication sharedApplication] openURL:url];
    
}

@end
