//
//  UIImage+Image.m
//  BuDeJie
//
//  Created by yz on 15/11/13.
//  Copyright © 2015年 yz. All rights reserved.
//

#import "UIImage+Image.h"

@implementation UIImage (Image)
+ (instancetype)imageWithOriginalName:(NSString *)imageName
{
    UIImage *selImage = [UIImage imageNamed:imageName];
    
    selImage = [selImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    return selImage;
}
@end
