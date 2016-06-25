//
//  TYThemeTopView.h
//  baisiAPP
//
//  Created by TimorYang on 16/6/25.
//  Copyright © 2016年 TimorYang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TYThemeItem;
@interface TYThemeTopView : UIView

/** TYThemeItem */
@property (nonatomic, strong) TYThemeItem *Item;

+ (instancetype)viewForXib;
@end
