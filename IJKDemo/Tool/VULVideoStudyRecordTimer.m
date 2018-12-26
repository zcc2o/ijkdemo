//
//  VULVideoStudyRecordTimer.m
//  VideoULimit
//
//  Created by 章程程 on 2018/11/20.
//  Copyright © 2018 svnlan. All rights reserved.
//

#import "VULVideoStudyRecordTimer.h"

@interface VULVideoStudyRecordTimer ()

@property (nonatomic, assign) NSInteger timeCount;

@property (nonatomic, assign) NSInteger studyTimeCount;

@property (nonatomic, assign) NSInteger lastRandomSecond;

@property (nonatomic, assign) NSInteger pauseOrFaildWaitSecond;

@end

@implementation VULVideoStudyRecordTimer

- (instancetype)init {
    if (self = [super init]) {
        _timeCount = 0;
        _studyTimeCount = 0;
        _pauseOrFaildWaitSecond = 0;
    }
    return self;
}

- (void)startTimerWithVideoType:(VideoType)type {
    if (!_timer) {
        _timer = [YYTimer timerWithTimeInterval:1 target:self selector:@selector(vul_timerSelector) repeats:YES];
    }
    self.videoType = type;
}

- (void)vul_timerSelector {
    _timeCount ++;
    switch (self.playState) {
        case ZFPlayerPlayStateUnknown:
        {
            
        }
            break;
        case ZFPlayerPlayStatePlaying:
        {
            _studyTimeCount ++;
            
            //第一次提交
            if (_studyTimeCount == 1) {
                [self submitStudyTimeWithFirstUpload:YES];
                //计算下次提交时间
                NSInteger value = 130 + (arc4random() % 91);
                self.lastRandomSecond = value + self.studyTimeCount;
            }
            
            //间隔一定时间提交
            if (self.studyTimeCount == self.lastRandomSecond) {
                [self submitStudyTimeWithFirstUpload:NO];
                //计算下次提交时间
                NSInteger value = 130 + (arc4random() % 91);
                self.lastRandomSecond = value + self.studyTimeCount;
            }
        }
            break;
        case ZFPlayerPlayStatePaused:
        case ZFPlayerPlayStatePlayFailed:
        {
            if (self.studyTimeCount > self.pauseOrFaildWaitSecond) {
                [self submitStudyTimeWithFirstUpload:NO];
            }
            //即使播放器多次输出这个状态 我也至少间隔十秒上传一次学习时间 避免大量上传造成后台奔溃
            self.pauseOrFaildWaitSecond = self.studyTimeCount + 10;
            
        }
            break;
        case ZFPlayerPlayStatePlayStopped:
        {
            if (self.timer) {
                [self submitStudyTimeWithFirstUpload:NO];
            }
            [self fireTimer];
        }
            break;
        default:
            break;
    }
}

- (void)fireTimer {
    if (self.timer) {
        [self.timer invalidate];//销毁
        self.timer = nil;
    }
}

/**< 提交学习时间 */
- (void)submitStudyTimeWithFirstUpload:(BOOL)isFirstUpLoad {
    if (isFirstUpLoad) {
        self.studyTimeCount = 1;
    }
    
    if (self.upLoadUserStudyProgressWidthStudyTime) {
        self.upLoadUserStudyProgressWidthStudyTime(self.studyTimeCount);
    }
}

@end
