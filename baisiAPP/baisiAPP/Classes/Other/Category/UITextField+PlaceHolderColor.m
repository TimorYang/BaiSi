//
//  UITextField+PlaceHolderColor.m
//  baisiAPP
//
//  Created by TimorYang on 16/6/19.
//  Copyright © 2016年 TimorYang. All rights reserved.
//

#import "UITextField+PlaceHolderColor.h"

@implementation UITextField (PlaceHolderColor)

//- (void)awakeFromNib
//{
//    self.placeholder = @" ";
//}

- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    //设置占位字符的颜色
//    NSMutableDictionary *attr = [NSMutableDictionary dictionary];
//    attr[NSForegroundColorAttributeName] = placeholderColor;
//    self.attributedPlaceholder = [[NSAttributedString alloc]initWithString:self.placeholder attributes:attr];
    
    if (self.placeholder.length == 0) {
        self.placeholder = @" ";
    }
    //设置占位符的颜色
    //获取占位label
    UILabel *placeholderLabel = [self valueForKey:@"placeholderLabel"];
    placeholderLabel.textColor = placeholderColor;
}
- (UIColor *)placeholderColor
{
    return nil;
}
@end
