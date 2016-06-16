//
//  XAddFirendViewModel.h
//  CloudDeveloper
//
//  Created by _Finder丶Tiwk on 16/4/13.
//  Copyright © 2016年 _Finder丶Tiwk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XAddRequest.h"

@interface XAddFirendViewModel : NSObject

/*! 添加好友信号*/
@property (nonatomic,strong) RACCommand *addFirendCommand;
/*! 要添加的好友账号*/
@property (nonatomic,copy) NSString *addText;
/*! 好友申请列表*/
@property (nonatomic,strong) NSArray<XAddRequest *> *requestArray;

- (void)removeRequestAtIndex:(NSUInteger)index;

@end
