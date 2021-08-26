//
//  SceneListCollectionViewCell.m
//  SoundValley
//
//  Created by apple on 2020/5/3.
//  Copyright © 2020 apple. All rights reserved.
//

#import "SceneListCollectionViewCell.h"

#define COLOR_WITH_HEX(hexValue) [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16)) / 255.0 green:((float)((hexValue & 0xFF00) >> 8)) / 255.0 blue:((float)(hexValue & 0xFF)) / 255.0 alpha:1.0f]
 
// 调用
@implementation SceneListCollectionViewCell
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self.contentView addSubview:self.iconImageView];
        [self.contentView addSubview:self.sceneTitleLabel];
        [self.contentView addSubview:self.playImageView];
    }
    return self;
}

-(UIImageView *)iconImageView
{
    if (!_iconImageView) {
       // self.backgroundColor =[UIColor redColor];
        CGFloat scale = [UIScreen mainScreen].scale ;
        CGFloat dimNew=(SCREEN_WIDTH/2-125)/2;
        _iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(dimNew, 0,125, 225)];
        _iconImageView.contentMode = UIViewContentModeScaleAspectFill;
        _iconImageView.layer.masksToBounds = YES;
        _iconImageView.layer.cornerRadius = 20;
    }
    return _iconImageView;
}

-(UIImageView *)playImageView
{
    if (!_playImageView) {
       // self.backgroundColor =[UIColor redColor];
        CGFloat scale = [UIScreen mainScreen].scale;
        CGFloat dimNew=(SCREEN_WIDTH/2-10)/2;
        _playImageView = [[UIImageView alloc] initWithFrame:CGRectMake(dimNew, 200,10, 10)];
        _playImageView.contentMode = UIViewContentModeScaleAspectFill;
        _playImageView.layer.masksToBounds = YES;
        _playImageView.layer.cornerRadius = 1;
    }
    return _playImageView;
}

-(UILabel *)sceneTitleLabel
{
    if (!_sceneTitleLabel) {
        CGFloat dimNew=(SCREEN_WIDTH/2-118)/2;
        _sceneTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(dimNew, 230, 118, 30)];
        _sceneTitleLabel.textAlignment = NSTextAlignmentCenter;
      _sceneTitleLabel.font = [UIFont systemFontOfSize:12];
      //  _sceneTitleLabel.font = [UIFont fontWithName:@"DINAlternate-Bold" size:15];
     
        _sceneTitleLabel.textColor = COLOR_WITH_HEX(0x4f4f4f);
    }
    return _sceneTitleLabel;
}
@end
