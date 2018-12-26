//
//  VULNIMLivingViewController.m
//  VideoULimit
//
//  Created by 章程程 on 2018/11/30.
//  Copyright © 2018 svnlan. All rights reserved.
//

#import "VULNIMLivingViewController.h"
//#import <NIMSDK/NIMSDK.h>
//#import "VULMediaCapture.h"
////#import "VULAlertController.h"
//#import "VULUserUtil.h"
//#import "VULMicConnector.h"
////#import "NIMNetCallManager
//#import "VULLiveInnerView.h"
//#import "VULRealmDBManager.h"
#import "ZFPlayer.h"
#import "ZFPlayerControlView.h"
#import "VULVideoStudyRecordTimer.h"
#import "ZFPlayerControlView.h"

@interface VULNIMLivingViewController ()//NIMNetCallManagerDelegate

@property (nonatomic, strong) UIView *containerView;

@property (nonatomic, strong) ZFPlayerController *player;

//@property (nonatomic, strong) NIMChatroom *chatroom;
//
//@property (nonatomic, strong) VULMediaCapture *capture;
//
//@property (nonatomic, strong) UIView *captureView;
//
//@property (nonatomic, strong) VULLiveInnerView *innerView;

@property (nonatomic, strong) UIView *playerViewContiner;/**< 播放容器view */
@property (nonatomic, strong) VULVideoStudyRecordTimer *studyRecordTimer;

@property (nonatomic, assign) NSTimeInterval DIFSecond;
@property (nonatomic, assign) BOOL firstErrNote; //提醒教师离开

@end

@implementation VULNIMLivingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.DIFSecond = 0;
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.containerView];
    self.containerView.frame = CGRectMake(0, 150, self.view.width, self.view.height - 150);
    
//    [[NIMAVChatSDK sharedSDK].netCallManager addDelegate:self];
    
    [self addViews];
    
    //加入互动
//    [self joinMeeting];
    [self playerLive];
}

- (void)playerLive {
    [self remakePlayer];
    [self playerState];
}

- (void)remakePlayer {
    
    if (self.player.currentPlayerManager && self.player.currentPlayerManager.playState == ZFPlayerPlayStatePlayStopped) {
        [self.player stop];
    }
    
    // TODO: 开始记录学习时间
    if (!self.studyRecordTimer.timer) {
        [self.studyRecordTimer startTimerWithVideoType:VULStudyVideoTypeLiving];
    }
    
    ZFIJKPlayerManager *ijkManager = [[ZFIJKPlayerManager alloc] init];
    self.player = [ZFPlayerController playerWithPlayerManager:ijkManager containerView:self.playerViewContiner];
    self.player.pauseWhenAppResignActive = YES;
    
    self.player.controlView = [[ZFPlayerControlView alloc] init];
    //    self.rightContentView.player.assetURL = [NSURL URLWithString:self.coursewareDetail.camPlay];
    NSString *url = @"http://ivi.bupt.edu.cn/hls/cctv1hd.m3u8";
        self.player.assetURL = [NSURL URLWithString:url];
}

#pragma mark - 播放状态统一在这里处理
- (void)playerState {
    WeakSelf(self);
    self.player.playerLoadStateChanged = ^(id<ZFPlayerMediaPlayback>  _Nonnull asset, ZFPlayerLoadState loadState) {
        NSLog(@"111加载状态发生变化-%zd",loadState);
        
        if (loadState == ZFPlayerLoadStateStalled) {
            
        }
    };
    
    self.player.playerPlayStateChanged = ^(id<ZFPlayerMediaPlayback>  _Nonnull asset, ZFPlayerPlaybackState playState) {
        NSLog(@"111播放状态发生变化-%zd",playState);
#pragma mark - 这里!!!!!!!!!!!!!!!!!!!!!!!!
        if (playState == ZFPlayerPlayStatePlayFailed || playState == ZFPlayerPlayStatePlayStopped) {
                [weakself liveStatus];
        }
//        if (playState == ZFPlayerPlayStatePlaying) {
//            weakself.firstErrNote = NO;
//            [weakself courseSignin]; //上传考勤统计
//        }
    };
    
    self.player.playerDidToEnd = ^(id<ZFPlayerMediaPlayback>  _Nonnull asset) {
        //        [weakself.player stop];
        NSLog(@"111播放结束-");
    };
    
    self.player.playerPlayFailed = ^(id<ZFPlayerMediaPlayback>  _Nonnull asset, id  _Nonnull error) {
//        if (weakself.isLiving) {
//            [weakself liveStatus];
//        }
        NSLog(@"111播放错误-%@",error);
    };
}

