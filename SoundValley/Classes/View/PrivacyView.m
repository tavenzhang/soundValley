//
//  PrivacyView.m
//  SoundValley
//
//  Created by apple on 2020/5/15.
//  Copyright © 2020 apple. All rights reserved.
//

#import "PrivacyView.h"
@interface PrivacyView ()<UITextViewDelegate>
@property (nonatomic, strong)UIView *container;
@property (nonatomic,strong)UILabel *titleLabel;
@property (nonatomic,strong)UILabel *descLabel;
@property (nonatomic,strong)UITextView *privacyTextView;
@property (nonatomic,strong)UIButton *agreeButton;
@property (nonatomic,strong)UILabel *line;
@property (nonatomic,strong)UIViewController *viewController;
@end

@implementation PrivacyView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setUI];
        [self mas_layoutSubviews];

    }
    return self;
}

-(void)setUI
{
    [self addSubview:self.container];
    [self.container addSubview:self.titleLabel];
    [self.container addSubview:self.descLabel];
    [self.container addSubview:self.privacyTextView];
    [self.container addSubview:self.line];
    [self.container addSubview:self.agreeButton];
}

-(void)mas_layoutSubviews
{
    [self.container mas_makeConstraints:^(MASConstraintMaker *make) {
         make.center.equalTo(self);
         make.width.mas_equalTo(300);
         make.height.mas_equalTo(260);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.container).offset (20);
        make.left.right.equalTo(self.container);
        make.height.mas_equalTo(30);
    }];
    [self.descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.container).offset(15);
        make.right.equalTo(self.container).offset(-15);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(20);
    }];
    [self.privacyTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.descLabel.mas_bottom).offset(20);
        make.left.right.equalTo(self.descLabel);
        make.height.mas_equalTo(30);
    }];
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.container);
        make.top.equalTo(self.privacyTextView.mas_bottom).offset(20);
        make.height.mas_equalTo(1);
    }];
    [self.agreeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.container);
        make.height.mas_equalTo(40);
        make.left.right.mas_equalTo(self.container);
    }];
}

- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange {
    if ([[URL scheme] isEqualToString:@"click"]) {
        if (self.clickPrivacyAction) {
            self.clickPrivacyAction();
        }
    }
    return YES;
}

-(void)clickAgreeButton
{
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:IS_AGREE];
    NSLog(@"IS_AGREE--------%ld",[[NSUserDefaults standardUserDefaults] boolForKey:IS_AGREE]);
    [self.container removeFromSuperview];
    [self removeFromSuperview];
}

-(UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = @"隐私政策";
        _titleLabel.textColor = HEXCOLOR(0x333333);
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont boldSystemFontOfSize:17];
    }
    return _titleLabel;
}

-(UILabel *)descLabel
{
    if (!_descLabel) {
        _descLabel = [[UILabel alloc] init];
        _descLabel.textAlignment = NSTextAlignmentCenter;
        _descLabel.textColor = RGB(159, 159, 159, 1);
        _descLabel.numberOfLines = 0;
        _descLabel.text = @"欢迎使用声谷手机软件app,请在使用软件之前，先点击”同意“。点击同意即代表您同意声谷隐私政策的相关内容。 ";
        _descLabel.font = [UIFont systemFontOfSize:16];
    }
    return _descLabel;
}

-(UITextView *)privacyTextView
{
    if (!_privacyTextView) {
        _privacyTextView = [[UITextView alloc] init];
        _privacyTextView.textAlignment = NSTextAlignmentCenter;
        _privacyTextView.editable = NO;
        _privacyTextView.scrollEnabled = NO;
        _privacyTextView.delegate = self;
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:@"点击查看《隐私政策协议》详情"];
        [attributedString addAttribute:NSLinkAttributeName
        value:@"click://"
        range:[[attributedString string] rangeOfString:@"《隐私政策协议》"]];
        _privacyTextView.linkTextAttributes = @{NSForegroundColorAttributeName: RGB(227, 123, 41, 1),
        NSUnderlineColorAttributeName: RGB(159, 159, 159, 1),
        NSUnderlineStyleAttributeName: @(NSUnderlinePatternSolid)};
        _privacyTextView.attributedText = attributedString;
        _privacyTextView.font = [UIFont systemFontOfSize:16];
        _privacyTextView.textColor = RGB(159, 159, 159, 1);
    }
    return _privacyTextView;
}

-(UILabel *)line
{
    if (!_line) {
        _line = [[UILabel alloc] init];
        _line.backgroundColor = RGB(159, 159, 159, 0.5);
    }
    return _line;
}

-(UIButton *)agreeButton
{
    if (!_agreeButton) {
        _agreeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_agreeButton setTitle:@"同意" forState:UIControlStateNormal];
        [_agreeButton setTitleColor:RGB(227, 123, 41, 1) forState:UIControlStateNormal];
        _agreeButton.titleLabel.font = [UIFont boldSystemFontOfSize:17];
        [_agreeButton addTarget:self action:@selector(clickAgreeButton) forControlEvents:UIControlEventTouchUpInside];
    }
    return _agreeButton;
}

-(UIView *)container
{
    if (!_container) {
        _container = [[UIView alloc] init];
        _container.backgroundColor = [UIColor whiteColor];
        _container.layer.masksToBounds = YES;
        _container.layer.cornerRadius = 10;
    }
    return _container;
}
@end
