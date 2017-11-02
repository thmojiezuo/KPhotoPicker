//
//  MyPhotoCell.h
//  KPhotoPicker
//
//  Created by tenghu on 2017/10/27.
//  Copyright © 2017年 tenghu. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MyPhotoCell : UICollectionViewCell

@property(nonatomic, strong)UIImageView *photoView;

@property(nonatomic, assign)BOOL chooseStatus;

@property (nonatomic, copy) NSString *representedAssetIdentifier;

@property (nonatomic, strong) UIProgressView *progressView;

@property (nonatomic, assign) CGFloat progressFloat;

@property (nonatomic, strong) UIImageView *signImage;

@end
