//
//  DQWelcomeViewController.m
//  DQStudy
//
//  Created by youdingquan on 16/5/1.
//  Copyright © 2016年 youdingquan. All rights reserved.
//

#import "DQWelcomeViewController.h"
#import "DQMainViewController.h"

@interface DQWelcomeViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *backImage;
@property (weak, nonatomic) IBOutlet UILabel *second;
@property (weak, nonatomic) IBOutlet UIButton *welcomeBtn;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *secondHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *welcomeHeight;

@property(nonatomic,strong)NSTimer * timer;
@end

@implementation DQWelcomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //back image
    self.backImage.contentMode = UIViewContentModeScaleAspectFill;
    NSString * backImage = [NSString stringWithFormat:@"%@/welcome.jpg",[[NSBundle mainBundle] pathForResource:@"Image" ofType:@"bundle"]];
    self.backImage.image = [UIImage imageWithContentsOfFile:backImage];
    
    //second
    self.second.backgroundColor = [UIColor whiteColor];
    self.second.layer.cornerRadius = self.secondHeight.constant/2.0;
    self.second.layer.masksToBounds = YES;
    [self addTimer];
    
    //welcome btn
    self.welcomeBtn.backgroundColor = [UIColor whiteColor];
    self.welcomeBtn.layer.cornerRadius = self.welcomeHeight.constant/2.0;
    self.welcomeBtn.layer.masksToBounds = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)welcomeClick:(id)sender {
    [self next];
}

#pragma mark -
#pragma mark next vc
-(void)next{
    if (self.timer.isValid) {
        [self.timer invalidate];
    }
    self.timer = nil;
    [UIApplication sharedApplication].keyWindow.rootViewController = [[DQMainViewController alloc] init];
}

#pragma mark -
#pragma mark add timer
-(void)addTimer{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(welcomeTimerSelector:) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSDefaultRunLoopMode];
    [self.timer fire];
}

-(void)welcomeTimerSelector:(NSTimer *)timer{
    static NSInteger time = 5;
    self.second.text = [NSString stringWithFormat:@"%lds",time];
    if (time == 0) {
        [self next];
    }
    time -= timer.timeInterval;
}

@end
