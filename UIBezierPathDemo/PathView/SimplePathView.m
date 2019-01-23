//
//  SimplePathView.m
//  UIBezierPathDemo
//
//  Created by houwenjie on 2019/1/23.
//  Copyright © 2019 houwenjie. All rights reserved.
//

#import "SimplePathView.h"

@implementation SimplePathView



- (void)drawRect:(CGRect)rect {
//1.     UIBezierPath *path = [UIBezierPath bezierPathWithRect:rect];// 根据 rect 生成一个矩形的路径
//2.     UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:rect];// 根据 rect 生成一个椭圆路径，rect 中心为零点。
//3.    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:10];// 根据 rect 生成一个 圆角矩形， cornerRadius 为圆角大小。
//4.    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:UIRectCornerTopLeft|UIRectCornerBottomRight cornerRadii:CGSizeMake(500, 500)];// 根据 rect 生成一个圆角矩形， roundingCorners 为指定的圆角，可以自由组合  cornerRadii 为圆角大小，超过宽或者高的一半自动变为一半，太大的话，四个角都会变成与圆角。
//5.    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(rect.size.width / 2.f, rect.size.height / 2.f) radius:40 startAngle:0 endAngle:2.f/4.f * M_PI clockwise:YES];// 根据圆心，半径，起始角度，结束角度，顺序是否顺时针 绘制路径
    
//6.    UIBezierPath *path = [UIBezierPath bezierPathWithCGPath:];// 根据 CGPath 生成一个 UIBezierPath
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(rect.size.width / 2.f, rect.size.height / 2.f) radius:40 startAngle:0 endAngle:2.f/4.f * M_PI clockwise:YES];// 根据圆心，半径，起始角度，结束角度，顺序是否顺时针 绘制路径
    path = [path bezierPathByReversingPath];// 反转，当前点成为了起点，起点成为了当前点，再次addPath的时候，从原来的起点处添加。
    path.lineWidth = 1;//路径线的宽度，默认是 1
    
    
    [[UIColor whiteColor] setFill];// 设置路径中填充的颜色
    [path fill];//填充路径
    [[UIColor redColor] setStroke];//设置路径线的颜色
    [path stroke];//落实路径线的颜色
    
}
@end
