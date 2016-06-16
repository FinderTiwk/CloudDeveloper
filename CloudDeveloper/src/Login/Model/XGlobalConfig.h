//
//  XGlobalConfig.h
//  CloudDeveloper
//
//  Created by _Finder丶Tiwk on 16/4/15.
//  Copyright © 2016年 _Finder丶Tiwk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XFirend.h"

@interface XGlobalConfig : NSObject

singleton(XGlobalConfig)

/*! 当前登录的用户*/
@property (nonatomic,strong) XFirend *loginUser;

@end
