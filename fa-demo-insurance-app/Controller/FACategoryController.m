//
//  FACategoryController.m
//  fa-demo-insurance-app
//
//  Created by Raphaël El Beze on 24/04/2016.
//  Copyright © 2016 FollowAnalytics. All rights reserved.
//

#import "FACategoryController.h"
#import "FATableHeaderView.h"
#import "FAContractDetailsCell.h"
#import "FAItemsCell.h"
#import "FAClaimsCell.h"
#import "FATableFooterView.h"
#import "FADetailViewController.h"
#import "FANotification.h"
#import <FollowApps/FAFollowApps.h>


@interface FACategoryController() <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *magicTrickGesture;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightConstraint;
@property (nonatomic,assign) BOOL shoudlDisplayNotification;

@property (nonatomic, assign) CGFloat heightCellNotification;

@end

@implementation FACategoryController


#pragma mark - Life Cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
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
    
    self.shoudlDisplayNotification = NO;
    
    if (self.typeView == FAtypeViewInsurance)
    {
        self.magicTrickGesture.enabled = YES;
    }
    
    [self loadXib];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    for (id navBar in self.navigationController.navigationBar.subviews)
    {
        if ([navBar isKindOfClass:[FANavigationBar class]])
        {
            FANavigationBar *bar = navBar;
            bar.alpha = 1;

        }
    }
    
}

#pragma mark - load xib

- (void)loadXib
{
    
    UINib *nib = [UINib nibWithNibName:@"FATableHeaderView" bundle:nil];
    [self.tableView registerNib:nib forHeaderFooterViewReuseIdentifier:@"FATableHeaderView"];
    
    nib = [UINib nibWithNibName:@"FATableFooterView" bundle:nil];
    [self.tableView registerNib:nib forHeaderFooterViewReuseIdentifier:@"FATableFooterView"];
    
    nib = [UINib nibWithNibName:@"FAContractDetailsCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"FAContractDetailsCell"];
    
    nib = [UINib nibWithNibName:@"FAItemsCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"FAItemsCell"];
    
    nib = [UINib nibWithNibName:@"FAClaimsCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"FAClaimsCell"];
    
}

#pragma mark TableView Data Source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 1)
    {
        return 2;
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        return 100;
    }
    else if (indexPath.section == 1)
    {
        if (indexPath.row == 0)
        {
            return 100;
        }
        if (indexPath.row == 1 && self.shoudlDisplayNotification == YES)
        {
            return 190 + self.heightCellNotification;
        }
        return 190;
    }
    return 150;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    FATableHeaderView *headerView = (FATableHeaderView *)[tableView dequeueReusableHeaderFooterViewWithIdentifier:@"FATableHeaderView"]; //[FATableHeaderView new];
    if (section == 0)
    {
        headerView.titleLabel.text = @"Contract Detail";
        headerView.editIcon.hidden = YES;
    }
    else if (section == 1)
    {
        if (self.typeView == FAtypeViewCars)
        {
            headerView.titleLabel.text = @"Insured Vehicles";

        }
        else if (self.typeView == FAtypeViewInsurance)
        {
            headerView.titleLabel.text = @"Properties";
            
        }
        headerView.editIcon.hidden = NO;
    }
    else
    {
        headerView.titleLabel.text = @"Claims";
        headerView.editIcon.hidden = YES;
    }
    
    return headerView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    FATableFooterView *footerView = (FATableFooterView *)[tableView dequeueReusableHeaderFooterViewWithIdentifier:@"FATableFooterView"];
    if (section == 2)
    {
        footerView.separatorView.hidden = YES;
    }
    
    return footerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0)
    {
        FAContractDetailsCell *cell = (FAContractDetailsCell *)[tableView dequeueReusableCellWithIdentifier:@"FAContractDetailsCell" forIndexPath:indexPath];
        cell = [cell initWithContractReference:self.contractRef date:self.dateString price:self.priceString];
        [cell setUserInteractionEnabled:NO];

        return cell;
    }
    else if (indexPath.section == 1)
    {
        FAItemsCell *cell = (FAItemsCell *)[tableView dequeueReusableCellWithIdentifier:@"FAItemsCell" forIndexPath:indexPath];
        if (self.typeView == FAtypeViewCars)
        {
            if (indexPath.row == 0)
            {
                cell.avatarPicture.image = [UIImage imageNamed:@"avatarToyota"];
                cell.titleLabel.text = @"John's Car";
                cell.firstDescriptionLabel.text = @"Toyota Prius C";
                cell.secondDescriptionLabel.text = @"AB-344-CA";
                cell.rightIcon.hidden = NO;
                cell.addButton.hidden = YES;
                cell.labelButton.hidden = YES;
            }
            else
            {
                cell.avatarPicture.image = [UIImage imageNamed:@"avatarFiat"];
                cell.titleLabel.text = @"Chloe's Car";
                cell.firstDescriptionLabel.text = @"Fiat 500";
                cell.secondDescriptionLabel.text = @"CZ-354-FG";
                cell.rightIcon.hidden = YES;
                cell.addButton.hidden = NO;
                cell.labelButton.hidden = NO;
                cell.labelButton.text = @"Add another contract";
            }
        }
        else if (self.typeView == FAtypeViewInsurance)
        {
            if (indexPath.row == 0)
            {
                cell.avatarPicture.image = [UIImage imageNamed:@"mainAvatar"];
                cell.titleLabel.text = @"Main Residence";
                cell.firstDescriptionLabel.text = @"22 Rue Saint Augustin";
                cell.secondDescriptionLabel.text = @"75002 Paris, France";
                cell.rightIcon.hidden = YES;
                cell.addButton.hidden = YES;
                cell.labelButton.hidden = YES;
                
            }
            else
            {
                cell.avatarPicture.image = [UIImage imageNamed:@"vacationAvatar"];
                cell.titleLabel.text = @"Vacation Residence";
                cell.firstDescriptionLabel.text = @"5 Gore Creek Drive";
                cell.secondDescriptionLabel.text = @"81657 Vail, CO, USA";
                cell.rightIcon.hidden = NO;
                cell.addButton.hidden = NO;
                cell.labelButton.hidden = NO;
                cell.labelButton.text = @"Add another property";
                
                if (self.shoudlDisplayNotification == YES)
                {
                    
                    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"weatherNotif"]];
                    imageView.backgroundColor = UIColorFromRGB(0x225cac);
                    
                    [cell.contentView layoutIfNeeded];
                    
                    FANotification *notification = [[NSBundle mainBundle] loadNibNamed:@"FANotification" owner:self options:nil][0];
                    [notification loadWithTitle:@"Cold weather in Vail!" Description:@"The temperature will drop below zero. It is recommended to empty your water pipes to avoid freezing." Footer:nil LeftImageView:imageView IsEnable:NO];
                                        
                    [cell.notificationView addSubview:notification];
                    [cell.contentView layoutIfNeeded];
                    
                    self.heightCellNotification = cell.notificationView.frame.size.height;

                }
                
            }
        }
        
        return cell;
    }
    else if (indexPath.section == 2)
    {
        FAClaimsCell *cell = (FAClaimsCell *)[tableView dequeueReusableCellWithIdentifier:@"FAClaimsCell" forIndexPath:indexPath];
        if (self.typeView == FAtypeViewCars)
        {
            cell.descriptionLabel.text = @"You currently have no claims in progress";
            cell.labelButton.text = @"Initiate a claim";
            cell.addButton.hidden = NO;
            cell.labelButton.hidden = NO;
        }
        else if (self.typeView == FAtypeViewInsurance)
        {
            cell.descriptionLabel.text = @"You currently have no claims in progress";
            cell.labelButton.text = @"Initiate a claim";
            cell.addButton.hidden = NO;
            cell.labelButton.hidden = NO;
        }
        

        return cell;
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FAContractDetailsCell"];
    
    return cell;
}

