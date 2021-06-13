//
//  SVHomeViewController.m
//  SoundValley
//
//  Created by apple on 2020/5/13.
//  Copyright © 2020 apple. All rights reserved.
//

#import "SVHomeViewController.h"
#import "InitData.h"
#import "SVViewController.h"
#import "SVPlayerManager.h"
#import "Tools.h"
#import "SceneListViewController.h"
#import "PersonCenterViewController.h"
#import "TimerView.h"
#import "PQ_TimerManager.h"
#import "PrivacyView.h"
#import "WebViewViewController.h"
#import "GuideView.h"
@interface SVHomeViewController ()<UIScrollViewDelegate>
@property (nonatomic, strong) CADisplayLink *displayLink;
@property (nonatomic, assign) CGFloat valumsSeconds;
@property (nonatomic, assign) BOOL isStart;
@property (nonatomic, strong) PrivacyView *privacyView;
@property (nonatomic, strong) UIScrollView *farScrollView;
@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, strong) LOTAnimationView *loadingView;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UIButton *timeButton;
@property (nonatomic, strong) UIButton *playButton;
@property (nonatomic, strong) UIButton *sceneButton;
@property (nonatomic, strong) TimerView *timeView;
@property (nonatomic, strong) PQ_TimerManager *playerTimer;
@property (nonatomic, assign) NSInteger currentSeconds;
@property (nonatomic, assign) NSInteger lastSeconds;
@property (nonatomic, strong) NSURL *currentUrl;
@property (nonatomic, strong) GuideView *guideView;
@property (nonatomic, assign) CGFloat animationProgress;
@end

@implementation SVHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNav];
    [self initData];
    [self setUI];
    [self may_layoutSubviews];
    [self isFirstLaunch];
    // Do any additional setup after loading the view.
}

-(void)setNav
{
    self.title = @"山谷";
   // [self setLeftNavBar:@"main_left"];
    [self setRightNavBar:@"main_right"];
}

-(void)initData
{
    // record first play animation progress
    self.animationProgress = 0.f;
    NSArray *array = [InitData getSceneListData];
    self.currentUrl = [NSURL fileURLWithPath:array[self.currentIndex][@"voice"]];
    self.currentSeconds = [[[NSUserDefaults standardUserDefaults] objectForKey:CURRENT_TIME] integerValue];
    self.lastSeconds = self.currentSeconds;
}

-(void)backClick
{
    SceneListViewController *vc = [[SceneListViewController alloc] init];
    __weak typeof(self) weakSelf = self;
    vc.playSceneVoice = ^(NSDictionary * _Nonnull dic) {
        [weakSelf destoryTimer];
        weakSelf.timeLabel.text =  [Tools getSecondsStr:weakSelf.currentSeconds];
        weakSelf.currentIndex = [dic[@"index"] integerValue];
        weakSelf.title = [dic[@"title"] description];
        weakSelf.playButton.selected = NO;
        self.currentUrl = [NSURL fileURLWithPath:dic[@"voice"]];
        [weakSelf clickPlayButton];
        dispatch_async(dispatch_get_main_queue(), ^{
            CGPoint position = CGPointMake(weakSelf.currentIndex*SCREEN_WIDTH, 0);
            [weakSelf.farScrollView setContentOffset:position animated:NO];
        });
    };
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)setUI
{
    self.currentIndex = 0;
    [self.view addSubview:self.farScrollView];
    NSArray *array = [InitData getSceneListData];
    for (int i= 0; i<array.count; i++) {
       SVViewController *childVC = [SVViewController new];
       childVC.view.frame = CGRectMake(i * SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
       [self addChildViewController:childVC];
       [self.farScrollView addSubview:childVC.view];
       NSDictionary *info = array[i];
       childVC.background.clipsToBounds = YES;
       childVC.background.contentMode = UIViewContentModeScaleAspectFill;
       childVC.background.image = [UIImage imageNamed:info[@"bigIcon"]];
     }
     [self.view addSubview:self.loadingView];
     [self.view addSubview:self.playButton];
     [self.view addSubview:self.timeLabel];
     [self.view addSubview:self.timeButton];
     [self.view addSubview:self.sceneButton];
}

-(void)may_layoutSubviews
{
    [self.loadingView mas_makeConstraints:^(MASConstraintMaker *make) {
         make.centerY.equalTo(self.view).offset(-30);
         make.centerX.equalTo(self.view);
         make.height.width.mas_equalTo(ScaleFit(300));
     }];
    [self.playButton mas_makeConstraints:^(MASConstraintMaker *make) {
     //   make.size.mas_equalTo(CGSizeMake(ScaleFit(60), ScaleFit(60)));
//       make.left.mas_equalTo(self.view);
//        make.right.mas_equalTo(self.view);
        make.centerX.equalTo(self.view);
       // make.center.mas_equalTo(self.loadingView);
        make.bottom.mas_equalTo(self.view.mas_bottom).offset( IS_IPhoneXAll ? -63:-30);
    }];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       // make.left.mas_equalTo(self.view);
       // make.right.mas_equalTo(self.view);
        make.height.mas_equalTo(30);
        make.center.mas_equalTo(self.loadingView);
        //make.bottom.mas_equalTo(self.view.mas_bottom).offset( IS_IPhoneXAll ? -103:-70);
    }];
    [self.timeButton mas_makeConstraints:^(MASConstraintMaker *make) {
       // make.size.mas_equalTo(CGSizeMake(ScaleFit(60), ScaleFit(60)));
      //  make.size.mas_equalTo(CGSizeMake(ScaleFit(60), ScaleFit(60)));

        make.centerX.equalTo(self.view).offset(100);
        make.bottom.mas_equalTo(self.view.mas_bottom).offset( IS_IPhoneXAll ? -63:-30);

       // make.bottom.equalTo(self.view.mas_bottom).offset(IS_IPhoneXAll ?-63:-30);
    }];
    [self.sceneButton mas_makeConstraints:^(MASConstraintMaker *make) {
      //  make.size.mas_equalTo(CGSizeMake(ScaleFit(60), ScaleFit(60)));
       // make.size.mas_equalTo(CGSizeMake(ScaleFit(60), ScaleFit(60)));
        make.centerX.equalTo(self.view).offset(-100);
        make.bottom.mas_equalTo(self.view.mas_bottom).offset( IS_IPhoneXAll ? -63:-30);

       // make.bottom.equalTo(self.view.mas_bottom).offset(IS_IPhoneXAll ?-63:-30);
    }];
}

