//
//  CreateRoomViewController.m
//  NiuLiving
//
//  Created by 何昊宇 on 2018/3/12.
//  Copyright © 2018年 PILI. All rights reserved.
//

#import "CreateRoomViewController.h"
#import "PushLiveViewController.h"
#import "UserDelegateVC.h"
#import "ScanViewController.h"

@interface CreateRoomViewController () <ScanViewControllerDelegate>

@end

@implementation CreateRoomViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setupUI];
}

- (void)setupUI {
    CAGradientLayer *pushButtonlayer = [[CAGradientLayer alloc] init];
    pushButtonlayer.frame = self.createRoomButton.bounds;
    pushButtonlayer.colors =  [NSArray arrayWithObjects:
                               (id) [[UIColor colorWithRed:14.0f / 255.0f green:183.0f / 255.0f blue:255.0f / 255.0f alpha:1] CGColor],
                               (id) [[UIColor colorWithRed:6.0f / 255.0f green:129.0f / 255.0f blue:255.0f / 255.0f alpha:1] CGColor],
                               nil];
    pushButtonlayer.startPoint = CGPointMake(0, 0);
    pushButtonlayer.endPoint = CGPointMake(1, 0);
    [self.createRoomButton.layer insertSublayer:pushButtonlayer atIndex:0];
    self.createRoomButton.layer.cornerRadius = 20.0;
    pushButtonlayer.cornerRadius = 20.0;
    
    [self.userClareButton setImage:[UIImage imageNamed:@"chose.png"] forState:UIControlStateSelected];
    [self.userClareButton setImage:[UIImage imageNamed:@"noChose.png"] forState:UIControlStateNormal];
    self.userClareButton.selected = NO;
    
    self.createRoomTextField.layer.borderColor = [[UIColor colorWithRed:199/255.0 green:199/255.0 blue:199/255.0 alpha:1] CGColor];
    self.createRoomTextField.layer.borderWidth = 0.5f;
    self.createRoomTextField.layer.cornerRadius = 20;
    self.createRoomTextField.layer.masksToBounds = YES;
    self.createRoomTextField.text = @"rtmp://pili-publish.qnsdk.com/sdk-live/Aaron";
}

- (IBAction)backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)scanAction:(id)sender {
    ScanViewController *scanVc = [[ScanViewController alloc] initWithDelegate:self];
    scanVc.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:scanVc animated:YES completion:nil];
}

- (IBAction)createRoomAction:(id)sender {
    if (!self.userClareButton.isSelected) {
        [self showAlertWithMessage:@"需同意牛直播用户协议" completion:nil];
        return;
    }
    if ([self.createRoomTextField.text isEqualToString:@""]) {
        [self showAlertWithMessage:@"房间名不能为空" completion:nil];
        return;
    }
    PushLiveViewController *pushLiveVC = [[PushLiveViewController alloc] initWithRoomName:self.createRoomTextField.text];
    pushLiveVC.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:pushLiveVC animated:YES completion:nil];
}

- (void)scanQRResult:(NSString *)qrString {
    if (qrString.length != 0) {
        self.createRoomTextField.text = qrString;
    }
}

- (IBAction)userClareAgreeAction:(id)sender {
    self.userClareButton.selected = !self.userClareButton.isSelected;
}

- (IBAction)userDelegateAction:(id)sender {
    UserDelegateVC *userDelegateVC = [[UserDelegateVC alloc] init];
    userDelegateVC.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:userDelegateVC animated:YES completion:^{
    }];
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

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
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
