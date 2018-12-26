//
//  VULLiveInnerView.m
//  VideoULimit
//
//  Created by 章程程 on 2018/12/5.
//  Copyright © 2018 svnlan. All rights reserved.
//

#import "VULLiveInnerView.h"
#import "VULLiveBypassView.h"
//#import "VULRealmDBManager.h"

@interface VULLiveInnerView ()

@property (nonatomic, strong)NSMutableArray<VULLiveBypassView *> *bypassViews;

@end

@implementation VULLiveInnerView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


//添加互動窗口
- (void)refreshBypassUIWithConnectorId:(NSString *)uid{
    
    __weak typeof(self)weakSelf = self;
    
//    [_bypassViews enumerateObjectsUsingBlock:^(VULLiveBypassView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        [weakSelf addByPassViewWithConnector:obj.uid];
//    }];
    
    [self addByPassViewWithConnector:uid];
    [self layoutIfNeeded];
}

- (VULLiveBypassView *)addByPassViewWithConnector:(NSString *)uid{
    
    __block BOOL isAdd = YES;
    __block VULLiveBypassView *ret = nil;
    [_bypassViews enumerateObjectsUsingBlock:^(VULLiveBypassView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if([obj.uid isEqualToString:uid]){
            isAdd = NO;
            ret = obj;
            *stop = YES;
        }
    }];
    
//    VULSaveUserInformation *info = [VULRealmDBManager getLocalUserInformational];
    
    if(isAdd){
        VULLiveBypassView *byPassView = [[VULLiveBypassView alloc] initWithFrame:CGRectZero];
        byPassView.uid = uid;
        byPassView.backgroundColor = VULRandomColor;
        if ([byPassView.uid isEqualToString:@"1590"]) {//是本人
            byPassView.localVideoDisplayView = _localDisplayView;
        }
        if(!_bypassViews){
            _bypassViews = [NSMutableArray array];
        }
        [_bypassViews addObject:byPassView];
        [self addSubview:byPassView];
        ret = byPassView;
        
        NSLog(@"---添加旁路l推流view---%@----", byPassView.uid);
    }
    return ret;
}

- (void)updateRemoteView:(NSData *)yuvData
                   width:(NSUInteger)width
                  height:(NSUInteger)height
                     uid:(NSString *)uid{
    
    VULLiveBypassView *bypassView = [self bypassViewWithUid:uid];
    
    [bypassView updateRemoteView:yuvData width:width height:height];
}

- (VULLiveBypassView *)bypassViewWithUid:(NSString *)uid{
    __block VULLiveBypassView *ret = nil;
    [_bypassViews enumerateObjectsUsingBlock:^(VULLiveBypassView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if([obj.uid isEqualToString:uid]){
            ret = obj;
            *stop = YES;
        }
    }];
    return ret;
}

- (void)layoutSubviews{
    
    if (_bypassViews.count > 0) {
        
        CGFloat width = (self.width - 8.0 * 4) / 4;
        CGFloat height = width * 1.7;
        
        CGFloat padding = 8;
        
        CGFloat bottom = K_TabBar_Height;
        
        __weak typeof(self)weakSelf = self;
        
        [_bypassViews enumerateObjectsUsingBlock:^(VULLiveBypassView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            obj.frame = CGRectMake(weakSelf.width - width - padding,
                                   weakSelf.height - bottom - (height + 8) * (idx + 1),
                                   width,
                                   height);
            [obj layoutIfNeeded];
        }];
    }
    
}

@end
