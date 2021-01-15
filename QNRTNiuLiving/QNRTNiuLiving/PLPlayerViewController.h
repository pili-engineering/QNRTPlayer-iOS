//
//  PLPlayerViewController.h
//  NiuLiving
//
//  Created by 何昊宇 on 2018/3/15.
//  Copyright © 2018年 PILI. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PLPlayerViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *infoButton;
@property (weak, nonatomic) IBOutlet UIButton *urlCopyButton;
@property (weak, nonatomic) IBOutlet UIButton *closeButton;
@property (weak, nonatomic) IBOutlet UIView *messageView;
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;
@property (weak, nonatomic) IBOutlet UIView *infoView;
@property (weak, nonatomic) IBOutlet UILabel *audioBitrateLabel;
@property (weak, nonatomic) IBOutlet UILabel *resolutionLabel;
@property (weak, nonatomic) IBOutlet UILabel *fpsLabel;
@property (weak, nonatomic) IBOutlet UILabel *bitrateLabel;
@property (weak, nonatomic) IBOutlet UIButton *reportButton;
@property (weak, nonatomic) IBOutlet UIButton *playButton;
@property (weak, nonatomic) IBOutlet UIButton *muteAudioButton;
@property (weak, nonatomic) IBOutlet UIButton *muteVideoButton;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *bufferingIndicator;

@property (nonatomic, strong) NSString *roomURL;

- (instancetype)initWithRoomURL:(NSString *)roomURL;

@end
