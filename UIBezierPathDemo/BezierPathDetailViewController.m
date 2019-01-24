//
//  BezierPathDetailViewController.m
//  UIBezierPathDemo
//
//  Created by houwenjie on 2019/1/23.
//  Copyright © 2019 houwenjie. All rights reserved.
//

#import "BezierPathDetailViewController.h"
#import "SimplePathView.h"
#import "BrokenLinePathView.h"
#import "CurlLinePathView.h"
#import "ShapeLayerWithPathView.h"
#import "BasePathView.h"

@interface BezierPathDetailViewController ()

/**
 绘图view
 */
@property (nonatomic, strong) BasePathView *drawView;

/**
 
 */
@property (nonatomic) Class drawViewClass;

/**
 页面类型
 */
@property (nonatomic, assign) BezierPathDetailType pageType;

@end

@implementation BezierPathDetailViewController

#pragma mark - life cycle


- (instancetype)initWithTitle:(NSString *)navTitle pageType:(BezierPathDetailType)pageType{
    self = [super init];
    if (self) {
        self.hidesBottomBarWhenPushed = YES;
        self.title = navTitle;
        self.pageType = pageType;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configDrawClassWithPageType:self.pageType];
    [self setUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - public methods

#pragma mark - private methods

- (void)setUI {
    self.view.backgroundColor = [UIColor whiteColor];
    [self setNav];
    [self addSubViews];
    [self setConstraints];
    [self renderDrawView];
}

- (void)addSubViews {
    [self.view addSubview:self.drawView];
}

- (void)setConstraints {
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    [self.drawView setFrame:CGRectMake(10, 100, screenSize.width - 20, 200)];
}


- (void)renderDrawView {
    [self.drawView renderPath];
}

- (void)setNav {
    
}

#pragma mark - handler Data


- (void)configDrawClassWithPageType:(BezierPathDetailType)pageType {
    switch (pageType) {
        case BezierPathDetailTypeCreateSimple:
            self.drawViewClass = [SimplePathView class];
            break;
        case BezierPathDetailTypeBrokenLine:
            self.drawViewClass = [BrokenLinePathView class];
            break;
        case BezierPathDetailTypeCurve:
            self.drawViewClass = [CurlLinePathView class];
            break;
        case BezierPathDetailTypeShapeLayer:
            self.drawViewClass = [ShapeLayerWithPathView class];
            break;
        default:
            break;
    }
}

#pragma mark - event handlers

#pragma mark - customDelegates

#pragma mark - systemDelegates

#pragma mark - getters and setters

- (UIView *)drawView {
    if (!_drawView) {
        _drawView = [[self.drawViewClass alloc] init];
//        _drawView.backgroundColor = [UIColor whiteColor];
    }
    return _drawView;
}

@end
