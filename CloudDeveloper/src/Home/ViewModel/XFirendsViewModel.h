//
//  XFirendsViewModel.h
//  CloudDeveloper
//
//  Created by _Finder丶Tiwk on 16/4/10.
//  Copyright © 2016年 _Finder丶Tiwk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIScrollView+EmptyDataSet.h"
#import "XFirend.h"

UIKIT_EXTERN NSString *const kAddReuqestKey;

@interface XFirendsViewModel : NSObject<DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>
/*! 标记是否获取好友列表完成*/
@property (nonatomic,assign) BOOL fetchComplete;

/*! 好友列表*/
@property (nonatomic,strong,readonly) NSArray<XFirend *> *firendsList;

/*! 删除好友*/
- (void)deleteFirend:(XFirend *)firend complete:(void(^)())complete;
- (void)deleteFirendAtIndex:(NSUInteger)index complete:(void(^)())complete;


#pragma mark - 好友申请在本地的缓存处理
- (void)saveAddRequestWithAccount:(NSString *)account message:(NSString *)message;

@end
