//
//  DQSelectView.m
//  DQStudy
//
//  Created by youdingquan on 16/5/2.
//  Copyright © 2016年 youdingquan. All rights reserved.
//

#import "DQSelectView.h"

@interface DQSelectView ()
@property (weak, nonatomic) IBOutlet UIScrollView *scroll;
@property (weak, nonatomic) IBOutlet UIButton *menu;

@property(nonatomic,strong)NSMutableArray * btnArray;
@property(nonatomic,strong)UIView * line;

@end

@implementation DQSelectView

-(NSMutableArray *)btnArray{
    if (!_btnArray) {
        _btnArray = [[NSMutableArray alloc] init];
    }
    return _btnArray;
}

-(void)setListTitleArray:(NSArray *)listTitleArray{
    _listTitleArray = listTitleArray;
    //button
    CGFloat x = 0;
    for (int i = 0 ; i < listTitleArray.count ; i++) {
        CGRect rect = [listTitleArray[i] boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName:[UIColor whiteColor]} context:nil];
        CGFloat width = 20*2 + rect.size.width;
        
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:listTitleArray[i] forState:UIControlStateNormal];
        btn.frame = CGRectMake(x, 0, width, 44);
        [btn addTarget:self action:@selector(selectViewClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.scroll addSubview:btn];
        [self.btnArray addObject:btn];
        x += width;
    }
    self.scroll.contentSize = CGSizeMake(x, 44);
    //line
    UIView * line = [[UIView alloc] init];
    CGRect rect = [listTitleArray[0] boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName:[UIColor whiteColor]} context:nil];
    line.frame = CGRectMake(20, 44-4, rect.size.width, 4);
    line.backgroundColor = [UIColor orangeColor];
    [self.scroll addSubview:line];
    self.line = line;
}

-(void)awakeFromNib{
}

- (IBAction)btn:(id)sender {
    
}

-(void)selectViewClick:(UIButton*)btn{
    NSInteger index = [self.listTitleArray indexOfObject:btn.titleLabel.text];
    [self moveToIndex:index];
    self.block(index);
}

-(void)moveToIndex:(NSInteger)index{
    UIButton * btn = self.btnArray[index];
    CGRect rect = [btn.titleLabel.text boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName:[UIColor whiteColor]} context:nil];
    CGRect frame = CGRectMake(btn.frame.origin.x+20, 44-4, rect.size.width, 4);
    [UIView animateWithDuration:0.2 animations:^{
        self.line.frame = frame;
    }];
    //
    if (btn.center.x > self.scroll.bounds.size.width/2.0 && self.scroll.contentSize.width - btn.center.x > self.scroll.bounds.size.width/2.0) {
        [self.scroll setContentOffset:CGPointMake(btn.center.x - self.scroll.bounds.size.width/2.0, 0) animated:YES];
    }else{
        if (btn.center.x < self.scroll.bounds.size.width/2.0) {
            [self.scroll setContentOffset:CGPointMake(0, 0) animated:YES];
        }else{
            [self.scroll setContentOffset:CGPointMake(self.scroll.contentSize.width-self.scroll.bounds.size.width, 0) animated:YES];
        }
    }
}

@end
