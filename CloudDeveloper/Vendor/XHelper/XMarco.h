//
//  XMarco.h
//  AirPortVIP
//
//  Created by _Finder丶Tiwk on 16/3/25.
//  Copyright © 2016年 _Finder丶Tiwk. All rights reserved.
//

#ifndef XMarco_h
#define XMarco_h

/**
 *  @author _Finder丶Tiwk, 16-01-12 19:01:30
 *
 *  @brief 单例声明
 *  @param __className 类名
 *  @return 单例
 *  @since v0.1.0
 */
#define singleton(__className) \
+ (__className *)share##__className;

/**
 *  @author _Finder丶Tiwk, 16-01-12 19:01:08
 *
 *  @brief 单例的实现
 *  @param __className 类名
 *  @return 单例
 *  @since v0.1.0
 */
#define singletonImpl(__className) \
static __className *_instance; \
+ (id)allocWithZone:(NSZone *)zone{\
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instance = [super allocWithZone:zone]; \
}); \
return _instance; \
} \
+ (__className *)share##__className{\
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instance = [[self alloc] init]; \
}); \
return _instance; \
}



#pragma mark - 颜色
/**
 *  @author _Finder丶Tiwk, 16-01-12 19:01:48
 *
 *  @brief UIColor初始化宏
 *  @param __r 红色
 *  @param __g 绿色
 *  @param __b 蓝色
 *  @param __a 透明度
 *  @return RGB颜色
 *  @since v0.1.0
 */
#define RGBACOLOR(__r,__g,__b,__a) \
[UIColor colorWithRed:(__r)/255.0f green:(__g)/255.0f blue:(__b)/255.0f alpha:(__a)]

#define RGBCOLOR(__r,__g,__b)  RGBACOLOR(__r,__g,__b,1)


#pragma mark - Block循环引用

/**
 *  @author _Finder丶Tiwk, 16-01-13 15:01:04
 *  这个宏灵感来源于ReactiveCocoa EXTScope.h
 *  @since v0.1.0
 */
#ifndef    xWeakify
#if __has_feature(objc_arc)
#define xWeakify autoreleasepool{} __weak __typeof__(self) weakRef = self;
#else
#define xWeakify autoreleasepool{} __block __typeof__(self) blockRef = self;
#endif
#endif

#ifndef     xStrongify
#if __has_feature(objc_arc)
#define xStrongify try{} @finally{} __typeof__(weakRef) self = weakRef;
#else
#define xStrongify try{} @finally{} __typeof__(blockRef) self = blockRef;
#endif
#endif

#endif /* XMarco_h */
