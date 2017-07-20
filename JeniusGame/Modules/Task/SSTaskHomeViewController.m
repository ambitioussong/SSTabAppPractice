//
//  SSTaskHomeViewController.m
//  JeniusGame
//
//  Created by CIZ on 2017/7/12.
//  Copyright © 2017年 CIZ. All rights reserved.
//

#import "SSTaskHomeViewController.h"
#import "SSTaskHomeDataController.h"
#import <UITableView+FDTemplateLayoutCell.h>
#import "SSTaskTableViewCell.h"

static NSString * const kTaskTableViewCellReuseIdentifier = @"kTaskTableViewCellReuseIdentifier";

@interface SSTaskHomeViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView       *tableView;

@end

@implementation SSTaskHomeViewController

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
    [[SSTaskHomeDataController sharedInstance] loadTaskData];
}

- (void)configureViews {
    self.title = @"Tasks";
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self.view);
    }];
}

#pragma mark - Private methods

- (NSString *)reuseIdentifierForIndexPath:(NSIndexPath *)indexPath {
    return kTaskTableViewCellReuseIdentifier;
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    SSTaskTableViewCell *taskCell = (SSTaskTableViewCell *)cell;
    SSTaskModel *taskModel = [SSTaskHomeDataController sharedInstance].taskItems[indexPath.row];
    [taskCell renderWithTaskModel:taskModel];
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
    SSTaskModel *taskModel = [SSTaskHomeDataController sharedInstance].taskItems[indexPath.row];
    if (taskModel.taskHandler) {
        taskModel.taskHandler();
    }
}

#pragma mark - <UITableViewDataSource>

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [SSTaskHomeDataController sharedInstance].taskItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *reuseIdentifier = [self reuseIdentifierForIndexPath:indexPath];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
    [self configureCell:cell atIndexPath:indexPath];
    
    return cell;
}

#pragma mark - Getters

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[SSTaskTableViewCell class] forCellReuseIdentifier:kTaskTableViewCellReuseIdentifier];
    }
    return _tableView;
}

@end
