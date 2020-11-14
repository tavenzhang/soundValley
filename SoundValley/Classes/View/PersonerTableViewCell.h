//
//  PersonerTableViewCell.h
//  SoundValley
//
//  Created by apple on 2020/5/3.
//  Copyright © 2020 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZJSwitch.h"
NS_ASSUME_NONNULL_BEGIN

@interface PersonerTableViewCell : UITableViewCell
@property (nonatomic,strong)UIView *alphaView;
@property (nonatomic,strong)UILabel *switchLabel;
@property (nonatomic,strong)UILabel *titleLabel;
@property (nonatomic,strong)UIImageView *icon;
@property (nonatomic,strong)UIImageView *rightIcon;
@end

NS_ASSUME_NONNULL_END
