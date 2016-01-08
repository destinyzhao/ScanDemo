//
//  UIImage+CreateQrImage.h
//  ScanDemo
//
//  Created by Alex on 16/1/8.
//  Copyright © 2016年 Alex. All rights reserved.
//

/**
 *  生成二维码图片
 *
 *  @param CreateQrImage
 *
 *  @return 
 */

#import <UIKit/UIKit.h>

@interface UIImage (CreateQrImage)

/**
 *  生成二维码
 *
 *  @param qrStr 生成字符串
 *
 *  @return 二维码图片
 */

+ (UIImage *)createRRcode:(NSString *)qrStr;
/**
 *  改变二维码大小
 *
 *  @param image CIImage
 *  @param size  size
 *
 *  @return 放大后的图片
 */
+ (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat) size;

@end
