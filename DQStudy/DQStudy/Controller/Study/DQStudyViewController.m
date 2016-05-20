//
//  DQStudyViewController.m
//  DQStudy
//
//  Created by youdingquan on 16/5/1.
//  Copyright © 2016年 youdingquan. All rights reserved.
//

#import "DQStudyViewController.h"
#import "DQDetailDao.h"
#import "DQDetailModel.h"
#import "DQSelectView.h"
#import "DQAddView.h"

#import "DQRecordViewController.h"
#import "DQSearchViewController.h"

@interface DQStudyViewController ()<UITableViewDataSource,UITableViewDelegate,AddViewDelegate,UISearchBarDelegate>
@property (weak, nonatomic) IBOutlet UITableView *table;

@property(nonatomic,strong)UISearchBar * search;
@property(nonatomic,strong)DQSelectView * selectView;

@property(nonatomic,strong)NSMutableArray * listArray;/**<类别数组*/
@property(nonatomic,assign)NSInteger currentIndex;/**<当前记录类别*/
@property(nonatomic,strong)NSMutableArray * recordArray;/**<记录数组*/

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
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (self.selectView) {
        [self.selectView setHidden:NO];
    }
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    if (self.selectView) {
        [self.selectView setHidden:YES];
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
    
    self.search.delegate = self;
    
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
    [self.navigationController pushViewController:record animated:NO];
    self.hidesBottomBarWhenPushed = NO;
    
//    [self.navigationController addChildViewController:record];
//    record.view.frame = [UIScreen mainScreen].bounds;
//    [[UIApplication sharedApplication].keyWindow addSubview:record.view];
}
-(void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.y >= 25 && scrollView.contentOffset.y <= 50) {
        [scrollView setContentOffset:CGPointMake(0, 50) animated:YES];
    }
}


#pragma mark -
#pragma mark search bar delegate
-(BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    DQSearchViewController * search = [[DQSearchViewController alloc] init];
    search.nowTitle = self.listArray[self.currentIndex];
    
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:search animated:NO];
    self.hidesBottomBarWhenPushed = NO;
//    DQBaseViewController * nav = [[DQBaseViewController alloc] initWithRootViewController:search];
//    [self.navigationController addChildViewController:nav];
//    nav.view.frame = CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT);
//    nav.navigationBar.barTintColor = [UIColor whiteColor];
//    [self.navigationController.view addSubview:nav.view];
//    [UIView animateWithDuration:0.3 animations:^{
//        nav.view.transform = CGAffineTransformMakeTranslation(0, -44);
//        nav.navigationBar.barTintColor = [UIColor blackColor];
//    }completion:^(BOOL finished) {
//        [self.tabBarController.tabBar setHidden:YES];
//    }];
    
    return NO;
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
    DQDetailModel * model = [[DQDetailModel alloc]init];
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
