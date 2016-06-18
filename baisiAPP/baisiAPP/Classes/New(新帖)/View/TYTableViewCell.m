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
@implementation TYTableViewCell

- (void)awakeFromNib {
    // Initialization code
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - setItem
- (void)setItem:(TYSubTagItem *)item
{
    _item = item;
    //给控件赋值
    [self.icon sd_setImageWithURL:[NSURL URLWithString:item.image_list] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    self.name.text = item.theme_name;
    //判断超过一万人就显示多少万
    NSString *numText = [NSString stringWithFormat:@"%@人已订阅", item.sub_number];
    float temp = [numText floatValue];
    if(temp >= 10000)
    {
        numText = [NSString stringWithFormat:@"%.1f万人已订阅", temp * 1.0 / 10000];
    }
    self.number.text = numText;
}



@end
