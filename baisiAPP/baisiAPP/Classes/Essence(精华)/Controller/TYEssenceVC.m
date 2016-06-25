//
//  TYEssenceVC.m
//  baisiAPP
//
//  Created by TimorYang on 16/6/14.
//  Copyright © 2016年 TimorYang. All rights reserved.
//

/*
 1.设置左边的UIBarButtonItem,直接使用UIButton,出现bug,点击按钮周围也会调用点击事件
   > 原因:一般情况下,设置一个按钮宽度,那么点击范围就是按钮范围,但是把按钮包装成UIBarButtonItem,点击范围扩大
   > 解决方法:把按钮放到UIView中,再把UIView包装成UIBarButtonItem
 */

/*
 搭建精华界面
 1.结构分层
    > TopView (UIScrollView:为什么要用UIScrollView,保证扩展性类似于网易新闻和今日头条)
    > bottomView (UICollectionView:为什么要用UICollectionView,提高性能,1.cell可以循环利用, 2.离开屏幕的view不像UIScrollView一样还是会被渲染)
 2.搭建TopView
    > 创建一个scrollView, 设置frame
        > 根据子控制器的个数,添加button
        > 计算button的frame
        > 设置button的title
        > 设置button正常和选中的颜色
        > 设置button的text的大小
 3.搭建bottomView
    > 创建布局方式(流水布局)
    > 创建collectionView
    > 设置数据源
    > 设置代理
    > 注册cell
 4.添加子控制器
 5.处理collectionView的细节
    > 在有导航栏的情况下,添加scrollview,会被导航栏顶下去
    > collectionView默认是垂直方向的滑动
    > 设置cell之间的间距
    > 设置滚动方向
    > 开启分页功能
    > 隐藏指示器
    > 设置背景颜色
 bug:the behavior of the UICollectionViewFlowLayout is not defined because:
 2016-06-22 20:57:14.257 baisiAPP[16275:208951] the item height must be less than the height of the UICollectionView minus the section insets top and bottom values, minus the content insets top and bottom values.
 解决方法:cell的高度超出了collectionView的高度
 
 6.根据子控制器的个数添加cell
    > 根据indexPath.row 可以和子控制器做到一一对应
    > cell是复用的所以每次使用之前都得把cell的contentView的子控件全部移除
    > 根据indexPath.row的值取出对应的子控制器,并把子控制器的view添加到cell的contentView中
 7.点击标题
    > 让标题变为选中状态
    > 取消之前标题的选中状态(搞一个属性记录上一个button)
    > 跳转到对应的子控制器的view(设置偏移量)
 8.滑动collectionView,让与之对应的标题被选中
    > 设置collectionView的代理
    > 实现scrollViewDidEndDecelerating方法(当scrollView减速完成时调用,拿到的偏移量最准确)
    > 拿到偏移量的X值去除以cell的宽度,可以知道当前是第几页,正好与button的tag对应
    > 调用selectButton这个方法
 9.处理tableView的细节
    > 默认控制器的frame有y值,每次添加的时候必须重新设置frame y = 20;
    > 想要tableView的内容从TopView下面开始展示内容,设置tableView的内边距,顶部的内边距为64 + TopView的高度
    > tableView底部的数据被TabBar挡住了,设置底部的内边距为49
 10.在TopView中添加下划线
 
 */
/**************** 抽取基类 ****************/
//问题: 添加子控制器必须在调用父类viewDidLoad之前


#import "TYEssenceVC.h"
#import "UIBarButtonItem+item.h"
#import "TYAllViewController.h"
#import "TYVideoViewController.h"
#import "TYVoiceViewController.h"
#import "TYPictureViewController.h"
#import "TYTextViewController.h"

@interface TYEssenceVC ()

@end

@implementation TYEssenceVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //添加子控制器
    [self addAllChildViewController];
    
    //设置导航栏内容
    [self setupNavigationBar];
    
    
}

#pragma mark - 设置导航栏内容
- (void)setupNavigationBar
{
    //添加左边的item
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem buttonItemImage:[UIImage imageNamed:@"nav_item_game_icon"] highLightImage:[UIImage imageNamed:@"nav_item_game_click_icon"] target:self action:@selector(game)];
    
    //添加Title
    self.navigationItem.titleView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
    //添加右边的item
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem buttonItemImage:[UIImage imageNamed:@"navigationButtonRandom"] highLightImage:[UIImage imageNamed:@"navigationButtonRandomClick"] target:self action:@selector(random)];
}
#pragma mark - 游戏按钮点击事件
- (void)game
{
    NSLog(@"点击了game");
}

#pragma mark - 随机按钮点击事件
- (void)random
{
    NSLog(@"点击了随机");
}

#pragma mark - 添加子控制器
- (void)addAllChildViewController
{
    //添加全部
    TYAllViewController *allVC = [[TYAllViewController alloc]init];
    allVC.title = @"全部";
    [self addChildViewController:allVC];
    //添加视频
    TYVideoViewController *videoVC = [[TYVideoViewController alloc]init];
    videoVC.title = @"视频";
    [self addChildViewController:videoVC];
    //添加声音
    TYVoiceViewController *voiceVC = [[TYVoiceViewController alloc]init];
    voiceVC.title = @"声音";
    [self addChildViewController:voiceVC];
    //添加图片
    TYPictureViewController *pictureVC = [[TYPictureViewController alloc]init];
    pictureVC.title = @"图片";
    [self addChildViewController:pictureVC];
    //添加段子
    TYTextViewController *textVC = [[TYTextViewController alloc]init];
    textVC.title = @"段子";
    [self addChildViewController:textVC];
}

@end
