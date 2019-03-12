//
//  HJBrokenLineView.h
//  UIBezierPathDemo
//  折线图，支持多条线，每条线的刷新，外界可设置
//  Created by houwenjie on 2019/1/28.
//  Copyright © 2019 houwenjie. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HJBrokenLineModel;
@class HJBrokenAxisModel;
@class HJBrokenLineItemModel;

NS_ASSUME_NONNULL_BEGIN

@interface HJBrokenLineView : UIView

/**
 背景色
 */
@property (nonatomic, strong) UIColor *backgroundColor;

/**
 横轴元素
 */
@property (nonatomic, strong) NSArray <HJBrokenAxisModel *>*horizontalArray;

/**
 纵轴元素
 */
@property (nonatomic, strong) NSArray <HJBrokenAxisModel *>*verticalArray;

/**
 折线元素二维数组
 每条折线都是一个元素数组，可以传入多条折线元素
 */
@property (nonatomic, strong) NSArray <HJBrokenLineModel *>*lineArray;

/**
 开始绘制
 */
- (void)renderChat;

@end


/**
 折线 model
 */
@interface HJBrokenLineModel : NSObject

/**
 折线颜色
 */
@property (nonatomic, strong) UIColor *lineColor;

/**
 元素数组 需要与横轴元素数目相同
 */
@property (nonatomic, strong) NSArray <HJBrokenLineItemModel *>*lineItemArray;

@end


/**
 折线点 model
 */
@interface HJBrokenLineItemModel : NSObject

/**
 名称
 */
@property (nonatomic, strong) NSString *itemName;

/**
 item 值 ，具体的值是乘以数轴大小
 */
@property (nonatomic, strong) NSNumber *itemValue;

@end


/**
 轴 model
 */
@interface HJBrokenAxisModel : NSObject

/**
 名称
 */
@property (nonatomic, strong) NSString *itemName;
/**
 名称是否可见，默认可见
 */
@property (nonatomic, assign) BOOL nameVisible;
/**
 轴点的值
 */
@property (nonatomic, strong) NSNumber *itemValue;

@end

NS_ASSUME_NONNULL_END
