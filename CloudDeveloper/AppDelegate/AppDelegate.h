//
//  AppDelegate.h
//  CloudDeveloper
//
//  Created by _Finder丶Tiwk on 16/4/7.
//  Copyright © 2016年 _Finder丶Tiwk. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FBMemoryProfiler;

@interface AppDelegate : UIResponder <UIApplicationDelegate>{
    FBMemoryProfiler *memoryProfiler;
}

@property (strong, nonatomic) UIWindow *window;


@end

