//
//  SSTaskTableViewCell.m
//  JeniusGame
//
//  Created by CIZ on 2017/7/14.
//  Copyright © 2017年 CIZ. All rights reserved.
//

#import "SSTaskTableViewCell.h"
#import "UILabel+HighlightWhenSelect.h"

@interface SSTaskTableViewCell ()

@property (nonatomic, strong) UIView      *containingView;
@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel     *titleLabel;
@property (nonatomic, strong) UILabel     *subtitleLabel;

@end

@implementation SSTaskTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self configureViews];
    }
    return self;
}

- (void)configureViews {
    self.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor clearColor];
    
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [self.contentView addSubview:self.containingView];
    [self.containingView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(2.5);
        make.bottom.equalTo(self.contentView).offset(-2.5);
        make.left.equalTo(self.contentView).offset(5);
        make.right.equalTo(self.contentView).offset(-5);
    }];
    
    [self.containingView addSubview:self.iconImageView];
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.containingView).offset(5).priorityHigh();
        make.bottom.equalTo(self.containingView).offset(-5).priorityHigh();
        make.height.mas_equalTo(50);
        make.width.mas_equalTo(50);
        make.left.equalTo(self.containingView).offset(5);
    }];
    
    [self.containingView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.iconImageView).multipliedBy(0.5);
        make.left.equalTo(self.iconImageView.mas_right).offset(5);
        make.right.equalTo(self.containingView).offset(-5);
    }];
    
    [self.containingView addSubview:self.subtitleLabel];
    [self.subtitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.iconImageView).multipliedBy(1.5);
        make.left.equalTo(self.iconImageView.mas_right).offset(5);
        make.right.equalTo(self.containingView).offset(-5);
    }];
}

- (void)prepareForReuse {
    [super prepareForReuse];
    
    self.iconImageView.image = nil;
    self.textLabel.text = nil;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
    [self.titleLabel highlightWhenSelect:selected];
    [self.subtitleLabel highlightWhenSelect:selected];
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    [super setHighlighted:highlighted animated:animated];
    
    self.titleLabel.highlighted = highlighted;
    self.subtitleLabel.highlighted = highlighted;
}

#pragma mark - Public method

- (void)renderWithTaskModel:(SSTaskModel *)taskModel {
    self.iconImageView.image = kImageNamed(taskModel.iconName);
    self.titleLabel.text = taskModel.titleText;
    self.titleLabel.highlightedTextColor = taskModel.textHighlightColor;
    self.subtitleLabel.text = taskModel.subtitleText;
    self.subtitleLabel.highlightedTextColor = taskModel.textHighlightColor;
}

#pragma mark - Getters

- (UIView *)containingView {
    if (!_containingView) {
        _containingView = [[UIView alloc] init];
        _containingView.backgroundColor = [UIColor brownColor];
        _containingView.layer.cornerRadius = 5.0f;
        _containingView.layer.shouldRasterize = YES;
        _containingView.layer.rasterizationScale = [UIScreen mainScreen].scale;
        _containingView.layer.masksToBounds = YES;
    }
    return _containingView;
}

- (UIImageView *)iconImageView {
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc] init];
        _iconImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _iconImageView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.numberOfLines = 0;
        _titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        [_titleLabel sizeToFit];
    }
    return _titleLabel;
}

- (UILabel *)subtitleLabel {
    if (!_subtitleLabel) {
        _subtitleLabel = [[UILabel alloc] init];
        _subtitleLabel.textAlignment = NSTextAlignmentLeft;
        _subtitleLabel.numberOfLines = 0;
        _subtitleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        [_subtitleLabel sizeToFit];
    }
    return _subtitleLabel;
}

@end
