//
//  FAContractDetailsCell.m
//  fa-demo-insurance-app
//
//  Created by Raphaël El Beze on 24/04/2016.
//  Copyright © 2016 FollowAnalytics. All rights reserved.
//

#import "FAContractDetailsCell.h"


@interface FAContractDetailsCell ()
@property (weak, nonatomic) IBOutlet UILabel *contractReferenceLabel;
@property (weak, nonatomic) IBOutlet UILabel *renewaldDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;


@end

@implementation FAContractDetailsCell

-(instancetype)initWithContractReference:(NSString *)contractRef date:(NSString *)date price:(NSString *)price
{
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    self = [super init];
    if (self)
    {
        self.contractReferenceLabel.text = contractRef;
        self.renewaldDateLabel.text = date;
        self.priceLabel.text = price;
        
        self.contentView.frame = CGRectMake(0, 0, width, 128);
    }
    return self;
}

@end
