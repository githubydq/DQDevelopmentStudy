//
//  DQToolViewController.m
//  DQStudy
//
//  Created by youdingquan on 16/5/1.
//  Copyright © 2016年 youdingquan. All rights reserved.
//

#import "DQToolViewController.h"
#import "DQLookDailyViewController.h"
#import "DQQRCodeScanViewController.h"
#import "DQQRCodeCreateViewController.h"


typedef NS_ENUM(NSInteger, QRCodeStyle) {
    QRCodeStyleScan = 0,
    QRCodeStyleCreate
};

@interface DQToolViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *mytable;


@property(nonatomic,strong)NSArray * listArray;
@end

@implementation DQToolViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
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
    self.listArray = @[@[@"每日一看"],@[@"二维码"]];
}

#pragma mark -
#pragma mark UI
-(void)configUI{
    self.navigationItem.title = @"工具";
    
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
    static NSString * identify = @"toolcell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    if ([self.listArray[indexPath.section][indexPath.row] length] > 0) {
        cell.textLabel.text = self.listArray[indexPath.section][indexPath.row];
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            DQLookDailyViewController * look = [[DQLookDailyViewController alloc] init];
            [self.navigationController pushViewController:look animated:NO];
        }
    }else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            [self choiceQRCodeStyle];
        }
    }else if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            
        }
    }
}

#pragma mark -
#pragma mark QRCode
-(void)choiceQRCodeStyle{
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"请选择二维码的使用方式" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    [alert addAction:[UIAlertAction actionWithTitle:@"扫描" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self intoQRCodeScanVC];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"生成" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self intoQRCodeCreateVC];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
}
-(void)intoQRCodeScanVC{
    DQQRCodeScanViewController * scan = [[DQQRCodeScanViewController alloc] init];
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:scan animated:NO];
    self.hidesBottomBarWhenPushed = NO;
}
-(void)intoQRCodeCreateVC{
    DQQRCodeCreateViewController * create = [[DQQRCodeCreateViewController alloc] init];
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:create animated:NO];
    self.hidesBottomBarWhenPushed = NO;
}
@end
