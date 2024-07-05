//
//  ScanViewController.h
//  NiuLiving
//
//  Created by 冯文秀 on 2022/10/26.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol ScanViewControllerDelegate <NSObject>

- (void)scanQRResult:(NSString *)qrString;

@end

@interface ScanViewController : UIViewController
@property (nonatomic, weak) id<ScanViewControllerDelegate> delegate;

- (instancetype)initWithDelegate:(id<ScanViewControllerDelegate>)delegate;

@end

NS_ASSUME_NONNULL_END
