//
//  TYSquareCell.m
//  baisiAPP
//
//  Created by TimorYang on 16/6/20.
//  Copyright © 2016年 TimorYang. All rights reserved.
//

#import "TYSquareCell.h"
#import "TYSquareItem.h"
#import <UIImageView+WebCache.h>

@interface TYSquareCell ()
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *name;

@end
@implementation TYSquareCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setItem:(TYSquareItem *)item
{
    _item = item;
    [self.icon sd_setImageWithURL:[NSURL URLWithString:item.icon]];
    self.name.text = item.name;
}
@end
