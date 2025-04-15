//
//  PLPlayerViewController.m
//  NiuLiving
//
//  Created by 何昊宇 on 2018/3/15.
//  Copyright © 2018年 PILI. All rights reserved.
//

#import "PLPlayerViewController.h"
#import <QNRTPlayerKit/QNRTPlayerKit.h>

@interface PLPlayerViewController () <QNRTPlayerDelegate>
@property (nonatomic, strong) QNRTPlayer *player;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) UISegmentedControl *segmentedControl;
@property (nonatomic, strong) NSArray *valueArray;

@property (weak, nonatomic) IBOutlet UIButton *pipBtn;

@end

@implementation PLPlayerViewController

- (instancetype)initWithRoomURL:(NSString *)roomURL {
    if ([super init]) {
        _roomURL = roomURL;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(playerInfo) userInfo:nil repeats:YES];
    [self setupUI];
    [self setupPlayer:self.roomURL];
}

- (void)setupUI {
    self.infoView.hidden = YES;
    self.messageView.alpha = 0;
    self.messageLabel.text = [NSString stringWithFormat:@"链接： %@复制到剪贴板",self.roomURL];
    self.reportButton.layer.cornerRadius = 10.0;
    
    [self.playButton setTitle:@"start" forState:UIControlStateNormal];
    [self.playButton setTitle:@"stop" forState:UIControlStateSelected];
    self.playButton.selected = NO;
    
    [self.muteAudioButton setBackgroundImage:[UIImage imageNamed:@"mute.png"] forState:UIControlStateNormal];
    [self.muteAudioButton setBackgroundImage:[UIImage imageNamed:@"volume-high.png"] forState:UIControlStateSelected];
    self.muteAudioButton.selected = NO;
    
    [self.muteVideoButton setBackgroundImage:[UIImage imageNamed:@"hide.png"] forState:UIControlStateNormal];
    [self.muteVideoButton setBackgroundImage:[UIImage imageNamed:@"show.png"] forState:UIControlStateSelected];
    self.muteVideoButton.selected = NO;
    
    self.valueArray = @[@"0", @"0.1", @"0.15", @"0.2", @"0.4", @"0.6", @"1.0"];
    self.segmentedControl = [[UISegmentedControl alloc] initWithItems:_valueArray];
    self.segmentedControl.backgroundColor = [UIColor whiteColor];
    self.segmentedControl.frame = CGRectMake(0, 0, 320, 50);
    self.segmentedControl.center = self.view.center;
    self.segmentedControl.selectedSegmentIndex = 0;
    [self.segmentedControl addTarget:self action:@selector(jitterBufferMinDelaySelected:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:_segmentedControl];
    _segmentedControl.hidden = YES;
}

- (void)jitterBufferMinDelaySelected:(UISegmentedControl *)segmentedControl {
    double jitterBuffer = [self.valueArray[segmentedControl.selectedSegmentIndex] doubleValue];
    [self.player setJitterBufferMinDelay:jitterBuffer];
}

- (void)playerInfo {
    self.resolutionLabel.text = [NSString stringWithFormat:@"分辨率： %.fx%.f", self.player.width, self.player.height];
}

- (void)setupPlayer:(NSString *)playURL {
    self.player = [[QNRTPlayer alloc] init];
    self.player.playView.frame = CGRectMake(10, 10, self.view.bounds.size.width - 20, 300);
    self.player.playView.fillMode = QNRTVideoFillModePreserveAspectRatio;
    self.player.statisticInterval = 2;
    [self.view insertSubview:self.player.playView atIndex:0];
    self.player.delegate = self;
    [self.player playWithUrl:[NSURL URLWithString:self.roomURL] supportHttps:NO];
    [self.bufferingIndicator startAnimating];
}

- (IBAction)infoAction:(id)sender {
    self.infoButton.selected = !self.infoButton.isSelected;
    if (self.infoButton.isSelected) {
        self.infoView.hidden = NO;
    } else {
        self.infoView.hidden = YES;
    }
}

- (IBAction)urlCopyAction:(id)sender {
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = self.roomURL;
    [UIView animateWithDuration:1.0 animations:^{ 
        // 执行动画
        self.messageView.alpha = 1.f;
    } completion:^(BOOL finished) { 
        // 完成
        [UIView animateWithDuration:2.0 delay:1.0 options:UIViewAnimationOptionCurveLinear animations:^{
            self.messageView.alpha = 0;
        } completion:nil];
    }];
}

- (IBAction)takeShotAction:(id)sender {
    [self.player takeScreenshotCallback:^(UIImage *ShotImage, NSError *error) {
        if (ShotImage) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self showAlertWithMessage:@"截图自己成功" completion:nil];
            });
            UIImageWriteToSavedPhotosAlbum(ShotImage, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self showAlertWithMessage:[NSString stringWithFormat:@"截图自己失败 %ld %@", (long)error.code, error.localizedDescription] completion:nil];
            });
        }
    }];
}
- (IBAction)picInPicAction:(UIButton *)sender {
    sender.selected = !sender.selected;
    if(sender.selected) {
        [self.player startPictureInPicture];
    } else {
        [self.player stopPictureInPicture];
    }
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    if (error) {
        NSLog(@"保存图片到相册失败: %@", error.localizedDescription);
    } else {
        NSLog(@"保存图片到相册成功");
    }
}

