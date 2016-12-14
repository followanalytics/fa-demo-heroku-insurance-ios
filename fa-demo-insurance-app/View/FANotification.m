//
//  FANotification.m
//  fa-demo-insurance-app
//
//  Created by Raphaël El Beze on 26/04/2016.
//  Copyright © 2016 FollowAnalytics. All rights reserved.
//

#import "FANotification.h"


@interface FANotification () <UIGestureRecognizerDelegate>

@property (weak, nonatomic) IBOutlet UIView *labelView;

@end

@implementation FANotification


//- (instancetype)initWithCoder:(NSCoder *)aDecoder
//{
//    CGFloat width = [UIScreen mainScreen].bounds.size.width;
//    
//    self = [super initWithCoder:aDecoder];
//    if (self)
//    {
////        self.frame = CGRectMake(0, 0, width, 120);
//    }
//    return self;
//}

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    
    if (newSuperview)
    {
        self.frame = CGRectMake(0, 0, newSuperview.frame.size.width, self.frame.size.height);

        [self.descriptionLabel layoutIfNeeded];
        [self.descriptionLabel sizeToFit];

        CGFloat heihtDiff = self.descriptionLabel.frame.size.height;
        
       NSLayoutConstraint *heightDescriptionConstraint = [NSLayoutConstraint constraintWithItem:self.descriptionLabel attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0 constant:self.descriptionLabel.frame.size.height];
        
        [self.descriptionLabel addConstraint:heightDescriptionConstraint];
        
        CGSize size =  [self systemLayoutSizeFittingSize:UILayoutFittingExpandedSize];
        self.frame = CGRectMake(0, 0, newSuperview.frame.size.width, size.height);
        
        size = self.frame.size;
            newSuperview.frame = CGRectMake(newSuperview.frame.origin.x
                                            , newSuperview.frame.origin.y
                                            , size.width, size.height);
        
        NSLayoutConstraint *heightSuperViewFrameConstraint = [NSLayoutConstraint constraintWithItem:newSuperview attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0 constant:size.height];
        NSLayoutConstraint *heightFrameConstraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0 constant:size.height];
        
        [newSuperview addConstraint:heightSuperViewFrameConstraint];
        [self addConstraint:heightFrameConstraint];
        
        [newSuperview layoutIfNeeded];
        [self layoutIfNeeded];
        [self.descriptionLabel sizeToFit];
        
        heightDescriptionConstraint.constant = self.descriptionLabel.frame.size.height;
        heihtDiff = self.descriptionLabel.frame.size.height-heihtDiff;
        
        [self.descriptionLabel layoutIfNeeded];

        heightFrameConstraint.constant = size.height + heihtDiff;
        heightSuperViewFrameConstraint.constant = size.height + heihtDiff;
        
        [self layoutIfNeeded];
        [newSuperview layoutIfNeeded];

    }
   
    
}

- (void)loadWithTitle:(NSString *)title Description:(NSString *)description Footer:(NSString *)footer LeftImageView:(UIImageView *)imageView IsEnable:(BOOL)isEnable
{
    if (self)
    {
        NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:title];

        [self.titleLabel setFont:[UIFont fontWithName:@"AdelleSans-Regular" size:16]];
        self.titleLabel.attributedText = attributeString;
        
        
        attributeString = [[NSMutableAttributedString alloc] initWithString:description];
        [self.descriptionLabel setFont:[UIFont fontWithName:@"AdelleSans-Regular" size:14]];
        self.descriptionLabel.attributedText = attributeString;

        if (footer)
        {
            attributeString = [[NSMutableAttributedString alloc] initWithString:footer];
            [attributeString addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInt:1] range:(NSRange){0,[attributeString length]}];
            
            [self.footerLabel setFont:[UIFont fontWithName:@"AdelleSans-SemiBoldItalic" size:14]];
            self.footerLabel.attributedText = attributeString;
        }
        else
        {
            self.labelView.hidden = YES;
            [self.labelView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0 constant:0]];
            
            [self.labelView layoutIfNeeded];
        }
        self.leftImageView.image = imageView.image;
        self.leftView.backgroundColor = imageView.backgroundColor;
        
        [self.labelView addGestureRecognizer:self.pushFooterGesture];
        

        [self layoutIfNeeded];
        
    }
}


- (IBAction)pushFooterGesture:(UITapGestureRecognizer *)sender
{
    
    if ([self.delegate respondsToSelector:@selector(notificationDidPushOnFooter:)])
    {
        [self.delegate notificationDidPushOnFooter:YES];
    }
}


@end
