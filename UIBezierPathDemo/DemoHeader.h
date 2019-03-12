//
//  DemoHeader.h
//  UIBezierPathDemo
//
//  Created by houwenjie on 2019/1/28.
//  Copyright © 2019 houwenjie. All rights reserved.
//

#ifndef DemoHeader_h
#define DemoHeader_h

typedef NS_ENUM(NSUInteger, BezierPathDetailType) {
    /// 简单的矩形
    BezierPathDetailTypeCreateSimple,
    /// 折线图
    BezierPathDetailTypeBrokenLine,
    /// 曲线图
    BezierPathDetailTypeCurve,
    /// 使用 layer 与 path 结合
    BezierPathDetailTypeShapeLayer,
    /// 饼状图封装
    BezierPathDetailTypePieChat,
    /// 折线图封装
    BezierPathDetailTypeBrokenLineView
};

#endif /* DemoHeader_h */
