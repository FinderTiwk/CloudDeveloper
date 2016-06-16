//
//  XReuqestCell.h
//  CloudDeveloper
//
//  Created by _Finder丶Tiwk on 16/4/13.
//  Copyright © 2016年 _Finder丶Tiwk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XAddRequest.h"

@interface XRequestCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableview;

@property (nonatomic,strong) XAddRequest *addRequest;

/*! 添加接受按钮或者添加按钮点击事件*/
@property (nonatomic,copy) void(^requestHandleBlock)();

@end
