//
//  SVNetWorkManager.h
//  SoundValley
//
//  Created by apple on 2020/5/12.
//  Copyright © 2020 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^block)(id responseObject, NSError *error);
@interface SVNetWorkManager : NSObject
+ (instancetype)sharedInstance;

// 获取分享页banner图
-(void)postBannerWithBlock:(block)block;

@end

NS_ASSUME_NONNULL_END
