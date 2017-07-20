//
//  SSRecordHomeViewController.m
//  JeniusGame
//
//  Created by CIZ on 2017/7/12.
//  Copyright © 2017年 CIZ. All rights reserved.
//

#import "SSRecordHomeViewController.h"
#import <MJRefresh.h>
#import <UITableView+FDTemplateLayoutCell.h>
#import "SSRecordTableViewCell.h"

static NSString * const kRecordTableViewCellReuseIdentifier = @"kRecordTableViewCellReuseIdentifier";

@interface SSRecordHomeViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray    *items;
@property (nonatomic, strong) UITableView       *tableView;

@end

@implementation SSRecordHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadData];
    [self configureViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadData {
    [self.items removeAllObjects];
    
    SSOfferModel *offerModel = [[SSOfferModel alloc] init];
    offerModel.iconUrlString = @"http://is2.mzstatic.com/image/thumb/Purple117/v4/fd/67/a4/fd67a46d-631c-d42b-4ba0-8ab0d0058d2a/source/175x175bb.jpg";
    offerModel.titleText = @"Sticky AI";
    offerModel.textHighlightColor = [UIColor redColor];
    [self.items addObject:offerModel];
    
    offerModel = [[SSOfferModel alloc] init];
    offerModel.iconUrlString = @"http://is5.mzstatic.com/image/thumb/Purple117/v4/9b/56/89/9b5689ca-433e-7968-584a-86e30d5713ce/source/175x175bb.jpg";
    offerModel.titleText = @"Street Fighter IV Champion Edition";
    offerModel.textHighlightColor = [UIColor redColor];
    [self.items addObject:offerModel];
    
    offerModel = [[SSOfferModel alloc] init];
    offerModel.iconUrlString = @"http://is1.mzstatic.com/image/thumb/Purple127/v4/e6/47/31/e6473171-2d4e-1424-4500-8ccaef0a51ea/source/175x175bb.jpg";
    offerModel.titleText = @"Color Magnet";
    offerModel.textHighlightColor = [UIColor redColor];
    [self.items addObject:offerModel];
}

- (void)configureViews {
    self.title = @"Records";
   
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self.view);
    }];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self performSelector:@selector(refreshRecordsTableView) withObject:nil afterDelay:2];
    }];
}

#pragma mark - Private methods

- (void)refreshRecordsTableView {
    [self loadData];
    [self.tableView reloadData];
    
    [self.tableView.mj_header endRefreshing];
}

- (NSString *)reuseIdentifierForIndexPath:(NSIndexPath *)indexPath {
    return kRecordTableViewCellReuseIdentifier;
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    SSRecordTableViewCell *recordCell = (SSRecordTableViewCell *)cell;
    SSOfferModel *offerModel = self.items[indexPath.row];
    [recordCell renderWithOfferModel:offerModel];
}

#pragma mark - <UITableViewDelegate>

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height = 0.0;
    NSString *reuseIdentifier = [self reuseIdentifierForIndexPath:indexPath];
    CGFloat tableViewWidth = CGRectGetWidth(tableView.frame);
    if (tableViewWidth > 0.0) {
        // workaround: 当tableView的宽度不确定时，此库会报警告
        height = [tableView fd_heightForCellWithIdentifier:reuseIdentifier
                                          cacheByIndexPath:indexPath
                                             configuration:^(id cell) {
                                                 [self configureCell:cell atIndexPath:indexPath];
                                             }];
    }
    
    return height;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark - <UITableViewDataSource>

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *reuseIdentifier = [self reuseIdentifierForIndexPath:indexPath];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
    [self configureCell:cell atIndexPath:indexPath];
    
    return cell;
}

#pragma mark - Getters

- (NSMutableArray *)items {
    if (!_items) {
        _items = [NSMutableArray new];
    }
    return _items;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[SSRecordTableViewCell class] forCellReuseIdentifier:kRecordTableViewCellReuseIdentifier];
    }
    return _tableView;
}

@end
