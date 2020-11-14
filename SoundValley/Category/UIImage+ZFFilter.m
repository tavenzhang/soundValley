//
//  UIImage+ZFFilter.m
//  SoundValley
//
//  Created by apple on 2020/5/10.
//  Copyright © 2020 apple. All rights reserved.
//

#import "UIImage+ZFFilter.h"
#import <Accelerate/Accelerate.h>

@implementation UIImage (ZFFilter)
+ (UIImage *)filterWith:(UIImage *)image andRadius:(CGFloat)radius{
    
    CIImage *inputImage = [[CIImage alloc] initWithCGImage:image.CGImage];
    
    CIFilter *affineClampFilter = [CIFilter filterWithName:@"CIAffineClamp"];
    CGAffineTransform xform = CGAffineTransformMakeScale(1.0, 1.0);
    [affineClampFilter setValue:inputImage forKey:kCIInputImageKey];
    [affineClampFilter setValue:[NSValue valueWithBytes:&xform
                                               objCType:@encode(CGAffineTransform)]
                         forKey:@"inputTransform"];
    
    CIImage *extendedImage = [affineClampFilter valueForKey:kCIOutputImageKey];
    
    CIFilter *blurFilter =
    [CIFilter filterWithName:@"CIGaussianBlur"];
    [blurFilter setValue:extendedImage forKey:kCIInputImageKey];
    [blurFilter setValue:@(radius) forKey:@"inputRadius"];
    
    CIImage *result = [blurFilter valueForKey:kCIOutputImageKey];
    
    CIContext *ciContext = [CIContext contextWithOptions:nil];
    
    CGImageRef cgImage = [ciContext createCGImage:result fromRect:inputImage.extent];
    
    UIImage *uiImage = [UIImage imageWithCGImage:cgImage];
    CGImageRelease(cgImage);
    
    return uiImage;
}

+(UIImage *)boxblurImage:(UIImage *)image withBlurNumber:(CGFloat)blur
 {
     if (blur < 0.f || blur > 1.f) {
        blur = 0.5f;
     }
     int boxSize = (int)(blur * 40);
     boxSize = boxSize - (boxSize % 2) + 1;
     CGImageRef img = image.CGImage;
     vImage_Buffer inBuffer, outBuffer;
     vImage_Error error;
     void *pixelBuffer;
     //从CGImage中获取数据
     CGDataProviderRef inProvider = CGImageGetDataProvider(img);
     CFDataRef inBitmapData = CGDataProviderCopyData(inProvider);
     //设置从CGImage获取对象的属性
     inBuffer.width = CGImageGetWidth(img);
     inBuffer.height = CGImageGetHeight(img);
     inBuffer.rowBytes = CGImageGetBytesPerRow(img);
     inBuffer.data = (void*)CFDataGetBytePtr(inBitmapData);
     pixelBuffer = malloc(CGImageGetBytesPerRow(img) * CGImageGetHeight(img));
     if(pixelBuffer == NULL)
         NSLog(@"No pixelbuffer");
     outBuffer.data = pixelBuffer;
     outBuffer.width = CGImageGetWidth(img);
     outBuffer.height = CGImageGetHeight(img);
     outBuffer.rowBytes = CGImageGetBytesPerRow(img);
     error = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
     if (error) {
           NSLog(@"error from convolution %ld", error);
     }
     CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
     CGContextRef ctx = CGBitmapContextCreate( outBuffer.data, outBuffer.width, outBuffer.height, 8, outBuffer.rowBytes, colorSpace, kCGImageAlphaNoneSkipLast);
     CGImageRef imageRef = CGBitmapContextCreateImage (ctx);
     UIImage *returnImage = [UIImage imageWithCGImage:imageRef];
     //clean up CGContextRelease(ctx);
     CGColorSpaceRelease(colorSpace);
     free(pixelBuffer);
     CFRelease(inBitmapData);
     CGColorSpaceRelease(colorSpace);
     CGImageRelease(imageRef);
     return returnImage;
}
@end
