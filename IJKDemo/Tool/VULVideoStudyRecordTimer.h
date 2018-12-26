//
//  VULVideoStudyRecordTimer.h
//  VideoULimit
//
//  Created by 章程程 on 2018/11/20.
//  Copyright © 2018 svnlan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YYTimer.h"

#import "ZFPlayerMediaPlayback.h"
/*
 typedef enum _ASIWebContentType {
 ASINotParsedWebContentType = 0,
 ASIHTMLWebContentType = 1,
 ASICSSWebContentType = 2
 } ASIWebContentType;

 */
typedef enum StudyVideoType {
    VULStudyVideoTypeUnKnow = 0,/**< 未知 */
    VULStudyVideoTypeLiving = 1,/**< 直播 */
    VULStudyVideoTypeReview = 2,/**< 回看 */
    VULStudyVideoTypeVideo = 3,/**< 普通视频点播 */
    
}VideoType;

//typedef NS_ENUM(NSUInteger, ZFPlayerPlaybackState) {
//    ZFPlayerPlayStateUnknown = 0,
//    ZFPlayerPlayStatePlaying,
//    ZFPlayerPlayStatePaused,
//    ZFPlayerPlayStatePlayFailed,
//    ZFPlayerPlayStatePlayStopped
//};

NS_ASSUME_NONNULL_BEGIN

@interface VULVideoStudyRecordTimer : NSObject

@property (nonatomic, strong, nullable) YYTimer *timer;
@property (nonatomic, assign) VideoType videoType;
@property (nonatomic, assign) ZFPlayerPlaybackState playState;

@property (nonatomic, copy) void(^upLoadUserStudyProgressWidthStudyTime)(NSInteger studyTime);

- (void)startTimerWithVideoType:(VideoType)type;

- (void)fireTimer;//销毁

@end

NS_ASSUME_NONNULL_END
