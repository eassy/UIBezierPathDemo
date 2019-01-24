//
//  BezierPathThirdViewController.m
//  UIBezierPathDemo
//
//  Created by houwenjie on 2019/1/24.
//  Copyright © 2019 houwenjie. All rights reserved.
//

#import "BezierPathThirdViewController.h"
#import "HJPieChatView.h"

@interface BezierPathThirdViewController ()

/**
 饼状图
 */
@property (nonatomic, strong) HJPieChatView *pieChatView;

@end

@implementation BezierPathThirdViewController

#pragma mark - life cycle


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
}

- (void)addSubViews {
    
}

- (void)setConstraints {
    
}

- (void)setNav {
    
}


- (void)drawPieChat {
    self.pieChatView.chatRadius = 10.f;
    NSMutableArray *chatItems = [[NSMutableArray alloc] init];
    for (int i = 0; i < 10; i ++) {
        HJPieChatItemModel *item = [[HJPieChatItemModel alloc] init];
        item.itemColor = [UIColor colorWithRed:random() % 255 / 255.f green:random() % 255 / 255.f blue:random() % 255 / 255.f alpha:1];
        item.itemProportion = 1/10.f;
        [chatItems addObject:item];
    }
    self.pieChatView.chatItems = [chatItems copy];
    [self.pieChatView reRenderChat];
}

#pragma mark - handler Data

#pragma mark - event handlers

#pragma mark - customDelegates

#pragma mark - systemDelegates

#pragma mark - getters and setters

- (HJPieChatView *)pieChatView {
    if (!_pieChatView) {
        _pieChatView = [[HJPieChatView alloc] init];
    }
    return _pieChatView;
}

@end
