//
//  DQQRCodeScanViewController.m
//  DQStudy
//
//  Created by youdingquan on 16/5/12.
//  Copyright © 2016年 youdingquan. All rights reserved.
//

#import "DQQRCodeScanViewController.h"
#import <AVFoundation/AVFoundation.h>

#import "DQQRcodeLayer.h"

@interface DQQRCodeScanViewController ()<AVCaptureMetadataOutputObjectsDelegate>
//摄像设备
@property (strong,nonatomic)AVCaptureDevice * device;
//输入流
@property (strong,nonatomic)AVCaptureDeviceInput * input;
//输出流
@property (strong,nonatomic)AVCaptureMetadataOutput * output;
//输入输出的中间桥梁
@property (strong,nonatomic)AVCaptureSession * session;
//图层
@property (strong,nonatomic)AVCaptureVideoPreviewLayer * preview;


@property (weak, nonatomic) IBOutlet UIButton *turnTorch;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *turnTorchWidth;

@end

@implementation DQQRCodeScanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
    
    self.turnTorch.layer.cornerRadius = self.turnTorchWidth.constant/2.0;
    self.turnTorch.layer.borderColor = [UIColor whiteColor].CGColor;
    self.turnTorch.layer.borderWidth = 2;
    self.turnTorch.layer.masksToBounds = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (self.session) {
        if ([self.session respondsToSelector:@selector(startRunning)]) {
            [self.session startRunning];
        }
    }
}

#pragma mark -
#pragma mark config data
-(void)loadData{
    // Device
    _device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if (_device) {
        // Input
        _input = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:nil];
        
        // Output
        _output = [[AVCaptureMetadataOutput alloc]init];
        [_output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
        
        // Session
        _session = [[AVCaptureSession alloc]init];
        [_session setSessionPreset:AVCaptureSessionPresetHigh];
        if ([_session canAddInput:self.input])
        {
            [_session addInput:self.input];
        }
        if ([_session canAddOutput:self.output])
        {
            [_session addOutput:self.output];
        }
        
        // 条码类型 AVMetadataObjectTypeQRCode
        _output.metadataObjectTypes =@[AVMetadataObjectTypeQRCode,AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code];
        
        // Preview
        _preview =[AVCaptureVideoPreviewLayer layerWithSession:_session];
        _preview.videoGravity =AVLayerVideoGravityResizeAspectFill;
        _preview.frame =CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        [self.view.layer insertSublayer:_preview atIndex:0];
        
        
        //设置扫描区域，上，左，高，宽(0,0,1,1)
        CGFloat width = 200.0;
        CGFloat x = (SCREEN_WIDTH - width)/2.0;
        CGFloat y = (SCREEN_HEIGHT - width)/2.0;
        
        CGRect rect = CGRectMake(y/SCREEN_HEIGHT, x/SCREEN_WIDTH, width/SCREEN_HEIGHT, width/SCREEN_WIDTH);
        [_output setRectOfInterest:rect];
        
        //初始化界面
        [self configUIWithShowRect:CGRectMake(x, y, width, width)];
        
        // Start
        if ([_session respondsToSelector:@selector(startRunning)]) {
            [_session startRunning];
        }

    }
    
}

#pragma mark -
#pragma mark configUI
-(void)configUIWithShowRect:(CGRect)rect{
    
    //导航栏标题
    self.navigationItem.title = @"二维码／条码";
    
    //设置扫描框
    DQQRcodeLayer * backLayer = [[DQQRcodeLayer alloc] init];
    backLayer.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    backLayer.showRect = rect;
    [backLayer setNeedsDisplay];
    [self.view.layer addSublayer:backLayer];
    //设置提示文字
    UILabel * promptLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, rect.origin.y + rect.size.height +20, SCREEN_WIDTH, 40)];
    promptLabel.textAlignment = NSTextAlignmentCenter;
    promptLabel.text = @"将二维码／条码放入框内，即可自动扫描";
    [promptLabel setTextColor:[UIColor whiteColor]];
    [self.view addSubview:promptLabel];
}

#pragma mark -
#pragma mark AVCaptureMetadataOutputObjectsDelegate

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    NSString *stringValue;
    if ([metadataObjects count] >0)
    {
        //停止扫描
        [_session stopRunning];
        
        [self.turnTorch setTitle:@"开灯" forState:UIControlStateNormal];
        
        AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex:0];
        stringValue = metadataObject.stringValue;
        NSLog(@"%@",stringValue);
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"扫描结果" message:stringValue preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [_session startRunning];
        }]];
        if ([stringValue hasPrefix:@"http"]) {
            [alert addAction:[UIAlertAction actionWithTitle:@"打开" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:stringValue]];
            }]];
        }
        [self presentViewController:alert animated:YES completion:nil];
    }
}

#pragma mark -
#pragma mark 闪光灯的开启

- (IBAction)turnTorch:(UIButton *)sender {
    Class captureDeviceClass = NSClassFromString(@"AVCaptureDevice");
    if (captureDeviceClass != nil) {
        AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        if ([device hasTorch] && [device hasFlash]){
            [device lockForConfiguration:nil];
            if ([sender.titleLabel.text isEqualToString:@"开灯"]) {
                [device setTorchMode:AVCaptureTorchModeOn];
                [device setFlashMode:AVCaptureFlashModeOn];
                [sender setTitle:@"关灯" forState:UIControlStateNormal];
            } else {
                [device setTorchMode:AVCaptureTorchModeOff];
                [device setFlashMode:AVCaptureFlashModeOff];
                [sender setTitle:@"开灯" forState:UIControlStateNormal];
            }
            [device unlockForConfiguration];
        }
    }
}


@end