// click playButton action
-(void)clickPlayButton
{
    self.playButton.selected = !self.playButton.selected;
    if (self.playButton.selected) {
        self.isStart = YES;
        // play audio
        [[SVPlayerManager sharedInstance] playMusicWithFilePath:self.currentUrl];
        [self startVolumChange];
        [self playLoadView];
        [self startTimer];
    }else{
        self.isStart = NO;
        // pause audio
        [[SVPlayerManager sharedInstance] pause];
        // Recording pause animation time
        self.animationProgress = self.loadingView.animationProgress;
        NSLog(@"animationProgress----------%f",self.loadingView.animationProgress);
        [self.loadingView pause];
        [self pausePlayTimer];
    }
}

// play loadView
-(void)playLoadView
{
    [self.loadingView playFromProgress:self.animationProgress toProgress:1 withCompletion:^(BOOL animationFinished) {
        if (animationFinished) {
          NSLog(@"animationFinished----------%f",self.loadingView.animationProgress);
          self.animationProgress = 0;
          [self playLoadView];
        }
    }];
}

-(void)stopPlayLoadView
{
    [self.loadingView stop];
}

// pause loadingView
-(void)pauseLoadingView
{
    [self.loadingView pause];
}

-(void)clickTimeButtonAction
{
    self.timeView = [[TimerView alloc] initWithFrame:CGRectZero];
    self.timeView.userInteractionEnabled = YES;
    self.timeView.arrTimeModel = [InitData getAllSecond];
    __weak typeof(self) weakSelf = self;
    self.timeView.clickConfirmButtonAction = ^(NSInteger time) {
        weakSelf.currentSeconds = time;
        weakSelf.lastSeconds = time;
        [[NSUserDefaults standardUserDefaults] setObject:@(time) forKey:CURRENT_TIME];
        weakSelf.timeLabel.text = [Tools getSecondsStr:time];
    };
    [self.timeView show];
}

- (void)startTimer
{
    //    进入后台后使定时器持续运行
    [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:^{
        [[UIApplication sharedApplication]endBackgroundTask:UIBackgroundTaskInvalid];
    }];
    self.playerTimer = [PQ_TimerManager pq_createTimerWithType:PQ_TIMERTYPE_CREATE_OPEN updateInterval:self.currentSeconds repeatInterval:1 update:^{
        self.currentSeconds --;
         self.timeLabel.text = [Tools getSecondsStr:self.currentSeconds];
         if (self.currentSeconds <= 0) {
             // 播放结束 时间置为原始值
             self.currentSeconds = self.lastSeconds;
             self.timeLabel.text = [Tools getSecondsStr:self.currentSeconds];
             [self.playerTimer pq_close];
             self.playButton.selected = NO;
             [self.loadingView stop];
             [[SVPlayerManager sharedInstance] stopPlay];
         }
    }];
}

-(void)pausePlayTimer
{
    [self.playerTimer pq_pause];
}

// destory playTimer
-(void)destoryTimer
{
    [self.playerTimer pq_close];
    self.playerTimer = nil;
}

