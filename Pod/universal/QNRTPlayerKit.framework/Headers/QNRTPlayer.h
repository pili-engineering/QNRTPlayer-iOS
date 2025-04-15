//
//  QNRTPlayer.h
//  QNRTPlayerKit
//
//  Created by 何云旗 on 2020/12/23.
//

#import <Foundation/Foundation.h>
#import <AVKit/AVKit.h>
#import "QNRTTypeDefines.h"

@class QNRTPlayer;
@class QNRTVideoView;
@class QNSampleBufferRender;

NS_ASSUME_NONNULL_BEGIN

/*!
 * @protocol QNRTPlayerDelegate
 *
 * @discussion QNRTPlayer 在运行过程中的状态和事件回调。
 *
 * @since v1.0.0
 */
@protocol QNRTPlayerDelegate <NSObject>

@optional
/*!
 * @abstract SDK 运行过程中发生错误会通过该方法回调。
 *
 * @param player QNRTPlayer
 * @param error 错误信息
 *
 * @discussion 具体错误码的含义可以见 QNRTTypeDefines.h 文件。
 *
 * @since v1.0.0
 */
- (void)RTPlayer:(QNRTPlayer *)player didFailWithError:(NSError *)error;

/**
 * QNRTPlayer 在运行过程中，状态发生变化的回调
 *
 * @param player QNRTPlayer
 * @param playState 播放状态
 *
 * @discussion 状态为 QNRTPlayStateError 时，具体错误信息会通过 - (void)RTPlayer:(QNRTPlayer *)player didFailWithError:(NSError *)error; 回调。
 *
 * @since v1.0.0
 */
- (void)RTPlayer:(QNRTPlayer *)player playStateDidChange:(QNRTPlayState)playState;

/*!
 * @abstract 统计信息回调。
 *
 * @param player QNRTPlayer
 * @param statistic 统计信息
 *
 * @discussion 回调的时间间隔由 statisticInterval 参数决定，statisticInterval 默认为 0，即不回调统计信息。
 *
 * @see statisticInterval
 *
 * @since v1.0.0
 */
- (void)RTPlayer:(QNRTPlayer *)player didGetStatistic:(NSDictionary *)statistic;

/*!
 * @abstract 当前流媒体流收到数据轨道的回调。
 *
 * @param player QNRTPlayer
 * @param kind 数据源类型
 *
 * @since v1.0.0
 */
- (void)RTPlayer:(QNRTPlayer *)player trackDidReceived:(QNRTSourceKind )kind;

/*!
 * @abstract 音视频首帧解码后的回调。
 *
 * @param player QNRTPlayer
 * @param kind 数据源类型
 *
 * @since v1.0.0
 */
- (void)RTPlayer:(QNRTPlayer *)player firstSourceDidDecode:(QNRTSourceKind )kind;


/*!
 * @abstract 画中画开启
 *
 * @param player QNRTPlayer
 * @param pictureInPictureController 画中画控制器
 *
 * @since v1.0.6
 */
- (void)RTPlayer:(QNRTPlayer *)player  didStartPictureInPicture:(AVPictureInPictureController *)pictureInPictureController;

/*!
 * @abstract 画中画停止。
 *
 * @param player QNRTPlayer
 * @param pictureInPictureController 画中画控制器
 *
 * @since v1.0.6
 */
- (void)RTPlayer:(QNRTPlayer *)player didStopPictureInPicture:(AVPictureInPictureController *)pictureInPictureController;

/*!
 * @abstract 可以实现这种方法，在画中画停止之前恢复用户界面。
 *
 * @param player QNRTPlayer
 *
 * @param completionHandler 委托在还原后需要调用的完成处理程序。
 *
 * @since v1.0.6
 */
- (void)RTPlayer:(QNRTPlayer *)player restoreUserInterfaceForPictureInPictureStopWithCompletionHandler:(void (^)(BOOL restored))completionHandler;
@end

@interface QNRTPlayer : NSObject

/*!
 * @abstract 状态回调的 delegate。
 *
 * @since v1.0.0
 */
@property (nonatomic, weak) id<QNRTPlayerDelegate> delegate;

/*!
 * @abstract 播放状态
 *
 * @since v1.0.0
 */
@property (nonatomic, assign, readonly) QNRTPlayState playState;

/*!
 * @abstract 是否在播放
 *
 * @since v1.0.0
 */
@property (nonatomic, assign, readonly) BOOL isPlaying;

/*!
 * @abstract 播放 url
 *
 * @since v1.0.0
 */
@property (nonatomic, copy, readonly) NSURL *playUrl;

/*!
 * @abstract 播放音量。
 *
 * @discussion 范围从 0 ~ 1，默认为 1。
 *
 * @since v1.0.0
 */
@property (nonatomic, assign) double volume;

/*!
 * 视频的宽
 *
 * @since v1.0.0
 */
