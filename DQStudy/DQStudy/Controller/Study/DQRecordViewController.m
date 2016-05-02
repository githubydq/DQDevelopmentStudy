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
-(void)configNav{
    self.textView.text  = self.model.detail;
    
    self.navigationItem.title = self.model.name;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(recordRightClick)];
}

-(void)recordRightClick{
    if (![self.textView.text isEqualToString:self.model.detail]) {
        self.model.detail = self.textView.text;
        [DQDetailDao updateAtModel:self.model];
        [self.navigationController popViewControllerAnimated:YES];
    }
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
