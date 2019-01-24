//
//  BezierPathDetailViewController.h
//  UIBezierPathDemo
//
//  Created by houwenjie on 2019/1/23.
//  Copyright © 2019 houwenjie. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, BezierPathDetailType) {
    /// 简单的矩形
    BezierPathDetailTypeCreateSimple,
    /// 折线图
    BezierPathDetailTypeBrokenLine,
    /// 曲线图
    BezierPathDetailTypeCurve,
    /// 使用 layer 与 path 结合
    BezierPathDetailTypeShapeLayer
};

@interface BezierPathDetailViewController : UIViewController

- (instancetype)initWithTitle:(NSString *)navTitle pageType:(BezierPathDetailType)pageType;

@end

NS_ASSUME_NONNULL_END
