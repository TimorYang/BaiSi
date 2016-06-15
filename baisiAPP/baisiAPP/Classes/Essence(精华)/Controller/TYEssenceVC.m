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

@interface TYEssenceVC ()

@end

@implementation TYEssenceVC

- (void)viewDidLoad {
    [super viewDidLoad];
    //添加左边的item
    //1.创建Button
    UIButton *buttonItem = [UIButton buttonWithType:UIButtonTypeCustom];
    //2.设置Button默认图片
    [buttonItem setImage:[UIImage imageNamed:@"nav_item_game_icon"] forState:UIControlStateNormal];
    //3.设置Button高亮图片
    [buttonItem setImage:[UIImage imageNamed:@"nav_item_game_click_icon"] forState:UIControlStateHighlighted];
    //4.设置Button尺寸
    [buttonItem sizeToFit];
    //5.监听按钮的点击
    [buttonItem addTarget:self action:@selector(game) forControlEvents:UIControlEventTouchUpInside];
    //5.创建一个UIView
    UIView *view = [[UIView alloc]initWithFrame:buttonItem.bounds];
    //6.把Button添加到View中
    [view addSubview:buttonItem];
    //5.设置左边的UIBarButtonItem
    self.navigationItem.leftBarButtonItem =  [[UIBarButtonItem alloc]initWithCustomView:view];
}

#pragma mark - 设置导航栏内容

#pragma mark - 按钮点击事件
- (void)game
{
    NSLog(@"点击了game");
}

@end
