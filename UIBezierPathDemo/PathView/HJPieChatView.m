//
//  HJPieChatView.m
//  UIBezierPathDemo
//
//  Created by houwenjie on 2019/1/24.
//  Copyright © 2019 houwenjie. All rights reserved.
//

#import "HJPieChatView.h"

@interface HJPieChatView ()

/**
 背景 layer
 */
@property (nonatomic, strong) CALayer *backLayer;

/**
 圆心点
 */
@property (nonatomic, assign) CGPoint centreOfCircle;

/**
 item 的图层数组
 */
@property (nonatomic, strong) NSMutableArray <CAShapeLayer *>*chatLayerArray;

@end

@implementation HJPieChatView

#pragma mark - systemMethods

/**
 初始化
 
 @param radius 半径
 @param chatItems 元素列表
 @param frame frame
 @return instancetype
 */
- (instancetype)initWithRadius:(CGFloat)radius chatItems:(NSArray *)chatItems frame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _chatRadius = radius;
        _chatItems = chatItems;
        _centreOfCircle = CGPointMake(frame.size.width / 2.f, frame.size.height / 2.f);
        [self setSubViews];
        [self setConstraints];
    }
    return self;
}


#pragma mark - privateMethods

- (void)setSubViews {
    [self.layer addSublayer:self.backLayer];
}

- (void)setConstraints {
    [self.backLayer setFrame:self.bounds];
}


- (void)preDrawPieChat {
    if (self.chatLayerArray.count < self.chatItems.count) {
        for (NSInteger i = self.chatLayerArray.count; i < self.chatItems.count ; i ++) {
            CAShapeLayer *itemShapeLayer = [[CAShapeLayer alloc] init];
            itemShapeLayer.lineWidth = 0.01f;
            itemShapeLayer.strokeColor = [UIColor clearColor].CGColor;
            [self.chatLayerArray addObject:itemShapeLayer];
            [self.layer addSublayer:itemShapeLayer];
        }
    }
    
    CGSize size = self.frame.size;
    self.centreOfCircle = CGPointMake(size.width / 2.f, size.height / 2.f);
}

#pragma mark - public methods

/**
 开始绘制图表
 */
- (void)renderChat {
    [self preDrawPieChat];
    // 最初起点从角度 0 开始
    __block CGFloat startAngle = 0.f;
    [self.chatLayerArray enumerateObjectsUsingBlock:^(CAShapeLayer * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx >= self.chatItems.count) {
            obj.hidden = YES;
        } else {
            obj.hidden = NO;
            HJPieChatItemModel *itemModel = [self.chatItems objectAtIndex:idx];
            // 这次的终点的计算
            CGFloat endAngle = startAngle + itemModel.itemProportion * M_PI * 2;
            if (endAngle > M_PI * 2) {
                endAngle = M_PI * 2;
            }
            // 首先根据圆心画了一个弧线，起点是 startAngle 对应的边界点，终点是 endAngle 对应的边界点
            UIBezierPath *itemPath = [UIBezierPath bezierPathWithArcCenter:self.centreOfCircle radius:self.chatRadius startAngle:startAngle endAngle:endAngle clockwise:YES];
            // 终点向圆心画一条直线，现在终点变成了圆心，起点还是原来的边界点
            [itemPath addLineToPoint:self.centreOfCircle];
            // 反转路径，原来的起点成为终点
            itemPath = [itemPath bezierPathByReversingPath];
            // 终点向圆心画一条直线，闭合，或者可以直接调用 closePath 闭合路径
            [itemPath addLineToPoint:self.centreOfCircle];
            
            obj.fillColor = itemModel.itemColor.CGColor;
            obj.path = itemPath.CGPath;
            
            startAngle = endAngle;
            if (endAngle >= M_PI * 2) {
                *stop = YES;
            }
        }
    }];
}

/**
 刷新某个 item
 
 @param color 新的颜色
 @param index 位置
 */
- (void)reloadItemWithColor:(UIColor *)color index:(NSInteger)index {
    if (index >= self.chatItems.count) {
        return;
    }
    HJPieChatItemModel *itemModel = [self.chatItems objectAtIndex:index];
    itemModel.itemColor = color;
    CAShapeLayer *itemLayer = [self.chatLayerArray objectAtIndex:index];
    itemLayer.fillColor = color.CGColor;
    
}

#pragma mark - event handler

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    CGPoint point = [[touches anyObject] locationInView:self];
    [self.chatLayerArray enumerateObjectsUsingBlock:^(CAShapeLayer * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIBezierPath *path = [UIBezierPath bezierPathWithCGPath:obj.path];
        BOOL isContain = [path containsPoint:point];
        if (isContain) {
            *stop = YES;
            if ([self.delegate respondsToSelector:@selector(pieChatViewClickWithItemModel:chatView:)]) {
                [self.delegate pieChatViewClickWithItemModel:[self.chatItems objectAtIndex:idx] chatView:self];
            }
        }
    }];
}

#pragma mark - getters and setters

- (NSMutableArray *)chatLayerArray {
    if (!_chatLayerArray) {
        _chatLayerArray = [[NSMutableArray alloc] init];
    }
    return _chatLayerArray;
}

@end


@implementation HJPieChatItemModel



@end
