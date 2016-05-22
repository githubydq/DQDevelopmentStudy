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

#import <MBProgressHUD.h>

//138,109,53 牛皮纸色

//199,237,204 护眼se

@interface DQRecordViewController ()
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textViewToBottom;

@end

@implementation DQRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self configUI];
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

-(void)configUI{
    self.navigationItem.title = self.model.name;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(recordRightClick)];
    
    self.textView.text  = self.model.detail;
    NSArray * array = [USER_DEFAULTS objectForKey:RECORD_BGCOLOR];
    self.textView.backgroundColor = [UIColor colorWithRed:[array[0] floatValue]/255.0 green:[array[1] floatValue]/255.0 blue:[array[2] floatValue]/255.0 alpha:1.0];
    self.textView.font = [UIFont systemFontOfSize:[[USER_DEFAULTS objectForKey:RECORD_FONTSIZE] floatValue]];
}

-(void)recordRightClick{
    MBProgressHUD * hub = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hub.mode = MBProgressHUDModeText;
    if (![self.textView.text isEqualToString:self.model.detail]) {
        self.model.detail = self.textView.text;
        if ([DQDetailDao updateAtModel:self.model]) {
            hub.labelText = @"保存成功";
        }else{
            hub.labelText = @"保存失败";
        }
        
    }else{
        hub.labelText = @"没有修改";
    }
    [hub show:YES];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [hub hide:YES];
    });
}

/**
 * 该方法废弃
 */
-(void)quit{
    if ([self.textView isFirstResponder]) {
        [self.textView resignFirstResponder];
    }
    
    [UIView animateKeyframesWithDuration:0.5 delay:0 options:UIViewKeyframeAnimationOptionLayoutSubviews animations:^{
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
