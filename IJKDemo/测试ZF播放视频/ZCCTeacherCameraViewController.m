//
//  ZCCTeacherCameraViewController.m
//  IJKDemo
//
//  Created by 章程程 on 2019/1/4.
//  Copyright © 2019 zcc. All rights reserved.
//

#import "ZCCTeacherCameraViewController.h"
#import "ZFPlayer.h"
#import "VULReviewControlView.h"
#import "Masonry.h"
#import "ZFAVPlayerManager.h"
#import "ZFplayercontrolView.h"

@interface ZCCTeacherCameraViewController ()

@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) VULReviewControlView *controlView;
@property (nonatomic, strong) ZFPlayerController *player;

@end

@implementation ZCCTeacherCameraViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self addViews];
    [self configPlayer];
}

- (void)configPlayer {
    ZFAVPlayerManager *reviewManager = [[ZFAVPlayerManager alloc] init];
    self.player = [ZFPlayerController playerWithPlayerManager:reviewManager containerView:self.containerView];
    self.player.controlView = [[ZFPlayerControlView alloc] init];
    self.player.shouldAutoPlay = NO;
//    self.player.assetURL = [NSURL URLWithString:@"http://221.228.226.5/15/t/s/h/v/tshvhsxwkbjlipfohhamjkraxuknsc/sh.yinyuetai.com/88DC015DB03C829C2126EEBBB5A887CB.mp4"];
    
    self.player.assetURL = [NSURL URLWithString:@"https://cqxwxx.xx.cn/api/common/mu/getM3u8.m3u8?courseWareId=30111&isCamera=1&sourceId=30985&token=eyJhbGciOiJIUzI1NiJ9.eyJpc3MiOiLmlrDnm5vok50iLCJwbGF0Zm9ybUlkIjoyMDMsImV4cCI6MTYwOTY0MDA3MywidXNlcklkIjoxNTkwLCJpYXQiOjE1NDY1NjgwNzN9.rDc_RUdDyg2pebtiWJhkamZZgFqEi-nridZDo6BqrY8"];
}

- (void)playStopBtnClciked:(UIButton *)sender {
    if (_player.currentPlayerManager.playState == ZFPlayerPlayStatePaused) {
        [_player.currentPlayerManager play];
        [sender setTitle:@"暂停" forState:UIControlStateNormal];
    } else {
        [_player.currentPlayerManager pause];
        [sender setTitle:@"播放" forState:UIControlStateNormal];
    }
}

- (void)addViews {
    [self.view addSubview:self.containerView];
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.mas_equalTo(self.view);
        make.top.mas_equalTo(64);
        make.height.mas_equalTo(200);
    }];
    
    UIButton *playStopBtn = [[UIButton alloc] init];
    [playStopBtn setBackgroundColor:VULRandomColor];
    [playStopBtn setTitle:@"暂停/播放" forState:UIControlStateNormal];
    [playStopBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [playStopBtn addTarget:self action:@selector(playStopBtnClciked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:playStopBtn];
    
    [playStopBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.containerView.mas_bottom).offset(40);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(40);
    }];
}

- (UIView *)containerView {
    if (!_containerView) {
        _containerView = [[UIView alloc] init];
    }
    return _containerView;
}

- (VULReviewControlView *)controlView {
    if (!_controlView) {
        _controlView = [[VULReviewControlView alloc] init];
    }
    return _controlView;
}

@end
