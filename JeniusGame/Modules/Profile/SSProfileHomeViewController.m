//
//  SSProfileHomeViewController.m
//  JeniusGame
//
//  Created by CIZ on 2017/7/12.
//  Copyright © 2017年 CIZ. All rights reserved.
//

#import "SSProfileHomeViewController.h"

@interface SSProfileHomeViewController ()

@property (nonatomic, strong) UIView        *profileView;
@property (nonatomic, strong) UILabel       *userIdSignLabel;
@property (nonatomic, strong) UIButton      *userIdButton;
@property (nonatomic, strong) UILabel       *masterIdSignLabel;
@property (nonatomic, strong) UIButton      *masterIdButton;
@property (nonatomic, strong) UIButton      *bindMasterButton;

@end

@implementation SSProfileHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"Profile";
    
    [self configureViews];
}

- (void)configureViews {
    [self.view addSubview:self.profileView];
    [self.profileView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(80);
        make.bottom.equalTo(self.view).offset(-80);
        make.left.equalTo(self.view).offset(20);
        make.right.equalTo(self.view).offset(-20);
    }];
    
    [self.profileView addSubview:self.userIdSignLabel];
    [self.userIdSignLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self.profileView);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(50);
    }];
    
    [self.profileView addSubview:self.userIdButton];
    [self.userIdButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.userIdSignLabel);
        make.height.equalTo(self.userIdSignLabel);
        make.right.equalTo(self.profileView);
        make.width.mas_equalTo(150);
    }];
    
    [self.profileView addSubview:self.masterIdSignLabel];
    [self.masterIdSignLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.userIdSignLabel.mas_bottom).offset(30);
        make.left.equalTo(self.userIdSignLabel);
        make.width.equalTo(self.userIdSignLabel);
        make.height.equalTo(self.userIdSignLabel);
    }];
    
    [self.profileView addSubview:self.masterIdButton];
    [self.masterIdButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.masterIdSignLabel);
        make.height.equalTo(self.masterIdSignLabel);
        make.right.equalTo(self.profileView);
        make.width.mas_equalTo(150);
    }];
    
    [self.profileView addSubview:self.bindMasterButton];
    [self.bindMasterButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.profileView);
        make.centerX.equalTo(self.profileView);
        make.width.mas_equalTo(250);
        make.height.mas_equalTo(50);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions 

- (void)onBindMasterButton {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"Input your referral code" preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        ;
    }];
    
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        ;
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        ;
    }];
    
    [alertController addAction:confirmAction];
    [alertController addAction:cancelAction];
    
    [self presentViewController:alertController animated:YES completion:NULL];
}

#pragma mark - Getters

- (UIView *)profileView {
    if (!_profileView) {
        _profileView = [[UIView alloc] init];
    }
    return _profileView;
}

- (UILabel *)userIdSignLabel {
    if (!_userIdSignLabel) {
        _userIdSignLabel = [[UILabel alloc] init];
        _userIdSignLabel.textAlignment = NSTextAlignmentLeft;
        _userIdSignLabel.font = [UIFont boldSystemFontOfSize:15];
        _userIdSignLabel.text = @"My Id:";
    }
    return _userIdSignLabel;
}

- (UIButton *)userIdButton {
    if (!_userIdButton) {
        _userIdButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _userIdButton.backgroundColor = [UIColor greenColor];
        _userIdButton.layer.cornerRadius = 10;
    }
    return _userIdButton;
}

- (UILabel *)masterIdSignLabel {
    if (!_masterIdSignLabel) {
        _masterIdSignLabel = [[UILabel alloc] init];
        _masterIdSignLabel.textAlignment = NSTextAlignmentLeft;
        _masterIdSignLabel.font = [UIFont boldSystemFontOfSize:15];
        _masterIdSignLabel.text = @"Master's Id:";
    }
    return _masterIdSignLabel;
}

- (UIButton *)masterIdButton {
    if (!_masterIdButton) {
        _masterIdButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _masterIdButton.backgroundColor = [UIColor greenColor];
        _masterIdButton.layer.cornerRadius = 10;
    }
    return _masterIdButton;
}

- (UIButton *)bindMasterButton {
    if (!_bindMasterButton) {
        _bindMasterButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _bindMasterButton.backgroundColor = [UIColor blueColor];
        _bindMasterButton.layer.cornerRadius = 10;
        [_bindMasterButton setTitle:@"Tap to input referral code" forState:UIControlStateNormal];
        [_bindMasterButton addTarget:self action:@selector(onBindMasterButton) forControlEvents:UIControlEventTouchUpInside];
    }
    return _bindMasterButton;
}

@end
