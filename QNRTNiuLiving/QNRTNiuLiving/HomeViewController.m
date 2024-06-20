//
//  HomeViewController.m
//  NiuLiving
//
//  Created by 何昊宇 on 2018/3/12.
//  Copyright © 2018年 PILI. All rights reserved.
//

#import "HomeViewController.h"
#import "SettingViewController.h"
#import "CreateRoomViewController.h"
#import "GoingRoomViewController.h"

#import <PLMediaStreamingKit/PLMediaStreamingKit.h>

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    [PLMediaStreamingSession requestCameraAccessWithCompletionHandler:^(BOOL granted) {
        if (!granted) {
            [self presentViewAlert:@"未成功获取相机采集权限，后续将无法正常推流！"];
        }
    }];
    
    [PLMediaStreamingSession requestMicrophoneAccessWithCompletionHandler:^(BOOL granted) {
        if (!granted) {
            [self presentViewAlert:@"未成功获取麦克风采集权限，后续将无法正常推流！"];
        }
    }];
    
    [self setupUI];
}

#pragma mark - alert view

- (void)presentViewAlert:(NSString *)message {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"ok" style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:alertAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBar.hidden = YES;
}

- (void)setupUI {
    CAGradientLayer *pushButtonlayer = [[CAGradientLayer alloc] init];
    pushButtonlayer.frame = self.pushButton.bounds;
    pushButtonlayer.colors =  [NSArray arrayWithObjects:
                               (id) [[UIColor colorWithRed:14.0f / 255.0f green:183.0f / 255.0f blue:255.0f / 255.0f alpha:1] CGColor],
                               (id) [[UIColor colorWithRed:6.0f / 255.0f green:129.0f / 255.0f blue:255.0f / 255.0f alpha:1] CGColor],
                               nil];
    pushButtonlayer.startPoint = CGPointMake(0, 0);
    pushButtonlayer.endPoint = CGPointMake(1, 0);
    [self.pushButton.layer insertSublayer:pushButtonlayer atIndex:0];
    self.pushButton.layer.cornerRadius = 20.0;
    pushButtonlayer.cornerRadius = 20.0;
    
    CAGradientLayer *playButtonlayer = [[CAGradientLayer alloc] init];
    playButtonlayer.frame = self.playButton.bounds;
    playButtonlayer.colors =  [NSArray arrayWithObjects:
                               (id) [[UIColor colorWithRed:14.0f / 255.0f green:183.0f / 255.0f blue:255.0f / 255.0f alpha:1] CGColor],
                               (id) [[UIColor colorWithRed:6.0f / 255.0f green:129.0f / 255.0f blue:255.0f / 255.0f alpha:1] CGColor],
                               nil];
    playButtonlayer.startPoint = CGPointMake(0, 0);
    playButtonlayer.endPoint = CGPointMake(1, 0);
    [self.playButton.layer insertSublayer:playButtonlayer atIndex:0];
    self.playButton.layer.cornerRadius = 20.0;
    playButtonlayer.cornerRadius = 20.0;
}

- (IBAction)pushAction:(id)sender {
    CreateRoomViewController *createRoomVC = [[CreateRoomViewController alloc] init];
    [self.navigationController pushViewController:createRoomVC animated:YES];
}

- (IBAction)playAction:(id)sender {
    GoingRoomViewController *goingRoomVC = [[GoingRoomViewController alloc] init];
    [self.navigationController pushViewController:goingRoomVC animated:YES];
}

- (IBAction)settingAction:(id)sender {
    SettingViewController *settingVC = [[SettingViewController alloc] init];
    [self.navigationController pushViewController:settingVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