-(void)rightClick
{
    PersonCenterViewController *vc = [[PersonCenterViewController alloc] init];
    vc.currentBackGroundImage = [InitData getSceneListData][self.currentIndex][@"bigIcon"];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)isFirstLaunch
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    NSString *isFirstLaunch = [[NSUserDefaults standardUserDefaults]
                               objectForKey:IS_FIRSTLAUNCH];
    NSLog(@"IS_AGREE--------%ld",[[NSUserDefaults standardUserDefaults] boolForKey:IS_AGREE]);
    if (!isFirstLaunch) {
        // TODO:
        [[NSUserDefaults standardUserDefaults] setObject:@(900) forKey:CURRENT_TIME];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:IS_AUTOPLAYAUDIO];
        [[NSUserDefaults standardUserDefaults] setObject:IS_FIRSTLAUNCH forKey:IS_FIRSTLAUNCH];
        self.currentSeconds = [[[NSUserDefaults standardUserDefaults] objectForKey:CURRENT_TIME] integerValue];
        self.timeLabel.text = [Tools getSecondsStr:self.currentSeconds];
    }
    if ([[NSUserDefaults standardUserDefaults] boolForKey:IS_AGREE] == NO) {
        WEAKSELF;
        if (!isFirstLaunch) {
            GuideView *guideView = [[GuideView alloc] initWithFrame:self.view.bounds];
            guideView.guideActionBlock = ^{
                [weakSelf.view addSubview:weakSelf.privacyView];
            };
            [guideView showGuideView];
        }else{
            [self.view addSubview:self.privacyView];
        }
        self.privacyView.clickPrivacyAction = ^{
           WebViewViewController *vc = [[WebViewViewController alloc] init];
           vc.title = @"轻睡协议";
           vc.urlString = @"https://mp.weixin.qq.com/s/_Gqap-_aVU528qkgqglJEQ";
           [weakSelf.navigationController pushViewController:vc animated:YES];
       };
    }
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger index = scrollView.contentOffset.x / SCREEN_WIDTH;
    NSString *title = [NSString stringWithFormat:@"%@",[InitData getSceneListData][index][@"title"]];
    self.title = title;
    [self showChildVC:index];
}

- (void)showChildVC:(NSInteger)index
{
    self.currentIndex = index;
    NSArray *array = [InitData getSceneListData];
    SVViewController *childVC = self.childViewControllers[index];
    self.farScrollView.contentOffset = CGPointMake(index * SCREEN_WIDTH, 0);
//    for (int i = 0; i<array.count; i++) {
//         if (i != index) {
//             // stop playLoadView
//             [self stopPlayLoadView];
//             // destory playTimer
//             [self destoryTimer];
//
//             self.currentSeconds =  [[[NSUserDefaults standardUserDefaults] objectForKey:CURRENT_TIME] integerValue];
//             self.lastSeconds = self.currentSeconds;
//             self.timeLabel.text = [Tools getSecondsStr:self.currentSeconds];
//             dispatch_async(dispatch_get_main_queue(), ^{
//                self.playButton.selected = NO;
//             });
//         }
//    }
    if (childVC.isViewLoaded) {
        NSString *path = array[index][@"voice"];
        self.currentUrl = [NSURL fileURLWithPath:array[self.currentIndex][@"voice"]];
        if ([[NSUserDefaults standardUserDefaults] boolForKey:IS_AUTOPLAYAUDIO]) {
            // auto play
            // play loadView
//            [self playLoadView];
            if(!self.loadingView.isAnimationPlaying)
            {
                [self playLoadView];
            }
            [self destoryTimer];
            // start Timer
            [self startTimer];
            self.isStart = YES;
            [self startVolumChange];
            [[SVPlayerManager sharedInstance] playMusicWithFilePath:[NSURL fileURLWithPath:path]];
            dispatch_async(dispatch_get_main_queue(), ^{
                self.playButton.selected = YES;
            });
        }else{
            self.isStart = NO;
            self.playButton.selected = NO;
            // pause PlayTimer
            [self pausePlayTimer];
            [[SVPlayerManager sharedInstance] stopPlay];
            // stop playLoadView
            [self.loadingView pause];
        }
        return;
    }
//    [self.farScrollView addSubview:vc.view];
//    vc.view.frame = CGRectMake(offsetX, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
}

- (void)startVolumChange
{
    [self.displayLink invalidate];
    self.displayLink = nil;
    self.valumsSeconds = self.isStart ? 0 : 0.7;
    self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(changeValum)];
    [self.displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)changeValum
{
    if (self.isStart) {
        self.valumsSeconds += 0.70 / 180;
        if (self.valumsSeconds >= 0.7) {
            [self.displayLink invalidate];
            self.displayLink = nil;
        }
    } else {
        self.valumsSeconds -= 0.70 / 180;
        if (self.valumsSeconds <= 0) {
            [self.displayLink invalidate];
            self.displayLink = nil;
        }
    }
    [[SVPlayerManager sharedInstance] setCustomVolume:self.valumsSeconds];
}

