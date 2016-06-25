//
//  TYThemeCell.m
//  baisiAPP
//
//  Created by TimorYang on 16/6/25.
//  Copyright © 2016年 TimorYang. All rights reserved.
//

#import "TYThemeCell.h"
#import "TYThemeTopView.h"
#import "TYThemeItem.h"

@interface TYThemeCell ()

@property (nonatomic, weak) TYThemeTopView *topView;

@end
@implementation TYThemeCell

//cell注册时底层会调用这个方法
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        //添加TopView
        //1.创建TopView
        TYThemeTopView *topView = [TYThemeTopView viewForXib];
        self.topView = topView;
        [self.contentView addSubview:topView];
        
        //2.设置TopView的位置和尺寸
        
        
        
        
        //添加middleView
        //添加hotCommentView
    }
    return self;
}

- (void)setItem:(TYThemeItem *)item
{
    _item = item;
    //设置TopView
    self.topView.Item = item;
}

@end
