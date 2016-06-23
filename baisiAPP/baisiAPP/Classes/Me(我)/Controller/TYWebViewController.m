//
//  TYWebViewController.m
//  baisiAPP
//
//  Created by TimorYang on 16/6/21.
//  Copyright © 2016年 TimorYang. All rights reserved.
//

#import "TYWebViewController.h"
#import <WebKit/WebKit.h>

@interface TYWebViewController ()

/** contentView */
@property (weak, nonatomic) IBOutlet UIView *contentView;
/** back */
@property (weak, nonatomic) IBOutlet UIBarButtonItem *back;
/** forward */
@property (weak, nonatomic) IBOutlet UIBarButtonItem *forward;
/** refresh */
@property (weak, nonatomic) IBOutlet UIBarButtonItem *refresh;
/** webView */
@property (nonatomic, weak) WKWebView *webView;
@property (weak, nonatomic) IBOutlet UIProgressView *progress;


@end

@implementation TYWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //创建WKWebView
    WKWebView *webView = [[WKWebView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.webView = webView;
    //添加到contentView
    [self.contentView addSubview:webView];
    //加载网页
    NSURLRequest *request = [NSURLRequest requestWithURL:self.url];
    [webView loadRequest:request];
    // 监听什么时候能前进,后退
    // KVO
    // 前进 后退 刷新
    /*
     Observer;观察者
     KeyPath:观察哪个属性
     options:观察新值 NSKeyValueObservingOptionNew
     */
    //监听是否能返回
    [webView addObserver:self forKeyPath:@"canGoBack" options:NSKeyValueObservingOptionNew context:nil];
    //监听是否能前景
    [webView addObserver:self forKeyPath:@"canGoForward" options:NSKeyValueObservingOptionNew context:nil];
    //监听进度
    [webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    //监听标题
    [webView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)back:(id)sender {
    [self.webView goBack];
}
- (IBAction)foward:(id)sender {
    [self.webView goForward];
}
- (IBAction)refresh:(id)sender {
    [self.webView reload];
}

//只要观察的属性有新值就会调用
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    self.back.enabled = self.webView.canGoBack;
    self.forward.enabled = self.webView.canGoForward;
    self.progress.progress = self.webView.estimatedProgress;
    self.progress.hidden = self.webView.estimatedProgress >= 1;
    self.title = self.webView.title;
}

//在控制器销毁前移除监听者
- (void)dealloc
{
    [self.webView removeObserver:self forKeyPath:@"canGoBack" context:nil];
    [self.webView removeObserver:self forKeyPath:@"canGoForward" context:nil];
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress" context:nil];
    [self.webView removeObserver:self forKeyPath:@"title" context:nil];
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
