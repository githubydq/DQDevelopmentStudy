//
//  NSArray+DQHelper.m
//  DQStudy
//
//  Created by youdingquan on 16/5/2.
//  Copyright © 2016年 youdingquan. All rights reserved.
//

#import "NSArray+DQHelper.h"
#import <UIKit/UIKit.h>

@implementation NSArray (DQHelper)
-(NSArray *)StringWidth{
    NSMutableArray * widthArr = [[NSMutableArray alloc] init];
    for (NSString * str in self) {
        CGRect rect = [str boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName:[UIColor whiteColor]} context:nil];
        //        [widthArr addObject:[NSNumber numberWithFloat:rect.size.width]];
        NSLog(@"1%@",str);
        NSLog(@"22%lf,%lf",rect.size.width,rect.size.height);
    }
    return widthArr;
}
@end
