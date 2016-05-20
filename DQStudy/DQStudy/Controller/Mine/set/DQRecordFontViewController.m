//
//  DQRecordFontViewController.m
//  DQStudy
//
//  Created by youdingquan on 16/5/21.
//  Copyright © 2016年 youdingquan. All rights reserved.
//

#import "DQRecordFontViewController.h"

@interface DQRecordFontViewController ()
@property (weak, nonatomic) IBOutlet UILabel *fontLabel;
@property (weak, nonatomic) IBOutlet UISlider *slider;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *silderLeading;

@property (weak, nonatomic) IBOutlet UILabel *fontSize;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *fontLeading;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *fontWidth;

@end

@implementation DQRecordFontViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSNumber * number = [[NSUserDefaults standardUserDefaults] objectForKey:RECORD_FONTSIZE];
    self.fontLabel.font = [UIFont systemFontOfSize:number.floatValue];
    
    self.slider.value = (number.floatValue-10.0)/20.0;
    
    self.fontSize.text = [NSString stringWithFormat:@"%ld",number.integerValue];
    self.fontLeading.constant = (SCREEN_WIDTH - self.silderLeading.constant*2)*self.slider.value - self.fontWidth.constant/2.0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [USER_DEFAULTS setObject:@(self.slider.value*20.0+10.0) forKey:RECORD_FONTSIZE];
}

- (IBAction)valueChangeed:(UISlider *)sender {
    CGFloat size = sender.value*20.0+10.0;
    
    self.fontLabel.font = [UIFont systemFontOfSize:size];
    
    self.fontSize.text = [NSString stringWithFormat:@"%ld",(NSInteger)size];
    self.fontLeading.constant = (SCREEN_WIDTH - self.silderLeading.constant*2)*self.slider.value - self.fontWidth.constant/2.0;
}


@end
