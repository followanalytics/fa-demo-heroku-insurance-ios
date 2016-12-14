//
//  FAHomeViewController.m
//  fa-demo-insurance-app
//
//  Created by Raphaël El Beze on 22/04/2016.
//  Copyright © 2016 FollowAnalytics. All rights reserved.
//

#import "FAHomeViewController.h"
#import "FALoginView.h"
#import "FANavigationController.h"
#import "FANavigationBar.h"
#import "FACategoryController.h"
#import "FAConstants.h"

@interface FAHomeViewController() <FALoginViewDelegate, FANavigationDelegate>

@property (nonatomic, retain) FALoginView *loginView;
@property (nonatomic, retain) FANavigationBar *navBar;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *categorieButton;
@property (weak, nonatomic) IBOutlet UIView *headerNavView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightConstraint;

@end

@implementation FAHomeViewController 

#pragma mark - Life Cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationController.edgesForExtendedLayout = UIRectEdgeNone;

    FANavigationController *navController = (FANavigationController *)self.navigationController;
    
    self.navBar = [[[NSBundle mainBundle] loadNibNamed:@"FANavigationBar" owner:self options:nil] objectAtIndex:0];
    
    self.navBar.delegate = self;
    self.navBar =[self.navBar initWithFrame:CGRectMake(0, 0, 0, 185) navigationController:navController];
    self.navBar.userImageView.image = [UIImage imageNamed:@"userPicture"];
    self.navBar.logoView.frame = CGRectMake(self.navBar.logoView.frame.origin.x, self.navBar.logoView.frame.origin.y, 180, 27);
    self.navBar.logoView.image = [UIImage imageNamed:@"logoHeader"];
    
    self.navBar.backgroundImageView.image = [UIImage imageNamed:@"categoryHeaderBackground"];

    [navController.navBar addSubview:self.navBar];
    
    CGFloat topLayout = self.navBar.frame.size.height - self.navigationController.navigationBar.frame.size.height;
    self.heightConstraint.constant = topLayout - 20;
    
    [[NSUserDefaults standardUserDefaults] synchronize];
    if ([[NSUserDefaults standardUserDefaults] valueForKey:FAInsuranceUserId])
    {
        [self setUserNameInNavBar:[[NSUserDefaults standardUserDefaults] valueForKey:FAInsuranceUserId]];
    }
    
}

- (void)setUserNameInNavBar:(NSString *)userNameString
{
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"Welcome back, %@",userNameString]];
    [attributeString addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInt:1] range:(NSRange){14,[userNameString length]}];
    [self.navBar.welcomLabel setFont:[UIFont fontWithName:@"AdelleSans-Light" size:18]];
    
    
    self.navBar.welcomLabel.attributedText = attributeString;

}

#pragma mark - FALoginViewDelegate

- (void)receiveUserName:(NSString *)userNameString
{
    [self setUserNameInNavBar:userNameString];
}

#pragma mark - FANavigationController

- (void)didLogOut
{
    [FAFollowApps logEventWithName:@"logOut_btn" details:nil];
    [self showLogin];
}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSString *key = sender;
    
    if ([[segue identifier] isEqualToString:@"showCategory"] && [key.stringByDeletingPathExtension isEqualToString:@"auto"])
    {
        
        FACategoryController *controller = (FACategoryController *)[[segue destinationViewController] topViewController];
        controller.contractRef = @"12345678";
        controller.dateString = @"August 23, 2017";
        controller.priceString = @"$400.00/year";
        controller.navBarBackground = [UIImage imageNamed:@"autoHeader"];
        
        controller.typeView = FAtypeViewCars;
        
        [FAFollowApps setString:controller.contractRef forKey:@"carContractRef"];
        [FAFollowApps setString:controller.dateString forKey:@"carRenewalDate"];
        [FAFollowApps setString:controller.priceString forKey:@"carPrice"];
        
        if ([key isEqualToString:@"auto.DL"])
        {
            [controller performSegueWithIdentifier:@"showDetail" sender:@"auto"];
        }

    }
    else if ([[segue identifier] isEqualToString:@"showCategory"] && [key.stringByDeletingPathExtension isEqualToString:@"property"])
    {
        
        FACategoryController *controller = (FACategoryController *)[[segue destinationViewController] topViewController];
        controller.contractRef = @"00AA00AA";
        controller.dateString = @"August 23, 2017";
        controller.priceString = @"$200.00/year";
        controller.navBarBackground = [UIImage imageNamed:@"propertyHeader"];
        
        [FAFollowApps setString:controller.contractRef forKey:@"propertyContractRef"];
        [FAFollowApps setString:controller.dateString forKey:@"propertyRenewalDate"];
        [FAFollowApps setString:controller.priceString forKey:@"propertyPrice"];
        
        controller.typeView = FAtypeViewInsurance;
        
        if ([key isEqualToString:@"property.DL"])
        {
            [controller performSegueWithIdentifier:@"showDetail" sender:@"property"];
        }
    }
}


#pragma mark - Listener

- (IBAction)pushButton:(UIButton *)sender
{
    switch (sender.tag)
    {
        case 1:
            [self performSegueWithIdentifier:@"showCategory" sender:@"auto"];
            [FAFollowApps logEventWithName:@"auto_btn" details:nil];

            break;
        case 2:
//            [self performSegueWithIdentifier:@"showCategory" sender:@"health"];
        
            [FAFollowApps logEventWithName:@"health_btn" details:nil];

            break;
        case 3:
//            [self performSegueWithIdentifier:@"showCategory" sender:@"finance"];
            [FAFollowApps logEventWithName:@"finance_btn" details:nil];

            break;
        case 4:
            [self performSegueWithIdentifier:@"showCategory" sender:@"property"];
            [FAFollowApps logEventWithName:@"property_btn" details:nil];

            
            break;
        case 5:
//            [self performSegueWithIdentifier:@"showCategory" sender:@"family"];
            [FAFollowApps logEventWithName:@"family_btn" details:nil];

            break;
        case 6:
            [self performSegueWithIdentifier:@"showTravel" sender:@"travel"];
            [FAFollowApps logEventWithName:@"travel_btn" details:nil];

            break;
            
        default:
            break;
    }
    
}

#pragma mark - Login View

- (void)showLogin
{
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    UINavigationController *navC = (UINavigationController *)window.rootViewController;
    if (navC.viewControllers.count > 1) {
        [navC popToRootViewControllerAnimated:NO];
    }
    
    if (nil == self.loginView)
    {
        self.loginView = [[NSBundle mainBundle] loadNibNamed:@"FALoginView" owner:nil options:nil][0];
        self.loginView.delegate =  self;
    }
    [window.rootViewController.view addSubview:self.loginView];
}


@end
