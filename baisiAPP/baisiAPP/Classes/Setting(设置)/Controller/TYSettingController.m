//
//  TYableViewController.m
//  baisiAPP
//
//  Created by TimorYang on 16/6/15.
//  Copyright © 2016年 TimorYang. All rights reserved.
//

/*
 1.自定义返回按钮替换系统自带的
    > 自定义按钮,没有尺寸,文字颜色默认是白色
    > 设置按钮的内边距实现按钮位置的偏移
    **替换系统的返回按钮后,侧滑返回功能不能使用**
 2.统一设置返回按钮
    > 在NavigationController中设置
 */

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
    
}


@end
