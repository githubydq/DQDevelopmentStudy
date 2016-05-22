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
    //刷新状态栏的设置
    [self setNeedsStatusBarAppearanceUpdate];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setHidden:NO];
    [self.tabBarController.tabBar setHidden:NO];
}

-(BOOL)prefersStatusBarHidden{
    [super prefersStatusBarHidden];
    return self.navigationController.navigationBar.hidden;
}

#pragma mark -
#pragma mark configUI
-(void)configUI{
    //字体faxiao
    NSArray * colorArray = [USER_DEFAULTS objectForKey:RECORD_BGCOLOR];
    self.showView.backgroundColor = [UIColor colorWithRed:[colorArray[0] floatValue]/255.0 green:[colorArray[1] floatValue]/255.0 blue:[colorArray[2] floatValue]/255.0 alpha:1.0];
    CGFloat fontSize = [[USER_DEFAULTS objectForKey:RECORD_FONTSIZE] floatValue];
    //attribute设置
//    NSDictionary * dic = @{NSFontAttributeName:[UIFont systemFontOfSize:fontSize],NSForegroundColorAttributeName:[UIColor orangeColor]};
//    NSAttributedString * attributeStr = [[NSAttributedString alloc] initWithString:self.model.detail attributes:dic];
//    self.showView.textAlignment = NSTextAlignmentLeft;
//    self.showView.attributedText = attributeStr;
    
    self.showView.textAlignment = NSTextAlignmentLeft;
    self.showView.font = [UIFont systemFontOfSize:fontSize];
    self.showView.textColor = [UIColor blackColor];
    self.showView.text = self.model.detail;
    
    self.navigationItem.title = self.model.name;
}

#pragma mark -
#pragma mark load data
-(void)loadData{
    NSArray * array = [DQDetailDao findAtTitle:@"iOS"];
    NSLog(@"11%@",array);
    NSInteger index = arc4random()%array.count;
    self.model = array[index];
}

#pragma mark -
#pragma mark click
- (IBAction)showViewTap:(UITapGestureRecognizer *)sender {
    //设置导航栏和状态栏的隐藏与显示
    BOOL hidden = self.navigationController.navigationBar.hidden;
    [self.navigationController.navigationBar setHidden:!hidden];
    
    [self setNeedsStatusBarAppearanceUpdate];
}

@end
