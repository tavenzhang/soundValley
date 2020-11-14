//
//  SVViewController.m
//  SoundValley
//
//  Created by apple on 2020/5/1.
//  Copyright © 2020 apple. All rights reserved.
//

#import "SVViewController.h"
#import "SceneListViewController.h"
#import "PersonCenterViewController.h"
#import "AudioPlayerTool.h"
#import "Tools.h"
#import "InitData.h"
#import "SVPlayerManager.h"
@interface SVViewController ()

@end

@implementation SVViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
    // Do any additional setup after loading the view.
}

-(void)setUI
{
    [self.view addSubview:self.background];
    self.view.backgroundColor = [UIColor redColor];
}

-(UIImageView *)background
{
    if (!_background) {
        _background = [[UIImageView alloc] init];
        _background.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        _background.userInteractionEnabled = YES;
        _background.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _background;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
