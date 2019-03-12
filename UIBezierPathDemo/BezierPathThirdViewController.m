//
//  BezierPathThirdViewController.m
//  UIBezierPathDemo
//
//  Created by houwenjie on 2019/1/24.
//  Copyright © 2019 houwenjie. All rights reserved.
//

#import "BezierPathThirdViewController.h"
#import "HJPieChatView.h"
#import "HJBrokenLineView.h"

@interface BezierPathThirdViewController () <HJPieChatViewDelegate>

/**
 页面类型
 */
@property (nonatomic, assign) BezierPathDetailType pageType;

/**
 饼状图
 */
@property (nonatomic, strong) HJPieChatView *pieChatView;

/**
 折线图
 */
@property (nonatomic, strong) HJBrokenLineView *brokenLineChatView;

@end

@implementation BezierPathThirdViewController

#pragma mark - life cycle

- (instancetype)initWithTitle:(NSString *)navTitle pageType:(BezierPathDetailType)pageType{
    self = [super init];
    if (self) {
        self.hidesBottomBarWhenPushed = YES;
        self.title = navTitle;
        self.pageType = pageType;
        self.view.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.hidesBottomBarWhenPushed = YES;
        self.view.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUI];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - public methods

#pragma mark - private methods

- (void)setUI {
    [self setNav];
    [self addSubViews];
    [self setConstraints];

    if (self.pageType == BezierPathDetailTypePieChat) {
        
        [self drawPieChat];
    } else if (self.pageType == BezierPathDetailTypeBrokenLineView) {
        [self drawBrokenLineChat];
    }
}

- (void)addSubViews {
    
    
}

- (void)setConstraints {
    if (self.pageType == BezierPathDetailTypePieChat) {
        [self.pieChatView setFrame:self.view.bounds];
    } else if (self.pageType == BezierPathDetailTypeBrokenLineView) {
        [self.brokenLineChatView setFrame:CGRectMake(30, 150, self.view.bounds.size.width - 60, 150)];
    }
    
}

- (void)setNav {
    
}


/**
 绘制饼状图
 */
- (void)drawPieChat {
    //饼状图
    [self.view addSubview:self.pieChatView];
    self.pieChatView.chatRadius = self.view.bounds.size.width / 2.f - 5.f;
    NSArray <NSNumber *>*proportionArray = @[@(0.1),@(0.3),@(0.2),@(0.1),@(0.5)];
    NSArray <UIColor *>*colorArray = @[[UIColor redColor],[UIColor orangeColor],[UIColor yellowColor],[UIColor greenColor],[UIColor blueColor]];
    NSMutableArray *chatItems = [[NSMutableArray alloc] init];
    for (int i = 0; i < 5; i ++) {
        HJPieChatItemModel *item = [[HJPieChatItemModel alloc] init];
        item.itemColor = colorArray[i];
        item.itemProportion = proportionArray[i].floatValue;
        [chatItems addObject:item];
    }
    self.pieChatView.chatItems = [chatItems copy];
    
    [self.pieChatView renderChat];
}


/**
 绘制折线图
 */
- (void)drawBrokenLineChat {
    // 折线图
    [self.view addSubview:self.brokenLineChatView];
    
    // 轴元素
    // 横轴
    NSArray <NSNumber *>*horizonAxisValueArray = @[@(0.1),@(0.3),@(0.5),@(0.7),@(0.9)];
    NSMutableArray *horizonAxisArray = [[NSMutableArray alloc] init];
    for (NSNumber *value in horizonAxisValueArray) {
        
        HJBrokenAxisModel *axisModel = [[HJBrokenAxisModel alloc] init];
        axisModel.itemValue = value;
        axisModel.itemName = @"1 月";
        [horizonAxisArray addObject:axisModel];
    }
    self.brokenLineChatView.horizontalArray = horizonAxisArray;
    // 纵轴
    NSArray <NSNumber *>*verticalAxisValueArray = @[@(0),@(0.2),@(0.4),@(0.6),@(0.8)];
    NSMutableArray *verticalAxisArray = [[NSMutableArray alloc] init];
    for (NSNumber *value in verticalAxisValueArray) {
        HJBrokenAxisModel * axisModel = [[HJBrokenAxisModel alloc] init];
        axisModel.itemValue = value;
        axisModel.itemName = [NSString stringWithFormat:@"%.0f",value.floatValue * 100];
        [verticalAxisArray addObject:axisModel];
    }
    self.brokenLineChatView.verticalArray = verticalAxisArray;
    // 折线元素
    NSMutableArray *lineArray = [[NSMutableArray alloc] init];
    NSArray <NSArray <NSNumber *>*>*proportionArray =@[
  @[@(0.9),@(0.8),@(0.2),@(0.1),@(0.1)],
  @[@(0.8),@(0.6),@(0.5),@(0.7),@(0.4)],
  @[@(0.7),@(0.1),@(0.8),@(0.0),@(0.3)],
  ];
    [proportionArray enumerateObjectsUsingBlock:^(NSArray<NSNumber *> * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        HJBrokenLineModel *singleLineModel = [[HJBrokenLineModel alloc] init];
        singleLineModel.lineColor = [UIColor blackColor];
        NSMutableArray *lineItemArray = [NSMutableArray array];
        [obj enumerateObjectsUsingBlock:^(NSNumber * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            HJBrokenLineItemModel *lineItemModel = [[HJBrokenLineItemModel alloc] init];
            lineItemModel.itemValue = obj;
            [lineItemArray addObject:lineItemModel];
        }];
        singleLineModel.lineItemArray = lineItemArray;
        [lineArray addObject:singleLineModel];
    }];
    
    
    self.brokenLineChatView.lineArray = lineArray;
    [self.brokenLineChatView renderChat];
}

#pragma mark - handler Data

#pragma mark - event handlers

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.pieChatView.chatRadius = self.pieChatView.chatRadius - 10;
    [self.pieChatView renderChat];
}

#pragma mark - customDelegates

- (void)pieChatViewClickWithItemModel:(HJPieChatItemModel *)itemModel chatView:(HJPieChatView *)chatView {
    [chatView reloadItemWithColor:[UIColor lightGrayColor] index:[chatView.chatItems indexOfObject:itemModel]];
}

#pragma mark - systemDelegates

#pragma mark - getters and setters

- (HJPieChatView *)pieChatView {
    if (!_pieChatView) {
        _pieChatView = [[HJPieChatView alloc] initWithRadius:10 chatItems:nil frame:CGRectZero];
        _pieChatView.delegate = self;
    }
    return _pieChatView;
}

- (HJBrokenLineView *)brokenLineChatView {
    if (!_brokenLineChatView) {
        _brokenLineChatView = [[HJBrokenLineView alloc] init];
        
    }
    return _brokenLineChatView;
}

@end


