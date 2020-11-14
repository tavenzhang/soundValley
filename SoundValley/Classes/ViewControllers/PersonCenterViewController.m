//
//  PersonCenterViewController.m
//  SoundValley
//
//  Created by apple on 2020/5/3.
//  Copyright © 2020 apple. All rights reserved.
//

#import "PersonCenterViewController.h"
#import "PersonerTableViewCell.h"
#import "ShareViewController.h"
#import <StoreKit/StoreKit.h>
#import "UIImage+ZFFilter.h"
#import "WZSwitch.h"
@interface PersonCenterViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSArray *dataArray;
@property (nonatomic,strong)UIImageView *background;
@property (nonatomic,strong)ZJSwitch *switchControl;
@property (nonatomic,strong)WZSwitch *wzSwitchControl;
@end

@implementation PersonCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNav];
    [self setUI];
    // Do any additional setup after loading the view.
}

-(void)setNav
{
    self.title = @"设置";
    [self setLeftNavBar:@"back_icon"];
}

-(void)setUI
{
    [self.view addSubview:self.tableView];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0 ;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 90;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PersonerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LSAlarmSettingCellIdentifier" forIndexPath:indexPath];
    NSDictionary *dic = self.dataArray[indexPath.row];
    cell.titleLabel.text = [dic[@"title"] description];
    cell.icon.image = [UIImage imageNamed:dic[@"icon"]];
    cell.backgroundColor = [UIColor clearColor];
    if(indexPath.row != 0)
    {
        cell.alphaView.hidden = YES;
        cell.switchLabel.hidden = YES;
    }else{
        cell.rightIcon.hidden = YES;
        [cell.contentView addSubview:self.wzSwitchControl];
        BOOL state = [[NSUserDefaults standardUserDefaults] boolForKey:IS_AUTOPLAYAUDIO];
        if (state) {
            cell.switchLabel.text = @"开";
        }else{
            cell.switchLabel.text = @"关";
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.row == 1){
        ShareViewController *vc = [[ShareViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if(indexPath.row == 2){
//        if([SKStoreReviewController respondsToSelector:@selector(requestReview)]) {// iOS 10.3 以上支持
            //防止键盘遮挡
//            [[UIApplication sharedApplication].keyWindow endEditing:YES];
            [SKStoreReviewController requestReview];
//        }
    }
}

-(void)handleSwitchEvent:(BOOL )state
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
                     PersonerTableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    if(state){
          cell.switchLabel.text = @"开";
          [[NSUserDefaults standardUserDefaults] setBool:YES forKey:IS_AUTOPLAYAUDIO];
    }else{
          cell.switchLabel.text = @"关";
          [[NSUserDefaults standardUserDefaults] setBool:NO forKey:IS_AUTOPLAYAUDIO];
    }
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.backgroundView = self.background;
        [_tableView registerClass:[PersonerTableViewCell class] forCellReuseIdentifier:@"LSAlarmSettingCellIdentifier"];
    }
    return _tableView;
}

-(NSArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = @[@{@"icon":@"autoPlay",@"title":@"首页自动播放"},
                       @{@"icon":@"share",@"title":@"分享好友"},
                       @{@"icon":@"score",@"title":@"app评分"}];
    }
    return _dataArray;
}

-(UIImageView *)background
{
    if (!_background) {
        _background = [[UIImageView alloc] init];
        UIImage *image = [UIImage imageNamed:self.currentBackGroundImage];
//        UIImage *changeImage = [UIImage boxblurImage:image withBlurNumber:50];
        _background.image = image;
        _background.frame = self.view.bounds;
        _background.userInteractionEnabled = YES;
        _background.contentMode = UIViewContentModeScaleAspectFill;
        UIBlurEffect *blurEffect =[UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
        UIVisualEffectView *effectView =[[UIVisualEffectView alloc]initWithEffect:blurEffect];
        effectView.frame = self.view.bounds;
        effectView.alpha = 1;
        [_background addSubview:effectView];
    }
   return _background;
}

-(WZSwitch *)wzSwitchControl
{
    if (!_wzSwitchControl) {
        _wzSwitchControl = [[WZSwitch alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 68, 33, 48, 24)];
        WEAKSELF;
        BOOL state = [[NSUserDefaults standardUserDefaults] boolForKey:IS_AUTOPLAYAUDIO];
        [_wzSwitchControl setSwitchState:state animation:NO];
        _wzSwitchControl.block = ^(BOOL state) {
            [weakSelf handleSwitchEvent:state];
            NSLog(@"state--------%ld",state);
        };
    }
    return _wzSwitchControl;
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
