//
//  FALoginView.m
//  fa-demo-insurance-app
//
//  Created by Raphaël El Beze on 21/04/2016.
//  Copyright © 2016 FollowAnalytics. All rights reserved.
//

#import "FALoginView.h"
#import "FAConstants.h"


@interface FALoginView()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@property (weak, nonatomic) IBOutlet UILabel *footerLabel;

@end

@implementation FALoginView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
//- (void)drawRect:(CGRect)rect {
//     Drawing code
//}
#pragma mark - KeyBoard

- (void)keyboardWillShow:(NSNotification *)notification
{
    NSDictionary *userInfo = notification.userInfo;
    
    CGFloat keyboadHeight = -CGRectGetHeight(((NSValue *)userInfo[UIKeyboardFrameEndUserInfoKey]).CGRectValue);
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:0.3];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    self.transform = CGAffineTransformMakeTranslation(0, keyboadHeight);
    [UIView commitAnimations];

     
}

- (void)keyboardWillHide:(NSNotification *)notification
{
    [UIView beginAnimations:nil context:nil];
     [UIView setAnimationDelegate:self];
     [UIView setAnimationDuration:0.3];
     [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
     self.transform = CGAffineTransformMakeTranslation(0, 0);
     [UIView commitAnimations];
}

- (IBAction)hideKeyboard:(UIButton *)sender
{
    [self endEditing:YES];
}


#pragma mark - Life Cycle

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;

    self = [super initWithCoder:aDecoder];
    if (self)
    {
        self.frame = CGRectMake(0, 0, width, height);
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    }
    return self;
}

#pragma mark - UITextField Delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ([textField isEqual:self.userNameTextField])
    {
        [self.passwordTextField becomeFirstResponder];
    }
    else
    {
        [self.passwordTextField resignFirstResponder];
        [self logInPush:nil];
    }
    return YES;
}

#pragma mark - Listerner

- (IBAction)logInPush:(UIButton *)sender
{
    if (self.userNameTextField.text.length > 0)
    {
        if ([self.delegate respondsToSelector:@selector(receiveUserName:)])
        {
            [self.delegate receiveUserName:self.userNameTextField.text];
        }
        
        [[NSUserDefaults standardUserDefaults] setObject:self.userNameTextField.text forKey:FAInsuranceUserId];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [FAFollowApps setUserId:self.userNameTextField.text];
        [FAFollowApps logEventWithName:@"login_btn" details:nil];
        
        [self closeView];
    }
}

#pragma mark - dismiss View

- (void)closeView
{
    [UIView animateWithDuration:0.3
                     animations:^{
                         self.alpha = 0;
                     }
                     completion:^(BOOL finished) {
                         self.userNameTextField.text = @"";
                         self.passwordTextField.text = @"";
                         [self removeFromSuperview];
                         self.alpha = 1;
                     }];
}


@end
