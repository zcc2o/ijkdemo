//
//  VULLiveBypassView.m
//  VideoULimit
//
//  Created by 章程程 on 2018/12/5.
//  Copyright © 2018 svnlan. All rights reserved.
//

#import "VULLiveBypassView.h"
#import "NTESGLView.h"
#import <NIMAVChat/NIMAVChat.h>
@interface VULLiveBypassView ()<NIMNetCallManagerDelegate>{
    UIView *_localPreView;
}

@property (nonatomic, strong) NTESGLView *glView;

@property (nonatomic, strong) UIView *videoDisplayView;

@property (nonatomic, strong) UIView *localVideoView;

@end

@implementation VULLiveBypassView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
//        [[NIMAVChatSDK sharedSDK].netCallManager addDelegate:self];
        [self setup];
    }
    return self;
}

#pragma mark - NIMNetCallManagerDelegate
//- (void)onLocalDisplayviewReady:(UIView *)displayView{
//    if (_localPreView) {
//        [_localPreView removeFromSuperview];
//    }
//    _localPreView = displayView;
//    displayView.frame = _localPreView.bounds;
//    [self.localVideoView addSubview:displayView];
//}

- (void)setLocalVideoDisplayView:(UIView *)localVideoDisplayView{
    _localVideoDisplayView = localVideoDisplayView;
    _localVideoDisplayView.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:_localVideoDisplayView];
}


- (void)setup{
    
    _localVideoView = [[UIView alloc] initWithFrame:CGRectZero];
    _localVideoView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"icon_glview_background"]];
    _localVideoView.contentMode = UIViewContentModeScaleAspectFill;
    _localVideoView.hidden = YES;
    
    [self addSubview:self.glView];
    
}

- (void)updateRemoteView:(NSData *)yuvData
                   width:(NSUInteger)width
                  height:(NSUInteger)height{
    self.backgroundColor = UIColorFromRGBA(0x0,.2);
    [self.glView render:yuvData width:width height:height];
}

- (void)layoutSubviews{
    self.glView.frame= self.bounds;
    self.localVideoView.frame = self.bounds;
    self.localVideoDisplayView.frame = self.bounds;
}

- (NTESGLView *)glView{
    if(!_glView){
        _glView = [[NTESGLView alloc] initWithFrame:CGRectZero];
        _glView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"icon_glview_background"]];
        _glView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _glView;
}

@end
