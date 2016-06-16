//
//  XFirend.m
//  CloudDeveloper
//
//  Created by _Finder丶Tiwk on 16/4/10.
//  Copyright © 2016年 _Finder丶Tiwk. All rights reserved.
//

#import "XFirend.h"

@implementation XFirend{
    NSString *__privateAvataImageName;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        int avatarIndex = (arc4random() % 6) + 1;
        __privateAvataImageName = [NSString stringWithFormat:@"avatar_default_00%zi",avatarIndex];
        _remark = @"这个人很懒,什么都没留下...";
    }
    return self;
}

+ (instancetype)firendWithAccount:(NSString *)account{
    XFirend *firend = [[XFirend alloc] init];
    firend.account = account;
    return firend;
}

- (NSString *)avatarImageName{
    return __privateAvataImageName;
}

@end
