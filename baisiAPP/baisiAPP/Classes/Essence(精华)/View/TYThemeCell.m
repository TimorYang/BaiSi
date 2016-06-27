//
//  TYThemeCell.m
//  baisiAPP
//
//  Created by TimorYang on 16/6/25.
//  Copyright © 2016年 TimorYang. All rights reserved.
//

#import "TYThemeCell.h"
#import "TYThemeTopView.h"
#import "TYThemeViewModel.h"
#import "TYThemePictureView.h"
#import "TYThemeVoiceView.h"
#import "TYThemeItem.h"
#import "TYThemeVideoView.h"

@interface TYThemeCell ()

/** topView */
@property (nonatomic, weak) TYThemeTopView *topView;
/** pictureView */
@property (nonatomic, weak) TYThemePictureView *pictureView;
/** voiceView */
@property (nonatomic, weak) TYThemeVoiceView *voiceView;
/** videoView */
@property (nonatomic, weak) TYThemeVideoView *videoView;

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

        //添加middleView
        //添加pictureView
        TYThemePictureView *pictureView = [TYThemePictureView viewForXib];
        self.pictureView = pictureView;
        [self.contentView addSubview:pictureView];
        //添加videoView
        TYThemeVideoView *videoView = [TYThemeVideoView viewForXib];
        self.videoView = videoView;
        [self.contentView addSubview:videoView];
        //添加VoiceView
        TYThemeVoiceView *voiceView = [TYThemeVoiceView viewForXib];
        self.voiceView = voiceView;
        [self.contentView addSubview:voiceView];
        //添加hotCommentView
        
    }
    return self;
}

- (void)setVm:(TYThemeViewModel *)vm
{
    _vm = vm;
    //设置TopView
    self.topView.Item = vm.item;
    self.topView.frame = vm.topViewFrame;
    
    //判断middleView中添加的是那种类型的View
    if(vm.item.type == TYThemeTypePicture)
    {
        //隐藏其他view
        self.voiceView.hidden = YES;
        self.videoView.hidden = YES;
        //设置pictureView
        self.pictureView.hidden = NO;
        self.pictureView.item = vm.item;
        self.pictureView.frame = vm.middleFrame;
    }else if (vm.item.type == TYThemeTypeVoice)
    {
        //隐藏其他view
        self.pictureView.hidden = YES;
        self.videoView.hidden = YES;
        //设置voiceView
        self.voiceView.hidden = NO;
        self.voiceView.item = vm.item;
        self.voiceView.frame = vm.middleFrame;
    }else if (vm.item.type == TYThemeTypeVideo)
    {
        //隐藏其他View
        self.pictureView.hidden = YES;
        self.voiceView.hidden = YES;
        
        //设置videoView
        self.videoView.hidden = NO;
        self.videoView.item = vm.item;
        self.videoView.frame = vm.middleFrame;
    }else
    {
        self.pictureView.hidden = YES;
        self.voiceView.hidden = YES;
        self.videoView.hidden = YES;
    }
    
}

@end
