//
//  PrivacyView.h
//  SoundValley
//
//  Created by apple on 2020/5/15.
//  Copyright © 2020 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PrivacyView : UIView
@property (nonatomic,copy)void (^clickPrivacyAction)(void);
@end

NS_ASSUME_NONNULL_END
