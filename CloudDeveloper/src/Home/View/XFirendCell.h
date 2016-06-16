//
//  XFirendCell.h
//  CloudDeveloper
//
//  Created by _Finder丶Tiwk on 16/4/10.
//  Copyright © 2016年 _Finder丶Tiwk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XFirend.h"

@interface XFirendCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableview;

@property (nonatomic,strong) XFirend *firend;

@end
