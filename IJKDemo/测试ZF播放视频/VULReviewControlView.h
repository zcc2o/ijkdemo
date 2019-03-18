//
//  VULReviewControlView.h
//  VideoULimit
//
//  Created by 章程程 on 2018/12/10.
//  Copyright © 2018 svnlan. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ZFSpeedLoadingView.h"
#import "ZFSmallFloatControlView.h"
#import "ZFVolumeBrightnessView.h"
#import "ZFPlayerController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^reviewTCViewplayedToEnd)(void);

@interface VULReviewControlView : UIView<ZFPlayerMediaControl>

@property (nonatomic, assign) NSInteger currentTime;/**< 视频当前位置 */
@property (nonatomic, assign) NSInteger totalTime;/**< 视频总时长 */

@property (nonatomic, copy)reviewTCViewplayedToEnd playEnd;

- (void)videoPlayer:(ZFPlayerController *)videoPlayer currentTime:(NSTimeInterval)currentTime totalTime:(NSTimeInterval)totalTime;

@end

NS_ASSUME_NONNULL_END
