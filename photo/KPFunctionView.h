//
//  KPFunctionView.h
//  KPhotoPicker
//
//  Created by tenghu on 2017/10/27.
//  Copyright © 2017年 tenghu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Photos/Photos.h>
#import <AssetsLibrary/AssetsLibrary.h>

typedef void(^finishChooseBlock)(NSMutableArray *myChoosePhotoArr);
typedef void(^PhotoKitBlock)(PHFetchResult *allPhotos);
typedef void(^ALAssetsLibraryBlock)(ALAssetsGroup* group);

typedef void(^HandlerBlock)(double progress);
typedef void(^ManagerBlock)(UIImage *result);

@interface KPFunctionView : UIView

//所选择的图片数组
+(void)finishChoosePhotos:(finishChooseBlock)block chooseArray:(NSMutableArray *)chooseArray;
// 高版本使用PhotoKit框架获取图片
+(void)getHeightVersionAllPhotos:(PhotoKitBlock)photosBlock;
// 低版本使用ALAssetsLibrary框架获取图片
+(void)getLowVersionAllPhotos:(ALAssetsLibraryBlock)photoGroupBlock;
// 高版本使用PhotoKit框架选择图片
+(void)getChoosePicPHImageManager:(HandlerBlock)handler manager:(ManagerBlock)manager asset:(PHAsset *)asset viewSize:(CGSize)viewSize;
// 列表中按钮点击动画效果
+(void)shakeToShow:(UIImageView *)button;

@end
