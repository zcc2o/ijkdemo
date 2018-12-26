//
//  VULLiveBypassView.h
//  VideoULimit
//
//  Created by 章程程 on 2018/12/5.
//  Copyright © 2018 svnlan. All rights reserved.
//

#import <UIKit/UIKit.h>

#pragma mark - UIColor宏定义
#define UIColorFromRGBA(rgbValue, alphaValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0x00FF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0x0000FF))/255.0 \
alpha:alphaValue]

NS_ASSUME_NONNULL_BEGIN

@interface VULLiveBypassView : UIView

@property (nonatomic, copy) NSString *uid;

@property (nonatomic, strong) UIView *localVideoDisplayView;

- (void)updateRemoteView:(NSData *)yuvData
                   width:(NSUInteger)width
                  height:(NSUInteger)height;


@end

NS_ASSUME_NONNULL_END
