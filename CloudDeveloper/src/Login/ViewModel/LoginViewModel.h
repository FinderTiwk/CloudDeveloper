//
//  LoginViewModel.h
//  CloudDeveloper
//
//  Created by _Finder丶Tiwk on 16/4/7.
//  Copyright © 2016年 _Finder丶Tiwk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoginViewModel : NSObject

@property (nonatomic,readonly) RACCommand *loginCommand;
@property (nonatomic,copy) NSString *account;
@property (nonatomic,copy) NSString *password;

/*! 是否记住用户名密码*/
@property (nonatomic,assign) BOOL rememberAccount;

@end
