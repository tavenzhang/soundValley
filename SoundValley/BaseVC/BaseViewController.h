//
//  BaseViewController.h
//  SoundValley
//
//  Created by apple on 2020/5/1.
//  Copyright © 2020 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseViewController : UIViewController
// 设置左导航栏
-(void)setLeftNavBar:(NSString *)leftImage;
// 设置右导航栏
-(void)setRightNavBar:(NSString *)rightImage;
@end

NS_ASSUME_NONNULL_END
