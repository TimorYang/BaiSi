//
//  AppDelegate.m
//  baisiAPP
//
//  Created by TimorYang on 16/6/14.
//  Copyright © 2016年 TimorYang. All rights reserved.
//

/*
    广告思路:
 思路一:
    程序运行时,方法的调用顺序
        > 第一步:-[AppDelegate application:willFinishLaunchingWithOptions:]
        > 第二步:-[AppDelegate application:didFinishLaunchingWithOptions:]
    1.程序在willFinishLaunchingWithOptions加载广告
    2.设置跟控制器为TYADViewController
    出现问题:启动界面被卡住了3秒钟,挡住了原本想要展示的广告图片 (此方法不行)
 思路二:
    在didFinishLaunchingWithOptions加载广告界面
    1.设置widow的跟控制器为TYADViewController
    2.在TYADViewController中设置一张跟启动图片一模一样的图片,造成一个应用程序仍在启动的假象
    3.设置一个定时器
    4.时间一到,跳转到主框架的控制器

 */
#import "AppDelegate.h"
#import "TYTabBarController.h"
#import "TYADViewController.h"

@interface AppDelegate ()

@end

//加载广告界面
//1.
@implementation AppDelegate

//- (BOOL)application:(UIApplication *)application willFinishLaunchingWithOptions:(nullable NSDictionary *)launchOptions NS_AVAILABLE_IOS(6_0)
//{
//    //1.创建UIWindow
//    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
//    
//    //2.设置window
//    
//    //> 2.1创建
//    //> 2.1创建UITabBarController
//    TYADViewController *tabbarControll = [[TYADViewController alloc]init];
//    //> 2.2设置控制器View的背景色
//    tabbarControll.view.backgroundColor = [UIColor blueColor];
//    //> 2.3设置窗口的根控制器
//    self.window.rootViewController = tabbarControll;
//    
//    //3.显示window
//    [self.window makeKeyAndVisible];
//    //线程睡眠3秒钟
//    [NSThread sleepForTimeInterval:3];
//    return YES;
//}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //1.创建UIWindow
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    //2.设置window
    //2.1加载广告
    //> 2.1.1创建TYADViewController
    TYADViewController *adVc = [[TYADViewController alloc]init]; // init 做了什么 init => initWithNibName => loadView 1.先去判断有没有指定的NibName,有的话就直接加载 2.再去看有没有同名的xib 3.在看看有没有不带Controller的同名的xib
    //> 2.1.2设置为windows的根控制器吗
    self.window.rootViewController = adVc;
    
    //3.显示window
    [self.window makeKeyAndVisible];
    
    
//    //> 2.2创建UITabBarController
//    TYTabBarController *tabbarControll = [[TYTabBarController alloc]init];
//    //> 2.2设置控制器View的背景色
//    tabbarControll.view.backgroundColor = [UIColor blueColor];
//    //> 2.3设置窗口的根控制器
//    [UIApplication sharedApplication].keyWindow = tabbarControll;
    
    
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
