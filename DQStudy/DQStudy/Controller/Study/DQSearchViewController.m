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
#import "DQRecordViewController.h"

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
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self loadData];
    [self configNav];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.search setHidden:NO];
    [self.cancel setHidden:NO];
    
    [self.search becomeFirstResponder];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.search setHidden:YES];
    [self.cancel setHidden:YES];
    
    [self.search resignFirstResponder];
}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [self removeFromParentViewController];
//    [self.view removeFromSuperview];
}


#pragma mark -
#pragma mark load data
-(void)loadData{
    self.resultArray = [[NSMutableArray alloc] init];
}

#pragma mark -
#pragma mark config nav
-(void)configNav{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    self.search = [[UISearchBar alloc] initWithFrame:CGRectMake(10, 0, SCREEN_WIDTH-10-70, 44)];
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
    [self.navigationController popViewControllerAnimated:NO];
    
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
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DQDetailModel * model = self.resultArray[indexPath.row];
    DQRecordViewController * record = [[DQRecordViewController alloc] init];
    record.model = model;
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:record animated:NO];
//    [self.navigationController popViewControllerAnimated:NO];
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
