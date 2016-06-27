//
//  TYThemePictureView.m
//  baisiAPP
//
//  Created by TimorYang on 16/6/25.
//  Copyright © 2016年 TimorYang. All rights reserved.
//

#import "TYThemePictureView.h"
#import <UIImageView+WebCache.h>
#import "TYThemeItem.h"
#import <SVProgressHUD/SVProgressHUD.h>
#import <DALabeledCircularProgressView.h>

@interface TYThemePictureView ()
@property (weak, nonatomic) IBOutlet UIImageView *contentImageView;
@property (weak, nonatomic) IBOutlet UIImageView *isGif;
@property (weak, nonatomic) IBOutlet UIView *isBig;
@property (weak, nonatomic) IBOutlet DALabeledCircularProgressView *progressView;


@end
@implementation TYThemePictureView

- (void)awakeFromNib
{
    //添加进度条动画
    self.progressView.roundedCorners = 10;
    //设置进度条颜色
    self.progressView.tintColor = [UIColor whiteColor];
    //
    self.progressView.trackTintColor = [UIColor clearColor];
    //设置数字进度的颜色
    self.progressView.progressLabel.textColor = [UIColor whiteColor];
}
-(void)setItem:(TYThemeItem *)item
{
    _item = item;
    
    [self.contentImageView sd_setImageWithURL:[NSURL URLWithString:item.image0] placeholderImage:nil options:SDWebImageLowPriority progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        //设置进度
        CGFloat progress = 1.0 * receivedSize / expectedSize;
        self.progressView.progress = progress;
        NSLog(@"%lf", self.progressView.progress);
        self.progressView.progressLabel.text = [NSString stringWithFormat:@"%.2lf%%", self.progressView.progress * 100];
    }  completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (!item.isBig) return;
        //把图片画上去
        //1.开启图形上下文
        UIGraphicsBeginImageContextWithOptions(self.contentImageView.bounds.size, NO, 0);
        //2.把图片画上去
        CGFloat margin = 10;
        CGFloat w = TYScreenW - 2 * margin;
        CGFloat h = TYScreenW / item.width * item.height;
        [image drawInRect:CGRectMake(0, 0, w, h)];
        //3.获取画好的图片
        image = UIGraphicsGetImageFromCurrentImageContext();
        //4.关闭图形上下文
        UIGraphicsEndImageContext();
        self.contentImageView.image = image;
    }];
    self.isBig.hidden = !item.isBig;
    self.isGif.hidden = !item.is_gif;
    if(item.isBig)
    {
        //处理图片
        //1.修改图片的拉伸方式
        self.contentImageView.layer.masksToBounds = YES;
        self.contentImageView.contentMode = UIViewContentModeTop;
        
    }else
    {
        self.contentImageView.layer.masksToBounds = NO;
        self.contentImageView.contentMode = UIViewContentModeScaleToFill;
    }
    
}

@end
