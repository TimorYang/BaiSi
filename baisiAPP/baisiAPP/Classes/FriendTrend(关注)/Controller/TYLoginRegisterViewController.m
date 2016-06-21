//
//  TYLoginRegisterViewController.m
//  baisiAPP
//
//  Created by TimorYang on 16/6/19.
//  Copyright © 2016年 TimorYang. All rights reserved.
//

#import "TYLoginRegisterViewController.h"
#import "TYLoginRegisterView.h"
#import "TYFastLogin.h"

@interface TYLoginRegisterViewController ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *ViewLine;
@property (weak, nonatomic) IBOutlet UIView *loginRegisterView;
@property (weak, nonatomic) IBOutlet UIView *bottomView;

@end

@implementation TYLoginRegisterViewController

// viewDidLoad约束还没有生效
- (void)viewDidLoad {
    [super viewDidLoad];
    //添加loginView
    TYLoginRegisterView *loginView = [TYLoginRegisterView loginView];
    [self.loginRegisterView addSubview:loginView];
    //添加registerView
    TYLoginRegisterView *registerView = [TYLoginRegisterView registerView];
//    registerView.TY_x = TYScreenW;
    [self.loginRegisterView addSubview:registerView];
    //添加FastLoginView
    TYFastLogin *fastLoginView = [TYFastLogin fastLogin];
//    fastLoginView.frame = self.bottomView.bounds;
    [self.bottomView addSubview:fastLoginView];
}
//约束生效
- (void)viewDidLayoutSubviews
{
    //设置loginView
    UIView *loginView = self.loginRegisterView.subviews[0];
    loginView.frame = CGRectMake(0, 0, self.loginRegisterView.TY_width * 0.5, self.loginRegisterView.TY_height);
    
    //设置registerView
    UIView *registerView = self.loginRegisterView.subviews[1];
    registerView.frame = CGRectMake(self.loginRegisterView.TY_width * 0.5, 0, self.loginRegisterView.TY_width * 0.5, self.loginRegisterView.TY_height);
    
    //设置fastLoginView
    UIView *fastView = self.bottomView.subviews[0];
    fastView.frame = self.bottomView.bounds;
    
    
}

#pragma mark - 点击屏幕退出键盘
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
#pragma mark - dismis
- (IBAction)dismiss:(id)sender {
    //dismiss
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - 点击注册账号
- (IBAction)loginRegisterBtnClick:(UIButton *)sender {
    sender.selected = !sender.selected;
    self.ViewLine.constant = self.ViewLine.constant == 0 ?-TYScreenW : 0;
    //设置动画
    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
    }];
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
