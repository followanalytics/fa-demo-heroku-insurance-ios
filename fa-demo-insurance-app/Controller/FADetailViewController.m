//
//  FADetailViewController.m
//  fa-demo-insurance-app
//
//  Created by Raphaël El Beze on 26/04/2016.
//  Copyright © 2016 FollowAnalytics. All rights reserved.
//

#import "FADetailViewController.h"
#import "FADetailCarView.h"
#import "FANotification.h"
#import "FADetailPropertyView.h"


@interface FADetailViewController ()

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation FADetailViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
   
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    NSArray *array = self.navigationController.navigationBar.subviews;
    
    for (id navBar in array)
    {
        if ([navBar isKindOfClass:[FANavigationBar class]])
        {
            FANavigationBar *bar = navBar;
            [UIView animateWithDuration:0.3 animations:^{
                bar.alpha = 0;
            }];
        }
    }
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self.navigationController action:@selector(popViewControllerAnimated:)];
    backButton.image = [UIImage imageNamed:@"leftArrow"];
    [self.navigationItem setLeftBarButtonItem:backButton];
    [self setTopTitle];
    [self setDetailView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setTopTitle
{
    if (self.typeView == FAtypeViewCars)
    {
        self.navigationItem.title = @"John's Car";
    }
    else if(self.typeView == FAtypeViewInsurance)
    {
        self.navigationItem.title = @"Vacation Residence";
    }
}

- (void)setDetailView
{
    if (self.typeView == FAtypeViewCars)
    {
        FADetailCarView *carView = [[NSBundle mainBundle] loadNibNamed:@"FADetailCarView" owner:nil options:nil][0];
        self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width, carView
                                                 .frame.size.height);
        self.scrollView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        [self.scrollView addSubview:carView];
        
    }
    else if (self.typeView == FAtypeViewInsurance)
    {
        FADetailPropertyView *propertyView = [[NSBundle mainBundle] loadNibNamed:@"FADetailPropertyView" owner:nil options:nil][0];
        //        carView = [[FADetailCarView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 726)];
        self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width, propertyView
                                                 .frame.size.height);
        self.scrollView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        [self.scrollView addSubview:propertyView];
        
    }
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
