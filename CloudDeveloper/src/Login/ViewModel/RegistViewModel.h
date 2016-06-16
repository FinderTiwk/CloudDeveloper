//
//  RegistViewModel.h
//  CloudDeveloper
//
//  Created by _Finder丶Tiwk on 16/4/8.
//  Copyright © 2016年 _Finder丶Tiwk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RegistViewModel : NSObject

/*! 注册按钮命令*/
@property (nonatomic,readonly) RACCommand *registCommand;

@property (nonatomic,readonly) RACSignal *accountValidSignal;
@property (nonatomic,readonly) RACSignal *passwordValidSignal;
@property (nonatomic,readonly) RACSignal *confirmPasswordValidSignal;

@property (nonatomic,copy) NSString *account;
@property (nonatomic,copy) NSString *password;
@property (nonatomic,copy) NSString *confirmPassword;

@end
