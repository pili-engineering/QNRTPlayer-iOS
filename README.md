# QNRTPlayerKit

七牛低延时直播构建了全新的低延时直播互动体验，相比于传统的直播能力降低了延时、优化了协议与底层技术，目前对于微信内直播多业务场景提供了更为优渥的使用体验。支持千万级并发同时拥有毫秒级开播体验，打通了用户对于直播低延时性的核心诉求。

## 功能特性

- [x] 支持 H.264 视频解码
- [x] 支持 Opus 音频解码
- [x] 支持 HeaderDoc 文档
- [x] 支持 ARMv7, ARM64, i386, x86_64 架构
- [x] 支持纯音频或纯视频播放
- [x] 支持自定义音视频处理
- [x] 支持苹果 ATS 安全标准

## 系统要求

- iOS Target : >= iOS 9
- iOS Device : >= iPhone 5

## 安装方法

[CocoaPods](https://cocoapods.org/) 是针对 Objective-C 的依赖管理工具，它能够将使用类似 QNRTPlayerKit 的第三方库的安装过程变得非常简单和自动化，你能够用下面的命令来安装它：

```bash
$ sudo gem install cocoapods
```

### Podfile

为了使用 CoacoaPods 集成 QNRTPlayerKit 到你的 Xcode 工程当中，你需要编写你的 `Podfile`

```ruby
source 'https://github.com/CocoaPods/Specs.git'
target 'TargetName' do
pod 'QNRTPlayerKit'
end
```

- 默认为真机版	
- 若需要使用模拟器 + 真机版，则改用如下配置	

```	
pod "QNRTPlayerKit", :podspec => 'https://raw.githubusercontent.com/pili-engineering/QNRTPlayer-iOS/master/QNRTPlayerKit-Universal.podspec'	
```	

**注意：鉴于目前 iOS 上架，只支持动态库真机，请在 App 上架前，更换至真机版本**

然后，运行如下的命令：

```bash
$ pod install
```

## 反馈及意见

当你遇到任何问题时，可以通过在 GitHub 的 repo 提交 issues 来反馈问题，请尽可能的描述清楚遇到的问题，如果有错误信息也一同附带，并且在 Labels 中指明类型为 bug 或者其他。

[通过这里查看已有的 issues 和提交 Bug。](https://github.com/pili-engineering/QNRTPlayer-iOS/issues)
