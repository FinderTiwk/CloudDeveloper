//
//  XReuqestCell.m
//  CloudDeveloper
//
//  Created by _Finder丶Tiwk on 16/4/13.
//  Copyright © 2016年 _Finder丶Tiwk. All rights reserved.
//

#import "XRequestCell.h"

@interface XRequestCell ()

@property (weak, nonatomic) IBOutlet UIButton *acceptButton;
@property (weak, nonatomic) IBOutlet UIButton *refuseButton;

@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
@property (weak, nonatomic) IBOutlet UILabel *remarkLabel;

@property (nonatomic,strong) RACCommand *acceptCommand;
@property (nonatomic,strong) RACCommand *refuseCommand;

@end

@implementation XRequestCell

+ (instancetype)cellWithTableView:(UITableView *)tableview{
    XRequestCell *cell = [tableview dequeueReusableCellWithIdentifier:NSStringFromClass([XRequestCell class])];
    
    cell.acceptButton.rac_command = cell.acceptCommand;
    cell.refuseButton.rac_command = cell.refuseCommand;
    
    return cell;
}

- (void)setAddRequest:(XAddRequest *)addRequest{
    _addRequest = addRequest;
    NSString *string = [NSString stringWithFormat:@"%@ 想要添加您为好友",addRequest.account];
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:string];
    [text addAttributes:@{NSForegroundColorAttributeName:[UIColor blueColor]} range:[string rangeOfString:addRequest.account]];
    _detailLabel.attributedText = text;
    _remarkLabel.text = addRequest.remark;
}


#pragma mark - ReactiveCocoa
- (RACCommand *)acceptCommand{
    if (!_acceptCommand) {
        _acceptCommand = [[RACCommand alloc] initWithEnabled:nil signalBlock:^RACSignal *(id input) {
            return [self acceptLogic];
        }];
        [_acceptCommand.executing subscribeNext:^(id x) {
            BOOL transcation = [x boolValue];
            if (transcation) {
                [SVProgressHUD showWithStatus:@"添加中.."];
            }else{
                [SVProgressHUD dismissWithDelay:1.2];
            }
        }];
        [_acceptCommand.errors subscribeNext:^(NSError *error) {
            [SVProgressHUD showErrorWithStatus:error.userInfo[@"message"]];
        }];
        [_acceptCommand.executionSignals subscribeNext:^(id x) {
            [SVProgressHUD showSuccessWithStatus:@"添加成功"];
            self.requestHandleBlock();
        }];
    }
    return _acceptCommand;
}

- (RACSignal *)acceptLogic{
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [[RACScheduler scheduler] schedule:^{
            EMError *error = [[EMClient sharedClient].contactManager acceptInvitationForUsername:self.addRequest.account];
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

- (RACCommand *)refuseCommand{
    if (!_refuseCommand) {
        _refuseCommand = [[RACCommand alloc] initWithEnabled:nil signalBlock:^RACSignal *(id input) {
            return [self refuseLogic];
        }];
        
        [_refuseCommand.executing subscribeNext:^(id x) {
            BOOL transcation = [x boolValue];
            if (!transcation) {
                [SVProgressHUD dismissWithDelay:1.2];
            }
        }];
        
        [_refuseCommand.errors subscribeNext:^(NSError *error) {
            [SVProgressHUD showErrorWithStatus:error.userInfo[@"message"]];
        }];
        
        [_refuseCommand.executionSignals subscribeNext:^(id x) {
            [SVProgressHUD showSuccessWithStatus:@"拒绝成功"];
            self.requestHandleBlock();
        }];
    }
    return _refuseCommand;
}

- (RACSignal *)refuseLogic{
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [[RACScheduler scheduler] schedule:^{
            EMError *error = [[EMClient sharedClient].contactManager declineInvitationForUsername:self.addRequest.account];
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