#pragma mark - Scroll View Delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat sectionHeaderHeight = 50;
    if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
    } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
    }
}

#pragma mark - Table View Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.typeView == FAtypeViewCars)
    {
        if (indexPath.row == 0 && indexPath.section == 1)
        {
            [FAFollowApps logEventWithName:@"carDetail_btn" details:@"John's car"];
            [self performSegueWithIdentifier:@"showDetail" sender:@"auto"];
            
        }
        
    }
    else if (self.typeView == FAtypeViewInsurance)
    {
        if (indexPath.row == 1 && indexPath.section == 1)
        {
            [FAFollowApps logEventWithName:@"propertyDetail_btn" details:@"Vacation residence"];
            [self performSegueWithIdentifier:@"showDetail" sender:@"property"];

        }
    }
}


#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    FADetailViewController *controller = (FADetailViewController *)[segue destinationViewController];

    if ([sender isEqualToString:@"auto"])
    {
        controller.typeView = FAtypeViewCars;
    }
    else if ([sender isEqualToString:@"property"])
    {
        controller.typeView = FAtypeViewInsurance;
    }
    
}


#pragma mark - Gesture recognise 

- (IBAction)didMagicTricks:(UITapGestureRecognizer *)sender
{
    
    
    self.shoudlDisplayNotification = YES;
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:1 inSection:1];
    [self.tableView beginUpdates];
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    [self.tableView endUpdates];
    
    self.magicTrickGesture.enabled = NO;
}


@end
