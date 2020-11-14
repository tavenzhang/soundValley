//
//  LSMacros.h
//  LightSleepPro
//
//  Created by 徐莹 on 2019/5/20.
//  Copyright © 2019 lightsleep. All rights reserved.
//

#ifndef LSMacros_h
#define LSMacros_h

#define APPID @"1486595434"


#define CURRENT_TIME @"CurrentTime"
#define IS_FIRSTLAUNCH @"isFirstLaunch"
#define IS_AUTOPLAYAUDIO @"ISAutoPlay"
#define IS_AGREE @"Agree_Privacy"


#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

#define Font(x) [UIFont systemFontOfSize:x]
#define ScaleFit(x) (SCREEN_WIDTH/375) * (x)
#define WEAKSELF typeof(self) __weak weakSelf = self

//判断是否是ipad
#define isPad ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
//判断iPhone5系列
#define kiPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
//判断iPhone6 6s 7系列
#define kiPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
//判断iPhone6p 6sp 7p系列
#define kiPhone6Plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
//判断iPhoneX，Xs（iPhoneX，iPhoneXs）
#define IS_IPHONE_X ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
//判断iPhoneXr
#define IS_IPHONE_Xr ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(828, 1792), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
//判断iPhoneXsMax
#define IS_IPHONE_Xs_Max ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size)&& !isPad : NO)

#define IS_IPhoneXAll (IS_IPHONE_X == YES || IS_IPHONE_Xr == YES || IS_IPHONE_Xs_Max == YES)

#define LS_HEADER_BAR_HEIGHT(vc) (LS_STATUS_BAR_HEIGHT + LS_NAVIGATION_BAR_HEIGHT(vc))

#define LS_NAVIGATION_BAR_HEIGHT(vc) (vc.navigationController.navigationBar ? vc.navigationController.navigationBar.frame.size.height : 44.0)

#define LS_STATUS_BAR_HEIGHT [[UIApplication sharedApplication] statusBarFrame].size.height

//状态栏高度
#define kSTATUS_BAR_HEIGHT_ ([[UIApplication sharedApplication] statusBarFrame].size.height)
//NavBar高度
#define kNAVIGATION_BAR_HEIGHT_ (self.navigationController.navigationBar.frame.size.height)
//状态栏 ＋ 导航栏 高度
#define kSTATUS_AND_NAVIGATION_HEIGHT ((kSTATUS_BAR_HEIGHT_) + (kNAVIGATION_BAR_HEIGHT_))

#define HEXCOLOR(hexValue) [UIColor colorWithRed:((CGFloat)((hexValue & 0xFF0000) >> 16))/255.0 green:((CGFloat)((hexValue & 0xFF00) >> 8))/255.0 blue:((CGFloat)(hexValue & 0xFF))/255.0 alpha:1.0]

#define HEXACOLOR(hexValue, alphaValue) [UIColor colorWithRed:((CGFloat)((hexValue & 0xFF0000) >> 16))/255.0 green:((CGFloat)((hexValue & 0xFF00) >> 8))/255.0 blue:((CGFloat)(hexValue & 0xFF))/255.0 alpha:(alphaValue)]
#define RGB(a,b,c,d) [UIColor colorWithRed:a/255.0f green:b/255.0f blue:c/255.0f alpha:d]
#endif /* LSMacros_h */

