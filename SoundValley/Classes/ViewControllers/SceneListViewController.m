//
//  SceneListViewController.m
//  SoundValley
//
//  Created by apple on 2020/5/2.
//  Copyright © 2020 apple. All rights reserved.
//

#import "SceneListViewController.h"
#import "SceneListCollectionViewCell.h"
#import "InitData.h"
@interface SceneListViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic,strong)NSArray *dataArray;
@property (nonatomic,strong)UICollectionView *collectionView;
@end

@implementation SceneListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNav];
    [self initData];
    [self setUI];
    // Do any additional setup after loading the view.
}

-(void)setNav
{
    self.title = @"场景音效";
    [self setLeftNavBar:@"black_left_arrow"];
}

-(void)viewWillAppear:(BOOL)animated
{
    //设置导航栏背景图片为一个空的image，这样就透明了
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault; //黑色
     [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : RGB(35, 35, 35, 1),
     NSFontAttributeName : [UIFont fontWithName:@"Helvetica-Bold" size:17]}];
     [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
}

-(void)viewWillDisappear:(BOOL)animated
{
    //    如果不想让其他页面的导航栏变为透明 需要重置
   [self.navigationController setNavigationBarHidden:NO animated:YES];
   [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
   [self.navigationController.navigationBar setShadowImage:nil];
   [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent; //白色
   [super viewWillDisappear:animated];
}

-(void)setUI
{
    if([self respondsToSelector:@selector(automaticallyAdjustsScrollViewInsets)])
    {
       self.automaticallyAdjustsScrollViewInsets = NO;
       UIEdgeInsets insets = self.collectionView.contentInset;
       insets.top = 20;
       self.collectionView.contentInset =insets;
       self.collectionView.scrollIndicatorInsets = insets;
    }
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.collectionView];
}

-(UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.minimumLineSpacing = 10.0;
        layout.minimumInteritemSpacing = 0;
        layout.sectionInset = UIEdgeInsetsMake(0, 30.0, 0, 30.0);
        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerClass:[SceneListCollectionViewCell class] forCellWithReuseIdentifier:@"SceneListCollectionViewCell"];
    }
    return _collectionView;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake( (SCREEN_WIDTH - 90)/2, 150);
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SceneListCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SceneListCollectionViewCell" forIndexPath:indexPath];
    NSDictionary *dic = self.dataArray[indexPath.row];
    cell.iconImageView.image = [UIImage imageNamed:dic[@"icon"]];
    cell.sceneTitleLabel.text = dic[@"title"];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic = self.dataArray[indexPath.item];
    if (self.playSceneVoice) {
        self.playSceneVoice(dic);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

// 隐藏导航栏-不随tableView滑动消失效果
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    //scrollView已经有拖拽手势，直接拿到scrollView的拖拽手势
    UIPanGestureRecognizer *pan = scrollView.panGestureRecognizer;
    //获取到拖拽的速度 >0 向下拖动 <0 向上拖动
    CGFloat velocity = [pan velocityInView:scrollView].y;
    if (velocity <- 5) {
        //向上拖动，隐藏导航栏
        [self.navigationController setNavigationBarHidden:YES animated:YES];
    }else if (velocity > 5) {
        //向下拖动，显示导航栏
        [self.navigationController setNavigationBarHidden:NO animated:YES];
    }else if(velocity == 0){
        //停止拖拽
    }
}

-(void)initData
{
    self.dataArray = [InitData getSceneListData];
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
