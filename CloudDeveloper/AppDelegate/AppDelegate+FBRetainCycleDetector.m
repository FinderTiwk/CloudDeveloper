//
//  AppDelegate+FBRetainCycleDetector.m
//  CloudDeveloper
//
//  Created by _Finder丶Tiwk on 16/4/20.
//  Copyright © 2016年 _Finder丶Tiwk. All rights reserved.
//

#import "AppDelegate+FBRetainCycleDetector.h"

/*! FBRetainCycleDetector*/
#import <FBMemoryProfiler/FBMemoryProfiler.h>
#import <FBAllocationTracker/FBAllocationTracker.h>
#import <FBRetainCycleDetector/FBRetainCycleDetector.h>

@interface CacheCleanerPlugin : NSObject<FBMemoryProfilerPluggable>
@end

@interface RetainCycleLoggerPlugin : NSObject<FBMemoryProfilerPluggable>
@end

#pragma mark - AppDelegate (FBRetainCycleDetector)
@implementation AppDelegate (FBRetainCycleDetector)

+ (void)xks_setupRetainCycleDetector{
#if DEBUG
    [FBAssociationManager hook];
    [[FBAllocationTrackerManager sharedManager] startTrackingAllocations];
    [[FBAllocationTrackerManager sharedManager] enableGenerations];
#endif
}

- (void)xks_configRetainCycleDetector{
#if DEBUG
    NSArray *filters = @[FBFilterBlockWithObjectIvarRelation([UIView class], @"_subviewCache")];
    
    CacheCleanerPlugin *cachePlugin       = [CacheCleanerPlugin new];
    RetainCycleLoggerPlugin *loggerPlugin = [RetainCycleLoggerPlugin new];
    
    FBObjectGraphConfiguration *configuration =
    [[FBObjectGraphConfiguration alloc] initWithFilterBlocks:filters
                                         shouldInspectTimers:YES];
    memoryProfiler = [[FBMemoryProfiler alloc] initWithPlugins:@[cachePlugin,loggerPlugin] retainCycleDetectorConfiguration:configuration];
    [memoryProfiler enable];
#endif
}


@end


#pragma mark - CacheCleanerPlugin

@implementation CacheCleanerPlugin
- (void)memoryProfilerDidMarkNewGeneration {
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
}

@end

#pragma mark - RetainCycleLoggerPlugin

@implementation RetainCycleLoggerPlugin
- (void)memoryProfilerDidFindRetainCycles:(NSSet *)retainCycles{
    if (retainCycles.count > 0 ) {
        NSLog(@"\n 🔴 retainCycles = \n%@", retainCycles);
    }
}

@end

