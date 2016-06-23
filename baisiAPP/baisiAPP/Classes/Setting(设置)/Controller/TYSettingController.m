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
#import <UIImageView+WebCache.h>
#import "TYFileManger.h"
#import <SVProgressHUD/SVProgressHUD.h>

@interface TYSettingController ()<UITableViewDelegate>
/** 文件大小 */
@property (nonatomic, assign) NSInteger totalSize;
@end

static NSString * const ID = @"cell";
@implementation TYSettingController

- (void)viewDidLoad
{
    [super viewDidLoad];
    //添加返回按钮
//    [self setupBackButton];
    
    //注册cell
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:ID];
    
    //去掉底部的线
    self.tableView.tableFooterView = [[UIView alloc]init];
    NSLog(@"sd----%ld", [[SDImageCache sharedImageCache]getSize]);
    
    //获取文件夹尺寸
    [SVProgressHUD showWithStatus:@"正在计算缓存"];
    [TYFileManger getDirectorySizeOfDirectoryPath:TYCaches completion:^(NSInteger totalSize) {
        [SVProgressHUD dismiss];
        self.totalSize = totalSize;
        //刷新数据
        [self.tableView reloadData];
        //把动画dismiss
    }];
    
    //设置代理
    self.tableView.delegate = self;
}
#pragma mark - 设置导航栏返回按钮
- (void)setupBackButton
{
    
}

#pragma mark - 数据源方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
    cell.textLabel.text = [self totalSizeStr];
    return cell;
}

#pragma mark - 文件大小转字符串
- (NSString *)totalSizeStr
{
    NSString *totalSizeStr = @"清理缓存";
    //定义一个变量保存转换后的totalSize
    CGFloat totalSizeF = 0;
    //判断文件大小是否超过1M
    if(self.totalSize > 1000 * 1000)
    {
        totalSizeF = self.totalSize / 1000.0 / 1000.0;
        //格式转换
        totalSizeStr = [NSString stringWithFormat:@"%@%.1lfM", totalSizeStr, totalSizeF];
    }else if (self.totalSize > 1000)
    {
        totalSizeF = self.totalSize / 1000.0;
        //格式转换
        totalSizeStr = [NSString stringWithFormat:@"%@%.1lfKB", totalSizeStr, totalSizeF];
    }else if (self.totalSize > 0)
    {
        totalSizeStr = [NSString stringWithFormat:@"%@%ldB", totalSizeStr, self.totalSize];
    }
    //如果后面是.0就替换为空
    totalSizeStr = [totalSizeStr stringByReplacingOccurrencesOfString:@".0" withString:@""];
    
    return totalSizeStr;
}


#pragma mark - UITableViewDelegate
//点击了cell调用这个方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //刷新tableView
    [self.tableView reloadData];
}

@end
