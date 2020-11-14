//
//  GuideView.m
//  SoundValley
//
//  Created by apple on 2020/5/20.
//  Copyright © 2020 apple. All rights reserved.
//

#import "GuideView.h"
@interface GuideView()
@property (nonatomic,strong)UILabel *guideLabel;
@property (nonatomic,strong)UIImageView *arrowView;
@end

@implementation GuideView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.frame = [UIApplication sharedApplication].keyWindow.bounds;
        self.backgroundColor = HEXACOLOR(0x333333, 0.45);
        [self addSubview:self.guideLabel];
        [self addSubview:self.arrowView];
        [self.arrowView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(80, 40));
            make.centerX.equalTo(self);
            make.bottom.mas_equalTo(self.mas_bottom).offset(-240);
        }];
        [self.guideLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.arrowView.mas_bottom).offset(10);
            make.size.mas_equalTo(CGSizeMake(150, 40));
            make.centerX.equalTo(self);
        }];
    }
    return self;
}

-(void)showGuideView
{
    [[UIApplication sharedApplication].keyWindow addSubview:self];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (self.guideActionBlock) {
        self.guideActionBlock();
    }
    [self removeFromSuperview];
}

-(UILabel *)guideLabel
{
    if (!_guideLabel) {
        _guideLabel = [[UILabel alloc] init];
        _guideLabel.textAlignment = NSTextAlignmentCenter;
        _guideLabel.textColor = [UIColor whiteColor];
        _guideLabel.font = [UIFont systemFontOfSize:18];
        _guideLabel.text = @"向左滑动切换声音";
    }
    return _guideLabel;
}

-(UIImageView *)arrowView
{
    if (!_arrowView) {
        _arrowView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"left_arrow"]];
    }
    return _arrowView;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
