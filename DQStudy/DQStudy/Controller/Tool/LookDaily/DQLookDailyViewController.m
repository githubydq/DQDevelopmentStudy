//
//  DQLookDailyViewController.m
//  DQStudy
//
//  Created by youdingquan on 16/5/16.
//  Copyright © 2016年 youdingquan. All rights reserved.
//

#import "DQLookDailyViewController.h"
#import "DQDetailDao.h"
#import "DQDetailModel.h"
#import "AppDelegate.h"

@interface DQLookDailyViewController ()
@property (weak, nonatomic) IBOutlet UITextView *showView;
@property(nonatomic,strong)DQDetailModel * model;

@end

@implementation DQLookDailyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self loadData];
    [self configUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:YES];
    [self.tabBarController.tabBar setHidden:YES];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setHidden:NO];
    [self.tabBarController.tabBar setHidden:NO];
}

-(BOOL)prefersStatusBarHidden{
    [super prefersStatusBarHidden];
    static BOOL is = NO;
    is = !is;
    return is;
}

#pragma mark -
#pragma mark configUI
-(void)configUI{
    //字体faxiao
    NSArray * colorArray = [USER_DEFAULTS objectForKey:RECORD_BGCOLOR];
    self.showView.backgroundColor = [UIColor colorWithRed:[colorArray[0] floatValue]/255.0 green:[colorArray[1] floatValue]/255.0 blue:[colorArray[2] floatValue]/255.0 alpha:1.0];
    CGFloat fontSize = [[USER_DEFAULTS objectForKey:RECORD_FONTSIZE] floatValue];
    //string设置
    NSDictionary * dic = @{NSFontAttributeName:[UIFont systemFontOfSize:fontSize],NSForegroundColorAttributeName:[UIColor orangeColor]};
    NSAttributedString * attributeStr = [[NSAttributedString alloc] initWithString:self.model.detail attributes:dic];
    self.showView.textAlignment = NSTextAlignmentLeft;
    self.showView.attributedText = attributeStr;
    
}

#pragma mark -
#pragma mark load data
-(void)loadData{
    NSArray * array = [DQDetailDao findAtTitle:@"iOS"];
    NSInteger index = arc4random()%array.count;
    self.model = array[index];
}

#pragma mark -
#pragma mark click
- (IBAction)showViewTap:(UITapGestureRecognizer *)sender {
    NSLog(@"%s",__FUNCTION__);
    BOOL hidden = self.navigationController.navigationBar.hidden;
    [self.navigationController.navigationBar setHidden:!hidden];
    
    [self setNeedsStatusBarAppearanceUpdate];
}

@end
