//
//  TYMeVC.m
//  baisiAPP
//
//  Created by TimorYang on 16/6/14.
//  Copyright © 2016年 TimorYang. All rights reserved.
//
//我的界面分析:就是一个tableview,下面的九宫格样式的可以使用UICollectionView来做,使用流水布局,不需要自己计算
/*
 从storyboard中加载控制器
 1.获取对应的storyboard对应的文件
 UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
 2.加载剪头指向的控制器
 UIViewController *vc = [storyBoard instantiateInitialViewController];
 
 设置底部视图(UICollectionView)
 > 创建collectionView的步骤
   1.创建布局
   2.创建collectionView
   3.设置数据源
   4.注册cell(collectView必须要注册)
 加载数据
 
 
 bug:collectionView不能滚动
 bug:collectionView需要重新设置高度
 2.1 计算collectionView高度 = 内容高度(由总行数)
 collectionH = rows * cellWH + (rows - 1) * margin
 总行数 = (count - 1) / cols + 1
 
 填补缺口,让collectionView更好看一些
 
 */
#import "TYMeVC.h"
#import "UIBarButtonItem+item.h"
#import "TYSettingController.h"
#import <AFNetworking/AFNetworking.h>
#import <MJExtension/MJExtension.h>
#import "TYSquareCell.h"
#import "TYSquareItem.h"
CGFloat const margin = 1;
NSInteger const cols = 4;
#define itemWH (TYScreenW - (cols - 1) * margin) / cols

static NSString * const ID = @"squrecell";
@interface TYMeVC ()<UICollectionViewDataSource>
/** 模型数组 */
@property (nonatomic, strong) NSMutableArray *squareItemArr;

/** collectionView */
@property (nonatomic, weak) UICollectionView *collectionView;

@end

@implementation TYMeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置导航栏内容
    [self setupNavigationBar];
    
    //设置底部试图
    [self setupFootView];
    
    //加载数据
    [self loadData];
    
    //设置tableView的头部视图和底部视图的高度
    self.tableView.sectionFooterHeight = 10;
    self.tableView.sectionHeaderHeight = 0;
    
    //设置tableView的内边距
    self.tableView.contentInset = UIEdgeInsetsMake(-25, 0, 0, 0);
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
    //控制器对象
    TYSettingController *settingVC = [[TYSettingController alloc]init];
    //隐藏底部TabBar(一定要在push之前隐藏)
//    settingVC.hidesBottomBarWhenPushed = YES;
    //跳转到设置控制器
    [self.navigationController pushViewController:settingVC animated:YES];
}

#pragma mark - nightModeItem点击事件
- (void)nightMode:(UIButton *)button
{
    button.selected = !button.selected;
    NSLog(@"点击了夜间模式");
}

#pragma mark - 设置底部视图
- (void)setupFootView
{
    //1.创建布局(流水布局)
    UICollectionViewFlowLayout *flowLayout = ({
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        
        flowLayout.itemSize = CGSizeMake(itemWH, itemWH);
        flowLayout.minimumInteritemSpacing = margin;
        flowLayout.minimumLineSpacing = margin;
        flowLayout;
    });
    
    //2.创建collectionView
    UICollectionView *collectionView = ({
        // tableView的头部视图和尾部视图,x,y,w都是由内部决定,只有h才有外界决定
        UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, 0, 300) collectionViewLayout:flowLayout];
        collectionView.backgroundColor = TYColor(215, 215, 215, 1);
        //3.设置数据源
        collectionView.dataSource = self;
        //4.注册cell(collectView必须要注册)
        [collectionView registerNib:[UINib nibWithNibName:@"TYSquareCell" bundle:nil] forCellWithReuseIdentifier:ID];
        collectionView;
    });
    self.collectionView = collectionView;
    //添加到尾部视图中
    self.tableView.tableFooterView = collectionView;
    
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.squareItemArr.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //使用这个方法必须要注册
    TYSquareCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
//    cell.backgroundColor = [UIColor orangeColor];
    
    cell.item = self.squareItemArr[indexPath.row];
    cell.TY_width = itemWH;
    cell.TY_height = itemWH;
    
    return cell;
}

#pragma mark - 加载数据
- (void)loadData
{
    //创建会话管理者
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    //拼接请求参数
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"square";
    parameters[@"c"] = @"topic";
    //发送请求
    [mgr GET:BaseURL parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //将响应体写到文件中
//        [responseObject writeToFile:@"/Users/timoryang/Documents/OC项目/BaiSi/baisiAPP/baisiAPP/Classes/Me(我)/square.plist" atomically:YES];
        //字典转模型
       self.squareItemArr =  [TYSquareItem mj_objectArrayWithKeyValuesArray:responseObject[@"square_list"]];
        
        //重新计算collectionView的高度
        NSInteger count = self.squareItemArr.count;
        NSInteger rows = (count - 1) / cols + 1;
        self.collectionView.TY_height = rows * itemWH + (rows - 1) * margin;
        //处理数据
        [self resolveData];
        //告诉tableView底部视图的大小变了
        self.tableView.tableFooterView = self.collectionView;
        //刷新collectionView
        [self.collectionView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
    }];
}

#pragma mark - 填补缺口
- (void)resolveData
{
    NSInteger count = self.squareItemArr.count;
    NSInteger num = count % cols;
    //判断最后一行有没有缺口,有进去填补空格
    if (num) {
        num = cols - num;
        for (int i = 0; i < num; i++) {
            //有几个缺口就创建几个空的item来补
            TYSquareItem *item = [[TYSquareItem alloc]init];
            [self.squareItemArr addObject:item];
        }
    }
}
@end
