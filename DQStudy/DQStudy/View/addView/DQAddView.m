//
//  DQAddView.m
//  DQStudy
//
//  Created by youdingquan on 16/5/3.
//  Copyright © 2016年 youdingquan. All rights reserved.
//

#import "DQAddView.h"

@interface DQAddView ()
@property (weak, nonatomic) IBOutlet UILabel *titleLable;
@property (weak, nonatomic) IBOutlet UITextField *textfield;

@end

@implementation DQAddView

-(void)awakeFromNib{
    [self.textfield becomeFirstResponder];
}

- (IBAction)cancel:(id)sender {
    [self removeFromSuperview];
}
- (IBAction)add:(id)sender {
    if (self.textfield.text.length > 0) {
        [self.delegate addRecordWithTitle:self.textfield.text];
        [self removeFromSuperview];
    }
}

- (IBAction)backTap:(id)sender {
    [self.textfield resignFirstResponder];
}

@end
