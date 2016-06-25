//
//  TYBaseViewController.m
//  baisiAPP
//
//  Created by TimorYang on 16/6/23.
//  Copyright © 2016年 TimorYang. All rights reserved.
//

#import "TYBaseViewController.h"



static NSString * const ID = @"contentcell";

@interface TYBaseViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>

/** TopView */
@property (nonatomic, weak) UIScrollView *topView;
/** 用来记录上一个button的 */
@property (nonatomic, strong) UIButton *button;
@property (nonatomic, weak) UICollectionView *bottomView;
/** 存放button的数组 */
@property (nonatomic, strong) NSMutableArray *buttonArr;
/** 下划线 */
@property (nonatomic, weak) UIView *underLine;
/** 是否执行过 */
@property (nonatomic, assign) BOOL isInitial;

@end

@implementation TYBaseViewController

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
    
    //为什么bottomView要在TopView之前添加 => TopView先添加的话会被bottomView挡住的
    //添加bottomView
    [self setupBottomView];
    
    //添加TopView
    [self setupTopView];
    
    //是否需要自动添加内边距
    self.automaticallyAdjustsScrollViewInsets = NO;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if(self.isInitial == NO)
    {
        //添加标题
        [self addTitleButton];
        self.isInitial = YES;
    }
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


@end
