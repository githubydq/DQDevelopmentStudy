//
//  DQRecordBGColorViewController.m
//  DQStudy
//
//  Created by youdingquan on 16/5/21.
//  Copyright © 2016年 youdingquan. All rights reserved.
//

#import "DQRecordBGColorViewController.h"

@interface DQRecordBGColorViewController ()
@property (weak, nonatomic) IBOutlet UISlider *redSlider;
@property (weak, nonatomic) IBOutlet UISlider *greenSlider;
@property (weak, nonatomic) IBOutlet UISlider *blueSlider;

@property (weak, nonatomic) IBOutlet UITextField *redText;
@property (weak, nonatomic) IBOutlet UITextField *greenText;
@property (weak, nonatomic) IBOutlet UITextField *blueText;
@end

@implementation DQRecordBGColorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    NSArray * array = [USER_DEFAULTS objectForKey:RECORD_BGCOLOR];
    CGFloat red = [array[0] floatValue];
    CGFloat green = [array[1] floatValue];
    CGFloat blue = [array[2] floatValue];
    self.redText.text = [NSString stringWithFormat:@"%ld",(NSInteger)red];
    self.greenText.text = [NSString stringWithFormat:@"%ld",(NSInteger)green];
    self.blueText.text = [NSString stringWithFormat:@"%ld",(NSInteger)blue];
    self.redSlider.value = red/255.0;
    self.greenSlider.value = green/255.0;
    self.blueSlider.value = blue/255.0;
    [self colorChangedRed:red/255.0 Green:green/255.0 Blue:blue/255.0];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [USER_DEFAULTS setObject:@[@(self.redSlider.value*255),@(self.greenSlider.value*255),@(self.blueSlider.value*255)] forKey:RECORD_BGCOLOR];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark 颜色改变
-(void)colorChangedRed:(CGFloat)red Green:(CGFloat)green Blue:(CGFloat)blue{
    self.view.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
}

- (IBAction)redChanged:(UISlider *)sender {
    NSInteger red = sender.value*255.0;
    self.redText.text = [NSString stringWithFormat:@"%ld",red];
    [self colorChangedRed:self.redSlider.value Green:self.greenSlider.value Blue:self.blueSlider.value];
}
- (IBAction)greenChanged:(id)sender {
    UISlider * slider = (UISlider *)sender;
    NSInteger green = slider.value*255.0;
    self.greenText.text = [NSString stringWithFormat:@"%ld",green];
    [self colorChangedRed:self.redSlider.value Green:self.greenSlider.value Blue:self.blueSlider.value];
}
- (IBAction)blueChanged:(UISlider *)sender {
    NSInteger blue = sender.value*255.0;
    self.blueText.text = [NSString stringWithFormat:@"%ld",blue];
    [self colorChangedRed:self.redSlider.value Green:self.greenSlider.value Blue:self.blueSlider.value];
}

#pragma mark -
#pragma mark button click
- (IBAction)btn1:(id)sender {
    self.redSlider.value = 199.0/255.0;
    self.greenSlider.value = 237.0/255.0;
    self.blueSlider.value = 204.0/255.0;
    self.redText.text = @"199";
    self.greenText.text = @"237";
    self.blueText.text = @"204";
    [self colorChangedRed:self.redSlider.value Green:self.greenSlider.value Blue:self.blueSlider.value];
}
- (IBAction)btn2:(id)sender {
    self.redSlider.value = 138.0/255.0;
    self.greenSlider.value = 109.0/255.0;
    self.blueSlider.value = 53.0/255.0;
    self.redText.text = @"138";
    self.greenText.text = @"109";
    self.blueText.text = @"53";
    [self colorChangedRed:self.redSlider.value Green:self.greenSlider.value Blue:self.blueSlider.value];
}
- (IBAction)btn3:(id)sender {
    self.redSlider.value = 255.0/255.0;
    self.greenSlider.value = 255.0/255.0;
    self.blueSlider.value = 255.0/255.0;
    self.redText.text = @"255";
    self.greenText.text = @"255";
    self.blueText.text = @"255";
    [self colorChangedRed:self.redSlider.value Green:self.greenSlider.value Blue:self.blueSlider.value];
}


#pragma mark -
#pragma mark bg tap
- (IBAction)bgTapClick:(id)sender {
    [self.redText resignFirstResponder];
    [self.greenText resignFirstResponder];
    [self.blueText resignFirstResponder];
}
@end
