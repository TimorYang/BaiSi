//
//  UIBarButtonItem+item.h
//  baisiAPP
//
//  Created by TimorYang on 16/6/15.
//  Copyright © 2016年 TimorYang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (item)

/** 快速创建UIBarButtonItem方法 */
+ (instancetype)buttonItemImage:(UIImage *)image highLightImage:(UIImage *)highLightImage target:(id)target action:(SEL)action;

/** 快速创建UIBarButtonItem方法 */
+ (instancetype)buttonItemImage:(UIImage *)image selectImage:(UIImage *)selectImage target:(id)target action:(SEL)action;
@end