- (IBAction)jitterBufferAction:(id)sender {
    self.jitterBufferButton.selected = !self.jitterBufferButton.isSelected;
    if (self.jitterBufferButton.isSelected) {
        self.segmentedControl.hidden = NO;
    } else {
        self.segmentedControl.hidden = YES;
    }
}

- (IBAction)closeAction:(id)sender {
    [self.timer invalidate];
    self.timer = nil;
    if (self.player) {
        [self.player stop];
        [self.player stopPictureInPicture];
        [self.player.playView removeFromSuperview];
        self.player.delegate = nil;
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)dealloc {
    NSLog(@"view dealloc");
}

- (IBAction)reportAction:(id)sender {
    [self showAlertWithMessage:@"您已举报此房间，我们会尽快处理" completion:^{
        [self closeAction:nil];
    }];
}

- (IBAction)playAction:(id)sender {
    UIButton * button = (UIButton *)sender;
    if (!button.isSelected) {
        [self.player playWithUrl:[NSURL URLWithString:self.roomURL] supportHttps:NO];
        [self.bufferingIndicator startAnimating];
    } else {
        [self.player stop];
    }
}

- (IBAction)muteAudioAction:(id)sender {
    UIButton *button = (UIButton *)sender;
    button.selected = !button.isSelected;
    [self.player muteAudio:button.isSelected];
    
}

- (IBAction)muteVideoAction:(id)sender {
    UIButton *button = (UIButton *)sender;
    button.selected = !button.isSelected;
    [self.player muteVideo:button.isSelected];
}
#pragma mark QNRTPlayerDelegate

- (void)RTPlayer:(QNRTPlayer *)player didFailWithError:(NSError *)error {
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"QNRTPlayerDelegate didFailWithError:%@", error);
        [self showAlertWithMessage:[NSString stringWithFormat:@"发生错误：%ld, 信息：%@", (long)error.code, error.localizedDescription] completion:nil];
    });
}

- (void)RTPlayer:(QNRTPlayer *)player playStateDidChange:(QNRTPlayState)playState {
    dispatch_async(dispatch_get_main_queue(), ^{
        NSString *message = @"";
        switch (playState) {
            case QNRTPlayStateInit:
                message = @"初始";
                break;
            case QNRTPlayStateError:
                message = @"错误";
                break;
            case QNRTPlayStateReady:
                message = @"已准备";
                break;
            case QNRTPlayStateStoped:
                message = @"已停止";
                break;
            case QNRTPlayStatePlaying:
                message = @"播放中";
                break;
            default:
                break;
        }
        NSLog(@"QNRTPlayerDelegate playStateDidChange:%@", message);
        if (playState == QNRTPlayStatePlaying) {
            self.playButton.selected = YES;
            [self.bufferingIndicator stopAnimating];
        } else {
            self.playButton.selected = NO;
        }
    });
}

- (void)RTPlayer:(QNRTPlayer *)player firstSourceDidDecode:(QNRTSourceKind)kind {
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"QNRTPlayerDelegate firstSourceDidDecode:%d",(int)kind);
        if (QNRTSourceKindVideo == kind) {
            [self.bufferingIndicator stopAnimating];
            NSString * message = [NSString stringWithFormat:@"首帧视频：%.fx%.f", self.player.width, self.player.height];
            [self showAlertWithMessage:message completion:nil];
        }
    });
}

- (void)RTPlayer:(QNRTPlayer *)player didGetStatistic:(NSDictionary *)statistic {
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"QNRTPlayerDelegate didGetStatistic:%@",statistic);
        self.fpsLabel.text = [NSString stringWithFormat:@"视频帧率： %@",statistic[QNRTStatisticVideoFrameRateKey]];
        self.bitrateLabel.text = [NSString stringWithFormat:@"视频码率： %0.2f b/s",[statistic[QNRTStatisticVideoBitrateKey] floatValue]];
        self.audioBitrateLabel.text = [NSString stringWithFormat:@"音频码率： %.2f b/s",[statistic[QNRTStatisticAudioBitrateKey] floatValue]];
    });
}

- (void)RTPlayer:(QNRTPlayer *)player trackDidReceived:(QNRTSourceKind )kind {
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"QNRTPlayerDelegate trackDidReceived:%d", (int)kind);
    });
}

-(void)RTPlayer:(QNRTPlayer *)player didStopPictureInPicture:(AVPictureInPictureController *)pictureInPictureController {
    dispatch_async(dispatch_get_main_queue(), ^{
        _pipBtn.selected = NO;
    });
}

-(void)RTPlayer:(QNRTPlayer *)player didStartPictureInPicture:(AVPictureInPictureController *)pictureInPictureController{
    
}

- (void)showAlertWithMessage:(NSString *)message completion:(void (^)(void))completion {
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    [controller addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        if (completion) {
            completion();
        }
    }]];
    [self presentViewController:controller animated:YES completion:nil];
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
