//
//  DQMainViewController.m
//  DQStudy
//
//  Created by youdingquan on 16/5/1.
//  Copyright © 2016年 youdingquan. All rights reserved.
//

#import "DQMainViewController.h"
#import "DQBaseViewController.h"
#import "DQStudyViewController.h"
#import "DQToolViewController.h"
#import "DQMineViewController.h"

@interface DQMainViewController ()
@property(nonatomic,strong)NSArray * itemsTitle;
@property(nonatomic,strong)NSArray * itemsImage;
@property(nonatomic,strong)NSArray * itemsVC;
@end

@implementation DQMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
    [self setItems];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark load data
-(void)loadData{
    self.itemsTitle = @[@"学习",@"工具",@"我的"];
    self.itemsImage = @[@"study30x30",@"tool30x30",@"mine30x30"];
    self.itemsVC = @[@"DQStudyViewController",@"DQToolViewController",@"DQMineViewController"];
}

#pragma mark -
#pragma mark set tabbar item
-(void)setItems{
    NSMutableArray * VCs = [[NSMutableArray alloc] init];
    for (int i = 0 ; i < self.itemsVC.count ; i++) {
        UIViewController * vc = [[NSClassFromString(self.itemsVC[i]) alloc] init];
        DQBaseViewController * nav = [[DQBaseViewController alloc] initWithRootViewController:vc];
        [VCs addObject:nav];
    }
    self.viewControllers = VCs;
    
    for (int j = 0 ; j < self.viewControllers.count; j++) {
        UIViewController * vc = VCs[j];
        vc.tabBarItem = [[UITabBarItem alloc] initWithTitle:self.itemsTitle[j] image:[UIImage imageNamed:self.itemsImage[j]]  selectedImage:nil];
        [vc.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:0.0/255.0 green:122.0/255.0 blue:255.0/255.0 alpha:1]} forState:UIControlStateNormal];
        
    }
}

@end
