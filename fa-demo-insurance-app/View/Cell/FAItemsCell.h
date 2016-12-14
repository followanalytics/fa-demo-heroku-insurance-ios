//
//  FAItemsCell.h
//  fa-demo-insurance-app
//
//  Created by Raphaël El Beze on 24/04/2016.
//  Copyright © 2016 FollowAnalytics. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FAItemsCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *avatarPicture;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *firstDescriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *secondDescriptionLabel;

@property (weak, nonatomic) IBOutlet UIButton *addButton;
@property (weak, nonatomic) IBOutlet UILabel *labelButton;

@property (weak, nonatomic) IBOutlet UIImageView *rightIcon;

@property (weak, nonatomic) IBOutlet UIView *notificationView;

@end
