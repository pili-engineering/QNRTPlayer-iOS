//
//  UserDelegateVC.h
//  PLCodingShow
//
//  Created by   何舒 on 16/1/22.
//  Copyright © 2016年 Aaron. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

@interface UserDelegateVC : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *backBtn;
@property (weak, nonatomic) IBOutlet WKWebView *userDelegateDataWeb;

@end
