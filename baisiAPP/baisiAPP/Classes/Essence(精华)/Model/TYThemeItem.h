//
//  TYThemeItem.h
//  baisiAPP
//
//  Created by TimorYang on 16/6/25.
//  Copyright © 2016年 TimorYang. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger
{
    TYThemeTypeAll = 1,
    TYThemeTypePicture = 10,
    TYThemeTypeVideo = 41,
    TYThemeTypeVoice = 31,
    TYThemeTypeText = 29
} TYThemeType;

@interface TYThemeItem : NSObject

/********** topView **********/
/** name */
@property (nonatomic, strong) NSString *name;
/** text */
@property (nonatomic, strong) NSString *text;
/** passtime */
@property (nonatomic, strong) NSString *passtime;
/** profile_image */
@property (nonatomic, strong) NSString *profile_image;
/********** topView **********/

/********** middleView **********/
/** TYThemeType */
@property (nonatomic, assign) TYThemeType type;

//pitcureView
/** image0 */
@property (nonatomic, strong) NSString *image0;
/** image1 */
@property (nonatomic, strong) NSString *image1;
/** image2 */
@property (nonatomic, strong) NSString *image2;
/** is_gif */
@property (nonatomic, assign) BOOL is_gif;
/** width */
@property (nonatomic, assign) NSInteger width;
/** height */
@property (nonatomic, assign) NSInteger height;
/** isBig */
@property (nonatomic, assign) BOOL isBig;

//videoView
/** playcount */
@property (nonatomic, assign) NSInteger playcount;
/** videotime */
@property (nonatomic, assign) NSInteger videotime;

//voiceView
/** voicetime */
@property (nonatomic, assign) NSInteger voicetime;

//voiceView



/********** middleView **********/

/********** hotCommentView **********/
/********** hotCommentView **********/

/********** bottomView **********/
/********** bottomView **********/

@end
