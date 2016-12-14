//
//  FAContractDetailsCell.h
//  fa-demo-insurance-app
//
//  Created by Raphaël El Beze on 24/04/2016.
//  Copyright © 2016 FollowAnalytics. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FAContractDetailsCell : UITableViewCell

-(instancetype)initWithContractReference:(NSString *)contractRef date:(NSString *)date price:(NSString *)price;

@end
