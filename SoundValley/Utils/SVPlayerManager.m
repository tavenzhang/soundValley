//
//  SVPlayerManager.m
//  SoundValley
//
//  Created by apple on 2020/5/14.
//  Copyright © 2020 apple. All rights reserved.
//

#import "SVPlayerManager.h"
#import "DOUAudioFile.h"
#import "DOUAudioStreamer.h"
#include <stdlib.h>
#import <AVFoundation/AVAudioSession.h>
#import <MediaPlayer/MediaPlayer.h>
#import "Track.h"
static void *kStatusKVOKey = &kStatusKVOKey;
static void *kDurationKVOKey = &kDurationKVOKey;
static void *kBufferingRatioKVOKey = &kBufferingRatioKVOKey;
@interface SVPlayerManager ()
@property (nonatomic, strong) DOUAudioStreamer *streamer;
@property (nonatomic, strong) NSURL *musicUrl;
@property (nonatomic, strong) Track *audioTrack;
@end

@implementation SVPlayerManager
static SVPlayerManager *_instance;
+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[SVPlayerManager alloc] init];
    });
    return _instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _audioTrack = [[Track alloc] init];
        AVAudioSession *session = [AVAudioSession sharedInstance];
        [session setActive:YES error:nil];
        [session setCategory:AVAudioSessionCategoryPlayback error:nil];
        //让app支持接受远程控制事件
        [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
        
        //添加通知，拔出耳机后暂停播放
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(routeChange:) name:AVAudioSessionRouteChangeNotification object:nil];
    }
    return self;
}

#pragma mark - Audio Action

- (void)updateSliderValue:(id)timer {
    if (!_streamer) {
        return;
    }
    if (_streamer.status == DOUAudioStreamerFinished) {
        [_streamer stop];
        [_streamer play];
    }
    
    if ([_streamer duration] == 0.0) {
       
    } else {
        if (_streamer.currentTime >= _streamer.duration) {
            _streamer.currentTime -= _streamer.duration;
        }
    }
}

- (void)setCustomVolume:(CGFloat)volume
{
    self.streamer.volume = volume;
//    NSLog(@"---------%.2f", volume);
}

- (void)pause
{
    [self.streamer pause];
}

- (void)resume
{
    [self.streamer play];
}

- (BOOL)isPlaying
{
    if (self.streamer && ([self.streamer status] == DOUAudioStreamerPlaying || [self.streamer status] == DOUAudioStreamerBuffering)) {
        return YES;
    } else {
        return NO;
    }
}

- (void)stopPlay
{
    [self.streamer stop];
    [self cancelStreamer];
}

- (void)playMusicWithFilePath:(NSURL *)filePathUrl
{
    self.musicUrl = filePathUrl;
    [self createStreamer];
}

- (void)playMusicWithUrl:(NSString *)url soundID:(NSString *)soundId
{
    self.musicUrl = [NSURL URLWithString:url];
    [self createStreamer];
}

- (void)updateBufferingStatus
{
    CGFloat bufferingStatus = [self.streamer bufferingRatio];
    if (bufferingStatus == 1.00) {
//        self.musicCache.cachedPath = self.streamer.cachedPath;
//        self.musicCache.cachedURL = self.streamer.cachedURL.absoluteString;
    }
}

#pragma mark - Audio Handle

- (void)createStreamer
{
    [self cancelStreamer];
    //    track.audioFileURL = fileURL;
    self.audioTrack.audioFileURL = self.musicUrl;
      //    track.audioFileURL = fileURL;
    _streamer = [DOUAudioStreamer streamerWithAudioFile:self.audioTrack];
    [self addStreamerObserver];
    
    [self.streamer play];
}

- (void)cancelStreamer
{
    if (_streamer != nil) {
        [_streamer pause];
        [_streamer removeObserver:self forKeyPath:@"status"];
        [_streamer removeObserver:self forKeyPath:@"duration"];
        [_streamer removeObserver:self forKeyPath:@"bufferingRatio"];
        _streamer = nil;
    }
}

