//
//  SVPlayerManager.h
//  SoundValley
//
//  Created by apple on 2020/5/14.
//  Copyright © 2020 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SVPlayerManager : NSObject
+ (instancetype)sharedInstance;

- (void)playMusicWithFilePath:(NSURL *)filePath;

// 播放
- (void)playMusicWithUrl:(NSString *)url soundID:(NSString *)soundId;

// 设置音量
- (void)setCustomVolume:(CGFloat)volume;

// 暂停
- (void)pause;

- (BOOL)isPlaying;

// 恢复
- (void)resume;

- (void)stopPlay;
@end

NS_ASSUME_NONNULL_END
