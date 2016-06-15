//
//  TYNavigationController.m
//  baisiAPP
//
//  Created by TimorYang on 16/6/15.
//  Copyright © 2016年 TimorYang. All rights reserved.
//

#import "TYNavigationController.h"

@implementation TYNavigationController

//类一加载就设置好他的导航栏的字体
//谁的事情谁管理
+ (void)load
{
    //为什么不获取全局的,获取全局的会出现问题,会修改其他导航栏的,所以获取当前类的.
    //获取当前类的导航条
    UINavigationBar *navgationBar = [UINavigationBar appearanceWhenContainedIn:self, nil];
    //设置字体
    NSMutableDictionary *attr = [NSMutableDictionary dictionary];
    attr[NSFontAttributeName] = [UIFont boldSystemFontOfSize:20];
    [navgationBar setTitleTextAttributes:attr];
    
    //设置背景图片
    [navgationBar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
}

@end
