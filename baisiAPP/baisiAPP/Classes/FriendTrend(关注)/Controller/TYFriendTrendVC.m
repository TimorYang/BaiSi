//
//  TYFriendTrendVC.m
//  baisiAPP
//
//  Created by TimorYang on 16/6/14.
//  Copyright © 2016年 TimorYang. All rights reserved.
//

#import "TYFriendTrendVC.h"
#import "UIBarButtonItem+item.h"
#import "TYLoginRegisterViewController.h"
@interface TYFriendTrendVC ()

@end

@implementation TYFriendTrendVC

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置导航栏内容
    [self setupNavigationBar];
    //设置背景颜色
    self.view.backgroundColor = TYColor(215, 215, 215, 1);
}
#pragma mark - 设置导航栏内容
- (void)setupNavigationBar
{
    //添加左侧按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem buttonItemImage:[UIImage imageNamed:@"friendsRecommentIcon"] highLightImage:[UIImage imageNamed:@"friendsRecommentIcon-click"] target:self action:@selector(friendsRecomment)];
    
    //添加标题
    self.navigationItem.title = @"我的关注";
}

#pragma mark - 推荐关注按钮点击事件
- (void)friendsRecomment
{
    NSLog(@"点击了推荐按钮");
}

#pragma mark - 点击立即登录注册
- (IBAction)loginRegisterClick {
    //modal出一个界面
    //创建TYLoginRegisterViewController
    TYLoginRegisterViewController *loginRegisterVC = [[TYLoginRegisterViewController alloc]init];
    [self presentViewController:loginRegisterVC animated:YES completion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
