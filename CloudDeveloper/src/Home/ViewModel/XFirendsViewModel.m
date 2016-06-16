//
//  XFirendsViewModel.m
//  CloudDeveloper
//
//  Created by _Finder丶Tiwk on 16/4/10.
//  Copyright © 2016年 _Finder丶Tiwk. All rights reserved.
//

#import "XFirendsViewModel.h"


NSString *const kAddReuqestKey = @"addReuqestKey";

@interface XFirendsViewModel ()
@property (nonatomic,strong) NSMutableArray *listArray;

@property (nonatomic,strong) RACCommand *queryCommand;
@property (nonatomic,strong) RACCommand *deleteCommand;
@end

@implementation XFirendsViewModel
- (instancetype)init{
    self = [super init];
    if (self) {
        _listArray = [NSMutableArray array];
        @weakify(self)
        [RACObserve(self, fetchComplete) subscribeNext:^(id x) {
            @strongify(self)
            BOOL transcationTag = [x boolValue];
            if (!transcationTag) {
                [_listArray removeAllObjects];
                [self.queryCommand execute:nil];
            }
        }];
        
        [self initUserDefaults];
    }
    return self;
}

#pragma mark - Others
- (NSArray *)firendsList{
    return _listArray;
}

- (void)deleteFirend:(XFirend *)firend complete:(void (^)())complete{
    [self.deleteCommand.executionSignals subscribeNext:^(id x) {
        [_listArray removeObject:firend];
        complete();
    }];
    [self.deleteCommand execute:firend];
}

- (void)deleteFirendAtIndex:(NSUInteger)index complete:(void (^)())complete{
    XFirend *firend = _listArray[index];
    if (firend) {
        [self deleteFirend:firend complete:complete];
    }
}


#pragma mark - UserDefaults Operation

- (void)initUserDefaults{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary * dic = [defaults valueForKey:kAddReuqestKey];
    if (!dic) {
        [defaults setValue:@{} forKey:kAddReuqestKey];
        [defaults synchronize];
    }
}

- (void)saveAddRequestWithAccount:(NSString *)account message:(NSString *)message{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary *dic = [[defaults valueForKey:kAddReuqestKey] mutableCopy];
    [dic setValue:message forKey:account];
    [defaults setValue:dic forKey:kAddReuqestKey];
    [defaults synchronize];
}


#pragma mark - ReactiveCocoa Command

#pragma mark 获取好友列表
- (RACCommand *)queryCommand{
    if (!_queryCommand) {
        @weakify(self)
        _queryCommand = [[RACCommand alloc] initWithEnabled:nil signalBlock:^RACSignal *(id input) {
            @strongify(self)
            return [self queryLogic];
        }];
        
        [_queryCommand.executing subscribeNext:^(id x) {
            if (![x boolValue]) {
                @strongify(self)
                self.fetchComplete =  YES;
            }
        }];
        
        [_queryCommand.errors subscribeNext:^(NSError *error) {
            [SVProgressHUD showErrorWithStatus:error.userInfo[@"message"]];
        }];
    }
    return _queryCommand;
}

- (RACSignal *)queryLogic{
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [[RACScheduler scheduler] schedule:^{
            EMError *error = nil;
            NSArray *userlist = [[EMClient sharedClient].contactManager getContactsFromServerWithError:&error];
            [[RACScheduler mainThreadScheduler] schedule:^{
                if (error) {
                    [subscriber sendError:[NSError errorWithDomain:@"com.fanhua.www" code:-1 userInfo:@{@"message":error.errorDescription}]];
                }else{
                    for (NSString *account in userlist) {
                        XFirend *firend = [XFirend firendWithAccount:account];
                        if ((arc4random() % 4) == 2) {
                            firend.vip = YES;
                            firend.remark = @"我是尊贵的会员😼";
                        }
                        [_listArray addObject:firend];
                    }
                    [subscriber sendCompleted];
                }
            }];
        }];
        return nil;
    }];
}

#pragma mark 删除好友
- (RACCommand *)deleteCommand{
    if (!_deleteCommand) {
        @weakify(self)
        _deleteCommand = [[RACCommand alloc] initWithEnabled:nil signalBlock:^RACSignal *(XFirend *firend) {
            @strongify(self)
            return [self deleteLogicWithFirend:firend];
        }];
        
        [_deleteCommand.errors subscribeNext:^(NSError *error) {
            [SVProgressHUD showErrorWithStatus:error.userInfo[@"message"]];
        }];
    }
    return _deleteCommand;
}


- (RACSignal *)deleteLogicWithFirend:(XFirend *)firend{
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [[RACScheduler scheduler] schedule:^{
            // 删除好友
            EMError *error = [[EMClient sharedClient].contactManager deleteContact:firend.account];
            [[RACScheduler mainThreadScheduler] schedule:^{
                if (error) {
                    [subscriber sendError:[NSError errorWithDomain:@"com.fanhua.www" code:-1 userInfo:@{@"message":error.errorDescription}]];
                }else{
                    [subscriber sendCompleted];
                }
            }];
        }];
        return nil;
    }];
}

@end



#pragma mark - DZNEmptyDataSetSource
@implementation XFirendsViewModel (DZNEmptyDataSet)

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView{
    NSString *text = @"No friends to show.";
    UIFont *font   = [UIFont fontWithName:@"HelveticaNeue-Light" size:22.0];
    
    
    NSMutableDictionary *attributes = [NSMutableDictionary new];
    attributes[NSFontAttributeName] = font;
    attributes[NSForegroundColorAttributeName] = [UIColor whiteColor];
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView{
    NSString *text =  @"Add friends to get started!";;
    UIFont *font   = [UIFont systemFontOfSize:13.0];
    
    NSMutableParagraphStyle *paragraph = [NSMutableParagraphStyle new];
    paragraph.lineBreakMode            = NSLineBreakByWordWrapping;
    paragraph.alignment                = NSTextAlignmentCenter;
    
    NSMutableDictionary *attributes = [NSMutableDictionary new];
    attributes[NSFontAttributeName] = font;
    attributes[NSParagraphStyleAttributeName] = paragraph;
    
    return [[NSMutableAttributedString alloc] initWithString:text attributes:attributes];
}

- (CGFloat)spaceHeightForEmptyDataSet:(UIScrollView *)scrollView{
    return 1.f;
}

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView{
    return [UIImage imageNamed:@"placeholder_noFirends"];
}

- (void)emptyDataSet:(UIScrollView *)scrollView didTapView:(UIView *)view{
    [scrollView.superview endEditing:YES];
}

- (UIColor *)backgroundColorForEmptyDataSet:(UIScrollView *)scrollView{
    return [UIColor colorWithRed:0.447 green:0.427 blue:0.404 alpha:1.000];
}

@end
