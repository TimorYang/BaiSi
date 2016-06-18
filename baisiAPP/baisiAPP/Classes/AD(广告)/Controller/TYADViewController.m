//
//  TYADViewController.m
//  baisiAPP
//
//  Created by TimorYang on 16/6/17.
//  Copyright © 2016年 TimorYang. All rights reserved.
//

#import "TYADViewController.h"
#import <AFNetworking/AFNetworking.h>
#import <MJExtension/MJExtension.h>
#import <UIImageView+WebCache.h>
#import "TYTabBarController.h"
#import "TYADItem.h"
#define baseURL  @"http://mobads.baidu.com/cpro/ui/mads.php"
#define TYCode2 @"phcqnauGuHYkFMRquANhmgN_IauBThfqmgKsUARhIWdGULPxnz3vndtkQW08nau_I1Y1P1Rhmhwz5Hb8nBuL5HDknWRhTA_qmvqVQhGGUhI_py4MQhF1TvChmgKY5H6hmyPW5RFRHzuET1dGULnhuAN85HchUy7s5HDhIywGujY3P1n3mWb1PvDLnvF-Pyf4mHR4nyRvmWPBmhwBPjcLPyfsPHT3uWm4FMPLpHYkFh7sTA-b5yRzPj6sPvRdFhPdTWYsFMKzuykEmyfqnauGuAu95Rnsnbfknbm1QHnkwW6VPjujnBdKfWD1QHnsnbRsnHwKfYwAwiu9mLfqHbD_H70hTv6qnHn1PauVmynqnjclnj0lnj0lnj0lnj0lnj0hThYqniuVujYkFhkC5HRvnB3dFh7spyfqnW0srj64nBu9TjYsFMub5HDhTZFEujdzTLK_mgPCFMP85Rnsnbfknbm1QHnkwW6VPjujnBdKfWD1QHnsnbRsnHwKfYwAwiuBnHfdnjD4rjnvPWYkFh7sTZu-TWY1QW68nBuWUHYdnHchIAYqPHDzFhqsmyPGIZbqniuYThuYTjd1uAVxnz3vnzu9IjYzFh6qP1RsFMws5y-fpAq8uHT_nBuYmycqnau1IjYkPjRsnHb3n1mvnHDkQWD4niuVmybqniu1uy3qwD-HQDFKHakHHNn_HR7fQ7uDQ7PcHzkHiR3_RYqNQD7jfzkPiRn_wdKHQDP5HikPfRb_fNc_NbwPQDdRHzkDiNchTvwW5HnvPj0zQWndnHRvnBsdPWb4ri3kPW0kPHmhmLnqPH6LP1ndm1-WPyDvnHKBrAw9nju9PHIhmH9WmH6zrjRhTv7_5iu85HDhTvd15HDhTLTqP1RsFh4ETjYYPW0sPzuVuyYqn1mYnjc8nWbvrjTdQjRvrHb4QWDvnjDdPBuk5yRzPj6sPvRdgvPsTBu_my4bTvP9TARqnam"

@interface TYADViewController ()
/** 启动图片 */
@property (weak, nonatomic) IBOutlet UIImageView *loadImage;
/** 占位图片 */
@property (weak, nonatomic) IBOutlet UIView *placeImage;
/** 跳过按钮 */
@property (weak, nonatomic) IBOutlet UIButton *jumpButton;
/** 定时器 */
@property (nonatomic, weak) NSTimer *timer;
/** 模型 */
@property (nonatomic, strong) TYADItem *adItem;

@end
@implementation TYADViewController

- (void)viewDidLoad
{
    //1.屏幕适配
    [self screenFit];
    
    //2.加载广告
    [self setADImage];
    
    //3.创建定时器
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(setBtnValue) userInfo:nil repeats:YES];
}

#pragma mark - 屏幕适配
- (void)screenFit
{
    //屏幕适配
    if(iPhone6P)
    {
        self.loadImage.image = [UIImage imageNamed:@"LaunchImage-800-Portrait-736h@3x"];
    }else if (iPhone6)
    {
        self.loadImage.image = [UIImage imageNamed:@"LaunchImage-800-667h"];
    }else if (iPhone5)
    {
        self.loadImage.image = [UIImage imageNamed:@"LaunchImage-700-568h"];
    }else if (iPhone4)
    {
        self.loadImage.image = [UIImage imageNamed:@"LaunchImage"];
    }
}

#pragma mark - 下载广告,设置广告
- (void)setADImage
{
    //下载广告
    //1.创建会话管理者
    AFHTTPSessionManager *msr =  [AFHTTPSessionManager manager];
    //设置参数
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"code2"] = TYCode2;
    //3.发送网络请求
    [msr GET:baseURL parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //请求成功
        //        NSLog(@"%@", responseObject);
        
        NSDictionary *adDict = [responseObject[@"ad"] firstObject];
        //把响应体写到文件中分析参数
        //        [responseObject writeToFile:@"/Users/timoryang/Documents/OC项目/BaiSi/baisiAPP/baisiAPP/Classes/AD(广告)/ad.plist" atomically:YES];
        //字典转模型
        self.adItem = [TYADItem mj_objectWithKeyValues:adDict];
        //设置广告图片
        UIImageView *adImageView = [[UIImageView alloc]init];
        //添加到占位View中
        [self.placeImage addSubview:adImageView];
        
        //防止广告图片超出屏幕,等比例缩小广告图片
        CGFloat h = TYScreenW / self.adItem.w * self.adItem.h;
        if(h >= TYScreenH * 0.8)
        {
            h = TYScreenH *0.8;
        }
        //设置adImageView的frame
        adImageView.frame = CGRectMake(0, 0, TYScreenW, h);
        
        //下载图片
        NSURL *url = [NSURL URLWithString:self.adItem.w_picurl];
        [adImageView sd_setImageWithURL:url];
        
        //点击广告能够跳转到网站
        //1.添加手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap)];
        
        //2.给adImageView添加手势
        [adImageView addGestureRecognizer:tap];
        //3.允许用户交互
        adImageView.userInteractionEnabled = YES;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //请求失败
        NSLog(@"%@", error);
    }];

}

#pragma mark - tap(点按广告图片跳转网站)
- (void)tap
{
    //跳转网页
    NSURL *url = [NSURL URLWithString:self.adItem.ori_curl];
    //跳转网页
    if([[UIApplication sharedApplication] canOpenURL:url])
    {
        [[UIApplication sharedApplication]openURL:url];
    }
}

#pragma mark - jumptoIndex(倒计时结束后跳转到主框架界面)
- (void)setBtnValue
{
    static int i = 3;
    i--;
    [self.jumpButton setTitle:[NSString stringWithFormat:@"跳过(%d)", i] forState:UIControlStateNormal];
    //当i为0时跳转到主框架界面
    if(i < 0)
    {
        [self jumpClick];
    }
    
}

#pragma mark - jumpClick(点击跳过按钮跳转到主框架界面)
- (IBAction)jumpClick {
    //跳转到主框架界面
    TYTabBarController *tabbarvc = [[TYTabBarController alloc]init];
    [UIApplication sharedApplication].keyWindow.rootViewController = tabbarvc;
    //销毁定时器
    [self.timer invalidate];
}

@end
