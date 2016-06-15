//
//  TYMeVC.m
//  baisiAPP
//
//  Created by TimorYang on 16/6/14.
//  Copyright © 2016年 TimorYang. All rights reserved.
//

#import "TYMeVC.h"
#import "UIBarButtonItem+item.h"

@interface TYMeVC ()

@end

@implementation TYMeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置导航栏内容
    [self setupNavigationBar];
}
#pragma mark - 设置导航栏内容
- (void)setupNavigationBar
{
    //添加标题
    self.navigationItem.title = @"我的";
    
    //添加右侧按钮组
    //第一个按钮
    UIBarButtonItem *settingItem = [UIBarButtonItem buttonItemImage:[UIImage imageNamed:@"mine-setting-icon"] highLightImage:[UIImage imageNamed:@"mine-setting-icon-click"] target:self action:@selector(setting)];
    //添加第二个按钮
    UIBarButtonItem *nightModeItem = [UIBarButtonItem buttonItemImage:[UIImage imageNamed:@"mine-moon-icon"] selectImage:[UIImage imageNamed:@"mine-moon-icon-click"] target:self action:@selector(nightMode:)];
    self.navigationItem.rightBarButtonItems = @[settingItem, nightModeItem];

}
#pragma mark - settingItem点击事件
- (void)setting
{
    NSLog(@"点击了设置");
}

#pragma mark - nightModeItem点击事件
- (void)nightMode:(UIButton *)button
{
    button.selected = !button.selected;
    NSLog(@"点击了夜间模式");
}
@end
