//
//  UIBarButtonItem+item.m
//  baisiAPP
//
//  Created by TimorYang on 16/6/15.
//  Copyright © 2016年 TimorYang. All rights reserved.
//

#import "UIBarButtonItem+item.h"

@implementation UIBarButtonItem (item)

+ (instancetype)buttonItemImage:(UIImage *)image highLightImage:(UIImage *)highLightImage target:(id)target action:(SEL)action
{
    //1.创建Button
    UIButton *buttonItem = [UIButton buttonWithType:UIButtonTypeCustom];
    //2.设置Button默认图片
    [buttonItem setImage:image forState:UIControlStateNormal];
    //3.设置Button高亮图片
    [buttonItem setImage:highLightImage forState:UIControlStateHighlighted];
    //4.设置Button尺寸
    [buttonItem sizeToFit];
    //5.监听按钮的点击
    [buttonItem addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    //6.创建一个UIView
    UIView *view = [[UIView alloc]initWithFrame:buttonItem.bounds];
    //7.把Button添加到View中
    [view addSubview:buttonItem];
    //8.设置UIBarButtonItem
    return [[UIBarButtonItem alloc]initWithCustomView:view];
}

+ (instancetype)buttonItemImage:(UIImage *)image selectImage:(UIImage *)selectImage target:(id)target action:(SEL)action
{
    //1.创建Button
    UIButton *buttonItem = [UIButton buttonWithType:UIButtonTypeCustom];
    //2.设置Button默认图片
    [buttonItem setImage:image forState:UIControlStateNormal];
    //3.设置Button高亮图片
    [buttonItem setImage:selectImage forState:UIControlStateSelected];
    //4.设置Button尺寸
    [buttonItem sizeToFit];
    //5.监听按钮的点击
    [buttonItem addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    //6.创建一个UIView
    UIView *view = [[UIView alloc]initWithFrame:buttonItem.bounds];
    //7.把Button添加到View中
    [view addSubview:buttonItem];
    //8.设置UIBarButtonItem
    return [[UIBarButtonItem alloc]initWithCustomView:view];
}
@end
