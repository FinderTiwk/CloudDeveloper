//
//  XProfileViewModel.m
//  CloudDeveloper
//
//  Created by _Finder丶Tiwk on 16/4/15.
//  Copyright © 2016年 _Finder丶Tiwk. All rights reserved.
//

#import "XProfileViewModel.h"

@implementation XProfileViewModel

- (instancetype)init{
    self = [super init];
    if (self) {
        _hiddenVipIcon = YES;
    }
    return self;
}

- (void)setHiddenVipIcon:(BOOL)hiddenVipIcon{
    _hiddenVipIcon = hiddenVipIcon;
    [XGlobalConfig shareXGlobalConfig].loginUser.vip = !hiddenVipIcon;
}

- (NSString *)account{
    return [XGlobalConfig shareXGlobalConfig].loginUser.account;
}

- (UIImage *)avatarImage{
    NSString *imageName = [XGlobalConfig shareXGlobalConfig].loginUser.avatarImageName;
    return [UIImage imageNamed:imageName];
}

#pragma mark - ReactiveCocoa
- (RACCommand *)logoutCommand{
    if (!_logoutCommand) {
        _logoutCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            return [self logoutLogic];
        }];
        
        [_logoutCommand.executing subscribeNext:^(id x) {
            BOOL transcation = [x boolValue];
            if (transcation) {
                [SVProgressHUD showWithStatus:@"退出中..."];
            }else{
                [SVProgressHUD dismissWithDelay:1.2];
            }
        }];
        
        [_logoutCommand.errors subscribeNext:^(NSError *error) {
            [SVProgressHUD showErrorWithStatus:error.userInfo[@"message"]];
        }];
        
        [_logoutCommand.executionSignals subscribeNext:^(id x) {
            UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"LoginViewController" bundle:nil];
            UIViewController *loginController = [storyBoard instantiateInitialViewController];
            [[UIApplication sharedApplication].keyWindow setRootViewController:loginController];
            [XGlobalConfig shareXGlobalConfig].loginUser = nil;
        }];
        
    }
    return _logoutCommand;
}

- (RACSignal *)logoutLogic{
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [[RACScheduler scheduler] schedule:^{
            EMError *error = [[EMClient sharedClient] logout:YES];
            [[RACScheduler mainThreadScheduler] schedule:^{
                if (error) {
                    [subscriber sendError:[NSError errorWithDomain:@"com.fanhua.www" code:-1 userInfo:@{@"message":error.errorDescription}]];
                }else{
                    XGlobalConfig *config = [XGlobalConfig shareXGlobalConfig];
                    XFirend *user         = [XFirend firendWithAccount:self.account];
                    config.loginUser      = user;
                    [subscriber sendNext:@{@"code":@"0",@"message":@""}];
                    [subscriber sendCompleted];
                }
            }];
        }];
        return nil;
    }];
}



@end
