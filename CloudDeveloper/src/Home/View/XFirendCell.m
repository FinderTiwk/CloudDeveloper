//
//  XFirendCell.m
//  CloudDeveloper
//
//  Created by _Finder丶Tiwk on 16/4/10.
//  Copyright © 2016年 _Finder丶Tiwk. All rights reserved.
//

#import "XFirendCell.h"


@interface XFirendCell ()
@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UILabel *accountLabel;
@property (weak, nonatomic) IBOutlet UILabel *remarkLabel;

@end

@implementation XFirendCell

+ (instancetype)cellWithTableView:(UITableView *)tableview{
    XFirendCell *cell = [tableview dequeueReusableCellWithIdentifier:NSStringFromClass([XFirendCell class])];
    return cell;
}


- (void)setFirend:(XFirend *)firend{
    _firend = firend;
    _accountLabel.text = firend.account;
    if (firend.isVip) {
        _accountLabel.textColor = [UIColor redColor];
    }else{
        _accountLabel.textColor = [UIColor blackColor];
    }
    _remarkLabel.text  = firend.remark;
    _avatarImageView.image = [UIImage imageNamed:firend.avatarImageName];
}


@end
