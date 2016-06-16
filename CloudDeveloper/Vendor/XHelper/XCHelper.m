//
//  XCHelper.m
//  AirPortVIP
//
//  Created by _Finder丶Tiwk on 16/3/25.
//  Copyright © 2016年 _Finder丶Tiwk. All rights reserved.
//

#import "XCHelper.h"

static NSString *__customFolderIndocument;
NSString *customFolderInDocument(NSString *folderName){
    if (!__customFolderIndocument) {
        NSFileManager *fileManager = [NSFileManager defaultManager];
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsPath = [paths objectAtIndex:0];
        NSString *folder = [documentsPath stringByAppendingPathComponent:folderName];
        if (![fileManager fileExistsAtPath:folder]){
            [fileManager createDirectoryAtPath:folder withIntermediateDirectories:YES attributes:nil error:nil];
        }
        __customFolderIndocument = folder;
    }
    return __customFolderIndocument;
}

NSString *getXUUID(){
    CFUUIDRef puuid = CFUUIDCreate(nil);
    CFStringRef uuidString = CFUUIDCreateString(nil, puuid);
    NSString * result = (__bridge_transfer NSString *)CFStringCreateCopy(NULL, uuidString);
    CFRelease(puuid);
    CFRelease(uuidString);
    return [[result stringByReplacingOccurrencesOfString:@"-" withString:@""] lowercaseString];
}


BOOL validateMobileNumber(NSString *mobileNumber){
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     12         */
    
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186
     17         */
    
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,180,189
     22         */
    
    //NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    /**
     25         * 大陆地区固话及小灵通
     26         * 区号：010,020,021,022,023,024,025,027,028,029
     27         * 号码：七位或八位
     28         */
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    //NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:mobileNumber] == YES)
        || ([regextestcm evaluateWithObject:mobileNumber] == YES)
        || ([regextestcu evaluateWithObject:mobileNumber] == YES)){
        return YES;
    }else{
        return NO;
    }
}



#pragma mark - *JSON*
///////////////////////////////////////////////////////////////////////////////////////////////////
NSString *collection2JsonString(id collection){
    NSString *jsonString = nil;
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:collection
                                                       options:0
                                                         error:&error];
    if (!jsonData) {
        NSLog(@"[XKSCommonSDK.framework] collection2JsonString 转换失败: %@", error);
    } else {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    return jsonString;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
id jsonString2Collection(NSString *jsonString){
    if (jsonString == nil) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    id jsonRet = [NSJSONSerialization JSONObjectWithData:jsonData
                                                 options:NSJSONReadingMutableContainers
                                                   error:&err];
    if(err) {
        NSLog(@"[XKSCommonSDK.framework] json字符串解析失败,请校验Json格式：%@",err);
        return nil;
    }
    return jsonRet;
}


#pragma mark - *NULL*
///////////////////////////////////////////////////////////////////////////////////////////////////
BOOL isArrayWithAnyItems(id object) {
    return [object isKindOfClass:[NSArray class]] && [(NSArray*)object count] > 0;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
BOOL isDictionaryWithAnyItems(id object) {
    return [object isKindOfClass:[NSDictionary class]] && [(NSDictionary*)object count] > 0;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
BOOL isStringWithAnyText(id object) {
    return [object isKindOfClass:[NSString class]] && [(NSString*)object length] > 0;
}




#pragma mark - *视图相关*
/**
 *  @author _Finder丶Tiwk, 16-01-13 14:01:02
 *
 *  @brief 从RootViewController开始递归查询当前显示的控制器
 *  @since v0.1.0
 */
UIViewController *xks_findBestViewController(UIViewController *controller){
    //1.如果控制器是被present出来的
    if (controller.presentedViewController) {
        return xks_findBestViewController(controller.presentedViewController);
    }
    //2.如果控制器是UISplitViewController
    else if ([controller isKindOfClass:[UISplitViewController class]]) {
        UISplitViewController *splitViewController = (UISplitViewController *) controller;
        if (splitViewController.viewControllers.count > 0){
            return xks_findBestViewController(splitViewController.viewControllers.lastObject);
        }else{
            return controller;
        }
    }
    //3.如果控制器是一个导航控制器
    else if ([controller isKindOfClass:[UINavigationController class]]) {
        UINavigationController *navController = (UINavigationController *) controller;
        if (navController.viewControllers.count > 0){
            return xks_findBestViewController(navController.topViewController);
        }else{
            return controller;
        }
    }
    //4.如果控制器是一个标签栏控制器
    else if ([controller isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tabBarController = (UITabBarController *) controller;
        if (tabBarController.viewControllers.count > 0){
            return xks_findBestViewController(tabBarController.selectedViewController);
        }else{
            return controller;
        }
    }
    //5.最根源的控制器
    else {
        return controller;
    }
}

UIViewController* currentViewController(){
    UIViewController *root = [UIApplication sharedApplication].keyWindow.rootViewController;
    return xks_findBestViewController(root);
}