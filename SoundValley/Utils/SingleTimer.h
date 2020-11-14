//
//  SingleTimer.h
//  SoundValley
//
//  Created by apple on 2020/5/16.
//  Copyright © 2020 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
typedef void (^TimeoutCallBack)(NSString *text);
typedef void (^TimeinCallBack)(void);

@interface SingleTimer : NSObject
@property (nonatomic,assign) NSInteger    timeRange;             //计时时间
@property (nonatomic,assign) NSInteger    timeRest;              //计时时间
@property (nonatomic ,copy)  TimeinCallBack       TimeinCall;  //在计时时调用
@property (nonatomic ,copy)  TimeoutCallBack      TimeoutCall; //在计时结束时调用
@property (nonatomic,strong) dispatch_source_t   timer;         //计时器

+ (id)sharedTimerManager;
- (void) startTimer;
- (void) pauseTimer;
- (void) resumeTimer;
- (void) stopTimer;
@end

NS_ASSUME_NONNULL_END
