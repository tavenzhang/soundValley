//
//  GuideView.h
//  SoundValley
//
//  Created by apple on 2020/5/20.
//  Copyright © 2020 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GuideView : UIView
@property (nonatomic,strong)void (^guideActionBlock)(void);
-(void)showGuideView;
@end

NS_ASSUME_NONNULL_END
