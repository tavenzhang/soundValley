//
//  StoryViewController.m
//  SoundValley
//
//  Created by apple on 2021/7/25.
//  Copyright © 2021 apple. All rights reserved.
//

#import "StoryViewController.h"
#import "KJBannerHeader.h"
#import <StoreKit/StoreKit.h>
#import "ShareViewController.h"
@interface StoryViewController ()
@property (nonatomic,strong)UILabel *titleLabel;
@property (nonatomic,strong)UILabel *subtitleLabel;
@property (nonatomic,strong)UILabel *descLabel;
@property (nonatomic,strong)UIButton *evaluateButton;
@property (nonatomic,strong)UIButton *shareButton;
@property (nonatomic,strong)KJBannerView *banner;
@end

@implementation StoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configerUI];
    // Do any additional setup after loading the view.
}

-(void)configerUI
{
    [self setLeftNavBar:@""];
    [self setRightNavBar:@"health_close"];
    [self.view addSubview:self.titleLabel];
    [self.view addSubview:self.subtitleLabel];
    [self.view addSubview:self.banner];
    [self.view addSubview:self.descLabel];
    [self.view addSubview:self.evaluateButton];
    [self.view addSubview:self.shareButton];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).offset(30);
       // make.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view).offset(90);
    }];
    [self.subtitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).offset(30);
        make.top.mas_equalTo(self.titleLabel).offset(40);
    }];
    [self.descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).offset(30);
        make.right.mas_equalTo(self.view).offset(-30);
        make.top.equalTo(self.banner.mas_bottom).offset(45);
    }];
    [self.evaluateButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).offset(30);
        make.bottom.mas_equalTo(self.view).offset(-50);
        make.size.mas_equalTo(CGSizeMake((SCREEN_WIDTH-90)/2, 40));
    }];
    [self.shareButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.evaluateButton.mas_right).offset(30);
        make.bottom.mas_equalTo(self.view).offset(-50);
        make.size.mas_equalTo(CGSizeMake((SCREEN_WIDTH-90)/2, 40));
    }];
}

-(void)clickShareButtonAction
{
    ShareViewController *vc = [[ShareViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)clickEvaluateButtonAction
{
    [SKStoreReviewController requestReview];
}

-(UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont boldSystemFontOfSize:22];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.text = @"声谷";
        _titleLabel.userInteractionEnabled = NO;
        _titleLabel.textColor = COLOR_WITH_HEX(0x000000);
    }
    return _titleLabel;
}

-(UILabel *)subtitleLabel
{
    if (!_subtitleLabel) {
        _subtitleLabel = [[UILabel alloc] init];
        _subtitleLabel.font = [UIFont systemFontOfSize:13];
        _subtitleLabel.textAlignment = NSTextAlignmentCenter;
        _subtitleLabel.text = @"一起聆听山谷里的声音放松身心";
        _subtitleLabel.textColor = COLOR_WITH_HEX(0x000000);
        _subtitleLabel.userInteractionEnabled = NO;
    }
    return _subtitleLabel;
}

-(UILabel *)descLabel
{
    if (!_descLabel) {
        _descLabel = [[UILabel alloc] init];
        _descLabel.font = [UIFont systemFontOfSize:13];
        _descLabel.textAlignment = NSTextAlignmentCenter;
        _descLabel.numberOfLines = 0;
        NSString *textStr = @"欢迎来到声谷,这里是我们录制的大自然声音和其他放松助眠音效,为了录制采集这些声音,我们去过了很多地方。山谷、丛林、雪山、平原、山丘、湖海...\n在这里希望你可以获得放松的体验。如果你又什么的建议，欢迎给我们评价留言。如果你觉得声谷不错,可以将声谷分享给你的朋友。感谢你的支持！";
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:textStr];
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setLineSpacing:18];
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [textStr length])];
        _descLabel.textColor = COLOR_WITH_HEX(0x757575);
        _descLabel.attributedText = attributedString;
        _descLabel.userInteractionEnabled = NO;
    }
    return _descLabel;
}

-(KJBannerView *)banner
{
    if (!_banner) {
        _banner = [[KJBannerView alloc]initWithFrame:CGRectMake(0, 190, self.view.frame.size.width,ScaleFit(180))];
        _banner.imgCornerRadius = 20;
        _banner.autoScrollTimeInterval = 2;
        _banner.isZoom = NO;
        _banner.infiniteLoop = NO;
        _banner.autoScroll = NO;
        _banner.itemSpace = 15;
        _banner.itemWidth = SCREEN_WIDTH-60;
        _banner.imageType = KJBannerViewImageTypeMix;
        _banner.imageDatas = @[@"p1",@"p2",@"p3",@"p4",@"p5",@"p6",@"p7",@"p8",@"p9",@"p10",@"p11",@"p12",@"p13",@"p14",@"p15",@"p16"];
        _banner.pageControl.hidden = YES;
    }
    return _banner;
}

-(UIButton *)evaluateButton
{
    if (!_evaluateButton) {
        _evaluateButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_evaluateButton setTitle:@"评价留言" forState:UIControlStateNormal];
        _evaluateButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_evaluateButton setTitleColor:HEXCOLOR(0x46bb46) forState:UIControlStateNormal];
        _evaluateButton.layer.masksToBounds = YES;
        _evaluateButton.layer.cornerRadius = 20;
        _evaluateButton.layer.borderWidth = 1;
        _evaluateButton.layer.borderColor = HEXCOLOR(0x46bb46).CGColor;
        [_evaluateButton addTarget:self action:@selector(clickEvaluateButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _evaluateButton;
}

-(UIButton *)shareButton
{
    if (!_shareButton) {
        _shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_shareButton setTitle:@"分享" forState:UIControlStateNormal];
        _shareButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_shareButton setTitleColor:HEXCOLOR(0x46bb46) forState:UIControlStateNormal];
        _shareButton.layer.masksToBounds = YES;
        _shareButton.layer.cornerRadius = 20;
        _shareButton.layer.borderWidth = 1;
        _shareButton.layer.borderColor = HEXCOLOR(0x46bb46).CGColor;
        [_shareButton addTarget:self action:@selector(clickShareButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _shareButton;
}

-(void)rightClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
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
