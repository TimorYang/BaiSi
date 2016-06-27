//
//  TYThemeVideoView.m
//  baisiAPP
//
//  Created by TimorYang on 16/6/27.
//  Copyright © 2016年 TimorYang. All rights reserved.
//

#import "TYThemeVideoView.h"
#import "TYThemeItem.h"
#import <UIImageView+WebCache.h>

@interface TYThemeVideoView ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *playtime;
@property (weak, nonatomic) IBOutlet UILabel *playcount;


@end

@implementation TYThemeVideoView

- (void)setItem:(TYThemeItem *)item
{
    _item = item;
    //设置图片
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:item.image0]];
    //设置播放次数
    self.playcount.text = [NSString stringWithFormat:@"%ld次播放", item.playcount];
    //设置播放时间
    self.playtime.text = [NSString stringWithFormat:@"%02ld:%02ld", item.videotime / 60, item.videotime % 60];
}
@end
