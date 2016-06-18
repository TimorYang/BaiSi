//
//  TYSubTagViewController.m
//  baisiAPP
//
//  Created by TimorYang on 16/6/18.
//  Copyright © 2016年 TimorYang. All rights reserved.
//

#import "TYSubTagViewController.h"
#import <AFNetworking/AFNetworking.h>
#import <MJExtension/MJExtension.h>
#import <UIImageView+WebCache.h>
#import "TYSubTagItem.h"
#import "TYTableViewCell.h"

@interface TYSubTagViewController ()

@property (nonatomic, strong) NSArray *subArray;
@end

@implementation TYSubTagViewController
//const 常量
// 谁不想修改,就用const去修饰
// const:修饰右边变量,被const修饰变量只读
static NSString *const ID = @"subtag";
/*
 默认cell的标示符 cell
 1.加载xib描述的cell 有几种方式
 1. NSBundle 一定要记得绑定标识符(在xib中绑定)
 2. 注册xib
 
 在开发中,尽量注册
 */
/*
 1.让分割线占据全屏
 1.自定义分割线 2.设置系统属性就能搞定 (iOS6和iOS7适配 iOS7和iOS8适配) 3.重写cell的frame
 
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    //设置导航栏标题
    //(方法一)不能用在根控制器上,快捷方法
    self.title = @"推荐标签";
    //(方法二)正常使用
//    self.navigationItem.title = @"推荐标签";
    //注册
    [self.tableView registerNib:[UINib nibWithNibName:@"TYTableViewCell" bundle:nil] forCellReuseIdentifier:ID];
    // 加载数据 => 服务器 => 查看接口文档(1.基本url 2.请求参数 3.请求方式) => 发送请求 => 解析数据 => 字典转模型 => 展示到界面
    [self loadData];
    
    //让分割线占据全屏
//    self.tableView.separatorInset = UIEdgeInsetsZero;
    
    //方法三(重写cell的frame)
    //设置tableView的背景色
    self.tableView.backgroundColor = [UIColor cyanColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.subArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //创建cell
    TYTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
//    TYTableViewCell *cell = [[NSBundle mainBundle]loadNibNamed:@"TYTableViewCell" owner:nil options:nil].firstObject;
    
    //设置cell
    cell.item = self.subArray[indexPath.row];
    
    //iOS8往上需要设置
//    if([[UIDevice currentDevice].systemVersion floatValue] >= 8.0)
//    {
//        cell.layoutMargins = UIEdgeInsetsZero;
//    }

    // Configure the cell...
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 61;
}

#pragma mark - 请求数据
- (void)loadData
{
    //创建会话管理者
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    //设置参数
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"tag_recommend";
    parameters[@"c"] = @"topic";
    parameters[@"action"] = @"sub";
    //发送请求
    [mgr GET:BaseURL parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //请求成功
        //写到文件中分析响应体
        //        [responseObject writeToFile:@"/Users/timoryang/Documents/OC项目/BaiSi/baisiAPP/baisiAPP/Classes/New(新帖)/subtag.plist" atomically:YES];
        //字典转模型
        self.subArray = [TYSubTagItem mj_objectArrayWithKeyValuesArray:responseObject];
        //刷新tableView
        [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
    }];

}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
