//
//  AudioPlayerTool.m
//  VideoWindow
//
//  Created by fangliguo on 2017/4/19.
//  Copyright © 2017年 cudatec. All rights reserved.
//

#import "AudioPlayerTool.h"


@interface AudioPlayerTool()
@property (nonatomic, strong) FSAudioStream *audioStream;

@end

@implementation AudioPlayerTool
+(AudioPlayerTool *)sharePlayerTool{
    static AudioPlayerTool *single;
    static dispatch_once_t oneToken;
    dispatch_once(&oneToken,^{
        single = [[AudioPlayerTool alloc] init];
        
    });
    return single;
}

- (FSAudioStream *)playerInit{
    _audioStream=[[FSAudioStream alloc]init];
    // 设置声音
    [_audioStream setVolume:1];
    return _audioStream;
}

- (void)stop{
    [_audioStream stop];
}

-(void)pause{
    [_audioStream pause];
}

-(void)play
{
    [_audioStream play];

}
@end
