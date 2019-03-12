//
//  HJBrokenLineView.m
//  UIBezierPathDemo
//
//  Created by houwenjie on 2019/1/28.
//  Copyright © 2019 houwenjie. All rights reserved.
//

#import "HJBrokenLineView.h"

@interface HJBrokenLineView ()

/**
 背景 layer
 */
@property (nonatomic, strong) CALayer *backLayer;
/**
 轴 layer
 */
@property (nonatomic, strong) CAShapeLayer *axisLayer;
/**
 存放折线 layer 的数组
 */
@property (nonatomic, strong) NSMutableArray <CAShapeLayer *>*lineLayerArray;
/**
 原点位置
 */
@property (nonatomic, assign) CGPoint originalPoint;
/**
 横轴纵轴距周围的边距
 */
@property (nonatomic, assign) CGFloat axisMargin;

@end

@implementation HJBrokenLineView

#pragma mark - systemMethods

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setSubViews];
        [self setConstraints];
    }
    return self;
}

#pragma mark - privateMethods

- (void)setSubViews {
    self.axisMargin = 20.f;
    [self.layer addSublayer:self.backLayer];
    [self.backLayer addSublayer:self.axisLayer];
}

- (void)setConstraints {
    
}

/**
 开始绘制
 */
- (void)renderChat {
    [self preDrawChat];
    [self renderAxis];
    [self renderLine];
}

/**
 绘制前准备
 */
- (void)preDrawChat {
    [self.backLayer setFrame:self.bounds];
    CGSize size = self.bounds.size;
    self.originalPoint = CGPointMake(self.axisMargin, size.height - self.axisMargin);
}

/**
 绘制轴线
 */
- (void)renderAxis {
    CGSize selfSize = self.bounds.size;
    CGFloat totalWidth = selfSize.width - 2 * self.axisMargin;
    CGFloat totalHeight = selfSize.height - 2 * self.axisMargin;
    
    UIBezierPath *axisPath = [UIBezierPath bezierPath];
    // 横轴
    [axisPath moveToPoint:self.originalPoint];
    [axisPath addLineToPoint:CGPointMake(selfSize.width - self.axisMargin, self.originalPoint.y)];
    
    // 纵轴
    [axisPath moveToPoint:self.originalPoint];
    [axisPath addLineToPoint:CGPointMake(self.axisMargin, self.axisMargin)];
    
    
    // 横轴元素使用 label 绘制
    [self.horizontalArray enumerateObjectsUsingBlock:^(HJBrokenAxisModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UILabel *horizontalLabel = [[UILabel alloc] init];
        horizontalLabel.text = obj.itemName;
        horizontalLabel.textColor = [UIColor colorWithRed:55.f/255.f green:66.f/255.f blue:73.f/255.f alpha:1];
        horizontalLabel.font = [UIFont systemFontOfSize:10];
        [horizontalLabel sizeToFit];
        CGSize labelSize = horizontalLabel.frame.size;
        [self addSubview:horizontalLabel];
        [horizontalLabel setFrame:CGRectMake(self.originalPoint.x +  obj.itemValue.floatValue * totalWidth - labelSize.width / 2.f, self.originalPoint.y, labelSize.width, labelSize.height)];
    }];
    // 纵轴元素使用 label 绘制
    [self.verticalArray enumerateObjectsUsingBlock:^(HJBrokenAxisModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UILabel *verticalLabel = [[UILabel alloc] init];
        verticalLabel.text = obj.itemName;
        verticalLabel.textColor = [UIColor colorWithRed:55.f/255.f green:66.f/255.f blue:73.f/255.f alpha:1];
        verticalLabel.font = [UIFont systemFontOfSize:10];
        [verticalLabel sizeToFit];
        CGSize labelSize = verticalLabel.frame.size;
        [self addSubview:verticalLabel];
        [verticalLabel setFrame:CGRectMake(self.originalPoint.x - labelSize.width, self.originalPoint.y - obj.itemValue.floatValue * totalHeight - labelSize.height / 2.f, labelSize.width, labelSize.height)];
        [axisPath moveToPoint:CGPointMake(self.originalPoint.x, self.originalPoint.y - obj.itemValue.floatValue * totalHeight)];
        [axisPath addLineToPoint:CGPointMake(self.originalPoint.x + totalWidth, self.originalPoint.y - obj.itemValue.floatValue * totalHeight)];
    }];
    self.axisLayer.path = axisPath.CGPath;
}

/**
 绘制折线
 */
- (void)renderLine {
    __block BOOL canDraw = YES;
    [self.lineArray enumerateObjectsUsingBlock:^(HJBrokenLineModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.lineItemArray.count != self.horizontalArray.count) {
            canDraw = NO;
            *stop = YES;
        }
    }];
    NSAssert(canDraw, @"折线中的点元素数目，需要与横轴元素数目保持一致");
    
    CGSize selfSize = self.bounds.size;
    CGFloat totalWidth = selfSize.width - 2 * self.axisMargin;
    CGFloat totalHeight = selfSize.height - 2 * self.axisMargin;
    
    // 多条线，每条线有一个 shapeLayer
    [self.lineArray enumerateObjectsUsingBlock:^(HJBrokenLineModel * _Nonnull lineModel, NSUInteger idx, BOOL * _Nonnull stop) {
        // 画线，每个点与横轴点x相同
        UIBezierPath *linePath = [[UIBezierPath alloc] init];
        [lineModel.lineItemArray enumerateObjectsUsingBlock:^(HJBrokenLineItemModel * _Nonnull lineItemModel, NSUInteger idx, BOOL * _Nonnull stop) {
            CGPoint targetPoint = CGPointMake([self.horizontalArray objectAtIndex:idx].itemValue.floatValue * totalWidth + self.originalPoint.x, self.originalPoint.y - lineItemModel.itemValue.floatValue * totalHeight);
            if (idx == 0) {
                [linePath moveToPoint:targetPoint];
            } else {
                [linePath addLineToPoint:targetPoint];
            }
        }];
        CAShapeLayer *lineLayer = [[CAShapeLayer alloc] init];
        lineLayer.strokeColor = lineModel.lineColor.CGColor;
        lineLayer.fillColor = [UIColor clearColor].CGColor;
        lineLayer.path = linePath.CGPath;
        lineLayer.lineWidth = 3.f;
        [self.backLayer addSublayer:lineLayer];
    }];
}

#pragma mark - public methods

#pragma mark - event handler

#pragma mark - getters and setters

- (CALayer *)backLayer {
    if (!_backLayer) {
        _backLayer = [[CALayer alloc] init];
    }
    return _backLayer;
}

- (CAShapeLayer *)axisLayer {
    if (!_axisLayer) {
        _axisLayer = [[CAShapeLayer alloc] init];
        _axisLayer.lineWidth = 1.f;
        _axisLayer.strokeColor = [UIColor colorWithRed:211.f/255.f green:211.f/255.f blue:211.f/255.f alpha:1].CGColor;
    }
    return _axisLayer;
}

- (NSMutableArray<CAShapeLayer *> *)lineLayerArray {
    if (!_lineLayerArray) {
        _lineLayerArray = [[NSMutableArray alloc] init];
    }
    return _lineLayerArray;
}


@end

@implementation HJBrokenLineModel


@end

@implementation HJBrokenLineItemModel


@end

@implementation HJBrokenAxisModel

- (instancetype)init {
    if (self = [super init]) {
        _nameVisible = YES;
    }
    return self;
}


@end
