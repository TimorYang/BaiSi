//
//  UIView+Frame.m
//  baisiAPP
//
//  Created by TimorYang on 16/6/15.
//  Copyright © 2016年 TimorYang. All rights reserved.
//

#import "UIView+Frame.h"

@implementation UIView (Frame)

- (void)setTY_x:(CGFloat)TY_x
{
    CGRect frame = self.frame;
    frame.origin.x = TY_x;
    self.frame = frame;
}
- (CGFloat)TY_x
{
    return self.frame.origin.x;
}
- (void)setTY_y:(CGFloat)TY_y
{
    CGRect frame = self.frame;
    frame.origin.y = TY_y;
    self.frame = frame;
}
- (CGFloat)TY_y
{
    return self.frame.origin.y;
}
- (void)setTY_width:(CGFloat)TY_width
{
    CGRect frame = self.frame;
    frame.size.width = TY_width;
    self.frame = frame;
}
- (CGFloat)TY_width
{
    return self.frame.size.width;
}
- (void)setTY_height:(CGFloat)TY_height
{
    CGRect frame = self.frame;
    frame.size.height = TY_height;
    self.frame = frame;
}
- (CGFloat)TY_height
{
    
    return self.frame.size.height;
}
- (void)setTY_centerX:(CGFloat)TY_centerX
{
    CGPoint center = self.center;
    center.x = TY_centerX;
    self.center = center;
}
- (CGFloat)TY_centerX
{
    return self.center.x;
}
- (void)setTY_centerY:(CGFloat)TY_centerY
{
    CGPoint center = self.center;
    center.y = TY_centerY;
    self.center = center;
}
- (CGFloat)TY_centerY
{
    return self.center.y;
}
@end
