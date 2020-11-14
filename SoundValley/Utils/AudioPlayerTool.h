//
//  AudioPlayerTool.h
//  VideoWindow
//
//  Created by fangliguo on 2017/4/19.
//  Copyright © 2017年 cudatec. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FSAudioStream.h>
@interface AudioPlayerTool : NSObject

+(AudioPlayerTool *)sharePlayerTool;
- (FSAudioStream *)playerInit;
- (void)stop;
- (void)pause;
- (void)play;
@property (nonatomic, strong) NSDictionary *audioDic;
@end
