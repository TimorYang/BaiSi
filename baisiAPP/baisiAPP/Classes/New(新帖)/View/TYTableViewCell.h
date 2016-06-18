//
//  TYTableViewCell.h
//  baisiAPP
//
//  Created by TimorYang on 16/6/19.
//  Copyright © 2016年 TimorYang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TYSubTagItem;
@interface TYTableViewCell : UITableViewCell

/** 标签模型 */
@property (nonatomic, strong) TYSubTagItem *item;

@end