// 拉流间隔  播放失败后及时处理
- (void)liveStatus {
    NSDate *localDate = [NSDate date];
    NSTimeInterval localSecond = [localDate timeIntervalSince1970] * 1000 + self.DIFSecond;
    
    //当前时间 处于直播开始结束时间段内
    if (localSecond > 1544601433 && localSecond < 1544612135) {
        if (!_firstErrNote) {
//            [self vul_showAlertWithTitle:@"老师暂时离开" message:@"请稍作等待" appearanceProcess:^(VULAlertController * _Nonnull alertMaker) {
//                alertMaker.
//                addActionCancelTitle(@"知道了");
//            } actionsBlock:^(NSInteger buttonIndex, UIAlertAction * _Nonnull action, VULAlertController * _Nonnull alertSelf) {
//            }];
            _firstErrNote = YES;
        }
        [self remakePlayer];
        [self playerState];
    }
    //课程结束 并 停止拉流
    if (localSecond > 1544612135) {
        if ([self.player.currentPlayerManager playState] == ZFPlayerPlayStatePlayStopped) {
            
//            [self configNavigation];
//            self.playStateLabel.text = @"直播已结束";
//            self.playStateLabel.hidden = NO;
            [self.player.currentPlayerManager stop];
//            [self makeOverToast];
        }
    }
}


- (void)joinMeeting {
    /*
    [self.view addSubview:self.captureView];
    __weak typeof(self) wself = self;
    
    [self.capture startPreview:NIMNetCallMediaTypeVideo container:self.captureView handler:^(NSError * _Nonnull error) {
        if(error){
            [self vul_showAlertWithTitle:@"" message:@"直播失败请检查" appearanceProcess:^(VULAlertController * _Nonnull alertMaker) {
                alertMaker.addActionCancelTitle(@"知道了");
            } actionsBlock:^(NSInteger buttonIndex, UIAlertAction * _Nonnull action, VULAlertController * _Nonnull alertSelf) {
                [wself dismissViewControllerAnimated:YES completion:nil];
            }];
        }
    }];
     */
    
//    NIMNetCallMeeting *meeting = [[NIMNetCallMeeting alloc] init];
//    meeting.name  = @"30112";
//    meeting.actor = YES;
//    meeting.type  = NIMNetCallMediaTypeVideo;
//    NIMNetCallOption *option = [VULUserUtil fillNetCallOption:meeting];
//
//    NIMNetCallVideoCaptureParam *param = [VULUserUtil videoCaptureParam];
//    param.videoCaptureOrientation = NIMVideoOrientationPortrait;
//    param.videoHandler = self.capture.videoHandler;
//    param.preferredVideoQuality = NIMNetCallVideoQualityDefault;
//    option.videoCaptureParam = param;
//
//    [[NIMAVChatSDK sharedSDK].netCallManager joinMeeting:meeting completion:^(NIMNetCallMeeting * _Nonnull meeting, NSError * _Nullable error) {
//        if (!error) {
//            //进入互动
//            VULMicConnector *connector = [VULMicConnector me:@"87"];
//            connector.type = NIMNetCallMediaTypeVideo;
//            connector.nick = @"zcc";
//        }else{
//            NSLog(@"%@", error);
//        }
//    }];
}
- (void)addViews {
//    [self.view addSubview:self.innerView];
    [self.view addSubview:self.playerViewContiner];
    
    self.playerViewContiner.frame = CGRectMake(0, 64, VULSCREEN_WIDTH, 280);
    
    
    /*
    [self.view addSubview:self.containerView];
    
    self.containerView.frame = CGRectMake(0, 64, VULSCREEN_WIDTH, 250);
    ZFIJKPlayerManager *ijkManager = [[ZFIJKPlayerManager alloc] init];
    self.player = [ZFPlayerController playerWithPlayerManager:ijkManager containerView:self.containerView];
    __weak typeof(self)weakSelf = self;
    self.player.controlView = [[ZFPlayerControlView alloc] init];
    self.player.playerDidToEnd = ^(id<ZFPlayerMediaPlayback>  _Nonnull asset) {
//        __strong typeof(weakSelf)sself = weakSelf;
        [weakSelf.player seekToTime:0.f completionHandler:^(BOOL finished) {
            [weakSelf.player playerPrepareToPlay];
        }];
    };
    self.player.assetURL = [NSURL URLWithString:@"http://ivi.bupt.edu.cn/hls/cctv1hd.m3u8"];
    
    self.player.playerLoadStateChanged = ^(id<ZFPlayerMediaPlayback>  _Nonnull asset, ZFPlayerLoadState loadState) {
        NSLog(@"==========%ld",loadState);
    };
    
    self.player.playerPlayStateChanged = ^(id<ZFPlayerMediaPlayback>  _Nonnull asset, ZFPlayerPlaybackState playState) {
     NSLog(@"-----------%ld",playState);
    };
     */
}

