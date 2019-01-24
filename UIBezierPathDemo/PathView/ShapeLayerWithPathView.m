//
//  ShapeLayerWithPathView.m
//  UIBezierPathDemo
//
//  Created by houwenjie on 2019/1/24.
//  Copyright © 2019 houwenjie. All rights reserved.
//  结合 ShapeLayer 和 UIBezierPath 来绘制图形，可以让我们不再使用 drawingRect 方法
//  drawingRect 属于 CoreGraphics 框架，占用 CPU ，性能消耗大
//  CAShapeLayer 属于 CoreAnimation 框架，通过 GPU 来直接渲染，节省性能。

#import "ShapeLayerWithPathView.h"

@interface ShapeLayerWithPathView ()

/**
 shapeLayer
 */
@property (nonatomic, strong) CAShapeLayer *shapeLayer;

@end

@implementation ShapeLayerWithPathView

#pragma mark - systemMethods

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self setSubViews];
        [self setConstraints];
        
    }
    return self;
}

#pragma mark - privateMethods

- (void)setSubViews {
    [self.layer addSublayer:self.shapeLayer];
}

- (void)setConstraints {
    [self.shapeLayer setFrame:self.bounds];
}


- (void)renderPath {
    CGSize size = self.bounds.size;
    // shapeLayer 与 path 结合使用
//    UIBezierPath *totalPath = [UIBezierPath bezierPath];
//
//    // 直线线段
//    UIBezierPath *straightPath = [UIBezierPath bezierPath];
//    [straightPath moveToPoint:CGPointMake(0, 0)];
//    [straightPath addLineToPoint:CGPointMake(30, 0)];
//    straightPath.lineWidth = 10;// 不起作用了，因为下面设置了 2
//    [totalPath appendPath:straightPath];// appendPath 执行后，totalPath 的 终点变成了 straightPath 的终点。
//
//
//
//    self.shapeLayer.lineWidth = 5;
//    self.shapeLayer.strokeColor = [UIColor redColor].CGColor;
//    self.shapeLayer.path = totalPath.CGPath;
    CAShapeLayer *masksLayer = [[CAShapeLayer alloc] init];
    UIBezierPath *cornerPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(10, 10)];
    masksLayer.path = cornerPath.CGPath;
    
    CALayer *contentLayer = [[CALayer alloc] init];
    [contentLayer setFrame:self.bounds];
    contentLayer.backgroundColor = [UIColor redColor].CGColor;
//    [self.layer addSublayer:contentLayer];
//    self.layer.mask = masksLayer;
    
    // 使用 path 和 shapeLayer 自定义阴影的路径，有一点需要注意的是：路径必须是闭合的。
    CGFloat shadowWidth = -2;
    UIBezierPath *shadowPath = [UIBezierPath bezierPath];
    
    [shadowPath moveToPoint:CGPointMake(-shadowWidth, self.bounds.size.height)];

    // 左竖边
    [shadowPath addLineToPoint:CGPointMake(-shadowWidth, shadowWidth)];

    //顶边
    [shadowPath addLineToPoint:CGPointMake(self.bounds.size.width + shadowWidth, shadowWidth)];
    
    //右边
    [shadowPath addLineToPoint:CGPointMake(self.bounds.size.width + shadowWidth, self.bounds.size.height)];
    
    //闭合
    [shadowPath addLineToPoint:CGPointMake(self.bounds.size.width, self.bounds.size.height)]  ;

    [shadowPath addLineToPoint:CGPointMake(size.width, 0)];

    [shadowPath addLineToPoint:CGPointMake(0, 0)];

    [shadowPath addLineToPoint:CGPointMake(0, size.height)];

    [shadowPath addLineToPoint:CGPointMake(-shadowWidth, size.height)];
    
    
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    self.layer.shadowRadius = 3;
    self.layer.shadowOffset = CGSizeZero;
    self.layer.shadowOpacity = 0.5;

    self.layer.shadowPath = shadowPath.CGPath;
}

#pragma mark - public methods

#pragma mark - event handler

#pragma mark - getters and setters

- (CAShapeLayer *)shapeLayer {
    if (!_shapeLayer) {
        _shapeLayer = [[CAShapeLayer alloc] init];
    }
    return _shapeLayer;
}

@end
