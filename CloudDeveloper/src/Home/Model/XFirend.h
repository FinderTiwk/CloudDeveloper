//
//  XFirend.h
//  CloudDeveloper
//
//  Created by _Finder丶Tiwk on 16/4/10.
//  Copyright © 2016年 _Finder丶Tiwk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XFirend : NSObject

@property (nonatomic,copy) NSString *account;
@property (nonatomic,copy) NSString *remark;
@property (nonatomic,readonly) NSString *avatarImageName;
@property (nonatomic,assign,getter=isVip) BOOL vip;

+ (instancetype)firendWithAccount:(NSString *)account;

@end
