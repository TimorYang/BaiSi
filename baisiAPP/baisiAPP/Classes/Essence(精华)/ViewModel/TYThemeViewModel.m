//
//  TYThemeViewModel.m
//  baisiAPP
//
//  Created by TimorYang on 16/6/25.
//  Copyright © 2016年 TimorYang. All rights reserved.
//

#import "TYThemeViewModel.h"
#import "TYThemeItem.h"
@implementation TYThemeViewModel

- (void)setItem:(TYThemeItem *)item
{
    _item = item;
    //计算xib的大小
    CGFloat top_x = 0;
    CGFloat top_y = 0;
    CGFloat top_w = TYScreenW;
    CGFloat originY = 55; // contentText的Y值
    CGFloat margin = 10;
    
    //限制contentText的宽度
    CGFloat text_w = TYScreenW - 2 * margin;
    //计算contentText的高度
    CGFloat text_h = [item.text sizeWithFont:[UIFont systemFontOfSize:17] constrainedToSize:CGSizeMake(text_w, MAXFLOAT)].height;
    CGFloat top_h = originY + text_h;
    
    //设置xib的frame
    _topViewFrame = CGRectMake(top_x, top_y, top_w, top_h);
    _cell_h = CGRectGetMaxY(_topViewFrame) + margin;
    
    if(item.type != TYThemeTypeText) //不是段子就要计算图片高度
    {
        //判断是否是gif
        
        CGFloat image_x = margin;
        CGFloat image_y = _cell_h;
        CGFloat image_w = text_w;
        //计算pictureView的尺寸
        CGFloat image_height = TYScreenW / item.width * item.height;
        if(image_height > TYScreenH)
        {
            image_height = 300;
            self.item.isBig = YES;
        }
        _middleFrame = CGRectMake(image_x, image_y, image_w, image_height);
        //计算cell的高度
        _cell_h = _cell_h + image_height;
    }
}
@end
