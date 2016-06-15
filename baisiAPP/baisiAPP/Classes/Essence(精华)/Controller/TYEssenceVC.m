//
//  TYEssenceVC.m
//  baisiAPP
//
//  Created by TimorYang on 16/6/14.
//  Copyright © 2016年 TimorYang. All rights reserved.
//

/*
 1.设置左边的UIBarButtonItem,直接使用UIButton,出现bug,点击按钮周围也会调用点击事件
   > 原因:一般情况下,设置一个按钮宽度,那么点击范围就是按钮范围,但是把按钮包装成UIBarButtonItem,点击范围扩大
   > 解决方法:把按钮放到UIView中,再把UIView包装成UIBarButtonItem
 */

#import "TYEssenceVC.h"
#import "UIBarButtonItem+item.h"

@interface TYEssenceVC ()

@end

@implementation TYEssenceVC

- (void)viewDidLoad {
    [super viewDidLoad];
    //添加左边的item
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem buttonItemImage:[UIImage imageNamed:@"nav_item_game_icon"] highLightImage:[UIImage imageNamed:@"nav_item_game_click_icon"] target:self action:@selector(game)];
    
    //添加Title
    self.navigationItem.titleView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
    //添加右边的item
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem buttonItemImage:[UIImage imageNamed:@"navigationButtonRandom"] highLightImage:[UIImage imageNamed:@"navigationButtonRandomClick"] target:self action:@selector(random)];
}

#pragma mark - 设置导航栏内容

#pragma mark - 游戏按钮点击事件
- (void)game
{
    NSLog(@"点击了game");
}

#pragma mark - 随机按钮点击事件
- (void)random
{
    NSLog(@"点击了随机");
}
@end
