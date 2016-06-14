//
//  main.m
//  baisiAPP
//
//  Created by TimorYang on 16/6/14.
//  Copyright © 2016年 TimorYang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

int main(int argc, char * argv[]) {
    @autoreleasepool {
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
    /** UIApplicationMain底层实现 */
    /*
     1.创建UIApplication对象(1.打开网页,2.设置联网状态,3.设置状态栏,4.设置提醒数字)
     2.创建UIApplication代理对象(1.监听应用程序的生命周期,2.内存警告)
     3.开启主运行循环(1.保证程序一直运行,2.监听事件,3.Runloop<主线程,程序启动自动开启Runloop,子线程需要手动开启>)
     4.判断info.plist文件中有没有Main.storyboard文件,有就加载
        > 加载Main.storyboard底层实现
        1.创建窗口
        2.设置窗口
        3.显示窗口
     */
}
