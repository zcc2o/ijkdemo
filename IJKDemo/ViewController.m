//
//  ViewController.m
//  IJKDemo
//
//  Created by 章程程 on 2018/12/11.
//  Copyright © 2018 zcc. All rights reserved.
//

#import "ViewController.h"
//#import <NIMSDK/NIMSDK.h>
#import "VULNIMLivingViewController.h"
#import "ZCCTeacherCameraViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIButton *jumpBtn = [[UIButton alloc] initWithFrame:CGRectMake((VULSCREEN_WIDTH - 200) / 2, 100, 200, 50)];
    [jumpBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [jumpBtn setTitle:@"跳转" forState:UIControlStateNormal];
    [jumpBtn setBackgroundColor:[UIColor blueColor]];
    [jumpBtn addTarget:self action:@selector(jumpBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:jumpBtn];
    
    UIButton *jumpZFBtn = [[UIButton alloc] initWithFrame:CGRectMake((VULSCREEN_WIDTH - 200) / 2, 200, 200, 50)];
    [jumpZFBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [jumpZFBtn setTitle:@"跳转" forState:UIControlStateNormal];
    [jumpZFBtn setBackgroundColor:[UIColor blueColor]];
    [jumpZFBtn addTarget:self action:@selector(jumpZFBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:jumpZFBtn];
}

- (void)jumpBtnClicked{
//    NSString *account = @"30154";
//    NSString *token = @"b6d436664e14e6b315a29d6f18aab58b";
//    [[[NIMSDK sharedSDK] loginManager] login:account token:token completion:^(NSError * _Nullable error) {
//        if(!error){
//            VULNIMLivingViewController *livingVC = [[VULNIMLivingViewController alloc] init];
//            [self presentViewController:livingVC animated:YES completion:nil];
////            [self.navigationController pushViewController:livingVC animated:YES];
//        }else{
//            NSLog(@"%@", error);
//        }
//    }];
    
    VULNIMLivingViewController *livingVC = [[VULNIMLivingViewController alloc] init];
    [self presentViewController:livingVC animated:YES completion:nil];
}

- (void)jumpZFBtnClicked {
    ZCCTeacherCameraViewController *teacherVC = [[ZCCTeacherCameraViewController alloc] init];
    [self presentViewController:teacherVC animated:YES completion:nil];
}

@end
