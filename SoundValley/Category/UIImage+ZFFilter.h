//
//  UIImage+ZFFilter.h
//  SoundValley
//
//  Created by apple on 2020/5/10.
//  Copyright © 2020 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (ZFFilter)
/**
 *  图片滤镜处理
 *
 *  @param image  UIImage类型
 *  @param radius 虚化参数
 *
 *  @return 虚化后的UIImage
 */
+ (UIImage *)filterWith:(UIImage *)image andRadius:(CGFloat)radius;

/**
*  图片滤镜处理
*
*  @param image  UIImage类型
*  @param radius 虚化参数
*
*  @return 虚化后的UIImage
*/
+(UIImage *)boxblurImage:(UIImage *)image withBlurNumber:(CGFloat)blur;

@end

NS_ASSUME_NONNULL_END