@property (nonatomic, assign, readonly) CGFloat width;

/*!
 * 视频的高
 *
 * @since v1.0.0
 */
@property (nonatomic, assign, readonly) CGFloat height;

/*!
 * @abstract 统计信息回调的时间间隔。
 *
 * @discussion 单位为秒。默认为 0，即默认不会回调统计信息。
 *
 * @since v1.0.0
 */
@property (nonatomic, assign) NSUInteger statisticInterval;

/*!
 * @abstract 渲染播放画面。
 *
 * @since v1.0.0
 */
@property (nonatomic, strong) QNRTVideoView *playView;

/*!
 * 开始播放新的 url
 *
 * @param url 需要播放的 url ，目前支持 webrtc (url 以 webrtc:// 开头) 、WHEP 协议。
 * @param isSupport 当前播放 URL 是否支持 SSL 证书，默认为 NO
 *
 * @since v1.0.0
 */
- (void)playWithUrl:(NSURL *)url supportHttps:(BOOL)isSupport;

/*!
 * 停止播放器
 *
 * @since v1.0.0
 */
- (void)stop;

/*!
 * 音频是否静音
 *
 * @param mute 静音开关。
 *
 * @since 1.0.0
 */
- (void)muteAudio:(BOOL)mute;

/*!
 * 视频是否停止画面渲染
 *
 * @param mute 渲染开关。
 *
 * @since 1.0.0
 */
- (void)muteVideo:(BOOL)mute;

/*!
 * @abstract 是否将声音从扬声器输出。
 *
 * @param speakerOn 扬声器开关。
 *
 * @discussion 默认值为 NO，传入 YES 时，会强制声音从扬声器输出。
 *
 * @warning 由于系统原因，在某些设备（如 iPhone XS Max、iPhone 8 Plus）上，连接 AirPods 后无法通过
 * 该接口将声音强制设为扬声器输出。如有需求，可以通过使用 AVRoutePickerView 来切换。
 *
 * @since v1.0.2
 */
- (void)setSpeakerOn:(BOOL)speakerOn;

/*!
 * @abstract 截图播放画面。
 *
 * @param resultCallback 截图的结果回调。
 *
 * @discussion 成功则回调图片，失败则回调错误。
 *
 * @warning 成功拉到首帧之后才可正常截图。
 *
 * @since v1.0.4
 */
- (void)takeScreenshotCallback:(QNScreenshotResultCallback)resultCallback;

/*!
 * @abstract 设置抖动缓冲区的最小延迟。
 *
 * @param jitterBufferMinDelay 抖动缓冲区最小延迟。
 *
 * @discussion 默认为 0，不开启抖动延迟，时间单位为秒，范围 [0, 1]。
 *
 * @warning 根据实际网络条件和对延迟的敏感度来平衡设置
 *
 * @since v1.0.4
 */
- (void)setJitterBufferMinDelay:(double)jitterBufferMinDelay;

/*!
 * @abstract 是否支持画中画 （iOS >= 15.0、iPad  >= 9.0  ）
 *
 * @since v1.0.6
 */
- (BOOL)isSupportPictureInPicture;

/*!
 * @abstract 开启画中画
 *
 * @since v1.0.6
 */
- (void)startPictureInPicture;

/*!
 * @abstract 关闭画中画
 *
 * @since v1.0.6
 */
- (void)stopPictureInPicture;

/*!
 * @abstract 画中画是否自动开启
 * 默认情况下，如果 playView 是全屏的，或者我们将 setCanStartPictureInPictureAutomaticallyFromInline 设置为 YES，则当用户移动到后台时，画中画 开始
 *
 * @since v1.0.6
 */
- (void)setCanStartPictureInPictureAutomaticallyFromInline:(BOOL)isAuto;


@end

#pragma mark - Category (Logging)

/*!
 * @category QNRTPlayer(Logging)
 *
 * @discussion 与日志相关的接口。
 *
 * @since v1.0.0
 */
@interface QNRTPlayer (Logging)

/*!
* @abstract 开启文件日志
*
* @discussion 为了不错过日志，建议在 App 启动时即开启，日志文件位于 App Container/Library/Caches/Pili/RTLogs 目录下以 QNRTPlayer+当前时间命名的目录内
* 注意：文件日志功能主要用于排查问题，打开文件日志功能会对性能有一定影响，上线前请记得关闭文件日志功能！
*
* @since v1.0.0
*/
+ (void)enableFileLogging;

@end

#pragma mark - Category (Info)

/*!
 * @category QNRTPlayer(Info)
 *
 * @discussion SDK 相关信息的接口。
 *
 * @since v1.0.0
 */
@interface QNRTPlayer (Info)

/*!
 * @abstract 获取 SDK 的版本信息。
 *
 * @since v1.0.0
 */
+ (NSString *)versionInfo;

@end

NS_ASSUME_NONNULL_END
