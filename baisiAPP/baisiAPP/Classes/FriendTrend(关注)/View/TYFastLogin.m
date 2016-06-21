//
//  TYFastLogin.m
//  baisiAPP
//
//  Created by TimorYang on 16/6/19.
//  Copyright © 2016年 TimorYang. All rights reserved.
//

#import "TYFastLogin.h"

@implementation TYFastLogin
+ (instancetype)fastLogin
{
    return [[NSBundle mainBundle]loadNibNamed:@"TYFastLogin" owner:nil options:nil].firstObject;
}
@end
