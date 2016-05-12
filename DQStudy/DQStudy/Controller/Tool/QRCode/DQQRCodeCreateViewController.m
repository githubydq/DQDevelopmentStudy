//
//  DQQRCodeCreateViewController.m
//  DQStudy
//
//  Created by youdingquan on 16/5/13.
//  Copyright © 2016年 youdingquan. All rights reserved.
//

#import "DQQRCodeCreateViewController.h"

@interface DQQRCodeCreateViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *QRcodeImage;
@property (weak, nonatomic) IBOutlet UITextField *textField;

@property (weak, nonatomic) IBOutlet UIButton *start;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *startWidth;
@end

@implementation DQQRCodeCreateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.start.layer.cornerRadius = self.startWidth.constant/2.0;
    self.start.layer.borderColor = [UIColor blackColor].CGColor;
    self.start.layer.borderWidth = 2;
    self.start.layer.masksToBounds = YES;
    
    [self.QRcodeImage setImage:[self createQRCodeWith:@""]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)strart:(id)sender {
    [self.QRcodeImage setImage:[self createQRCodeWith:self.textField.text]];
}
- (IBAction)backClick:(id)sender {
    [self.textField resignFirstResponder];
}


-(UIImage *)createQRCodeWith:(NSString * )str{
    // 1. 实例化二维码滤镜
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    
    // 2. 恢复滤镜的默认属性
    [filter setDefaults];
    
    // 3. 将字符串转换成
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    
    // 4. 通过KVO设置滤镜inputMessage数据
    [filter setValue:data forKey:@"inputMessage"];
    
    // 5. 获得滤镜输出的图像
    CIImage *outputImage = [filter outputImage];
    
    // 6. 将CIImage转换成UIImage，并放大显示
    return [self createNonInterpolatedUIImageFormCIImage:outputImage size:200];
//    return [UIImage imageWithCIImage:outputImage];
}

- (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)ciImage size:(CGFloat)widthAndHeight
{
    CGRect extentRect = CGRectIntegral(ciImage.extent);
    CGFloat scale = MIN(widthAndHeight / CGRectGetWidth(extentRect), widthAndHeight / CGRectGetHeight(extentRect));
    
    // 1.创建bitmap;
    size_t width = CGRectGetWidth(extentRect) * scale;
    size_t height = CGRectGetHeight(extentRect) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    
    CIContext *context = [CIContext contextWithOptions:nil];
    
    CGImageRef bitmapImage = [context createCGImage:ciImage fromRect:extentRect];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extentRect, bitmapImage);
    
    // 保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    
    //return [UIImage imageWithCGImage:scaledImage]; // 黑白图片
    return [UIImage imageWithCGImage:scaledImage];
}
@end
