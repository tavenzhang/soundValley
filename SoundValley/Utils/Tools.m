//
//  Tools.m
//  SoundValley
//
//  Created by apple on 2020/5/7.
//  Copyright © 2020 apple. All rights reserved.
//

#import "Tools.h"

@implementation Tools
+(NSString *)getSecondsStr:(NSInteger)timeInteger
{
     NSInteger hours =  timeInteger / 3600;
     NSInteger secondNum = timeInteger % 60;
     NSInteger minuteNum = (timeInteger / 60) % 60;
     NSString *hoursStr = [NSString stringWithFormat:@"%@", @(hours)];
     NSString *secondStr = secondNum < 10 ? [NSString stringWithFormat:@"0%@", @(secondNum)] : @(secondNum).stringValue;
     NSString *minuteStr = minuteNum < 10 ? [NSString stringWithFormat:@"0%@", @(minuteNum)] : @(minuteNum).stringValue;
     NSString *timeStr = hours > 0 ? [NSString stringWithFormat:@"%@:%@:%@",hoursStr,minuteStr,secondStr] : [NSString stringWithFormat:@"%@:%@",minuteStr,secondStr];
    return timeStr;
}
@end
