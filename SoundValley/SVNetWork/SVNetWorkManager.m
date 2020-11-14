//
//  SVNetWorkManager.m
//  SoundValley
//
//  Created by apple on 2020/5/12.
//  Copyright © 2020 apple. All rights reserved.
//

#import "SVNetWorkManager.h"
#import "SVNetWork.h"


@implementation SVNetWorkManager
static SVNetWorkManager *manager = nil;
static dispatch_once_t onceToken;

+ (instancetype)sharedInstance {
    dispatch_once(&onceToken, ^{
        manager = [self new];
    });
    return manager;
}

// 获取分享页banner图
-(void)postBannerWithBlock:(block)block
{
    [[SVNetWork sharedManager] postJsonDataWithPath:@"/api/v1/shenggu/share/all.json" parameters:nil block:^(id  _Nonnull responseObject, NSError * _Nonnull error) {
        block(responseObject,error);
    }];
}
@end
