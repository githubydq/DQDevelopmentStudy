//
//  DQSelectView.h
//  DQStudy
//
//  Created by youdingquan on 16/5/2.
//  Copyright © 2016年 youdingquan. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^myblock)(NSInteger index);
@interface DQSelectView : UIView
@property(nonatomic,copy)myblock block;
@property(nonatomic,copy)void (^menuBlock)();

-(void)setListArray:(NSArray *)array Index:(NSInteger)index;

@end
