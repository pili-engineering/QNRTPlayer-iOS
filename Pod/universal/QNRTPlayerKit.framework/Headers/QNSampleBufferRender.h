//
//  QNSampleBufferRender.h
//  QNRTPlayerKit
//
//  Created by sunmu on 2024/11/5.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "QNRTTypeDefines.h"
#import "QNRTVideoView.h"

NS_ASSUME_NONNULL_BEGIN

@interface QNSampleBufferRender : QNRTVideoView

@property (nonatomic, readonly) AVSampleBufferDisplayLayer *displayLayer;

- (void)reset;

- (void)renderVideoPixelBuffer:(CVPixelBufferRef)pixelBuffer;


@end

NS_ASSUME_NONNULL_END
