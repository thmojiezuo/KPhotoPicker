//
//  UIImage+FixOrientation.h
//  KPhotoPicker
//
//  Created by tenghu on 2017/10/27.
//  Copyright © 2017年 tenghu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (FixOrientation)

+ (UIImage *)fixOrientation:(UIImage *)aImage;
+ (UIImage *)image:(UIImage *)image rotation:(UIImageOrientation)orientation;


@end
