//
//  ViewController.m
//  KPhotoPicker
//
//  Created by tenghu on 2017/10/27.
//  Copyright © 2017年 tenghu. All rights reserved.
//

#import "ViewController.h"
#import "KPhotoPicker.h"
#import "DynamicScrollView.h"
#import "VPImageCropperViewController.h"
#import "UIImage+FixOrientation.h"

#define phoneScale [UIScreen mainScreen].bounds.size.width/720.0

typedef NS_ENUM(NSInteger, IMGStandard) {
    
    iconIMG = 0,
    IDCardIMG = 1,
    IMG43 = 2
};

@interface ViewController ()<VPImageCropperDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
     NSMutableArray *_photosArr;
}

// 添加图片按钮
@property(nonatomic,strong)  DynamicScrollView *photoScrollView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blackColor];
    
    _photosArr = [[NSMutableArray alloc] init];
    
    //添加图片
    _photoScrollView = [[DynamicScrollView alloc] initWithFrame:CGRectMake(10,  100, [UIScreen mainScreen].bounds.size.width-20, 70) withImages:nil];
    [_photoScrollView addTagert:self andExtrendAction:@selector(addPic:) tag:600 andImage:nil];
    
  //  __weak typeof(self)weakSelf = self;
    [_photoScrollView setSelectedAtIndex:^(int index) {
        
       // [weakSelf getPhotoS:index];
        
    }];
    
    [self.view addSubview:_photoScrollView];
    
}
#pragma mark 上传票据
- (void)addPic:(UIButton*)sender {
    
    [self.view endEditing:YES];
    
    
    if([self getSelectedImageCountWithTag:sender.tag] >=5){
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"图片数量不能大于五张" message:nil delegate:self cancelButtonTitle:@"知道了" otherButtonTitles: nil];
        [alert show];
        
        return;
    }
    UIActionSheet * ac = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"相机",@"相册", nil];
    
    ac.tag = sender.tag;
    [ac setDelegate:self];
    [ac showInView:self.view];
    
}
-(NSInteger) getSelectedImageCountWithTag:(NSInteger) tag{
    
    return self.photoScrollView?self.photoScrollView.imageViews.count:0;
    
}
- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 2)
    {
        return;
    }
    if(buttonIndex == 0){
        
        UIImagePickerController *picker = [[UIImagePickerController alloc]init];
        [picker setSourceType: (buttonIndex == 0 && [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera ])? UIImagePickerControllerSourceTypeCamera:UIImagePickerControllerSourceTypePhotoLibrary];
        picker.delegate = self;
        picker.view.tag = actionSheet.tag;
        [self presentViewController:picker animated:YES completion:nil];
    }
    else if (buttonIndex == 1){
        
        
        [self mutiPics:actionSheet.tag];
    }
}
-(void) mutiPics:(NSInteger) tag{
   
    KPhotoPicker *photoVC = [[KPhotoPicker alloc] init];
    photoVC.selectPhotoOfMax = 5;
    
    __weak typeof(self)weakSelf = self;
    [photoVC setSelectPhotosBack:^(NSMutableArray *phostsArr) {
        [_photosArr addObjectsFromArray:phostsArr];
 
        [weakSelf.photoScrollView setImagesNow:phostsArr isORG:NO];
        if(weakSelf.photoScrollView.imageViews.count == 5){
            weakSelf.photoScrollView.justView = YES;
        }
        
    }];
    [self presentViewController:photoVC animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:^{
        
        VPImageCropperViewController * vpCrop = [[VPImageCropperViewController alloc]initWithImage:[UIImage fixOrientation:(UIImage *)[info objectForKey:@"UIImagePickerControllerOriginalImage"]] cropFrame:[self standardizedIconIMGRectWithType:IMG43] limitScaleRatio:3.0f];
        vpCrop.tag = picker.view.tag;

        vpCrop.delegate = self;
        [self presentViewController:vpCrop animated:YES completion:nil];
        
        
//        UIImage * edited = (UIImage *)[info objectForKey:@"UIImagePickerControllerOriginalImage"];
        //  edited =  [UIImage fixOrientation:edited];
//        [_photosArr addObject:edited];
//
//        if (picker.view.tag == 600) {
//            [self.photoScrollView setImagesNow:_photosArr isORG:NO];
//            if(self.photoScrollView.imageViews.count == 5){
//                self.photoScrollView.justView = YES;
//            }
//        }
        
        
    }];
    
}
-(CGRect)standardizedIconIMGRectWithType:(IMGStandard) imgType
{
    CGFloat ratio = 1;
    
    switch (imgType) {
            
        case iconIMG:
        {
            ratio = 140.0f/105.0f;
        }
            break;
            
        case IDCardIMG:
        {
            ratio = 220.0f/340.0f;
        }
            break;
        case IMG43:{
            
            ratio = 300/400.0f;
        }
            break;
        default:
            
            break;
    }
    
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat hight = [UIScreen mainScreen].bounds.size.height;
    
    return CGRectMake(0.1f * width, hight / 2.0f - width * 0.8f * ratio / 2.0f, width * 0.8f, width * 0.8f * ratio);
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
}
- (void)imageCropper:(VPImageCropperViewController *)cropperViewController didFinished:(UIImage *)editedImage
{
    UIImage * edited =  [UIImage imageWithCGImage:editedImage.CGImage scale:1 orientation:UIImageOrientationUp];
    
    [_photosArr removeAllObjects];
    
    [_photosArr addObject:edited];
    
    switch (cropperViewController.tag) {
        case 600:
        {
            [self.photoScrollView setImagesNow:_photosArr isORG:NO];
            if(self.photoScrollView.imageViews.count == 5){
                self.photoScrollView.justView = YES;
            }
        }
            break;
        default:
            
            break;
    }
    [cropperViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)imageCropperDidCancel:(VPImageCropperViewController *)cropperViewController
{
    [cropperViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
