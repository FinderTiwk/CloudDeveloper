//
//  LoginViewController.m
//  CloudDeveloper
//
//  Created by _Finder丶Tiwk on 16/4/7.
//  Copyright © 2016年 _Finder丶Tiwk. All rights reserved.
//

#import "LoginViewController.h"
#import "FBShimmeringView.h"
#import "LoginViewModel.h"

@interface LoginViewController ()

@property (weak, nonatomic) IBOutlet FBShimmeringView *logoView;
@property (weak, nonatomic) IBOutlet UITextField *accountField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UISwitch *rememberSwitch;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@property (nonatomic,strong) LoginViewModel *viewModel;

@end

@implementation LoginViewController

- (LoginViewModel *)viewModel{
    if (!_viewModel) {
        _viewModel = [[LoginViewModel alloc] init];
    }
    return _viewModel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _accountField.text  = self.viewModel.account;
    _passwordField.text = self.viewModel.password;
    
    RAC(self.viewModel,account)         = [_accountField rac_textSignal];
    RAC(self.viewModel,password)        = [_passwordField rac_textSignal];
    RAC(self.viewModel,rememberAccount) = _rememberSwitch.rac_newOnChannel;
    
    _loginButton.rac_command = self.viewModel.loginCommand;

    RAC(_accountField,backgroundColor) = [[_accountField rac_textSignal] map:^UIColor *(NSString *text) {
        NSUInteger length = text.length;
        if (length < 5) {
            return [UIColor whiteColor];
        }else if (length >8){
            return [UIColor redColor];
        }else{
            return [UIColor greenColor];
        }
    }];
    
    RAC(_passwordField,backgroundColor) = [[_passwordField rac_textSignal] map:^UIColor *(NSString *text) {
        NSUInteger length = text.length;
        if (length < 6) {
            return [UIColor whiteColor];
        }else if (length >8){
            return [UIColor redColor];
        }else{
            return [UIColor greenColor];
        }
    }];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    UILabel *logoLabel = [[UILabel alloc] initWithFrame:_logoView.bounds];
    logoLabel.textAlignment = NSTextAlignmentCenter;
    logoLabel.textColor     = [UIColor whiteColor];
    logoLabel.text          = @"🌴Cloud Developer";
    logoLabel.font          = [UIFont preferredFontForTextStyle:UIFontTextStyleTitle1];
    _logoView.contentView   = logoLabel;
    _logoView.shimmering    = YES;
}

#pragma mark - IBActions
- (IBAction)dismissSegue:(UIStoryboardSegue *)segue{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

@end
