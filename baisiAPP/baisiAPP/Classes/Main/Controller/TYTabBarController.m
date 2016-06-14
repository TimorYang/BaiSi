//
//  TYTabBarController.m
//  baisiAPP
//
//  Created by TimorYang on 16/6/14.
//  Copyright © 2016年 TimorYang. All rights reserved.
//

#import "TYTabBarController.h"
#import "TYEssenceVC.h"
#import "TYNewVC.h"
#import "TYPublishVC.h"
#import "TYFriendTrendVC.h"
#import "TYMeVC.h"

@interface TYTabBarController ()

@end

@implementation TYTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    //添加子控制器
    [self setupAllChildViewController];
    //设置TabBarIterm按钮的图片和文字
    [self setupAllButtonIterm];
}

#pragma mark - 添加子控制器
- (void)setupAllChildViewController
{
    //添加子控制器
    //>> 精华
    //>> 1.创建UIViewController
    TYEssenceVC *vc1 = [[TYEssenceVC alloc]init];
    //>> 2.设置控制器view的背景色
    vc1.view.backgroundColor = [UIColor greenColor];
    //>> 3.创建UINavigationController并设置vc为essenceNav的根控制器
    UINavigationController *essenceNav = [[UINavigationController alloc]initWithRootViewController:vc1];
    //>> 4.将essenceNav添加到TabBarController中
    [self addChildViewController:essenceNav];
    
    //>> 新帖
    //>> 1.创建UIViewController
    TYNewVC *vc2 = [[TYNewVC alloc]init];
    //>> 2.设置控制器view的背景色
    vc2.view.backgroundColor = [UIColor yellowColor];
    //>> 3.创建UINavigationController并设置vc为essenceNav的根控制器
    UINavigationController *newNav = [[UINavigationController alloc]initWithRootViewController:vc2];
    //>> 4.将essenceNav添加到TabBarController中
    [self addChildViewController:newNav];
    
    //>> 发布
    //>> 1.创建UIViewController
    TYPublishVC *vc3 = [[TYPublishVC alloc]init];
    //>> 2.设置控制器view的背景色
    vc3.view.backgroundColor = [UIColor purpleColor];
    //>> 4.将essenceNav添加到TabBarController中
    [self addChildViewController:vc3];
    
    //>> 关注
    //>> 1.创建UIViewController
    TYFriendTrendVC *vc4 = [[TYFriendTrendVC alloc]init];
    //>> 2.设置控制器view的背景色
    vc4.view.backgroundColor = [UIColor redColor];
    //>> 3.创建UINavigationController并设置vc为essenceNav的根控制器
    UINavigationController *friendTrendNav = [[UINavigationController alloc]initWithRootViewController:vc4];
    //>> 4.将essenceNav添加到TabBarController中
    [self addChildViewController:friendTrendNav];
    
    //>> 我
    //>> 1.创建UIViewController
    TYMeVC *vc5 = [[TYMeVC alloc]init];
    //>> 2.设置控制器view的背景色
    vc5.view.backgroundColor = [UIColor orangeColor];
    //>> 3.创建UINavigationController并设置vc为essenceNav的根控制器
    UINavigationController *meNav = [[UINavigationController alloc]initWithRootViewController:vc5];
    //>> 4.将essenceNav添加到TabBarController中
    [self addChildViewController:meNav];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 给TabBarIterm添加图片和文字
- (void)setupAllButtonIterm
{
    //获取TabBarController的子控制器
    //精华
    UIViewController *vc1 = self.childViewControllers[0];
    //设置图片
    //>> 默认状态
    vc1.tabBarItem.image = [UIImage imageNamed:@"tabBar_essence_icon"];
    //>> 选中状态
    vc1.tabBarItem.selectedImage = [UIImage imageNamed:@"tabBar_essence_click_icon"];
    //设置文字
    vc1.tabBarItem.title = @"精华";
    
    //新帖
    UIViewController *vc2 = self.childViewControllers[1];
    //设置图片
    //>> 默认状态
    vc2.tabBarItem.image = [UIImage imageNamed:@"tabBar_new_icon"];
    //>> 选中状态
    vc2.tabBarItem.selectedImage = [UIImage imageNamed:@"tabBar_new_click_icon"];
    //设置文字
    vc2.tabBarItem.title = @"新帖";
    
    //发布
    UIViewController *vc3 = self.childViewControllers[2];
    //设置图片
    //>> 默认状态
    vc3.tabBarItem.image = [UIImage imageNamed:@"tabBar_publish_icon"];
    //>> 选中状态
    vc3.tabBarItem.selectedImage = [UIImage imageNamed:@"tabBar_publish_click_icon"];
    
    //关注
    UIViewController *vc4 = self.childViewControllers[3];
    //设置图片
    //>> 默认状态
    vc4.tabBarItem.image = [UIImage imageNamed:@"tabBar_friendTrends_icon"];
    //>> 选中状态
    vc4.tabBarItem.selectedImage = [UIImage imageNamed:@"tabBar_friendTrends_click_icon"];
    //设置文字
    vc4.tabBarItem.title = @"关注";
    
    //我
    UIViewController *vc5 = self.childViewControllers[4];
    //设置图片
    //>> 默认状态
    vc5.tabBarItem.image = [UIImage imageNamed:@"tabBar_me_icon"];
    //>> 选中状态
    vc5.tabBarItem.selectedImage = [UIImage imageNamed:@"tabBar_me_click_icon"];
    //设置文字
    vc5.tabBarItem.title = @"我";

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
