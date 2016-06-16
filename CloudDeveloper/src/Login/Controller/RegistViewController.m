//
//  RegistViewController.m
//  CloudDeveloper
//
//  Created by _Finder丶Tiwk on 16/4/7.
//  Copyright © 2016年 _Finder丶Tiwk. All rights reserved.
//

#import "RegistViewController.h"
#import "RegistViewModel.h"

@interface RegistViewController ()

@property (weak, nonatomic) IBOutlet UITextField *acoountField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField1;
@property (weak, nonatomic) IBOutlet UITextField *passwordField2;
@property (weak, nonatomic) IBOutlet UIButton *submitButton;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;

@property (nonatomic,strong) RegistViewModel *viewModel;

@end

@implementation RegistViewController

- (RegistViewModel *)viewModel{
    if (!_viewModel) {
        _viewModel = [[RegistViewModel alloc] init];
    }
    return _viewModel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    RAC(self.viewModel,account)         = [_acoountField rac_textSignal];
    RAC(self.viewModel,password)        = [_passwordField1 rac_textSignal];
    RAC(self.viewModel,confirmPassword) = [_passwordField2 rac_textSignal];
    
    RAC(_acoountField,backgroundColor) = [self.viewModel.accountValidSignal map:^id(id value) {
        return [value boolValue]?[UIColor whiteColor]:[UIColor redColor];
    }];
    
    RAC(_passwordField1,backgroundColor) = [self.viewModel.passwordValidSignal map:^id(id value) {
        return [value boolValue]?[UIColor whiteColor]:[UIColor redColor];
    }];
    
    RAC(_passwordField2,backgroundColor) = [self.viewModel.passwordValidSignal map:^id(id value) {
        return [value boolValue]?[UIColor whiteColor]:[UIColor redColor];
    }];
    
    RAC(_tipLabel,text) = [RACSignal combineLatest:@[[_acoountField rac_textSignal],[_passwordField1 rac_textSignal],[_passwordField2 rac_textSignal]] reduce:^NSString *(NSString *account,NSString *password1,NSString *password2){
        if (account.length == 0 && password1.length ==0 && password2.length == 0) {
            return @"";
        }else if (account.length < 5 || account.length > 8) {
            return @"用户名长度应该为5-8个字符";
        }else if (password1.length == 0 || password2.length == 0){
            return @"";
        }else if (password1.length < 6){
            return @"密码长度为6-18位";
        } else if (password1.length ==0 ){
            return @"密码不能为空";
        }else if (![password1 isEqualToString:password2]){
            return @"两次输入密码不一致";
        }else{
            return @"";
        }
    }];
    
    _submitButton.rac_command = self.viewModel.registCommand;
    @weakify(self)
    [[_submitButton.rac_command.executionSignals doNext:^(id x) {
        @strongify(self)
        NSString *successMessage = [NSString stringWithFormat:@"恭喜您，注册成功\n账号:%@\n密码:%@",self.viewModel.account,self.viewModel.password];
        [SVProgressHUD showWithStatus:successMessage];
    }] subscribeNext:^(id x) {
        @strongify(self)
        [self.navigationController dismissViewControllerAnimated:YES completion:^{
            [SVProgressHUD dismissWithDelay:1.2];
        }];
    }];
    
    _acoountField.backgroundColor = [UIColor whiteColor];
    _passwordField1.backgroundColor = [UIColor whiteColor];
    _passwordField2.backgroundColor = [UIColor whiteColor];
}

@end
