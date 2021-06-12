//
//  ShareViewController.m
//  SoundValley
//
//  Created by apple on 2020/5/3.
//  Copyright © 2020 apple. All rights reserved.
//

#import "ShareViewController.h"
#import "KJBannerHeader.h"
#import "SaveView.h"
#import "SVNetWorkManager.h"
@interface ShareViewController ()<UIGestureRecognizerDelegate>
@property (nonatomic,strong)KJBannerView *banner;
@property (nonatomic,strong)SaveView *saveView;
@property (nonatomic,strong)NSMutableArray *shareImages;
//@property (nonatomic,strong)UIButton *hiddenButton;
@end

@implementation ShareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNav];
    [self configBackgroudColor];
    [self setUI];
    [self mas_layoutSubviews];
    [self requestData];
    // Do any additional setup after loading the view.
}

-(void)setNav
{
    self.title = @"分享";
    [self setLeftNavBar:@"health_close"];
}

-(void)setUI
{
    [self.view addSubview:self.banner];
    [self.view addSubview:self.saveView];
//    [self.view addSubview:self.hiddenButton];
}

-(void)mas_layoutSubviews
{
    [self.saveView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(60);
        make.right.equalTo(self.view.mas_right).offset(-60);
        make.bottom.equalTo(self.view.mas_bottom).offset(IS_IPhoneXAll ?-83:-50);
        make.height.mas_equalTo(50);
    }];
//    [self.hiddenButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.size.mas_equalTo(CGSizeMake(90, 30));
//        make.top.equalTo(self.saveView.mas_bottom).offset(30);
//        make.centerX.equalTo(self.view);
//    }];
}

-(void)requestData
{
    self.shareImages = [NSMutableArray new];
    [[SVNetWorkManager sharedInstance] postBannerWithBlock:^(id  _Nonnull responseObject, NSError * _Nonnull error) {
        if([responseObject[@"code"] integerValue] == 100)
        {
            for (NSDictionary *dic in responseObject[@"data"]) {
                [self.shareImages addObject:dic[@"shareImgUrl"]];
            }
            [[NSUserDefaults standardUserDefaults] setObject:self.shareImages forKey:@"SHARE_IMAGE_CACHE"];
            dispatch_async(dispatch_get_main_queue(), ^{
                self.banner.imageDatas = self.shareImages;
            });
        }else
        {
            
        }
    }];
}

// save current banner image
-(void)clickSaveViewAction
{
    NSLog(@"currentBannerIndex------%ld",self.banner.index);
//    if (self.shareImages.count != 0) {
//       NSURL *url = [NSURL URLWithString:self.shareImages[self.banner.index]];
//        // 获取的图片地址
//       UIImage *image = [UIImage imageWithData: [NSData dataWithContentsOfURL:url]];
//
//       [self loadImageFinished:image];
//    }
    UIImage *image =[UIImage imageNamed:@"shareScan"];
    [self loadImageFinished:image];
}

// save photo
- (void)loadImageFinished:(UIImage *)image
{
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), (__bridge void *)self);
}
 
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (!error) {
        [self.view makeToast:@"保存成功"];
    }
    NSLog(@"image = %@, error = %@, contextInfo = %@", image, error, contextInfo);
}

//-(void)clickHiddenButtonAction:(UIButton *)sender
//{
//    sender.selected = !sender.selected;
//}

-(KJBannerView *)banner
{
    if (!_banner) {
        _banner = [[KJBannerView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width,ScaleFit(360))];
        _banner.imgCornerRadius = 20;
        _banner.autoScrollTimeInterval = 2;
        _banner.isZoom = NO;
        _banner.infiniteLoop = NO;
        _banner.autoScroll = NO;
        _banner.itemSpace = 40;
        _banner.itemWidth = ScaleFit(200);
        _banner.imageType = KJBannerViewImageTypeMix;
        if ([[NSUserDefaults standardUserDefaults] objectForKey:@"SHARE_IMAGE_CACHE"]) {
              self.shareImages = [[NSUserDefaults standardUserDefaults] objectForKey:@"SHARE_IMAGE_CACHE"];
              _banner.imageDatas = self.shareImages;
          }
      //  _banner.imageDatas = @[@"sg-big",@"sl-big",@"hl-big",@"ht-big",@"hp-big",@"gl-big",@"yt-big",@"yd-big",@"sd-big",
      // @"wq-big",@"ddsz-big",@"ppq-big",@"jpdz-big",@"qb-big"];
        _banner.imageDatas = @[@"shareScan"];
        
        _banner.pageControl.hidden = YES;
        _banner.center = self.view.center;
    }
    return _banner;
}

-(SaveView *)saveView
{
    if (!_saveView) {
        _saveView = [[SaveView alloc] init];
        _saveView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickSaveViewAction)];
        [_saveView addGestureRecognizer:tap];
    }
    return _saveView;
}

//-(UIButton *)hiddenButton
//{
//    if (!_hiddenButton) {
//        _hiddenButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        [_hiddenButton setTitle:@"隐藏二维码" forState:UIControlStateNormal];
//        [_hiddenButton setTitleColor:RGB(184, 184, 184, 1) forState:UIControlStateNormal];
//        [_hiddenButton setImage:[UIImage imageNamed:@"unselect"] forState:UIControlStateNormal];
//        [_hiddenButton setImage:[UIImage imageNamed:@"select"] forState:UIControlStateSelected];
//        _hiddenButton.titleLabel.font = [UIFont systemFontOfSize:13];
//        _hiddenButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
//        _hiddenButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 80);
//        _hiddenButton.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
//        [_hiddenButton addTarget:self action:@selector(clickHiddenButtonAction:) forControlEvents:UIControlEventTouchUpInside];
//    }
//    return _hiddenButton;
//}

-(void)viewWillAppear:(BOOL)animated
{
    //设置导航栏背景图片为一个空的image，这样就透明了
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : RGB(35, 35, 35, 1),
    NSFontAttributeName : [UIFont fontWithName:@"Helvetica-Bold" size:17]}];
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    //去掉透明后导航栏下边的黑边
     [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
     [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault; //黑色
    if([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
          self.navigationController.interactivePopGestureRecognizer.delegate = self;
    }
}

- (void)configBackgroudColor
{
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = self.view.bounds;
    //将CAGradientlayer对象添加在我们要设置背景色的视图的layer层
    [self.view.layer addSublayer:gradientLayer];
    //设置渐变区域的起始和终止位置（范围为0-1）
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(0, 1);
    //设置颜色数组
    gradientLayer.colors = @[(__bridge id)HEXCOLOR(0X447494).CGColor,
                             (__bridge id)HEXCOLOR(0Xeadfdb).CGColor];
    //设置颜色分割点（范围：0-1）
    gradientLayer.locations = @[@(0.0f), @(1.0f)];
}

//UIGestureRecognizerDelegate 重写侧滑协议
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    return [self gestureRecognizerShouldBegin];
}

- (BOOL)gestureRecognizerShouldBegin {
    //NSLog(@"~~~~~~~~~~~%@控制器 滑动返回~~~~~~~~~~~~~~~~~~~",[self class]);
    return YES;
}

- (void)viewWillDisappear:(BOOL)animated
{
    //    如果不想让其他页面的导航栏变为透明 需要重置
      [self.navigationController setNavigationBarHidden:NO animated:YES];
      [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
      [self.navigationController.navigationBar setShadowImage:nil];
      [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent; //白色
      [super viewWillDisappear:animated];
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
