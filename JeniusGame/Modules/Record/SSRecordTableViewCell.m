//
//  SSRecordTableViewCell.m
//  JeniusGame
//
//  Created by CIZ on 2017/7/13.
//  Copyright © 2017年 CIZ. All rights reserved.
//

#import "SSRecordTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "UILabel+HighlightWhenSelect.h"

@interface SSRecordTableViewCell ()

@property (nonatomic, strong) UIView      *containingView;
@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel     *titleLabel;

@end


@implementation SSRecordTableViewCell

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
        make.centerY.equalTo(self.iconImageView);
        make.height.mas_equalTo(60);
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
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    [super setHighlighted:highlighted animated:animated];
    
    self.titleLabel.highlighted = highlighted;
}

#pragma mark - Public method

- (void)renderWithOfferModel:(SSOfferModel *)offerModel {
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:offerModel.iconUrlString]];
    self.titleLabel.text = offerModel.titleText;
    self.titleLabel.highlightedTextColor = offerModel.textHighlightColor;
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
        _iconImageView.layer.borderWidth = 1.0f;
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

@end
