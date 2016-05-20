//
//  DQMineViewController.m
//  DQStudy
//
//  Created by youdingquan on 16/5/1.
//  Copyright © 2016年 youdingquan. All rights reserved.
//

#import "DQMineViewController.h"
#import "DQRecordFontViewController.h"
#import "DQRecordBGColorViewController.h"

@interface DQMineViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *table;

@property(nonatomic,strong)NSArray * listArray;
@property(nonatomic,strong)NSArray * sectionArray;
@end

@implementation DQMineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
    [self configUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark load data
-(void)loadData{
    self.listArray = @[@[@"字体大小",@"背景颜色"]];
    self.sectionArray = @[@"记录界面的设置"];
}

#pragma mark -
#pragma mark UI
-(void)configUI{
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.navigationItem.title = @"设置";
}


#pragma mark -
#pragma mark table delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.listArray.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.listArray[section] count];
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * identify = @"minecell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (self.listArray.count) {
        cell.textLabel.text = self.listArray[indexPath.section][indexPath.row];
    }
    return cell;
}
-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return self.sectionArray[section];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            DQRecordFontViewController * font = [[DQRecordFontViewController alloc] init];
            self.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:font animated:NO];
            self.hidesBottomBarWhenPushed = NO;
        }else if (indexPath.row == 1){
            DQRecordBGColorViewController * bgcolor = [[DQRecordBGColorViewController alloc] init];
            self.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:bgcolor animated:NO];
            self.hidesBottomBarWhenPushed = NO;
        }
    }
}

@end
