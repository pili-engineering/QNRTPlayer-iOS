//
//  GoingRoomViewController.m
//  NiuLiving
//
//  Created by 何昊宇 on 2018/3/12.
//  Copyright © 2018年 PILI. All rights reserved.
//

#import "GoingRoomViewController.h"
#import "PLPlayerViewController.h"
#import "ScanViewController.h"

@interface GoingRoomViewController () <ScanViewControllerDelegate>

@end

@implementation GoingRoomViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setupUI];
}

- (void)setupUI {    
    CAGradientLayer *pushButtonlayer = [[CAGradientLayer alloc] init];
    pushButtonlayer.frame = self.goingRoomButton.bounds;
    pushButtonlayer.colors =  [NSArray arrayWithObjects:
                               (id) [[UIColor colorWithRed:14.0f / 255.0f green:183.0f / 255.0f blue:255.0f / 255.0f alpha:1] CGColor],
                               (id) [[UIColor colorWithRed:6.0f / 255.0f green:129.0f / 255.0f blue:255.0f / 255.0f alpha:1] CGColor],
                               nil];
    pushButtonlayer.startPoint = CGPointMake(0, 0);
    pushButtonlayer.endPoint = CGPointMake(1, 0);
    [self.goingRoomButton.layer insertSublayer:pushButtonlayer atIndex:0];
    self.goingRoomButton.layer.cornerRadius = 20.0;
    pushButtonlayer.cornerRadius = 20.0;
    
    self.goingRoomTextField.layer.borderColor = [[UIColor colorWithRed:199/255.0 green:199/255.0 blue:199/255.0 alpha:1] CGColor];
    self.goingRoomTextField.layer.borderWidth = 0.5f;
    self.goingRoomTextField.layer.cornerRadius = 20;
    self.goingRoomTextField.layer.masksToBounds = YES;
}

- (IBAction)backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)scanAction:(UIButton *)sender {
    ScanViewController *scanVc = [[ScanViewController alloc] initWithDelegate:self];
    scanVc.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:scanVc animated:YES completion:nil];
}

- (IBAction)goingRoomAction:(id)sender {
    if ([self.goingRoomTextField.text isEqualToString:@""]) {
        [self showAlertWithMessage:@"链接不能为空！！！" completion:nil];
        return;
    }
    PLPlayerViewController *playerVC = [[PLPlayerViewController alloc] initWithRoomURL:self.goingRoomTextField.text];
    playerVC.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:playerVC animated:YES completion:nil];
}

- (void)scanQRResult:(NSString *)qrString {
    if (qrString.length != 0) {
        self.goingRoomTextField.text = qrString;
    }
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
