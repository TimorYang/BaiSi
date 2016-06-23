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

#import "TYEssenceVC.h"
#import "UIBarButtonItem+item.h"
#import "TYAllViewController.h"
#import "TYVideoViewController.h"
#import "TYVoiceViewController.h"
#import "TYPictureViewController.h"
#import "TYTextViewController.h"

static NSString * const ID = @"contentcell";

@interface TYEssenceVC ()<UICollectionViewDataSource, UICollectionViewDelegate>

/** TopView */
@property (nonatomic, weak) UIScrollView *topView;
/** 用来记录上一个button的 */
@property (nonatomic, strong) UIButton *button;
@property (nonatomic, weak) UICollectionView *bottomView;
/** 存放button的数组 */
@property (nonatomic, strong) NSMutableArray *buttonArr;
/** 下划线 */
@property (nonatomic, weak) UIView *underLine;

@end

@implementation TYEssenceVC
#pragma mark - 懒加载
- (NSMutableArray *)buttonArr
{
    if(_buttonArr == nil)
    {
        _buttonArr = [NSMutableArray array];
    }
    return _buttonArr;
}

#pragma mark - viewDidLoad
// 导航条内容由栈顶控制器的navigationItem
// 谁显示到最外边,谁就能设置导航条内容
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置导航栏内容
    [self setupNavigationBar];
    
    //为什么bottomView要在TopView之前添加 => TopView先添加的话会被bottomView挡住的
    //添加bottomView
    [self setupBottomView];
    
    
    //添加子控制器
    [self addAllChildViewController];
    //添加TopView
    [self setupTopView];
    
    
    //是否需要自动添加内边距
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    
    
    
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

#pragma mark - 搭建TopView
- (void)setupTopView
{
    //位置和尺寸
    CGFloat topView_x = 0;
    CGFloat topView_y = 64;
    CGFloat topView_w = TYScreenW;
    CGFloat topView_H = 35;
    //创建ScrollView
    UIScrollView *topView = [[UIScrollView alloc]initWithFrame:CGRectMake(topView_x, topView_y, topView_w, topView_H)];
    topView.backgroundColor = [UIColor colorWithWhite:1 alpha:0.6];
    //添加到精华的View上面
    self.topView = topView;
    [self.view addSubview:topView];
    //添加标题
    [self addTitleButton];
}

#pragma mark - 添加标题Button
- (void)addTitleButton
{
    NSInteger count = self.childViewControllers.count;
    //尺寸和位置
    CGFloat titleBtn_w = TYScreenW * 1.0 / count;
    CGFloat titleBtn_h = self.topView.TY_height;
    CGFloat titleBtn_x = 0;
    CGFloat titleBtn_y = 0;
    //for循环
    for (int i = 0; i < count; i++) {
        //创建button
        UIButton *titlebtn = [UIButton buttonWithType:UIButtonTypeCustom];
        titlebtn.tag = i;
        //根据下标取出对应的控制器
        UIViewController *vc = self.childViewControllers[i];
        //取出子控制器的标题赋值给button的titleLabel的text
        [titlebtn setTitle:vc.title forState:UIControlStateNormal];
        //设置正常状态
        [titlebtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        //设置选中状态
        [titlebtn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        //设置文字大小
        titlebtn.titleLabel.font = [UIFont systemFontOfSize:15];
        titleBtn_x = i * titleBtn_w;
        //设置button尺寸
        titlebtn.frame = CGRectMake(titleBtn_x, titleBtn_y, titleBtn_w, titleBtn_h);
        //添加到buttonArr数组中
        [self.buttonArr addObject:titlebtn];
//        NSLog(@"arr---%ld", self.buttonArr.count);
        //添加到TopView上
        [self.topView addSubview:titlebtn];
        //监听按钮点击
        [titlebtn addTarget:self action:@selector(titleButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        //默认选中第0个
        if (i == 0) {
            [self titleButtonClick:titlebtn];
            //创建下划线
            UIView *underLine = [[UIView alloc]init];
            //设置背景色
            underLine.backgroundColor = [UIColor redColor];
            //尺寸和位置
            //先让titleLabel计算出自己的尺寸
            [titlebtn.titleLabel sizeToFit];
            //设置高度
            underLine.TY_height = 2;
            //设置宽度
            underLine.TY_width = titlebtn.titleLabel.TY_width;
            //设置y
            underLine.TY_y = self.topView.TY_height - underLine.TY_height;
            //设置centerX
            underLine.TY_centerX = titlebtn.TY_centerX;
            
            _underLine = underLine;
            
            [self.topView addSubview:underLine];
        }
    }
}

#pragma mark - 监听button
- (void)titleButtonClick:(UIButton *)button
{
    //选中按钮
    [self selectButton:button];
    //设置collectionView的偏移量
    CGFloat offset_x = button.tag * TYScreenW;
    self.bottomView.contentOffset = CGPointMake(offset_x, 0);
}

#pragma mark - 选中按钮
- (void)selectButton:(UIButton *)button
{
    //取消之前按钮的选中状态
    self.button.selected = NO;
    //让按钮成为选中的按钮
    button.selected = YES;
    //把现在的按钮存到临时的button属性中
    self.button = button;
    //偏移underLine的x
    [UIView animateWithDuration:0.2 animations:^{
        self.underLine.TY_centerX = button.TY_centerX;
    }];
}

#pragma mark - UICollectionViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //根据偏移量计算出页码
    NSInteger pages = scrollView.contentOffset.x / TYScreenW;
    //获取对应的button
    UIButton *button = self.buttonArr[pages];
    //选中按钮
    [self selectButton:button];
}

#pragma mark - 搭建BottomView
- (void)setupBottomView
{
    //创建布局方式
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    //设置布局大小
    flowLayout.itemSize = CGSizeMake(TYScreenW, TYScreenH);
    //设置滚动方向
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    //设置间距
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.minimumLineSpacing = 0;
    //创建collectionView
    UICollectionView *bottomView = [[UICollectionView alloc]initWithFrame:[UIScreen mainScreen].bounds collectionViewLayout:flowLayout];
    bottomView.backgroundColor = TYGlobalColor;
    //设置分页
    bottomView.pagingEnabled = YES;
    //隐藏指示器
    bottomView.showsHorizontalScrollIndicator = NO;
    //设置数据源
    bottomView.dataSource = self;
    //设置代理
    bottomView.delegate = self;
    //注册collectionView
    [bottomView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:ID];
    self.bottomView = bottomView;
    //添加到精华View上
    [self.view addSubview:bottomView];
    
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.childViewControllers.count;
}

//有新的cell就会来到这个方法
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    //移除cell的contentView中上一个控制器
    [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    //当新的cell显示到屏幕上时,就要把子控制器的View添加到cell上
    UIViewController *vc = self.childViewControllers[indexPath.row];
    //默认控制器的frame有y值,每次添加的时候必须重新设置frame y = 20;
    vc.view.frame = [UIScreen mainScreen].bounds;
    [cell.contentView addSubview:vc.view];
    //随机颜色
    cell.backgroundColor = [UIColor colorWithRed:((float)arc4random_uniform(256) / 255.0) green:((float)arc4random_uniform(256) / 255.0) blue:((float)arc4random_uniform(256) / 255.0) alpha:1.0];
    return cell;
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
