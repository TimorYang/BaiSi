//
//  AppDelegate.m
//  baisiAPP
//
//  Created by TimorYang on 16/6/14.
//  Copyright © 2016年 TimorYang. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //1.创建UIWindow
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    //2.设置window
    //> 2.1创建UITabBarController
    UITabBarController *tabbarControll = [[UITabBarController alloc]init];
    //添加子控制器
    //>> 精华
    //>> 1.创建UIViewController
    UIViewController *vc = [[UIViewController alloc]init];
    //>> 2.设置控制器view的背景色
    vc.view.backgroundColor = [UIColor greenColor];
    //>> 3.创建UINavigationController并设置vc为essenceNav的根控制器
    UINavigationController *essenceNav = [[UINavigationController alloc]initWithRootViewController:vc];
    //>> 4.将essenceNav添加到TabBarController中
    [tabbarControll addChildViewController:essenceNav];
    
    //>> 新帖
    //>> 1.创建UIViewController
    UIViewController *vc2 = [[UIViewController alloc]init];
    //>> 2.设置控制器view的背景色
    vc2.view.backgroundColor = [UIColor yellowColor];
    //>> 3.创建UINavigationController并设置vc为essenceNav的根控制器
    UINavigationController *newNav = [[UINavigationController alloc]initWithRootViewController:vc2];
    //>> 4.将essenceNav添加到TabBarController中
    [tabbarControll addChildViewController:newNav];
    
    //>> 发布
    //>> 1.创建UIViewController
    UIViewController *vc3 = [[UIViewController alloc]init];
    //>> 2.设置控制器view的背景色
    vc3.view.backgroundColor = [UIColor purpleColor];
    //>> 3.创建UINavigationController并设置vc为essenceNav的根控制器
    UINavigationController *publishNav = [[UINavigationController alloc]initWithRootViewController:vc3];
    //>> 4.将essenceNav添加到TabBarController中
    [tabbarControll addChildViewController:publishNav];
    
    //>> 关注
    //>> 1.创建UIViewController
    UIViewController *vc4 = [[UIViewController alloc]init];
    //>> 2.设置控制器view的背景色
    vc4.view.backgroundColor = [UIColor redColor];
    //>> 3.创建UINavigationController并设置vc为essenceNav的根控制器
    UINavigationController *friendTrendNav = [[UINavigationController alloc]initWithRootViewController:vc4];
    //>> 4.将essenceNav添加到TabBarController中
    [tabbarControll addChildViewController:friendTrendNav];
    
    //>> 我
    //>> 1.创建UIViewController
    UIViewController *vc5 = [[UIViewController alloc]init];
    //>> 2.设置控制器view的背景色
    vc5.view.backgroundColor = [UIColor orangeColor];
    //>> 3.创建UINavigationController并设置vc为essenceNav的根控制器
    UINavigationController *meNav = [[UINavigationController alloc]initWithRootViewController:vc5];
    //>> 4.将essenceNav添加到TabBarController中
    [tabbarControll addChildViewController:meNav];
    
    //> 2.2设置控制器View的背景色
    tabbarControll.view.backgroundColor = [UIColor blueColor];
    //> 2.3设置窗口的根控制器
    self.window.rootViewController = tabbarControll;
    //3.显示window
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
