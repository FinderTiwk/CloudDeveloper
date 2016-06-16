//
//  XAddFirendViewModel.m
//  CloudDeveloper
//
//  Created by _Finder丶Tiwk on 16/4/13.
//  Copyright © 2016年 _Finder丶Tiwk. All rights reserved.
//

#import "XAddFirendViewModel.h"

extern NSString *kAddReuqestKey;

@interface XAddFirendViewModel ()
/*! 账号是否合法*/
@property (nonatomic,strong) RACSignal *accountValidSignal;
@end

@implementation XAddFirendViewModel{
    NSMutableArray *__requesetArray;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        __requesetArray = [NSMutableArray array];
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSMutableDictionary *dic = [[defaults valueForKey:kAddReuqestKey] mutableCopy];
        [dic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            XAddRequest *request = [[XAddRequest alloc] init];
            request.account = key;
            request.remark  = obj;
            [__requesetArray addObject:request];
        }];
    }
    return self;
}

- (void)deleteAddRequestWithAccount:(NSString *)account{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary *dic = [[defaults valueForKey:kAddReuqestKey] mutableCopy];
    [dic removeObjectForKey:account];
    [defaults setValue:dic forKey:kAddReuqestKey];
    [defaults synchronize];
}


- (NSArray<XAddRequest *> *)requestArray{
    
    return __requesetArray;
}

- (void)removeRequestAtIndex:(NSUInteger)index{
    XAddRequest *request = __requesetArray[index];
    [self deleteAddRequestWithAccount:request.account];
    [__requesetArray removeObjectAtIndex:index];
}


#pragma mark - ReactiveCocoa

- (RACSignal *)accountValidSignal{
    if (!_accountValidSignal) {
        _accountValidSignal = [RACObserve(self, addText) map:^id(NSString *text) {
            NSUInteger length = text.length;
            return @(length >=4 && length <8);
        }];
    }
    return _accountValidSignal;
}

- (RACCommand *)addFirendCommand{
    if (!_addFirendCommand) {
        _addFirendCommand = [[RACCommand alloc] initWithEnabled:self.accountValidSignal signalBlock:^RACSignal *(id input) {
            return [self addLogic];
        }];
        
        [_addFirendCommand.executing subscribeNext:^(id x) {
            BOOL transcation = [x boolValue];
            if (transcation) {
                [SVProgressHUD showWithStatus:@"添加好友中..."];
            }else{
                [SVProgressHUD dismissWithDelay:1.2];
            }
        }];
        
        [_addFirendCommand.executionSignals subscribeNext:^(id x) {
            [SVProgressHUD showSuccessWithStatus:@"请等待对方接受..."];
        }];
        
        [_addFirendCommand.errors subscribeNext:^(NSError *error) {
            [SVProgressHUD showErrorWithStatus:error.userInfo[@"message"]];
        }];
    }
    return _addFirendCommand;
}


- (RACSignal *)addLogic{
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [[RACScheduler scheduler] schedule:^{
            EMError *error = [[EMClient sharedClient].contactManager addContact:self.addText message:@"我想加您为好友"];;
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
