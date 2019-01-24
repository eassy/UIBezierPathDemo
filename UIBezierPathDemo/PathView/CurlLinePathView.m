//
//  CurlLinePathView.m
//  UIBezierPathDemo
//
//  Created by houwenjie on 2019/1/24.
//  Copyright © 2019 houwenjie. All rights reserved.
//

#import "CurlLinePathView.h"

@implementation CurlLinePathView


- (void)drawRect:(CGRect)rect {
    UIBezierPath *path = [UIBezierPath bezierPath];
    CGSize size = rect.size;
    
    [path moveToPoint:CGPointMake(0, 0)];// 首先给 path 一个起点
    [path addQuadCurveToPoint:CGPointMake(size.width / 2.f, size.height / 2.f) controlPoint:CGPointMake(size.width / 4.f, 0)];// 添加单点控制曲线
    
    [path addCurveToPoint:CGPointMake(size.width, size.height) controlPoint1:CGPointMake(size.width * 2.f / 4.f, size.height) controlPoint2:CGPointMake(size.width * 3.f / 4.f, size.height / 2.f)];// 添加双点控制曲线
    
    [path closePath]; //闭合路径，起点和终点之间会连一条线
    CGFloat a[] = {20,10};
    [path setLineDash:a count:2 phase:10]; // 设置虚线，dash 为 C 语言的 float 类型数组，里面的元素代表实线长度和虚线长度，例如 1,4,3 代表实线 1 虚线 4 实线 3 然后循环。 count 为数组的元素个数，phase 代表绘制起始的点
    
    path.lineWidth = 2;
    [[UIColor greenColor] setFill];
    [path fill];
    [[UIColor redColor] setStroke];
    [path stroke];
}

@end
