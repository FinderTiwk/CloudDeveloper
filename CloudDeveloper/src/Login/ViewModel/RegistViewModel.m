//
//  RegistViewModel.m
//  CloudDeveloper
//
//  Created by _Finder丶Tiwk on 16/4/8.
//  Copyright © 2016年 _Finder丶Tiwk. All rights reserved.
//

#import "RegistViewModel.h"

@implementation RegistViewModel


#pragma mark - ReactiveCocoa
- (RACSignal *)accountValidSignal{
    
    return [RACObserve(self, account) map:^id(NSString *text) {
        NSUInteger length = text.length;
        return @(length >=5 && length <8);
    }];
}

- (RACSignal *)passwordValidSignal{
    return [RACObserve(self, password) map:^id(NSString *text) {
        NSUInteger length = text.length;
        return @(length >=6 && length <8);
    }];
}

- (RACSignal *)confirmPasswordValidSignal{
    return [RACObserve(self, confirmPassword) map:^id(NSString *text) {
        NSUInteger length = text.length;
        return @(length >=6 && length <8);
    }];
}


- (RACCommand *)registCommand{
    RACSignal *validSignal = [RACSignal merge:@[self.accountValidSignal,self.passwordValidSignal]];
    @weakify(self)
    RACCommand *registCommand = [[RACCommand alloc] initWithEnabled:validSignal signalBlock:^RACSignal *(id input) {
        @strongify(self)
        return [self registLogic];
    }];
    
    [registCommand.executing subscribeNext:^(id x) {
        if ([x boolValue]) {
            [SVProgressHUD showWithStatus:@"Registing..."];
        }else{
            [SVProgressHUD dismissWithDelay:1.2];
        }
    }];
    
    [registCommand.errors subscribeNext:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:error.userInfo[@"message"]];
        
    }];
    return registCommand;
}

- (RACSignal *)registLogic{
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [[RACScheduler scheduler] schedule:^{
            EMError *error = [[EMClient sharedClient] registerWithUsername:self.account password:self.password];
            [[RACScheduler mainThreadScheduler] schedule:^{
                if (error) {
                    [subscriber sendError:[NSError errorWithDomain:@"com.fanhua.www" code:-1 userInfo:@{@"message":error.errorDescription}]];
                }else{
                    [subscriber sendNext:@{@"code":@"0",@"message":@""}];
                    [subscriber sendCompleted];
                }
            }];
        }];
        return nil;
    }];
}

@end

