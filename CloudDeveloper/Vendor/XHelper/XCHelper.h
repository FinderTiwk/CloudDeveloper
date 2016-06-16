//
//  XCHelper.h
//  AirPortVIP
//
//  Created by _Finder丶Tiwk on 16/3/25.
//  Copyright © 2016年 _Finder丶Tiwk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#ifndef XCHelper_h
#define XCHelper_h

#pragma mark  - ＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝
#pragma mark - *公共方法*
#pragma mark  - ＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝

/**
 *  @author _Finder丶Tiwk, 16-03-30 13:03:32
 *
 *  @brief 返回指定文件夹在沙盒中的路径,如果文件夹不存在则创建
 *  @param folderName 文件夹名称
 *  @return 文件夹全路径
 *  @since v1.0.0
 */
NSString *customFolderInDocument(NSString *folderName);
/**
 *  @author _Finder丶Tiwk, 16-01-12 17:01:51
 *
 *  @brief 生成UUID
 *  @return 随机生成16位小写的字符串
 *  @since v0.1.0
 */
NSString* getXUUID();

/**
 *  @author _Finder丶Tiwk, 16-01-12 17:01:14
 *
 *  @brief 验证手机号码的合法性
 *  @param mobileNum 手机号
 *  @return 手机号码是否合法
 *  @since v0.1.0
 */
BOOL validateMobileNumber(NSString *mobileNumber);


#pragma mark  - ＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝
#pragma mark - *JSON*
#pragma mark  - ＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝

/**
 *  @author _Finder丶Tiwk, 16-01-12 17:01:14
 *
 *  @brief 将集合对象转换成Json字符串
 *  @param collection 集合对象(Array,Dictionary,Set)
 *  @return Json字符串(如果转换失败，则返回nil)
 *  @since v0.1.0
 */
NSString* collection2JsonString(id collection);

/**
 *  @author _Finder丶Tiwk, 16-01-12 17:01:55
 *
 *  @brief 将标准的Json格式的字符串转换成集合对象
 *  @param jsonString Json字符串
 *  @return 集合(Array,Dictionary,Set中的某一种)(如果转换失败，则返回nil)
 *  @since v0.1.0
 */
id jsonString2Collection(NSString *jsonString);


#pragma mark  - ＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝
#pragma mark - *NULL*
#pragma mark  - ＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝
/**
 *  @author _Finder丶Tiwk, 16-01-12 17:01:45
 *
 *  @brief 判断一个对象是否是NSArray类型并且不为空
 *  @param object OC对象
 *  @return 是否是可用的数组
 *  @since v0.1.0
 */
BOOL isArrayWithAnyItems(id object);
/**
 *  @author _Finder丶Tiwk, 16-01-12 17:01:31
 *
 *  @brief 判断一个对象是否是NSDictionary类型并且不为空
 *  @param object OC对象
 *  @return 是否是可用的字典
 *  @since v0.1.0
 */
BOOL isDictionaryWithAnyItems(id object);

/**
 *  @author _Finder丶Tiwk, 16-01-12 17:01:00
 *
 *  @brief 判断一个对象是否是NSString类型并且不为空
 *  @param object OC对象
 *  @return 是否是可用的字符串
 *  @since v0.1.0
 */
BOOL isStringWithAnyText(id object);


#pragma mark  - ＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝
#pragma mark - *视图相关*
#pragma mark  - ＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝

/**
 *  @author _Finder丶Tiwk, 16-01-13 14:01:29
 *
 *  @brief 获取当前显示的视图控制器
 *  @return 当前显示的视图控制器
 *  @since v0.1.0
 */
UIViewController* currentViewController();


#endif /* XCHelper_h */
