//
//  Track.h
//  SoundValley
//
//  Created by apple on 2020/5/14.
//  Copyright © 2020 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DOUAudioFile.h"

NS_ASSUME_NONNULL_BEGIN

@interface Track : NSObject<DOUAudioFile>
@property (nonatomic, strong) NSString *artist;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSURL *audioFileURL;
@end

NS_ASSUME_NONNULL_END
