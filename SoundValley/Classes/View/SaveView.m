//
//  SaveView.m
//  SoundValley
//
//  Created by apple on 2020/5/5.
//  Copyright © 2020 apple. All rights reserved.
//

#import "SaveView.h"

@interface SaveView ()
@property (nonatomic,strong)UILabel *textLabel;
@property (nonatomic,strong)UILabel *line;
@property (nonatomic,strong)UIButton *downloadButton;

@end

@implementation SaveView
-(instancetype)init
{
    if (self = [super init]) {
        [self setUI];
        [self mas_layoutSubviews];
    }
    return self;
}

-(void)setUI
{
    [self addSubview:self.textLabel];
    [self addSubview:self.line];
    [self addSubview:self.downloadButton];
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 25;
    self.layer.borderWidth = 2;
    self.layer.borderColor = HEXCOLOR(0xfe4925).CGColor;
}

-(void)mas_layoutSubviews
{
    [self.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(30);
        make.right.equalTo(self.mas_right).offset(-50);
        make.top.bottom.equalTo(self);
    }];
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-50);
        make.top.equalTo(self).offset(15);
        make.bottom.equalTo(self.mas_bottom).offset(-15);
        make.width.mas_equalTo(1);
    }];
    [self.downloadButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(30, 30));
        make.right.equalTo(self.mas_right).offset(-10);
        make.top.equalTo(self).offset(10);
    }];
}

-(UILabel *)textLabel
{
    if (!_textLabel) {
        _textLabel = [[UILabel alloc] init];
        _textLabel.textColor = HEXCOLOR(0xfe4925);
        _textLabel.textAlignment = NSTextAlignmentLeft;
        _textLabel.text = @"保存图片分享给好友";
        _textLabel.font = [UIFont systemFontOfSize:18];
    }
    return _textLabel;
}

-(UILabel *)line
{
    if (!_line) {
        _line = [[UILabel alloc] init];
        _line.backgroundColor = RGB(216, 216, 216, 1);
    }
    return _line;
}

-(UIButton *)downloadButton
{
    if (!_downloadButton) {
        _downloadButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_downloadButton setImage:[UIImage imageNamed:@"download"] forState:UIControlStateNormal];
    }
    return _downloadButton;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
