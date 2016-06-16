//
//  XBaseNavigationController.m
//  CloudDeveloper
//
//  Created by _Finder丶Tiwk on 16/6/17.
//  Copyright © 2016年 _Finder丶Tiwk. All rights reserved.
//

#import "XBaseNavigationController.h"

@implementation XBaseNavigationController


+ (void)initialize{
    [self setupNavBar];
    
    [self setupNavItem];
}

+ (void)setupNavBar{
    
    UINavigationBar *navBar = [UINavigationBar appearance];
  
    NSMutableDictionary *navBarAttributeDicM = [NSMutableDictionary dictionary];
    navBarAttributeDicM[NSForegroundColorAttributeName] = [UIColor whiteColor];
    
    NSShadow *shadow    = [[NSShadow alloc] init];
    shadow.shadowColor  = [UIColor lightTextColor];
    shadow.shadowOffset = CGSizeMake(1, 1);
    
    navBarAttributeDicM[NSShadowAttributeName] = shadow;
    navBarAttributeDicM[NSFontAttributeName]   = [UIFont boldSystemFontOfSize:20];
    
    [navBar setTitleTextAttributes:navBarAttributeDicM];
    
}

+ (void)setupNavItem{
    
    UIBarButtonItem *navItem = [UIBarButtonItem appearance];
    
    NSMutableDictionary *navItemAttributeDicM = [NSMutableDictionary dictionary];
    navItemAttributeDicM[NSForegroundColorAttributeName] = [UIColor whiteColor];
    
    NSShadow *shadow    = [[NSShadow alloc] init];
    shadow.shadowColor  = [UIColor lightTextColor];
    shadow.shadowOffset = CGSizeMake(1, 1);
    navItemAttributeDicM[NSShadowAttributeName] = shadow;
    navItemAttributeDicM[NSFontAttributeName]   = [UIFont boldSystemFontOfSize:18];
    
    [navItem setTitleTextAttributes:navItemAttributeDicM forState:UIControlStateNormal];
    [navItem setTitleTextAttributes:navItemAttributeDicM forState:UIControlStateNormal];
    
}



- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}


@end
