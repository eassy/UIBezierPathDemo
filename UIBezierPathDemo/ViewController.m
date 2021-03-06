//
//  ViewController.m
//  UIBezierPathDemo
//
//  Created by houwenjie on 2019/1/23.
//  Copyright © 2019 houwenjie. All rights reserved.
//

#import "ViewController.h"
#import "DemoHeader.h"
#import "BezierPathDetailViewController.h"
#import "BezierPathThirdViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

/**
 UITable
 */
@property (nonatomic, strong) UITableView *itemTable;
/**
 items
 */
@property (nonatomic, strong) NSMutableArray *items;

@end

@implementation ViewController

#pragma mark - life cycle


- (instancetype)init {
    self = [super init];
    if (self) {
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUI];
    [self bindData];
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
    [self.view addSubview:self.itemTable];
}

- (void)setConstraints {
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    [self.itemTable setFrame:CGRectMake(0, 0, screenSize.width, screenSize.height)];
}

- (void)setNav {
    self.title = @"UIBezierPath";
}

#pragma mark - handler Data


- (void)bindData {
    NSArray *itemArray = @[@"Create a Simple Path",
                           @"Create a Broken Path",
                           @"Create a CurlLine Path",
                           @"Path With ShapeLayer",
                           @"Create a PieChat With BezierPath",
                           @"Create a BrokenPath Chat With BezierPath"];
    [self.items addObjectsFromArray:itemArray];
}

#pragma mark - event handlers

#pragma mark - customDelegates

#pragma mark - systemDelegates

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"cellIIdentifier";
    UITableViewCell *itemCell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!itemCell) {
        itemCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        itemCell.textLabel.font = [UIFont boldSystemFontOfSize:18];
//        itemCell.textLabel.textColor =
    }
    itemCell.textLabel.text = self.items[indexPath.row];
    return itemCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    BezierPathDetailType pageType = BezierPathDetailTypeCreateSimple;
    if (indexPath.row == 0) {
        pageType = BezierPathDetailTypeCreateSimple;
    } else if (indexPath.row == 1) {
        pageType = BezierPathDetailTypeBrokenLine;
    } else if (indexPath.row == 2) {
        pageType = BezierPathDetailTypeCurve;
    } else if (indexPath.row == 3) {
        pageType = BezierPathDetailTypeShapeLayer;
    } else if (indexPath.row == 4) {
        BezierPathThirdViewController *thirdViewController = [[BezierPathThirdViewController alloc] initWithTitle:[self.items objectAtIndex:indexPath.row] pageType:BezierPathDetailTypePieChat];
        [self.navigationController pushViewController:thirdViewController animated:YES];
        return;
    } else if (indexPath.row == 5) {
        BezierPathThirdViewController *thirdViewController = [[BezierPathThirdViewController alloc] initWithTitle:[self.items objectAtIndex:indexPath.row] pageType:BezierPathDetailTypeBrokenLineView];
        [self.navigationController pushViewController:thirdViewController animated:YES];
        return;
    }
    BezierPathDetailViewController *pathDetailViewController = [[BezierPathDetailViewController alloc] initWithTitle:[self.items objectAtIndex:indexPath.row] pageType:pageType];
    [self.navigationController pushViewController:pathDetailViewController animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

#pragma mark - getters and setters

- (NSMutableArray *)items {
    if (!_items) {
        _items = [[NSMutableArray alloc] init];
    }
    return _items;
}

- (UITableView *)itemTable {
    if (!_itemTable) {
        _itemTable = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _itemTable.delegate = self;
        _itemTable.dataSource = self;
    }
    return _itemTable;
}

@end
