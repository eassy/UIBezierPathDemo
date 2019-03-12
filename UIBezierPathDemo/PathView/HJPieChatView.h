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
@class HJPieChatView;

@protocol HJPieChatViewDelegate <NSObject>

- (void)pieChatViewClickWithItemModel:(HJPieChatItemModel *)itemModel chatView:(HJPieChatView *)chatView;

@end

@interface HJPieChatView : UIView

/**
 半径 重新赋值后调用 renderChat 会刷新
 */
@property (nonatomic, assign) CGFloat chatRadius;

/**
 图表元素数组，赋值后调用 renderChat 会刷新
 */
@property (nonatomic, strong) NSArray <HJPieChatItemModel *>*chatItems;

/**
 代理
 */
@property (nonatomic, weak) id <HJPieChatViewDelegate> delegate;

/**
 初始化

 @param radius 半径
 @param chatItems 元素列表
 @param frame frame
 @return instancetype
 */
- (instancetype)initWithRadius:(CGFloat)radius chatItems:(NSArray <HJPieChatItemModel *>*)chatItems frame:(CGRect)frame;

/**
 开始绘制图表，最好设置好了 frame
 */
- (void)renderChat;

/**
 刷新某个 item

 @param color 新的颜色
 @param index 位置
 */
- (void)reloadItemWithColor:(UIColor *)color index:(NSInteger)index;

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
