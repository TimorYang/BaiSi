//
//  TYADItem.h
//  baisiAPP
//
//  Created by TimorYang on 16/6/18.
//  Copyright © 2016年 TimorYang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TYADItem : NSObject
/** 广告URL */
@property (nonatomic, strong) NSString *w_picurl;
/** 点击广告跳转的URL */
@property (nonatomic, strong) NSString *ori_curl;
/** 图片宽度 */
@property (nonatomic, assign) CGFloat w;
/** 图片高度 */
@property (nonatomic, assign) CGFloat h;
@end
