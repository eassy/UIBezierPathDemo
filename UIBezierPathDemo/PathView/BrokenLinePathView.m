//
//  BrokenLinePathView.m
//  UIBezierPathDemo
//
//  Created by houwenjie on 2019/1/23.
//  Copyright © 2019 houwenjie. All rights reserved.
//

#import "BrokenLinePathView.h"

@implementation BrokenLinePathView


- (void)drawRect:(CGRect)rect {
    UIBezierPath *brokenPath = [UIBezierPath bezierPath];
//    [brokenPath moveToPoint:CGPointMake(0, 0)];// 当前点挪到 0，0
//    [brokenPath addLineToPoint:CGPointMake(10, 10)];//添加当前点到 10，10 的线
//
//    [brokenPath moveToPoint:CGPointMake(20, 20)];//当前点挪到 20，20
//    [brokenPath addLineToPoint:CGPointMake(30, 30)];//添加当前点到 30，30 的线
    
    CGPoint lastPoint = CGPointMake(30, 0);
    for (int i =  30; i < rect.size.width; i += 20) {
        CGPoint toPoint = CGPointMake(i, (i-30)/20%2 * 50);
        [brokenPath moveToPoint:lastPoint];
        [brokenPath addLineToPoint:toPoint];
        lastPoint = toPoint;
    }
    brokenPath.lineWidth = 2;
    [[UIColor redColor] setStroke];//设置路径线的颜色
    [brokenPath stroke];//落实路径线的颜色
}

@end
