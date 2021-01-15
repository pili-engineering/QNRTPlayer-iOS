//
//  QNRTTypeDefines.h
//  QNRTPlayerKit
//
//  Created by 何云旗 on 2020/12/24.
//

#ifndef QNRTPlayerKit_QNRTTypeDefines_h
#define QNRTPlayerKit_QNRTTypeDefines_h

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

extern NSString *QNRTErrorDomain;

#pragma mark - RTPlayer Error Code

NS_ERROR_ENUM(QNRTErrorDomain)
{
    // 服务请求超时，或者域名解析错误等
    QNRTErrorNetworkError                            = 20001,
    // 请求服务鉴权失败
    QNRTErrorAuthFailed                              = 20002,
    // 播放流地址不存在
    QNRTErrorPlayStreamNotExit                       = 20003,
    // 对应服务 invalid parameter / server error
    QNRTErrorPlayRequestFailed                       = 20004,
    // 内部sdp错误
    QNRTErrorDescriptionError                        = 20005,
    // 连接异常
    QNRTErrorConnectFailed                           = 20006,
    
};

///音频播放状态
typedef NS_ENUM(NSUInteger, QNRTPlayState) {
    /*!
     * @abstract 未知状态，只会作为 init 前的初始状态，开始播放之后任何情况下都不会再回到此状态。
     *
     * @since v1.0.0
     */
    QNRTPlayStateUnknow,
    /*!
     * @abstract 初始状态
     *
     * @since v1.0.0
     */
    QNRTPlayStateInit = 0,
    /*!
     * @abstract 准备播放的状态
     *
     * @since v1.0.0
     */
    QNRTPlayStateReady,
    /*!
     * @abstract 正在播放的状态
     *
     * @since v1.0.0
     */
    QNRTPlayStatePlaying,
    /*!
     * @abstract 停止播放的状态
     *
     * @since v1.0.0
     */
    QNRTPlayStateStoped,
    /*!
     * @abstract 播放发生错误的状态
     *
     * @since v1.0.0
     */
    QNRTPlayStateError
};

/*!
 @typedef    QNRTSourceKind
 @abstract   定义 Source 的类型。
 */
typedef NS_ENUM(NSUInteger, QNRTSourceKind) {
    QNRTSourceKindAudio = 0,
    QNRTSourceKindVideo = 1,
};

//视频填充模式
typedef enum {
    /**
     @brief Stretch to fill the full view, which may distort the image outside of its normal aspect ratio
     */
    QNRTVideoFillModeStretch,
    
    /**
     @brief Maintains the aspect ratio of the source image, adding bars of the specified background color
     */
    QNRTVideoFillModePreserveAspectRatio,
    
    /**
     @brief Maintains the aspect ratio of the source image, zooming in on its center to fill the view
     */
    QNRTVideoFillModePreserveAspectRatioAndFill
} QNRTVideoFillModeType;


extern NSString *QNRTStatisticAudioBitrateKey;
extern NSString *QNRTStatisticVideoBitrateKey;
extern NSString *QNRTStatisticVideoFrameRateKey;


#endif /* QNRTTypeDefines_h */
