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
 绘图 layer
 */
@property (nonatomic, strong) CAShapeLayer *shapeLayer;

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
        [self setSubViews];
        [self setConstraints];
    }
    return self;
}


#pragma mark - privateMethods

- (void)setSubViews {
    
}

- (void)setConstraints {
    
}

#pragma mark - public methods

/**
 开始绘制图表
 */
- (void)renderChat {
    
}

/**
 重新绘制图表
 */
- (void)reRenderChat {
    
}

#pragma mark - event handler

#pragma mark - getters and setters

@end
