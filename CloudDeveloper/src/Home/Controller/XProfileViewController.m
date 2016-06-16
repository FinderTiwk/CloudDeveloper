//
//  XProfileViewController.m
//  CloudDeveloper
//
//  Created by _Finder丶Tiwk on 16/4/15.
//  Copyright © 2016年 _Finder丶Tiwk. All rights reserved.
//

#import "XProfileViewController.h"
#import "XProfileViewModel.h"
#import <PassKit/PassKit.h>

@interface XProfileViewController ()<PKPaymentAuthorizationViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UILabel *accountLabel;

@property (weak, nonatomic) IBOutlet UIImageView *vipImageView;

@property (weak, nonatomic) IBOutlet UIButton *payButton;
@property (weak, nonatomic) IBOutlet UIButton *logouButton;

@property (nonatomic,strong) XProfileViewModel *viewModel;

@end

@implementation XProfileViewController

- (XProfileViewModel *)viewModel{
    if (!_viewModel) {
        _viewModel = [[XProfileViewModel alloc] init];
    }
    return _viewModel;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    RAC(_vipImageView,hidden) = RACObserve(self.viewModel, hiddenVipIcon);
    _accountLabel.text       = self.viewModel.account;
    _avatarImageView.image   = self.viewModel.avatarImage;
    _logouButton.rac_command = self.viewModel.logoutCommand;
    [RACObserve(self.viewModel, hiddenVipIcon) subscribeNext:^(id x) {
        BOOL flag = [x boolValue];
        if (flag) {
            [_payButton setTitle:@"开通VIP会员" forState:UIControlStateNormal];
        }else{
            [_payButton setTitle:@"续费" forState:UIControlStateNormal];
        }
    }];
    
    [[_payButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [self applePay:x];
    }];
}


#pragma mark - ApplePay Action
- (void)applePay:(UIButton *)sender{
    
    if (![PKPaymentAuthorizationViewController canMakePaymentsUsingNetworks:@[PKPaymentNetworkChinaUnionPay,PKPaymentNetworkMasterCard,PKPaymentNetworkVisa]]) {
        PKPassLibrary *library = [[PKPassLibrary alloc] init];
        [library openPaymentSetup];
        return;
    }
    
    PKPaymentRequest *payRequest = [[PKPaymentRequest alloc] init];
    // 1.1 配置商户ID
    payRequest.merchantIdentifier = @"merchant.com.fanhua.payment";
    // 1.2 配置国家代码
    payRequest.countryCode        = @"CN";
    // 1.3 配置货币代码
    payRequest.currencyCode       = @"CNY";
    // 1.4 配置支付支持的银行通道
    payRequest.supportedNetworks  = @[PKPaymentNetworkChinaUnionPay,PKPaymentNetworkMasterCard,PKPaymentNetworkVisa];
    // 1.5 配置商户的处理方式
    payRequest.merchantCapabilities = PKMerchantCapability3DS;
    
    // 1.5 配置商品明细
    NSDecimalNumber *number = [NSDecimalNumber decimalNumberWithString:@"15.00"];
    PKPaymentSummaryItem *item = [PKPaymentSummaryItem summaryItemWithLabel:@"VIP会员月卡" amount:number type:PKPaymentSummaryItemTypeFinal];
    payRequest.paymentSummaryItems = @[item];
    
    PKPaymentAuthorizationViewController *authorController = [[PKPaymentAuthorizationViewController alloc] initWithPaymentRequest:payRequest];
    authorController.delegate = self;
    [self presentViewController:authorController animated:YES completion:nil];
}


#pragma mark - PKPaymentAuthorizationViewControllerDelegate

- (void)paymentAuthorizationViewController:(PKPaymentAuthorizationViewController *)controller didAuthorizePayment:(PKPayment *)payment completion:(void (^)(PKPaymentAuthorizationStatus))completion{
    completion(PKPaymentAuthorizationStatusSuccess);
}

- (void)paymentAuthorizationViewControllerDidFinish:(PKPaymentAuthorizationViewController *)controller{
    [controller dismissViewControllerAnimated:YES completion:nil];
    self.viewModel.hiddenVipIcon = NO;
}

@end
