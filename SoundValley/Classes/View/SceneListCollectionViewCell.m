//
//  SceneListCollectionViewCell.m
//  SoundValley
//
//  Created by apple on 2020/5/3.
//  Copyright © 2020 apple. All rights reserved.
//

#import "SceneListCollectionViewCell.h"

@implementation SceneListCollectionViewCell
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self.contentView addSubview:self.iconImageView];
        [self.contentView addSubview:self.sceneTitleLabel];
    }
    return self;
}

-(UIImageView *)iconImageView
{
    if (!_iconImageView) {
        CGFloat scale = [UIScreen mainScreen].scale ;
        CGFloat dim =(SCREEN_WIDTH-80*3)/4;
        CGFloat dimNew=(118-80)/2;
        _iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(dimNew, 0,80, 80)];
        _iconImageView.contentMode = UIViewContentModeScaleAspectFill;
        _iconImageView.layer.masksToBounds = YES;
        _iconImageView.layer.cornerRadius = 20;
    }
    return _iconImageView;
}

-(UILabel *)sceneTitleLabel
{
    if (!_sceneTitleLabel) {
        _sceneTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 90, 118, 30)];
        _sceneTitleLabel.textAlignment = NSTextAlignmentCenter;
        _sceneTitleLabel.font = [UIFont systemFontOfSize:15];
        _sceneTitleLabel.textColor = RGB(139, 139, 139, 1);
    }
    return _sceneTitleLabel;
}
@end
