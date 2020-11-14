//
//  InitData.m
//  SoundValley
//
//  Created by apple on 2020/5/10.
//  Copyright © 2020 apple. All rights reserved.
//

#import "InitData.h"

@implementation InitData
+(NSArray *)getSceneListData{
    NSString *path = [[NSBundle mainBundle]pathForResource:@"voice" ofType:@"bundle"];
    return  @[@{@"icon":@"sg-small",
                            @"title":@"山谷",
                            @"bigIcon":@"sg-big",
                            @"voice":[[NSBundle bundleWithPath:path]pathForResource:@"山谷" ofType:@"mp3"],
                            @"index":@0},
                       @{@"icon":@"sl-small",
                         @"title":@"森林",
                         @"bigIcon":@"sl-big",
                         @"index":@1,
                         @"voice":[[NSBundle bundleWithPath:path]pathForResource:@"森林" ofType:@"mp3"]},
                       @{@"icon":@"hl-small",
                         @"title":@"河流",
                         @"bigIcon":@"hl-big",
                         @"index":@2,
                         @"voice":[[NSBundle bundleWithPath:path]pathForResource:@"河流" ofType:@"mp3"]},
                       @{@"icon":@"ht-small",
                         @"title":@"海滩",
                         @"bigIcon":@"ht-big",
                         @"index":@3,
                         @"voice":[[NSBundle bundleWithPath:path]pathForResource:@"海滩" ofType:@"mp3"]},
                       @{@"icon":@"hp-small",
                         @"title":@"湖泊",
                         @"bigIcon":@"hp-big",
                         @"index":@4,
                         @"voice":[[NSBundle bundleWithPath:path]pathForResource:@"湖泊" ofType:@"mp3"]},
                       @{@"icon":@"gl-small",
                         @"title":@"公路",
                         @"bigIcon":@"gl-big",
                         @"index":@5,
                         @"voice":[[NSBundle bundleWithPath:path]pathForResource:@"公路" ofType:@"mp3"]},
                       @{@"icon":@"yt-small",
                         @"title":@"雨天",
                         @"bigIcon":@"yt-big",
                         @"index":@6,
                         @"voice":[[NSBundle bundleWithPath:path]pathForResource:@"雨天" ofType:@"mp3"]},
                       @{@"icon":@"yd-small",
                         @"title":@"雨滴",
                         @"bigIcon":@"yd-big",
                         @"index":@7,
                         @"voice":[[NSBundle bundleWithPath:path]pathForResource:@"雨滴" ofType:@"mp3"]},
                       @{@"icon":@"sd-small",
                         @"title":@"水滴",
                         @"bigIcon":@"sd-big",
                         @"index":@8,
                         @"voice":[[NSBundle bundleWithPath:path]pathForResource:@"水滴" ofType:@"mp3"]},
                       @{@"icon":@"wq-small",
                         @"title":@"网球场",
                         @"bigIcon":@"wq-big",
                         @"index":@9,
                         @"voice":[[NSBundle bundleWithPath:path]pathForResource:@"网球场" ofType:@"mp3"]},
                       @{@"icon":@"ddsz-small",
                         @"title":@"滴答时钟",
                         @"bigIcon":@"ddsz-big",
                         @"index":@10,
                         @"voice":[[NSBundle bundleWithPath:path]pathForResource:@"嘀嗒时钟" ofType:@"mp3"]},
                       @{@"icon":@"ppq-small",
                         @"title":@"乒乓球",
                         @"bigIcon":@"ppq-big",
                         @"index":@11,
                         @"voice":[[NSBundle bundleWithPath:path]pathForResource:@"乒乓球" ofType:@"mp3"]},
                       @{@"icon":@"jpdz-small",
                         @"title":@"键盘",
                         @"bigIcon":@"jpdz-big",
                         @"index":@12,
                         @"voice":[[NSBundle bundleWithPath:path]pathForResource:@"键盘" ofType:@"mp3"]},
                       @{@"icon":@"qb-small",
                         @"title":@"铅笔",
                         @"bigIcon":@"qb-big",
                         @"index":@13,
                         @"voice":[[NSBundle bundleWithPath:path]pathForResource:@"铅笔" ofType:@"mp3"]}];
}

+(NSArray *)getAllSecond
{
  return  @[@(300), @(600), @(900), @(1200),
            @(1500),@(1800),@(2100),@(2400),
            @(2700),@(3000),@(3300),@(3600),
            @(3900),@(4200),@(4500),@(4800),
            @(5100),@(5400),@(5700),@(6000),
            @(6300),@(6600),@(6900),@(7200)];
}
@end