- (void)addStreamerObserver {
    [_streamer addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:kStatusKVOKey];
    [_streamer addObserver:self forKeyPath:@"duration" options:NSKeyValueObservingOptionNew context:kDurationKVOKey];
    [_streamer addObserver:self forKeyPath:@"bufferingRatio" options:NSKeyValueObservingOptionNew context:kBufferingRatioKVOKey];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if (context == kStatusKVOKey) {
        [self performSelector:@selector(updateStatus)
                     onThread:[NSThread mainThread]
                   withObject:nil
                waitUntilDone:NO];
    } else if (context == kDurationKVOKey) {
        [self performSelector:@selector(updateSliderValue:)
                     onThread:[NSThread mainThread]
                   withObject:nil
                waitUntilDone:NO];
    } else if (context == kBufferingRatioKVOKey) {
       [self performSelector:@selector(updateStatus)
                           onThread:[NSThread mainThread]
                         withObject:nil
                      waitUntilDone:NO];
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (void)updateStatus
{
    switch ([self.streamer status]) {
        case DOUAudioStreamerPlaying:
            break;
        case DOUAudioStreamerPaused:
            break;
            
        case DOUAudioStreamerIdle:
            break;
            
        case DOUAudioStreamerFinished:
            if (_streamer.bufferingRatio == 1) {
                 [self resume];
            } else {
                
            }
           
            break;
        case DOUAudioStreamerBuffering:
            
            break;
        case DOUAudioStreamerError:
            break;
    }
    [self updateMusicsState];
}

- (void)updateMusicsState
{
    
}

// 拔出耳机后暂停播放
-(void)routeChange:(NSNotification *)notification
{
    NSDictionary *dic=notification.userInfo;
    int changeReason= [dic[AVAudioSessionRouteChangeReasonKey] intValue];
    //等于AVAudioSessionRouteChangeReasonOldDeviceUnavailable表示旧输出不可用
    
    if (changeReason==AVAudioSessionRouteChangeReasonOldDeviceUnavailable) {
        AVAudioSessionRouteDescription *routeDescription=dic[AVAudioSessionRouteChangePreviousRouteKey];
        AVAudioSessionPortDescription *portDescription= [routeDescription.outputs firstObject];
        //原设备为耳机则暂停
        if ([portDescription.portType isEqualToString:@"Headphones"]) {
            [_streamer pause];
        }
    }
}


//锁屏时音乐显示(这个方法可以在点击播放时，调用传值)
- (void)setupLockScreenInfoWithSing:(NSString *)sign WithSigner:(NSString *)signer WithImage:(UIImage *)image
{
    // 1.获取锁屏中心
    MPNowPlayingInfoCenter *playingInfoCenter = [MPNowPlayingInfoCenter defaultCenter];
    
    //初始化一个存放音乐信息的字典
    NSMutableDictionary *playingInfoDict = [NSMutableDictionary dictionary];
    // 2、设置歌曲名
    if (sign) {
        [playingInfoDict setObject:sign forKey:MPMediaItemPropertyAlbumTitle];
    }
    // 设置歌手名
    if (signer) {
        [playingInfoDict setObject:signer forKey:MPMediaItemPropertyArtist];
    }
    // 3设置封面的图片
    if (image) {
        MPMediaItemArtwork *artwork = [[MPMediaItemArtwork alloc] initWithImage:image];
        [playingInfoDict setObject:artwork forKey:MPMediaItemPropertyArtwork];
    }
    
    // 4设置歌曲的总时长
    //    [playingInfoDict setObject:self.currentModel.detailDuration forKey:MPMediaItemPropertyPlaybackDuration];
    //音乐信息赋值给获取锁屏中心的nowPlayingInfo属性
    playingInfoCenter.nowPlayingInfo = playingInfoDict;
    // 5.开启远程交互
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
}



//锁屏时操作
- (void)remoteControlReceivedWithEvent:(UIEvent *)receivedEvent {
    if (receivedEvent.type == UIEventTypeRemoteControl) {
        switch (receivedEvent.subtype) {//判断是否为远程控制
                
            case UIEventSubtypeRemoteControlPause:
                // [[HYNEntertainmentController sharedInstance].streamer pause];
                [_streamer pause];
                break;
            case UIEventSubtypeRemoteControlStop:
                break;
            case UIEventSubtypeRemoteControlPlay:
                //[[HYNEntertainmentController sharedInstance].streamer play];
                [self resume];
                break;
            case UIEventSubtypeRemoteControlTogglePlayPause:
                break;
            case UIEventSubtypeRemoteControlNextTrack:
                break;
            case UIEventSubtypeRemoteControlPreviousTrack:
                break;
            default:
                break;
        }
    }
}



@end
