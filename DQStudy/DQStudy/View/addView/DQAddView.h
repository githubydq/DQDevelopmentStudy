//
//  DQAddView.h
//  DQStudy
//
//  Created by youdingquan on 16/5/3.
//  Copyright © 2016年 youdingquan. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AddViewDelegate <NSObject>

@required
-(void)addRecordWithTitle:(NSString *)str;

@end

@interface DQAddView : UIView
@property(nonatomic,assign)id <AddViewDelegate> delegate;
@end
