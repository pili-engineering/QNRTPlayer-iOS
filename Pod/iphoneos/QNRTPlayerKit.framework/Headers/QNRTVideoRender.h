//
//  QNRTVideoRender.h
//  QNRTPlayerKit
//
//  Created by 何云旗 on 2020/12/24.
//

#import <Foundation/Foundation.h>
#import "QNRTVideoView.h"

NS_ASSUME_NONNULL_BEGIN

@interface QNRTVideoRender : NSObject

/**
 @brief 对应的 sessionId，由 SDK 内部设置
 */
@property (nonatomic, strong, readonly) NSString *sessionId;


@property (nonatomic, strong) QNRTVideoView *renderView;

@end

NS_ASSUME_NONNULL_END