/*
- (void)onLocalDisplayviewReady:(UIView *)displayView{
    _innerView.localDisplayView = displayView;
    
    [self.innerView refreshBypassUIWithConnectorId:[NSString stringWithFormat:@"%ld", 1590]];
}
*/
/**
 *  网络通话委托

#pragma mark - NIMNetCallManagerDelegate
- (void)joinMettingWithUid:(NSString *)roomId{
    NSLog(@"%@", roomId);
}

- (void)onUserJoined:(NSString *)uid
             meeting:(NIMNetCallMeeting *)meeting
{
    NSLog(@"on user joined uid %@",uid);
    
    [self.innerView refreshBypassUIWithConnectorId:uid];
    
}
 

- (void)onUserLeft:(NSString *)uid
           meeting:(NIMNetCallMeeting *)meeting
{
    NSLog(@"on user left %@",uid);
}

- (void)onMeetingError:(NSError *)error
               meeting:(NIMNetCallMeeting *)meeting
{
    NSLog(@"on meeting error: %zd",error.code);
}

- (void)onRemoteYUVReady:(NSData *)yuvData
                   width:(NSUInteger)width
                  height:(NSUInteger)height
                    from:(NSString *)user
{
    NSLog(@"%@", user);
    
    [self.innerView updateRemoteView:yuvData width:width height:height uid:user];
}

- (void)onCameraTypeSwitchCompleted:(NIMNetCallCamera)cameraType
{}
 */

- (UIView *)containerView{
    if(!_containerView){
        _containerView = [[UIView alloc] init];
    }
    return _containerView;
}

- (UIView *)playerViewContiner {
    if(!_playerViewContiner) {
        _playerViewContiner = [[UIView alloc] init];
        _playerViewContiner.backgroundColor = [UIColor blackColor];
    }
    return _playerViewContiner;
}


//- (UIView *)captureView{
//    if(!_captureView){
//        _captureView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.height / 2, self.view.width, self.view.height / 2)];
//        _captureView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
//        _captureView.backgroundColor = VULRandomColor;
//    }
//    return _captureView;
//}

//- (VULLiveInnerView *)innerView{
//    if(!_innerView){
//        _innerView = [[VULLiveInnerView alloc] initWithFrame:self.view.bounds];
////        _innerView.backgroundColor = VULRandomColor;
//    }
//    return _innerView;
//}

@end
