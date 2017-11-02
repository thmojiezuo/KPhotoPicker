//
//  NavView.h
//  KPhotoPicker
//
//  Created by tenghu on 2017/10/27.
//  Copyright © 2017年 tenghu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NavView : UIView

@property (nonatomic, copy) void(^navViewBack)();
@property (nonatomic, copy) void(^quitChooseBack)();

// 创建nav
-(void)createNavViewTitle:(NSString *)title;

@end
