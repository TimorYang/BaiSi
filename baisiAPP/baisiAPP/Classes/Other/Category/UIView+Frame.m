//
//  UIView+Frame.m
//  baisiAPP
//
//  Created by TimorYang on 16/6/15.
//  Copyright © 2016年 TimorYang. All rights reserved.
//

#import "UIView+Frame.h"

@implementation UIView (Frame)
- (void)setTYx:(CGFloat)TYx
{
    CGRect frame = self.frame;
    frame.origin.x = TYx;
    self.frame = frame;
}
- (CGFloat)TYx
{
    return self.frame.origin.x;
}
- (void)setTYy:(CGFloat)TYy
{
    CGRect frame = self.frame;
    frame.origin.x = TYy;
    self.frame = frame;
}
- (CGFloat)TYy
{
    return self.frame.origin.y;
}
- (void)setTYwidth:(CGFloat)TYwidth
{
    CGRect frame = self.frame;
    frame.size.width = TYwidth;
    self.frame = frame;
}
- (CGFloat)TYwidth
{
    return self.frame.size.width;
}
- (void)setTYheight:(CGFloat)TYheight
{
    CGRect frame = self.frame;
    frame.size.height = TYheight;
    self.frame = frame;
}
- (CGFloat)TYheight
{
    
    return self.frame.size.height;
}
@end
