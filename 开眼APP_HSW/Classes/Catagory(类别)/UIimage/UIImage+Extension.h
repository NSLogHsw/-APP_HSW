//
//  ATHttpSessionManager.m
//  yunEstate
//
//  Created by  677676  on 17/3/23.
//  Copyright © 2017年 艾腾软件. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface UIImage (Extension)
- (UIImage *)coreImageBlurNumber:(CGFloat)blur;
- (UIImage *)boxblurWithBlurNumber:(CGFloat)blur;
/**
 *  用颜色生成指定大小的图片
 */
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;
@end
