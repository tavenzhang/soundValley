//
//  SVNetWork.h
//  SoundValley
//
//  Created by apple on 2020/5/12.
//  Copyright © 2020 apple. All rights reserved.
//

#import "AFHTTPSessionManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface SVNetWork : AFHTTPSessionManager
+ (instancetype)sharedManager;

-(void)postJsonDataWithPath:(NSString *)path parameters:(id _Nullable)parameters block:(void (^)(id responseObject, NSError *error))block;
@end

NS_ASSUME_NONNULL_END