-(UIButton *)sceneButton
{
    if (!_sceneButton) {
        _sceneButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_sceneButton setImage:[UIImage imageNamed:@"main_left"] forState:UIControlStateNormal];
        [_sceneButton setTitle:@"场景" forState:UIControlStateNormal];
        _sceneButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;//使图片和文字水平居中显示
        _sceneButton.imageEdgeInsets = UIEdgeInsetsMake(-_sceneButton.titleLabel.intrinsicContentSize.height, 0, 0, -_sceneButton.titleLabel.intrinsicContentSize.width);
        _sceneButton.titleEdgeInsets = UIEdgeInsetsMake(_playButton.currentImage.size.height+20, -(_sceneButton.currentImage.size.width-10), 0, 0);
        _sceneButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_sceneButton addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sceneButton;
}


-(UIButton *)playButton
{
    if (!_playButton) {
        _playButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_playButton setImage:[UIImage imageNamed:@"main_play"] forState:UIControlStateNormal];
        [_playButton setImage:[UIImage imageNamed:@"main_pause"] forState:UIControlStateSelected];
        [_playButton setTitle:@"播放" forState:UIControlStateNormal];
        [_playButton setTitle:@"停止" forState:UIControlStateSelected];
       _playButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;//使图片和文字水平居中显示
        _playButton.imageEdgeInsets = UIEdgeInsetsMake(-_playButton.titleLabel.intrinsicContentSize.height, 0, 0, -_playButton.titleLabel.intrinsicContentSize.width);
      _playButton.titleEdgeInsets = UIEdgeInsetsMake(_playButton.currentImage.size.height+20, -(_playButton.currentImage.size.width-10), 0, 0);
        _playButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_playButton addTarget:self action:@selector(clickPlayButton) forControlEvents:UIControlEventTouchUpInside];
    }
    return _playButton;
}

- (UIScrollView *)farScrollView
{
    if (!_farScrollView) {
        _farScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _farScrollView.contentSize = CGSizeMake(SCREEN_WIDTH * [InitData getSceneListData].count, 0);
        _farScrollView.pagingEnabled = YES;
        _farScrollView.userInteractionEnabled = YES;
        _farScrollView.bounces = NO;
        _farScrollView.showsHorizontalScrollIndicator = NO;
        _farScrollView.delegate = self;
    }
    return _farScrollView;
}

- (LOTAnimationView *)loadingView
{
    if (!_loadingView) {
        _loadingView = [LOTAnimationView animationNamed:@"clock" inBundle:[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:@"animation" ofType:@"bundle"]]];
     //   _loadingView = [LOTAnimationView animationNamed:@"shenggu4s" inBundle:[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:@"animation" ofType:@"bundle"]]];
//        _loadingView.autoReverseAnimation = YES;
     // _loadingView.loopAnimation = YES;
        _loadingView.cacheEnable = YES;
        _loadingView.shouldRasterizeWhenIdle = YES;
    }
    return _loadingView;
}

-(UILabel *)timeLabel
{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.textColor = [UIColor whiteColor];
        _timeLabel.font =  [UIFont fontWithName:@"DINAlternate-Bold" size:34];
        _timeLabel.textAlignment = NSTextAlignmentCenter;
        _timeLabel.text = [Tools getSecondsStr:self.currentSeconds];
        _timeLabel.userInteractionEnabled = NO;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickTimeButtonAction)];
        [_timeLabel addGestureRecognizer:tap];
    }
    return _timeLabel;
}

-(UIButton *)timeButton
{
    if (!_timeButton) {
        _timeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_timeButton setImage:[UIImage imageNamed:@"main_timer"] forState:UIControlStateNormal];
        [_timeButton setTitle:@"定时" forState:UIControlStateNormal];
        _timeButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;//使图片和文字水平居中显示
        _timeButton.imageEdgeInsets = UIEdgeInsetsMake(-_timeButton.titleLabel.intrinsicContentSize.height, 0, 0, -_timeButton.titleLabel.intrinsicContentSize.width);
        _timeButton.titleEdgeInsets = UIEdgeInsetsMake(_playButton.currentImage.size.height+20, -(_timeButton.currentImage.size.width-10), 0, 0);
        _timeButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_timeButton setTitleColor:[UIColor colorWithWhite:1 alpha:0.5] forState:UIControlStateNormal];
        [_timeButton addTarget:self action:@selector(clickTimeButtonAction) forControlEvents:UIControlEventTouchUpInside];
        _timeButton.imageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _timeButton;
}

-(PrivacyView *)privacyView
{
    if (!_privacyView) {
        _privacyView = [[PrivacyView alloc] initWithFrame:self.view.bounds];
    }
    return _privacyView;
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
