//
//  XChatViewModel.m
//  CloudDeveloper
//
//  Created by _Finder丶Tiwk on 16/4/10.
//  Copyright © 2016年 _Finder丶Tiwk. All rights reserved.
//

#import "XChatViewModel.h"

@implementation XChatViewModel

@end

#pragma mark - DZNEmptyDataSetSource
@implementation XChatViewModel (DZNEmptyDataSetSource)

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView{
    NSString *text = @"No Messages";
    UIFont *font   = [UIFont fontWithName:@"HelveticaNeue-Light" size:22.0];
    
    NSMutableDictionary *attributes = [NSMutableDictionary new];
    attributes[NSFontAttributeName] = font;
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView{
    NSString *text = @"When you have messages, \nyou’ll see them here.";
    UIFont *font   = [UIFont systemFontOfSize:13.0];
    
    NSMutableParagraphStyle *paragraph = [NSMutableParagraphStyle new];
    paragraph.lineBreakMode            = NSLineBreakByWordWrapping;
    paragraph.alignment                = NSTextAlignmentCenter;
    
    NSMutableDictionary *attributes = [NSMutableDictionary new];
    attributes[NSFontAttributeName] = font;
    attributes[NSParagraphStyleAttributeName] = paragraph;
    
    return [[NSMutableAttributedString alloc] initWithString:text attributes:attributes];
}


- (NSAttributedString *)buttonTitleForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state{
    NSString *text     = @"Start Browsing";
    UIFont *font       = [UIFont boldSystemFontOfSize:16.0];
    UIColor *textColor = [UIColor colorWithRed:0.000 green:0.543 blue:1.000 alpha:1.000];
    
    NSMutableDictionary *attributes = [NSMutableDictionary new];
    attributes[NSFontAttributeName] = font;
    attributes[NSForegroundColorAttributeName] = textColor;
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

- (CGFloat)spaceHeightForEmptyDataSet:(UIScrollView *)scrollView{
    return 12.f;
}

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView{
    return [UIImage imageNamed:@"placeholder_noMessage"];
}

- (void)emptyDataSet:(UIScrollView *)scrollView didTapButton:(UIButton *)button{
    NSLog(@"11");
}


@end
