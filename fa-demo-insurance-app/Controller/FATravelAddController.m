//
//  FATravelAddController.m
//  fa-demo-insurance-app
//
//  Created by Raphaël El Beze on 28/04/2016.
//  Copyright © 2016 FollowAnalytics. All rights reserved.
//

#import "FATravelAddController.h"
#import "FAHomeViewController.h"
#import <FollowApps/FAFollowApps.h>


@interface FATravelAddController ()

@property (nonatomic, retain) NSNumber *beneficiaireNumber;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightConstraint;
@property (weak, nonatomic) IBOutlet UILabel *beneficiaireLabel;
@property (weak, nonatomic) IBOutlet UIView *leftViewDate;
@property (weak, nonatomic) IBOutlet UIView *rightViewDate;
@property (weak, nonatomic) IBOutlet UILabel *fromDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *toDateLabel;
@property (strong, nonatomic) IBOutlet UIDatePicker *datePicker;

@property (nonatomic, retain) NSDate *fromDate;
@property (nonatomic, retain) NSDate *toDate;

@property (nonatomic, assign) CGSize size;


@end

@implementation FATravelAddController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    FANavigationBar *navBar = [[[NSBundle mainBundle] loadNibNamed:@"FANavigationBar" owner:self options:nil] objectAtIndex:0];
    
    navBar =[navBar initWithFrame:CGRectMake(0, 0, 0, 160) navigationController:self.navigationController];
    
    navBar.welcomLabel.hidden = YES;
    navBar.welcom2Label.hidden = YES;
    navBar.logoView.hidden = YES;
    navBar.cancelButton.hidden = NO;
    
    navBar.backgroundImageView.image = self.navBarBackground;
    
    [self.navigationController.navigationBar addSubview:navBar];
    
    CGFloat topLayout = navBar.frame.size.height - self.navigationController.navigationBar.frame.size.height - 20;
    self.heightConstraint.constant = topLayout;
    
    self.size = CGSizeMake(self.datePicker.frame.size.width, self.datePicker.frame.size.height);
    
    [self setInitialValue];
}

- (void)setInitialValue
{
    self.beneficiaireNumber = [NSNumber numberWithInteger:1];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    [formatter setCalendar:[[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian]];
    [formatter setLocale:locale];
    [formatter setDateFormat:@"dd/MM/yy"];
    self.fromDateLabel.text = [formatter stringFromDate:[NSDate date]];
    
    [self.datePicker setDate:[NSDate date]];
    [self.datePicker setMinimumDate:[NSDate date]];
    

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - IBAction


- (IBAction)decreaseBenificaireNumber:(UIButton *)sender
{
    if (self.beneficiaireNumber.integerValue > 1)
    {
        self.beneficiaireNumber = [NSNumber numberWithInteger:self.beneficiaireNumber.integerValue - 1];
        self.beneficiaireLabel.text = self.beneficiaireNumber.stringValue;
    }
}


- (IBAction)increaseBenificiareNumber:(UIButton *)sender
{
    if (self.beneficiaireNumber.integerValue < 10)
    {
        self.beneficiaireNumber = [NSNumber numberWithInteger:self.beneficiaireNumber.integerValue + 1];
        self.beneficiaireLabel.text = self.beneficiaireNumber.stringValue;
    }
}

- (IBAction)fromDatePickerPush:(UIButton *)sender
{
    
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
        [formatter setCalendar:[[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian]];
        [formatter setLocale:locale];
        [formatter setDateFormat:@"dd/MM/yy"];
        
        self.fromDateLabel.text = [formatter stringFromDate:self.datePicker.date];
        self.fromDate = self.datePicker.date;
        [self.datePicker setMinimumDate:self.datePicker.date];
        
        
    }]];
    

    NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:actionSheet.view attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:self.size.height * 1.35];

    [heightConstraint setPriority:UILayoutPriorityDefaultHigh];
    [actionSheet.view addConstraint:heightConstraint];
    
    [self fitSizeDatePicker];
    [actionSheet.view addSubview:self.datePicker];
    [self presentViewController:actionSheet animated:YES completion:nil];
}

- (IBAction)toDatePickerPush:(UIButton *)sender
{
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    
    
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
        [formatter setCalendar:[[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian]];
        [formatter setLocale:locale];
        [formatter setDateFormat:@"dd/MM/yy"];
        
        self.toDateLabel.text = [formatter stringFromDate:self.datePicker.date];
        self.toDate = self.datePicker.date;
        self.toDateLabel.textColor = UIColorFromRGB(0x222222);
    }]];
    
    
    
    NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:actionSheet.view attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:self.size.height * 1.35];
    [heightConstraint setPriority:UILayoutPriorityDefaultHigh];
    
    [actionSheet.view addConstraint:heightConstraint];
    
    [self fitSizeDatePicker];
    [actionSheet.view addSubview:self.datePicker];
    
    
    [self presentViewController:actionSheet animated:YES completion:nil];

}

- (IBAction)pushConfirm:(UIButton *)sender {

    
    if (!self.toDate)
    {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Warning" message:@"Before confirm, Please choose a date" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleCancel handler:nil]];
        [self presentViewController:alertController animated:YES completion:nil];
        
        self.toDateLabel.textColor = [UIColor redColor];
    }
    else if ([self.fromDate timeIntervalSinceReferenceDate] > [self.toDate timeIntervalSinceReferenceDate])
    {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Warning" message:@"Please select a valide date" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleCancel handler:nil]];
        
        
        [self presentViewController:alertController animated:YES completion:nil];
    }
    else
    {
        
        [FAFollowApps logEventWithName:@"travelConfirm_btn" details:nil];
        [FAFollowApps setInt:self.beneficiaireNumber.integerValue forKey:@"beneficiaire"];
        [FAFollowApps setDate:self.fromDate forKey:@"start travel date"];
        [FAFollowApps setDate:self.toDate forKey:@"end travel date"];

        FAHomeViewController *controller = (FAHomeViewController *)[[[UIApplication sharedApplication] keyWindow] rootViewController].childViewControllers[0] ;
        
        controller.travelButton.imageView.image = [UIImage imageNamed:@"travelRedButton"];
        [self.view.window.rootViewController dismissViewControllerAnimated:YES completion:nil];
    }
    
}

- (void)fitSizeDatePicker
{
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    
    if (width == 375)
    {
        [self.datePicker setFrame:CGRectMake(20, 0, self.size.width, self.size.height)];
    }
    else if (width == 414)
    {
        [self.datePicker setFrame:CGRectMake(30, 0, self.size.width, self.size.height)];
    }
    else
    {
        [self.datePicker setFrame:CGRectMake(0, 0, self.size.width, self.size.height)];
    }

}


@end
