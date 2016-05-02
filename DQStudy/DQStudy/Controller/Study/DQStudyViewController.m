//
//  DQStudyViewController.m
//  DQStudy
//
//  Created by youdingquan on 16/5/1.
//  Copyright © 2016年 youdingquan. All rights reserved.
//

#import "DQStudyViewController.h"
#import "DQSelectView.h"

@interface DQStudyViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *table;

@property(nonatomic,strong)UISearchBar * search;
@property(nonatomic,strong)DQSelectView * selectView;

@property(nonatomic,strong)NSMutableArray * listArray;
@property(nonatomic,copy)NSString * nowTitle;
@end

@implementation DQStudyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadData];
    [self configUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UISearchBar *)search{
    if (!_search) {
        _search = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
        _search.barTintColor = [UIColor whiteColor];
    }
    return _search;
}

-(NSString *)nowTitle{
    if (!_nowTitle) {
        _nowTitle = self.listArray.firstObject;
    }
    return _nowTitle;
}

#pragma mark -
#pragma mark load data
-(void)loadData{
    self.listArray = [NSMutableArray arrayWithArray:@[@"iOS",@"你好",@"你好啊",@"iOS1",@"你好1",@"你好啊1"]];
}

-(void)refreshData{
    [self.table reloadData];
    self.table.contentOffset = CGPointMake(0, 50);
}

#pragma mark -
#pragma mark configUI
-(void)configUI{
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.table.tableHeaderView = self.search;
    self.table.contentOffset = CGPointMake(0, 50);
    
    [self configNav];
}
-(void)configNav{
    //selectView
    self.selectView = [[NSBundle mainBundle] loadNibNamed:@"DQSelectView" owner:nil options:nil].firstObject;
    self.selectView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 44);
    self.selectView.listTitleArray = self.listArray;
    [self.navigationController.navigationBar addSubview:self.selectView];
    __block DQStudyViewController * BlockSelf = self;
    self.selectView.block = ^(NSInteger index){
        BlockSelf.nowTitle = BlockSelf.listArray[index];
        [BlockSelf refreshData];
    };
}

#pragma mark -
#pragma mark table delegate and datasource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
    return self.listArray.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * identify = @"studycell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    cell.textLabel.text = self.nowTitle;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
-(void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.y >= 25 && scrollView.contentOffset.y <= 50) {
        [scrollView setContentOffset:CGPointMake(0, 50) animated:YES];
    }
}



#pragma mark -
#pragma mark top Click
- (IBAction)top:(id)sender {
    [self.table setContentOffset:CGPointMake(0, 50) animated:YES];
}


@end
