//
//  SceneListViewController.h
//  SoundValley
//
//  Created by apple on 2020/5/2.
//  Copyright © 2020 apple. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface SceneListViewController : BaseViewController
@property (nonatomic,copy)void(^playSceneVoice)(NSDictionary *dic);
@end

NS_ASSUME_NONNULL_END
