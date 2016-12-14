//
//  FATravelController.m
//  fa-demo-insurance-app
//
//  Created by Raphaël El Beze on 28/04/2016.
//  Copyright © 2016 FollowAnalytics. All rights reserved.
//

#import "FATravelController.h"
#import "FANotification.h"
#import "FACategoryController.h"
#import <FollowApps/FAFollowApps.h>
#import "FAConstants.h"


@interface FATravelController () <UIScrollViewDelegate>

@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *magicTricksGesture;
@property (weak, nonatomic) IBOutlet UIView *notificationView;

@property (nonatomic, assign) FANotification *notification;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;

@end

@implementation FATravelController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view
    
    [self.view addGestureRecognizer:self.magicTricksGesture];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self.view layoutIfNeeded];

    if ([[NSUserDefaults standardUserDefaults] objectForKey:FAInsuranceReceiveNotificationTravel])
    {
        [self didMagicTricks:nil];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:FAInsuranceReceiveNotificationTravel];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBAction
- (IBAction)cancelPush:(UIButton *)sender
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];

}

- (IBAction)addTravelPush:(UIButton *)sender
{
    [FAFollowApps logEventWithName:@"addTravel_btn" details:nil];
    [self performSegueWithIdentifier:@"showAddTravel" sender:nil];
}

#pragma mark - Gesture

- (IBAction)didMagicTricks:(UITapGestureRecognizer *)sender
{
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"travelNotification"]];
    imageView.backgroundColor = UIColorFromRGB(0xee4d39);
    
    self.notification = [[NSBundle mainBundle] loadNibNamed:@"FANotification" owner:self options:nil][0];
    [self.notification loadWithTitle:@"Dengue fever outbreak in Taiwan" Description:@"There has been a recent outbreak of this mosquito-borne illness. Make sure you have proper insurance coverage during your stay." Footer:nil LeftImageView:imageView IsEnable:NO];
    
    [self.notificationView addSubview:self.notification];
    
    [self.view layoutIfNeeded];
    
    self.magicTricksGesture.enabled = NO;
}

#pragma mark - Segue Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    FACategoryController *controller = (FACategoryController *)[[segue destinationViewController] topViewController];

    controller.navBarBackground = [UIImage imageNamed:@"travelHeader"];
    
}

#pragma mark - UIScrollView Delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    if (scrollView.contentOffset.y <= 0)
    {
        self.titleLabel.alpha = 1;
        self.descriptionLabel.alpha = 1;
    }
    else
    {
        self.titleLabel.alpha = 1- (scrollView.contentOffset.y * 0.01);
        self.descriptionLabel.alpha = 1- (scrollView.contentOffset.y * 0.0095);
    }
}




@end
