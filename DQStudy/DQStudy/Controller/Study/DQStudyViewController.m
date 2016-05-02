//
//  DQStudyViewController.m
//  DQStudy
//
//  Created by youdingquan on 16/5/1.
//  Copyright © 2016年 youdingquan. All rights reserved.
//

#import "DQStudyViewController.h"
#import "DQRecordViewController.h"
#import "DQDetailDao.h"
#import "DQDetailModel.h"
#import "DQSelectView.h"
#import "DQAddView.h"

@interface DQStudyViewController ()<UITableViewDataSource,UITableViewDelegate,AddViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *table;

@property(nonatomic,strong)UISearchBar * search;
@property(nonatomic,strong)DQSelectView * selectView;

@property(nonatomic,strong)NSMutableArray * listArray;
@property(nonatomic,assign)NSInteger currentIndex;
@property(nonatomic,strong)NSMutableArray * recordArray;

@property(nonatomic,strong)DQAddView * addView;
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

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if (!self.selectView) {
        [self configNav];
    }
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    if (self.addView) {
        [self.addView removeFromSuperview];
    }
}

-(UISearchBar *)search{
    if (!_search) {
        _search = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
        _search.barTintColor = [UIColor whiteColor];
    }
    return _search;
}

-(NSInteger)currentIndex{
    if (!_currentIndex) {
        _currentIndex = 0;
    }
    return _currentIndex;
}

#pragma mark -
#pragma mark load data
-(void)loadData{
    self.listArray = [NSMutableArray arrayWithArray:@[@"iOS",@"Android",@"Java",@"C/C++",@"H5",@"Web"]];
    [self loadRecordData];
}

-(void)loadRecordData{
    self.recordArray = [DQDetailDao findAtTitle:self.listArray[self.currentIndex]];
    
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
//    self.selectView.listTitleArray = self.listArray;
    [self.selectView setListArray:self.listArray Index:self.currentIndex];
    [self.navigationController.navigationBar addSubview:self.selectView];
    __block DQStudyViewController * BlockSelf = self;
    self.selectView.block = ^(NSInteger index){
        BlockSelf.currentIndex = index;
        [BlockSelf loadRecordData];
        [BlockSelf.table reloadData];
    };
    self.selectView.menuBlock = ^{
        NSLog(@"menu");
    };
}

#pragma mark -
#pragma mark table delegate and datasource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.recordArray.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * identify = @"studycell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    DQDetailModel * model = self.recordArray[indexPath.row];
    cell.textLabel.text = model.name;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DQRecordViewController * record = [[DQRecordViewController alloc] init];
    record.model = self.recordArray[indexPath.row];
    
    self.hidesBottomBarWhenPushed = YES;
    [self.selectView removeFromSuperview];
    self.selectView = nil;
    [self.navigationItem.backBarButtonItem setTitle:self.listArray[self.currentIndex]];
    [self.navigationController pushViewController:record animated:NO];
    self.hidesBottomBarWhenPushed = NO;
}
-(void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.y >= 25 && scrollView.contentOffset.y <= 50) {
        [scrollView setContentOffset:CGPointMake(0, 50) animated:YES];
    }
}



#pragma mark -
#pragma mark add Click
- (IBAction)top:(id)sender {
//    [self.table setContentOffset:CGPointMake(0, 50) animated:NO];
    self.addView = [[NSBundle mainBundle]loadNibNamed:@"DQAddView" owner:nil options:nil].firstObject;
    self.addView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    self.addView.delegate = self;
    [[UIApplication sharedApplication].keyWindow addSubview:self.addView];
}

-(void)addRecordWithTitle:(NSString *)str{
    NSDateFormatter * format = [[NSDateFormatter alloc] init];
    format.dateFormat = @"yyyyMMddHHmmss";
    NSDate * date = [NSDate date];
    
    DQDetailModel * model = [[DQDetailModel alloc]init];
    model.date = [format stringFromDate:date];
    model.title = self.listArray[self.currentIndex];
    model.name = str;
    model.detail = @"";
    model.image = @"";
    [DQDetailDao save:model];
    [self.recordArray insertObject:model atIndex:0];
    [self.table reloadData];
}

#pragma mark -
#pragma mark


@end
