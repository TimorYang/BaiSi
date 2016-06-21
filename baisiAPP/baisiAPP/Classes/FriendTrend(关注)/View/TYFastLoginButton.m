//
//  TYFastLoginButton.m
//  baisiAPP
//
//  Created by TimorYang on 16/6/19.
//  Copyright © 2016年 TimorYang. All rights reserved.
//

#import "TYFastLoginButton.h"

@implementation TYFastLoginButton

- (void)layoutSubviews
{
    [super layoutSubviews];
    //设置图片的位置
    self.imageView.TY_y = 0;
    self.imageView.TY_centerX = self.TY_width * 0.5;
    //设置文字的位置
    [self.titleLabel sizeToFit];
    self.titleLabel.TY_y = self.TY_height - self.titleLabel.TY_height - 5;
    self.titleLabel.TY_centerX = self.TY_width * 0.5;
}@end
