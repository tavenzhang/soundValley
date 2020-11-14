//
//  PersonerTableViewCell.m
//  SoundValley
//
//  Created by apple on 2020/5/3.
//  Copyright © 2020 apple. All rights reserved.
//

#import "PersonerTableViewCell.h"

@interface PersonerTableViewCell ()
@end

@implementation PersonerTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUI];
        [self mas_layoutSubviews];
    }
    return self;
}

-(void)setUI
{
    self.contentView.backgroundColor = [UIColor clearColor];
//    [self.contentView addSubview:self.alphaView];
    [self.contentView addSubview:self.icon];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.switchLabel];
    [self.contentView addSubview:self.rightIcon];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

-(void)mas_layoutSubviews
{
//    [self.alphaView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH-30, 80));
//        make.center.equalTo(self.contentView);
//    }];
    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(30);
        make.size.mas_equalTo(CGSizeMake(20, 20));
        make.centerY.mas_equalTo(self.contentView);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.icon.mas_right).offset(15);
        make.size.mas_equalTo(CGSizeMake(120, 30));
        make.centerY.mas_equalTo(self.contentView);
    }];
    [self.rightIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(20, 20));
        make.right.equalTo(self.contentView.mas_right).offset(-20);
        make.centerY.mas_equalTo(self.contentView);
    }];
    [self.switchLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-78);
        make.top.equalTo(self.contentView);
        make.bottom.equalTo(self.contentView);
        make.width.mas_equalTo(40);
    }];
}

-(UIView *)alphaView
{
    if (!_alphaView) {
        _alphaView = [[UIView alloc] init];
        _alphaView.backgroundColor = [UIColor colorWithWhite:1 alpha:0.08];
        _alphaView.layer.masksToBounds = YES;
        _alphaView.layer.cornerRadius = 15;
    }
    return _alphaView;
}

-(UIImageView *)icon
{
    if (!_icon) {
        _icon = [[UIImageView alloc] init];
        _icon.contentMode =  UIViewContentModeScaleAspectFill;
    }
    return _icon;
}

-(UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.font = [UIFont systemFontOfSize:16];
    }
    return _titleLabel;
}

-(UIImageView *)rightIcon
{
    if (!_rightIcon) {
        _rightIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"rightIcon"]];
        _rightIcon.contentMode =  UIViewContentModeScaleAspectFill;
    }
    return _rightIcon;
}

-(UILabel *)switchLabel
{
    if (!_switchLabel) {
        _switchLabel = [[UILabel alloc] init];
        _switchLabel.textAlignment = NSTextAlignmentRight;
        _switchLabel.textColor = [UIColor whiteColor];
        _switchLabel.font = [UIFont systemFontOfSize:15];
    }
    return _switchLabel;
}



@end
