//
//  TYThemeBaseView.m
//  baisiAPP
//
//  Created by TimorYang on 16/6/27.
//  Copyright © 2016年 TimorYang. All rights reserved.
//

#import "TYThemeBaseView.h"

@implementation TYThemeBaseView

+ (instancetype)viewForXib
{
    return [[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil].firstObject;
}

@end
