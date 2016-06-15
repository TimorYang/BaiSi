//
//  TYTabBarController.m
//  baisiAPP
//
//  Created by TimorYang on 16/6/14.
//  Copyright © 2016年 TimorYang. All rights reserved.
//

#import "TYTabBarController.h"
#import "TYEssenceVC.h"
#import "TYNewVC.h"
#import "TYPublishVC.h"
#import "TYFriendTrendVC.h"
#import "TYMeVC.h"
#import "UIImage+Image.h"

// 分类思想
// 为什么要去抽取分类:  复用
// 分类作用:扩充系统类的方法 不能扩充属性

// 插件常识
// 插件 肯定会安装到电脑 => 找到插件 => 路径 => 找插件代码 => 插件安装路径 => 搜索plug => install_path

/*
 tabBar上按钮内容 细节
 1.按钮被选中,图片会被渲染 1.修改图片 2.通过代码
 2.按钮被选中,标题会被渲染 标题字体太小
 2.1 设置标题 字体颜色 => 标题内容由对应子控制器的tabBarItem决定 => 找到tabBarItem设置
 
 3.中间发布按钮显示不出来
 分析: 中间图片和其它图片不一样 => 中间图片太大,导致显示不出来 => 选中图片可以显示出来,但是正常状态下显示不出来 => 选中状态下图片没有渲染,正常状态下图片可能被渲染
 
 4.中间图片位置不对
 4.1 去设置中间按钮位置
 
 5.系统的tabBar上按钮只有选中状态,但是实例程序是高亮状态
 5.1 中间按钮不能使用tabBar上按钮,只能用UIButton
 5.2 把中间的按钮换成UIButton
 5.3 创建一个UIButton覆盖住当前的TabBar的发布按钮
 5.4 添加上去的Button不能够点击,但是TabBarController得View会显示为发布控制器的View我推测TabBar的按钮是在我添加Button后面添加的
     解决方法:让TabBar中的发布按钮不能处理点击事件
 5.5 TabBar中的按钮是什么时候添加的呢
 
 */

@interface TYTabBarController ()

@end

@implementation TYTabBarController

