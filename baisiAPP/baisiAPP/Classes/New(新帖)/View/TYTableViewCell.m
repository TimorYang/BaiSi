//
//  TYTableViewCell.m
//  baisiAPP
//
//  Created by TimorYang on 16/6/19.
//  Copyright © 2016年 TimorYang. All rights reserved.
//

#import "TYTableViewCell.h"
#import "TYSubTagItem.h"
#import <UIImageView+WebCache.h>

@interface TYTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *number;


@end
// 头像变成圆形
// 1.修改图层圆角半径 2.裁剪

// blog有可能会过期
// iOS9之前,通过layer设置圆角半径,导致帧数降低

@implementation TYTableViewCell

- (void)awakeFromNib {
    // Initialization code
    //第一种方法
    //设置圆角半径
//    self.icon.layer.cornerRadius = self.icon.TY_width * 0.5;
    //超出主层的裁剪
//    self.icon.layer.masksToBounds = YES;
    //第二种方法
    //运行时
    //第三种方法,画图
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - 重写cell的frame方法
- (void)setFrame:(CGRect)frame
{
    frame.size.height -= 5;
    frame.size.width -= 20;
    frame.origin.x += 10;
    frame.origin.y += 10;
    // 一定要调用,这才是真正去设置frame
    [super setFrame:frame];
    
}

#pragma mark - setItem
- (void)setItem:(TYSubTagItem *)item
{
    _item = item;
    //画图
    [self.icon sd_setImageWithURL:[NSURL URLWithString:item.image_list] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        //开启图形上下文
        UIGraphicsBeginImageContextWithOptions(self.icon.frame.size, NO, 0);
        //描述圆形裁剪区域
        UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, self.icon.TY_width, self.icon.TY_height)];
        //设置裁剪区域
        [path addClip];
        //画图片
        [image drawAtPoint:CGPointZero];
        //获取图片
        image = UIGraphicsGetImageFromCurrentImageContext();
        //关闭上下文
        UIGraphicsEndImageContext();
        //设置头像
        self.icon.image = image;
    }];
    //给控件赋值
//    [self.icon sd_setImageWithURL:[NSURL URLWithString:item.image_list] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    self.name.text = item.theme_name;
    //判断超过一万人就显示多少万
    NSString *numText = [NSString stringWithFormat:@"%@人已订阅", item.sub_number];
    float temp = [numText floatValue];
    if(temp >= 10000)
    {
        numText = [NSString stringWithFormat:@"%.1f万人已订阅", temp * 1.0 / 10000];
        //如果是2.0万不太好,需要移除.0
        [numText stringByReplacingOccurrencesOfString:@".0" withString:@""];
    }
    self.number.text = numText;
}



@end
