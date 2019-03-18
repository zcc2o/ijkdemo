//
//  VULReviewControlView.m
//  VideoULimit
//
//  Created by 章程程 on 2018/12/10.
//  Copyright © 2018 svnlan. All rights reserved.
//

#import "VULReviewControlView.h"
#import "Masonry.h"
#import "NSString+EXTENSION.h"
@interface VULReviewControlView ()
@property (nonatomic, strong) UIButton *failureBtn;
@property (nonatomic, strong) ZFSpeedLoadingView *activity;
@end

@implementation VULReviewControlView
@synthesize player = _player;

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.failureBtn];
//        [self.failureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.top.right.bottom.mas_equalTo(self);
//        }];
        [self addSubview:self.activity];
    }
    return self;
}

- (void)videoPlayer:(ZFPlayerController *)videoPlayer playStateChanged:(ZFPlayerPlaybackState)state {
    [self layoutIfNeeded];
    //播放失败
    if (state == ZFPlayerPlayStatePlayFailed) {
        self.failureBtn.hidden = NO;
    }
}

- (void)videoPlayer:(ZFPlayerController *)videoPlayer loadStateChanged:(ZFPlayerLoadState)state {
    switch (state) {
        case ZFPlayerLoadStateStalled:
        case ZFPlayerLoadStatePrepare:
        {
            [self.activity startAnimating];
        }
            break;
        default:
        {
            [self.activity stopAnimating];
        }
            break;
    }
}

- (void)failureBtnClicked:(UIButton *)sender {
    self.failureBtn.hidden = YES;
    [self.player.currentPlayerManager reloadPlayer];
}

- (void)videoPlayer:(ZFPlayerController *)videoPlayer currentTime:(NSTimeInterval)currentTime totalTime:(NSTimeInterval)totalTime {
    self.totalTime = totalTime;
    self.currentTime = currentTime;
    
    if ((totalTime - currentTime) < 10) {
        self.playEnd();
    }
}

- (void)layoutSubviews {
    CGFloat min_X = 0;
    CGFloat min_Y = 0;
    CGFloat min_Width = 0;
    CGFloat min_Height = 0;
    
    CGSize strSize = [self.failureBtn.titleLabel.text sizewithFont:self.failureBtn.titleLabel.font andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    min_Width = strSize.width;
    min_Height = strSize.height;
    
    min_X = (self.width - min_Width) / 2;
    min_Y = (self.height - min_Height) / 2;
    
    self.failureBtn.frame = CGRectMake(min_X, min_Y, min_Width, min_Height);
    
    min_Width =  80;
    min_Height = 80;
    self.activity.frame = CGRectMake(min_X, min_Y, min_Width, min_Height);
    self.activity.centerX = self.centerX;
    self.activity.centerY = self.centerY + 10;
}

- (UIButton *)failureBtn {
    if (!_failureBtn) {
        _failureBtn = [[UIButton alloc] init];
        _failureBtn.hidden = YES;
        [_failureBtn setTitle:@"加载失败,点击重试" forState:UIControlStateNormal];
        [_failureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_failureBtn addTarget:self action:@selector(failureBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        _failureBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    }
    return _failureBtn;
}

- (ZFSpeedLoadingView *)activity {
    if (!_activity) {
        _activity = [[ZFSpeedLoadingView alloc] init];
    }
    return _activity;
}

@end
