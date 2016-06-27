//
//  TYThemeViewModel.h
//  baisiAPP
//
//  Created by TimorYang on 16/6/25.
//  Copyright © 2016年 TimorYang. All rights reserved.
//

#import <Foundation/Foundation.h>
@class TYThemeItem;
@interface TYThemeViewModel : NSObject

/** TYThemeItem */
@property (nonatomic, strong) TYThemeItem *item;

/** topViewFrame */
@property (nonatomic, assign) CGRect topViewFrame;

/** cell_h */
@property (nonatomic, assign) CGFloat cell_h;

/** middleFrame */
@property (nonatomic, assign) CGRect middleFrame;





@end
