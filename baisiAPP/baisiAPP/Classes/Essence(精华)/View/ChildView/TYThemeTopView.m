//
//  TYThemeTopView.m
//  baisiAPP
//
//  Created by TimorYang on 16/6/25.
//  Copyright © 2016年 TimorYang. All rights reserved.
//

#import "TYThemeTopView.h"
#import "TYThemeItem.h"
#import <UIImageView+WebCache.h>

@interface TYThemeTopView ()
@property (weak, nonatomic) IBOutlet UIImageView *userIcon;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *passTime;
@property (weak, nonatomic) IBOutlet UILabel *contentText;

@end

@implementation TYThemeTopView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (instancetype)viewForXib
{
    return [[NSBundle mainBundle]loadNibNamed:@"TYThemeTopView" owner:nil options:nil].firstObject;
}

- (void)setItem:(TYThemeItem *)Item
{
    _Item = Item;
    //给控件赋值
    [self.userIcon sd_setImageWithURL:[NSURL URLWithString:Item.profile_image]];
    self.userName.text = Item.name;
    self.passTime.text = Item.passtime;
    self.contentText.text = Item.text;
}

@end
