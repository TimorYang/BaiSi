//
//  TYSubTagItem.h
//  baisiAPP
//
//  Created by TimorYang on 16/6/19.
//  Copyright © 2016年 TimorYang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TYSubTagItem : NSObject
/** 头像 */
@property (nonatomic, strong) NSString *image_list;
/** 标签名称 */
@property (nonatomic, strong) NSString *theme_name;
/** 关注量 */
@property (nonatomic, strong) NSString *sub_number;

@end
