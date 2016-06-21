//
//  TYLoginRegisterView.m
//  baisiAPP
//
//  Created by TimorYang on 16/6/19.
//  Copyright © 2016年 TimorYang. All rights reserved.
//

#import "TYLoginRegisterView.h"

@interface TYLoginRegisterView ()
@property (weak, nonatomic) IBOutlet UIButton *loginbutton;

@end
@implementation TYLoginRegisterView

//initWithCoder调用时还没有连线
//- (instancetype)initWithCoder:(NSCoder *)coder
//{
//    self = [super initWithCoder:coder];
//    if (self) {
//    }
//    return self;
//}
//awakeFromNib已经连线了
- (void)awakeFromNib
{
    //获取正常背景图片
    UIImage *bgImage = ({
        UIImage *bgImage = [self.loginbutton backgroundImageForState:UIControlStateNormal];
        bgImage = [bgImage stretchableImageWithLeftCapWidth:bgImage.size.width * 0.5 topCapHeight:bgImage.size.height * 0.5];
        bgImage;
                          });
    //获取高亮状态下的背景图片
    UIImage *bgHighLightImage = ({
        UIImage *bgHighLightImage = [self.loginbutton backgroundImageForState:UIControlStateHighlighted];
        bgHighLightImage = [bgHighLightImage stretchableImageWithLeftCapWidth:bgImage.size.width * 0.5 topCapHeight:bgImage.size.height * 0.5];
        bgHighLightImage;
    });


    //设置图片的拉伸区域
    [self.loginbutton setBackgroundImage:bgImage forState:UIControlStateNormal];
    [self.loginbutton setBackgroundImage:bgHighLightImage forState:UIControlStateHighlighted];
}

#pragma mark - 快速创建loginView
+ (instancetype)loginView
{
    return [[NSBundle mainBundle]loadNibNamed:@"TYLoginRegisterView" owner:nil options:nil].firstObject;
}

+ (instancetype)registerView
{
    return [[NSBundle mainBundle]loadNibNamed:@"TYLoginRegisterView" owner:nil options:nil].lastObject;
}

@end
