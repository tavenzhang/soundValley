//
//  TimerView.h
//  SoundValley
//
//  Created by apple on 2020/5/2.
//  Copyright © 2020 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TimerView : UIView
@property (nonatomic,strong)NSArray *arrTimeModel;
@property (nonatomic,copy)void(^clickConfirmButtonAction)(NSInteger time);
-(instancetype)initWithFrame:(CGRect)frame;

-(void)show;
@end

NS_ASSUME_NONNULL_END
