//
//  TYNavigationController.m
//  baisiAPP
//
//  Created by TimorYang on 16/6/15.
//  Copyright © 2016年 TimorYang. All rights reserved.
//

/*
 1. 为什么在load中设置导航条的字体
    > 设置导航条的字体只需要做一次,而load这个方法是类加载到内存中时调用,只会调用一次,所以在这个方法里面来设置导航条的字体
 2. 为什么在pushViewController中来统一设置返回按钮
    > 当push到下一个Controller后,才需要返回按钮,所以在这个方法里面统一设置返回按钮
    **在TabBarController中我们用了initWithRootViewController来设置NavigationController的根控制器,initWithRootViewController底层会调用pushViewController这个方法,所以程序一启动pushViewController会被调用多次**
 */

#import "TYNavigationController.h"

@implementation TYNavigationController

#pragma mark - 设置当前类的导航条的字体
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

#pragma mark - viewDidLoad
- (void)viewDidLoad
{
    [super viewDidLoad];
}

#pragma mark - pushViewController
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    //非根控制器才需要返回按钮(initWithRootViewController底层会调用push方法)
    if(self.childViewControllers.count > 0)
    {
        //设置导航栏左边的按钮
        UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        //设置正常状态的图片
        [backButton setImage:[UIImage imageNamed:@"navigationButtonReturn"] forState:UIControlStateNormal];
        //设置高亮状态下的图片
        [backButton setImage:[UIImage imageNamed:@"navigationButtonReturnClick"] forState:UIControlStateHighlighted];
        //设置文字
        [backButton setTitle:@"返回" forState:UIControlStateNormal];
        [backButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        //设置按钮高亮时文字的颜色
        [backButton setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        //监听backButton
        [backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        //设置按钮尺寸
        [backButton sizeToFit];
        //设置按钮的内边距
        backButton.contentEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
        //
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backButton];
    }
    //真正的进行跳转
    [super pushViewController:viewController animated:animated];
}

#pragma mark - backButton点击事件
- (void)back
{
    //返回上一级
    [self popViewControllerAnimated:YES];
}

@end
