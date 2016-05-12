//
//  DQSearchViewController.m
//  DQStudy
//
//  Created by youdingquan on 16/5/11.
//  Copyright © 2016年 youdingquan. All rights reserved.
//

#import "DQSearchViewController.h"
#import "DQDetailDao.h"
#import "DQDetailModel.h"

@interface DQSearchViewController ()<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>
@property (weak, nonatomic) IBOutlet UITableView *myTable;
@property(nonatomic,strong)UISearchBar * search;
@property(nonatomic,strong)UIButton * cancel;

@property(nonatomic,strong)NSMutableArray * resultArray;
@end

@implementation DQSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self loadData];
    [self configNav];
    
    [UIView animateWithDuration:1 animations:^{
        self.search.bounds = CGRectMake(0, 0, SCREEN_WIDTH-70-10, 44);
        self.search.center = CGPointMake(SCREEN_WIDTH/2.0-70/2.0, 44/2.0);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    [self configNav];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
}

#pragma mark -
#pragma mark load data
-(void)loadData{
    self.resultArray = [[NSMutableArray alloc] init];
}

#pragma mark -
#pragma mark config nav
-(void)configNav{
    self.search = [[UISearchBar alloc] initWithFrame:CGRectMake(10, 0, SCREEN_WIDTH-10*2, 44)];
    self.search.placeholder = @"请输入搜索的内容";
    [self.navigationController.navigationBar addSubview:self.search];
    self.search.delegate = self;
    
    self.cancel = [UIButton buttonWithType:UIButtonTypeCustom];
    self.cancel.frame = CGRectMake(SCREEN_WIDTH-60, 0, 50, 44);
    [self.cancel setTitle:@"取消" forState:UIControlStateNormal];
    [self.navigationController.navigationBar addSubview:self.cancel];
    [self.cancel addTarget:self action:@selector(searchCancelClick) forControlEvents:UIControlEventTouchUpInside];
    
}
-(void)searchCancelClick{
    [self.tabBarController.tabBar setHidden:NO];
    [self.navigationController.view removeFromSuperview];
    [self.navigationController removeFromParentViewController];
    
}

#pragma mark -
#pragma mark table delegate & datasource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.resultArray.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * identify = @"searchcell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    if (self.resultArray.count > 0) {
        DQDetailModel * model = self.resultArray[indexPath.row];
        cell.textLabel.text = model.name;
    }
    return cell;
}

#pragma mark -
#pragma mark search delegate
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    self.resultArray = [DQDetailDao searchWithString:searchBar.text From:self.nowTitle];
    [self.myTable reloadData];
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    self.resultArray = [DQDetailDao searchWithString:searchBar.text From:self.nowTitle];
    [self.myTable reloadData];
}

@end
