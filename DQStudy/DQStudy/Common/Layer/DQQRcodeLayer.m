//
//  DQQRcodeLayer.m
//  DQStudy
//
//  Created by youdingquan on 16/5/12.
//  Copyright © 2016年 youdingquan. All rights reserved.
//

#import "DQQRcodeLayer.h"


@implementation DQQRcodeLayer

-(void)drawInContext:(CGContextRef)ctx{
    
    CGContextAddRect(ctx, CGRectMake(0, 0, SCREEN_WIDTH, self.showRect.origin.y));
    CGContextSetRGBFillColor(ctx, 0, 0, 0, 0.3);
    CGContextFillPath(ctx);
    
    CGContextAddRect(ctx, CGRectMake(0, self.showRect.origin.y, self.showRect.origin.x, self.showRect.size.height));
    CGContextSetRGBFillColor(ctx, 0, 0, 0, 0.3);
    CGContextFillPath(ctx);
    
    CGContextAddRect(ctx, CGRectMake(self.showRect.origin.x+self.showRect.size.width, self.showRect.origin.y, SCREEN_WIDTH-self.showRect.origin.x-self.showRect.size.width, self.showRect.size.height));
    CGContextSetRGBFillColor(ctx, 0, 0, 0, 0.3);
    CGContextFillPath(ctx);
    
    CGContextAddRect(ctx, CGRectMake(0, self.showRect.size.height+self.showRect.origin.y, SCREEN_WIDTH, SCREEN_HEIGHT-self.showRect.size.height-self.showRect.origin.y));
    CGContextSetRGBFillColor(ctx, 0, 0, 0, 0.3);
    CGContextFillPath(ctx);
    
    CGContextAddRect(ctx, self.showRect);
    CGContextSetRGBStrokeColor(ctx, 1, 1, 1, 1);
    CGContextStrokePath(ctx);
}

@end
