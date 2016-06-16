//
//  AppDelegate+Easemob.m
//  CloudDeveloper
//
//  Created by _Finder丶Tiwk on 16/4/8.
//  Copyright © 2016年 _Finder丶Tiwk. All rights reserved.
//

#import "AppDelegate+Easemob.h"
#import "EMSDK.h"

static NSString *const kEASEMOBAPP_KEY = @"huafan#clouddeveloper";

@implementation AppDelegate (Easemob)

- (void)xks_setupEasemob{
    //AppKey:注册的appKey，详细见下面注释。
    //apnsCertName:推送证书名(不需要加后缀)，详细见下面注释。
    EMOptions *options = [EMOptions optionsWithAppkey:kEASEMOBAPP_KEY];
//    options.enableConsoleLog = YES;
    [[EMClient sharedClient] initializeSDKWithOptions:options];
}

- (void)xks_easemobDidEnterBackground:(UIApplication *)application{
    [[EMClient sharedClient] applicationDidEnterBackground:application];
}

- (void)xks_easemobWillEnterForeground:(UIApplication *)application{
    [[EMClient sharedClient] applicationWillEnterForeground:application];
}

@end
