//
//  BezierPathDetailViewController.m
//  UIBezierPathDemo
//
//  Created by houwenjie on 2019/1/23.
//  Copyright © 2019 houwenjie. All rights reserved.
//

#import "BezierPathDetailViewController.h"
#import "SimplePathView.h"

@interface BezierPathDetailViewController ()

/**
 绘图view
 */
@property (nonatomic, strong) UIView *drawView;

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
}

- (void)addSubViews {
    [self.view addSubview:self.drawView];
}

- (void)setConstraints {
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    [self.drawView setFrame:CGRectMake(10, 100, screenSize.width - 20, 200)];
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
            
            break;
        case BezierPathDetailTypeCurve:
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
        _drawView.backgroundColor = [UIColor whiteColor];
    }
    return _drawView;
}

@end
