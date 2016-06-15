//
//  TYNewVC.m
//  baisiAPP
//
//  Created by TimorYang on 16/6/14.
//  Copyright © 2016年 TimorYang. All rights reserved.
//

#import "TYNewVC.h"
#import "UIBarButtonItem+item.h"

@interface TYNewVC ()

@end

@implementation TYNewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置导航栏内容
    [self setupNavigationBar];
}
#pragma mark - 设置导航栏内容
- (void)setupNavigationBar
{
    //添加左侧按钮(推荐标签)
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem buttonItemImage:[UIImage imageNamed:@"MainTagSubIcon"] highLightImage:[UIImage imageNamed:@"MainTagSubIconClick"] target:self action:@selector(tagsub)];
    
    //添加标题
    self.navigationItem.titleView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"MainTitle"]];

}

#pragma mark - 推荐标签点击事件
- (void)tagsub
{
    NSLog(@"点击了推荐标签");
}

@end