//当类第一次加载到内存中调用
+ (void)load
{
    /*
     appearance注意:
     1.任何类都可以使用appearance吗? 只有遵守了UIAppearance协议
     2.哪些属性都可以通过appearance去设置? 只要定义了UI_APPEARANCE_SELECTOR宏就能使用
     3.通过appearance去设置属性,必须要在控件显示之前去设置.
     */
    //获取全局的TabBarItem
    UITabBarItem *item = [UITabBarItem appearanceWhenContainedIn:self, nil];
    
    // 设置标题颜色
    // ***模型一般都是通过富文本属性去设置文字的颜色,字体等等.***
    // 通过富文本属性 去设置 文字颜色,字体
    
    //正常状态
    // ****设置tabBar上按钮文字字体,必须通过正常状态下,才可以设置成功****
    //创建一个可变字典来存放属性
    NSMutableDictionary *norAttrTitle = [NSMutableDictionary dictionary];
    //字体大小属性
    norAttrTitle[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    //加载属性
    [item setTitleTextAttributes:norAttrTitle forState:UIControlStateNormal];
    
    //选中状态
    //创建一个可变字典
    NSMutableDictionary *selAttrTitle = [NSMutableDictionary dictionary];
    //字体大小属性
    selAttrTitle[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    //字体颜色属性
    selAttrTitle[NSForegroundColorAttributeName] = [UIColor blackColor];
    //加载属性
    [item setTitleTextAttributes:selAttrTitle forState:UIControlStateSelected];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //添加子控制器
    [self setupAllChildViewController];
    //设置TabBarIterm按钮的图片和文字
    [self setupAllButtonIterm];
    //在TabBar上添加按钮
    [self addPublishBtn];
    //查看TabBar的子控件
//    NSLog(@"%@",self.tabBar.subviews);
}

#pragma mark - viewWillAppear
//系统TabBar上的按钮是在viewWillAppear时添加的
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //查看TabBar的子控件
//    NSLog(@"%@",self.tabBar.subviews);
}

#pragma mark - 添加子控制器
- (void)setupAllChildViewController
{
    //添加子控制器
    //>> 精华
    //>> 1.创建UIViewController
    TYEssenceVC *vc1 = [[TYEssenceVC alloc]init];
    //>> 2.设置控制器view的背景色
    vc1.view.backgroundColor = [UIColor greenColor];
    //>> 3.创建UINavigationController并设置vc为essenceNav的根控制器
    UINavigationController *essenceNav = [[UINavigationController alloc]initWithRootViewController:vc1];
    //>> 4.将essenceNav添加到TabBarController中
    [self addChildViewController:essenceNav];
    
    //>> 新帖
    //>> 1.创建UIViewController
    TYNewVC *vc2 = [[TYNewVC alloc]init];
    //>> 2.设置控制器view的背景色
    vc2.view.backgroundColor = [UIColor yellowColor];
    //>> 3.创建UINavigationController并设置vc为essenceNav的根控制器
    UINavigationController *newNav = [[UINavigationController alloc]initWithRootViewController:vc2];
    //>> 4.将essenceNav添加到TabBarController中
    [self addChildViewController:newNav];
    
    
    //>> 发布
    //>> 1.创建UIViewController
    TYPublishVC *vc3 = [[TYPublishVC alloc]init];
    //>> 2.设置控制器view的背景色
    vc3.view.backgroundColor = [UIColor purpleColor];
    //>> 4.将essenceNav添加到TabBarController中
    [self addChildViewController:vc3];
    
    //>> 关注
    //>> 1.创建UIViewController
    TYFriendTrendVC *vc4 = [[TYFriendTrendVC alloc]init];
    //>> 2.设置控制器view的背景色
    vc4.view.backgroundColor = [UIColor redColor];
    //>> 3.创建UINavigationController并设置vc为essenceNav的根控制器
    UINavigationController *friendTrendNav = [[UINavigationController alloc]initWithRootViewController:vc4];
    //>> 4.将essenceNav添加到TabBarController中
    [self addChildViewController:friendTrendNav];
    
    //>> 我
    //>> 1.创建UIViewController
    TYMeVC *vc5 = [[TYMeVC alloc]init];
    //>> 2.设置控制器view的背景色
    vc5.view.backgroundColor = [UIColor orangeColor];
    //>> 3.创建UINavigationController并设置vc为essenceNav的根控制器
    UINavigationController *meNav = [[UINavigationController alloc]initWithRootViewController:vc5];
    //>> 4.将essenceNav添加到TabBarController中
    [self addChildViewController:meNav];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 给TabBarIterm添加图片和文字
- (void)setupAllButtonIterm
{
    //获取TabBarController的子控制器
    //精华
    UIViewController *vc1 = self.childViewControllers[0];
    //设置图片
    //>> 默认状态
    vc1.tabBarItem.image = [UIImage imageWithOriginalName:@"tabBar_essence_icon"];
    //>> 选中状态
    vc1.tabBarItem.selectedImage = [UIImage imageWithOriginalName:@"tabBar_essence_click_icon"];
    //设置文字
    vc1.tabBarItem.title = @"精华";
    
    //新帖
    UIViewController *vc2 = self.childViewControllers[1];
    //设置图片
    //>> 默认状态
    vc2.tabBarItem.image = [UIImage imageWithOriginalName:@"tabBar_new_icon"];
    //>> 选中状态
    vc2.tabBarItem.selectedImage = [UIImage imageWithOriginalName:@"tabBar_new_click_icon"];
    //设置文字
    vc2.tabBarItem.title = @"新帖";
    
    //发布(通过UIButton覆盖到TabBarButton上)
    UIViewController *vc3 = self.childViewControllers[2];
    vc3.tabBarItem.enabled = NO;
//    //设置图片
//    //>> 默认状态
//    vc3.tabBarItem.image = [UIImage imageWithOriginalName:@"tabBar_publish_icon"];
//    //>> 选中状态
//    vc3.tabBarItem.selectedImage = [UIImage imageWithOriginalName:@"tabBar_publish_click_icon"];
//    //调整发布按钮的位置(设置内边距)
//    vc3.tabBarItem.imageInsets = UIEdgeInsetsMake(7, 0, -7, 0);
    
    //关注
    UIViewController *vc4 = self.childViewControllers[3];
    //设置图片
    //>> 默认状态
    vc4.tabBarItem.image = [UIImage imageWithOriginalName:@"tabBar_friendTrends_icon"];
    //>> 选中状态
    vc4.tabBarItem.selectedImage = [UIImage imageWithOriginalName:@"tabBar_friendTrends_click_icon"];
    //设置文字
    vc4.tabBarItem.title = @"关注";
    
    //我
    UIViewController *vc5 = self.childViewControllers[4];
    //设置图片
    //>> 默认状态
    vc5.tabBarItem.image = [UIImage imageWithOriginalName:@"tabBar_me_icon"];
    //>> 选中状态
    vc5.tabBarItem.selectedImage = [UIImage imageWithOriginalName:@"tabBar_me_click_icon"];
    //设置文字
    vc5.tabBarItem.title = @"我";

}

#pragma mark - 在TabBar上添加发布按钮
- (void)addPublishBtn
{
    //创建一个Button覆盖到TabBar上
    UIButton *publishButton = [UIButton buttonWithType:UIButtonTypeCustom];
    //设置button默认状态下的图片
    [publishButton setImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
    //设置button高亮状态下的图片
    [publishButton setImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted];
    //注意点******一定要先设置size,在设置位置******
    //设置button尺寸
    //尺寸会根据内容自适应
    [publishButton sizeToFit];
    //设置button的位置
    publishButton.center = CGPointMake(self.tabBar.bounds.size.width * 0.5, self.tabBar.bounds.size.height * 0.5);
    //添加到TabBar中
    [self.tabBar addSubview:publishButton];
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
