//
//  TYAllViewController.m
//  baisiAPP
//
//  Created by TimorYang on 16/6/22.
//  Copyright © 2016年 TimorYang. All rights reserved.
//

#import "TYAllViewController.h"
#import "TYThemeCell.h"
#import <AFNetworking/AFNetworking.h>
#import <MJExtension/MJExtension.h>
#import "TYThemeItem.h"
#import "TYThemeViewModel.h"

static NSString * const ID = @"All";
@interface TYAllViewController ()

@property (nonatomic, strong) NSMutableArray *itemArray;
@end

@implementation TYAllViewController

#pragma mark - itemArray懒加载
- (NSMutableArray *)itemArray
{
    if(_itemArray == nil)
    {
        _itemArray = [NSMutableArray array];
    }
    return _itemArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[TYThemeCell class] forCellReuseIdentifier:ID];
    //设置tableView的内边距
    self.tableView.contentInset = UIEdgeInsetsMake(64 + 35, 0, 49, 0);
    
    //加载数据
    [self loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 加载数据
- (void)loadData
{
    //创建会话管理者
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    //拼接请求参数
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"list";
    parameters[@"c"] = @"data";
    parameters[@"type"] = @(TYThemeTypeAll);
    //发送请求
    [mgr GET:BaseURL parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [responseObject writeToFile:@"/Users/timoryang/Documents/OC项目/BaiSi/baisiAPP/baisiAPP/Classes/Essence(精华)/all.plist" atomically:YES];
        
        //定义一个数组保存返回的数据
        NSArray *dataArr = responseObject[@"list"];
        //字典转模型
        NSArray *modelItemArray = [TYThemeItem mj_objectArrayWithKeyValuesArray:dataArr];
        //模型存放到视图模型
        for (TYThemeItem *item in modelItemArray) {
            TYThemeViewModel *vm = [[TYThemeViewModel alloc]init];
            vm.item = item;
            [self.itemArray addObject:vm];
        }
        
        //刷新数据
        [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.itemArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TYThemeCell *cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
    cell.vm = self.itemArray[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TYThemeViewModel *vm = self.itemArray[indexPath.row];
    return vm.cell_h;
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
