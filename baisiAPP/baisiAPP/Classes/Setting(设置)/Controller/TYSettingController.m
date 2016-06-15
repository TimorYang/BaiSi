//
//  TYableViewController.m
//  baisiAPP
//
//  Created by TimorYang on 16/6/15.
//  Copyright © 2016年 TimorYang. All rights reserved.
//

#import "TYSettingController.h"

@implementation TYSettingController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupBackButton];
    
    //添加手势
    
}
#pragma mark - 设置导航栏返回按钮
- (void)setupBackButton
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
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backButton];
}

#pragma mark - backButton点击事件
- (void)back
{
    //返回上一级
    [self.navigationController popViewControllerAnimated:YES];
}
@end
