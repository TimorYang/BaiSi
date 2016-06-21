//
//  TYTextField.m
//  baisiAPP
//
//  Created by TimorYang on 16/6/20.
//  Copyright © 2016年 TimorYang. All rights reserved.
//

#import "TYTextField.h"
#import "UITextField+PlaceHolderColor.h"

@implementation TYTextField

//只需要加载一次
- (void)awakeFromNib
{
    //设置光标的颜色
    self.tintColor = [UIColor whiteColor];
    //设置文本颜色为白色
    self.textColor = [UIColor whiteColor];
    //设置占位字符的颜色
//    NSMutableDictionary *attr = [NSMutableDictionary dictionary];
//    attr[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
//    self.attributedPlaceholder = [[NSAttributedString alloc]initWithString:self.placeholder attributes:attr];
    self.placeholderColor = [UIColor lightGrayColor];
    //1.代理 2.通知 3.addtarget
    
    //开始编辑
    [self addTarget:self action:@selector(textChange) forControlEvents:UIControlEventEditingDidBegin];
    //结束编辑
    [self addTarget:self action:@selector(textEnd) forControlEvents:UIControlEventEditingDidEnd];
}

#pragma mark - textChange
- (void)textChange
{
    //设置占位字符的颜色
    self.placeholderColor = [UIColor whiteColor];
}

#pragma mark - textEnd
- (void)textEnd
{
    //设置占位字符的颜色
    self.placeholderColor = [UIColor lightGrayColor];
}
@end
