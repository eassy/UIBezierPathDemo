//
//  HJPieChatView.h
//  UIBezierPathDemo
//
//  Created by houwenjie on 2019/1/24.
//  Copyright © 2019 houwenjie. All rights reserved.
//  饼状图

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class HJPieChatItemModel;

@interface HJPieChatView : UIView

/**
 半径 重新赋值后会刷新
 */
@property (nonatomic, assign) CGFloat chatRadius;

/**
 图表元素数组，赋值后会刷新
 */
@property (nonatomic, strong) NSArray <HJPieChatItemModel *>*chatItems;

/**
 初始化

 @param radius 半径
 @param chatItems 元素列表
 @param frame frame
 @return instancetype
 */
- (instancetype)initWithRadius:(CGFloat)radius chatItems:(NSArray *)chatItems frame:(CGRect)frame;

/**
 开始绘制图表
 */
- (void)renderChat;


/**
 重新绘制图表
 */
- (void)reRenderChat;

@end

@interface HJPieChatItemModel : NSObject

/**
 颜色
 */
@property (nonatomic, strong) UIColor *itemColor;

/**
 比重 小数数值，前面的优先级高
 */
@property (nonatomic, assign) CGFloat itemProportion;

@end

NS_ASSUME_NONNULL_END
