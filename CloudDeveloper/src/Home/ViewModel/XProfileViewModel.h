//
//  XProfileViewModel.h
//  CloudDeveloper
//
//  Created by _Finder丶Tiwk on 16/4/15.
//  Copyright © 2016年 _Finder丶Tiwk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XProfileViewModel : NSObject

@property (nonatomic,readonly) NSString *account;
@property (nonatomic,readonly) UIImage *avatarImage;
@property (nonatomic,assign) BOOL hiddenVipIcon;

/*! 退出登录命令*/
@property (nonatomic,strong) RACCommand *logoutCommand;

@end
