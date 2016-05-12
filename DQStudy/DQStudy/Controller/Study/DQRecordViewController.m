//
//  DQRecordViewController.m
//  DQStudy
//
//  Created by youdingquan on 16/5/2.
//  Copyright © 2016年 youdingquan. All rights reserved.
//

#import "DQRecordViewController.h"
#import "DQDetailModel.h"
#import "DQDetailDao.h"

//138,109,53 牛皮纸色

//199,237,204 护眼se

@interface DQRecordViewController ()
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textViewToBottom;
@property (weak, nonatomic) IBOutlet UILabel *titleLable;

@end

@implementation DQRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self configNav];
    [self addNotification];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc{
    [self removeNotification];
}

#pragma mark -
#pragma mark config UI

- (IBAction)backClick:(id)sender {
    [self quit];
}
- (IBAction)saveClick:(id)sender {
    if (![self.textView.text isEqualToString:self.model.detail]) {
        self.model.detail = self.textView.text;
        [DQDetailDao updateAtModel:self.model];
        [self quit];
    }
}
-(void)quit{
    if ([self.textView isFirstResponder]) {
        [self.textView resignFirstResponder];
    }
    
    [UIView animateKeyframesWithDuration:0.8 delay:0 options:UIViewKeyframeAnimationOptionLayoutSubviews animations:^{
        [UIView addKeyframeWithRelativeStartTime:0 relativeDuration:0.8 animations:^{
            self.view.transform = CGAffineTransformMakeTranslation(SCREEN_WIDTH, 0);
        }];
        [UIView addKeyframeWithRelativeStartTime:0.8 relativeDuration:0.1 animations:^{
            self.view.transform = CGAffineTransformMakeTranslation(SCREEN_WIDTH-50, 0);
        }];
        [UIView addKeyframeWithRelativeStartTime:0.9 relativeDuration:0.1 animations:^{
            self.view.transform = CGAffineTransformMakeTranslation(SCREEN_WIDTH, 0);
        }];
    } completion:^(BOOL finished) {
        [self.view removeFromSuperview];
        [self removeFromParentViewController];
    }];
}


-(void)configNav{
    self.textView.text  = self.model.detail;
    self.titleLable.text = self.model.name;
}


#pragma mark -
#pragma mark notification

-(void)addNotification{
    //监听通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showKeyBoard:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hideKeyBoard:) name:UIKeyboardWillHideNotification object:nil];
}
-(void)removeNotification{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

-(void)hideKeyBoard:(NSNotification *)notify
{
    self.textViewToBottom.constant = 0;
}

-(void)showKeyBoard:(NSNotification *)notifty
{
    NSDictionary *userInfo = notifty.userInfo;
    NSValue *value = userInfo[UIKeyboardFrameEndUserInfoKey];
    
    self.textViewToBottom.constant = [value CGRectValue].size.height+10;
}

@end
