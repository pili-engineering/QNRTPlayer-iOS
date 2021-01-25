//
//  QNRTVideoView.h
//  QNRTPlayerKit
//
//  Created by 何云旗 on 2020/12/24.
//

#import <UIKit/UIKit.h>
#import "QNRTTypeDefines.h"

NS_ASSUME_NONNULL_BEGIN

@interface QNRTVideoView : UIView

/*!
 * @abstract 远端画面的填充方式
 *
 * @discussion 当画面与 QNRTVideoView 的比例不一致时，使用的填充方式。默认使用 QNRTVideoFillModePreserveAspectRatioAndFill。
 *
 * @since v1.0.0
 */
@property(nonatomic, assign) QNRTVideoFillModeType fillMode;

@end

NS_ASSUME_NONNULL_END
