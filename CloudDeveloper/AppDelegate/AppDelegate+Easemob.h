//
//  AppDelegate+Easemob.h
//  CloudDeveloper
//
//  Created by _Finder丶Tiwk on 16/4/8.
//  Copyright © 2016年 _Finder丶Tiwk. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate (Easemob)

- (void)xks_setupEasemob;

- (void)xks_easemobDidEnterBackground:(UIApplication *)application;

- (void)xks_easemobWillEnterForeground:(UIApplication *)application;

@end
