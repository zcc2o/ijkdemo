//
//  VULLiveInnerView.h
//  VideoULimit
//
//  Created by 章程程 on 2018/12/5.
//  Copyright © 2018 svnlan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface VULLiveInnerView : UIView

@property (nonatomic, strong) UIView *localDisplayView;  //本地预览视图

- (void)refreshBypassUIWithConnectorId:(NSString *)uid;

//根据data 不断修改data更新封面
- (void)updateRemoteView:(NSData *)yuvData
                   width:(NSUInteger)width
                  height:(NSUInteger)height
                     uid:(NSString *)uid;

@end

NS_ASSUME_NONNULL_END
