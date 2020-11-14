//
//  TimerView.m
//  SoundValley
//
//  Created by apple on 2020/5/2.
//  Copyright © 2020 apple. All rights reserved.
//

#import "TimerView.h"
#import "Tools.h"
@interface TimerView ()<
    UIPickerViewDataSource,
    UIPickerViewDelegate
>
@property (nonatomic, assign) NSInteger selectRow;
@property (nonatomic, strong)UIView *container;
@property (nonatomic, strong)UILabel *timeLabel;
@property (nonatomic, strong)UILabel *minuteLabel;
@property (nonatomic, strong) UIPickerView *pickView;
@property (nonatomic, strong)UIButton *confirmButton;
@property (nonatomic, strong)UIView *line1;
@property (nonatomic, strong)UIView *line2;
@end

@implementation TimerView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = [UIApplication sharedApplication].keyWindow.bounds;
        [self addSubview:self.container];
        [self.container addSubview:self.pickView];
        [self.container addSubview:self.timeLabel];
        [self.container addSubview:self.minuteLabel];
        [self.container addSubview:self.confirmButton];
        [self.container addSubview:self.line1];
        [self.container addSubview:self.line2];
    }
    return self;
}

-(void)show
{
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [UIView animateWithDuration:0.3 animations:^{
          CGRect rect = self.container.frame;
          rect.origin.y = SCREEN_HEIGHT - 400;
          self.container.frame = rect;
      }];
     [self.pickView selectRow:2 inComponent:0 animated:NO];
     [self.pickView reloadAllComponents];
}

-(void)clickConfirmAction
{
    NSInteger time =[self.arrTimeModel[[self.pickView selectedRowInComponent:0]] integerValue];
    if (self.clickConfirmButtonAction) {
        self.clickConfirmButtonAction(time);
    }
    [UIView animateWithDuration:0.3 animations:^{
        CGRect rect = self.container.frame;
        rect.origin.y = SCREEN_HEIGHT;
        self.container.frame = rect;
    }completion:^(BOOL finished) {
        [self.container removeFromSuperview];
        [self removeFromSuperview];
    }];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [UIView animateWithDuration:0.3 animations:^{
        CGRect rect = self.container.frame;
        rect.origin.y = SCREEN_HEIGHT;
        self.container.frame = rect;
    }completion:^(BOOL finished) {
        [self.container removeFromSuperview];
        [self removeFromSuperview];
    }];
}

#pragma pickView delegate
//UIPickerViewDataSource中定义的方法，该方法的返回值决定该控件包含的列数
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView*)pickerView
{
    return 1; // 返回1表明该控件只包含1列
}

//UIPickerViewDataSource中定义的方法，该方法的返回值决定该控件指定列包含多少个列表项
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    // 由于该控件只包含一列，因此无须理会列序号参数component
    // 该方法返回teams.count，表明teams包含多少个元素，该控件就包含多少行
    return self.arrTimeModel.count;
}

-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 66;
}

// UIPickerViewDelegate中定义的方法，该方法返回的NSString将作为UIPickerView
// 中指定列和列表项的标题文本
- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    // 由于该控件只包含一列，因此无须理会列序号参数component
    // 该方法根据row参数返回teams中的元素，row参数代表列表项的编号，
    // 因此该方法表示第几个列表项，就使用teams中的第几个元素
    for (UIView *subView in pickerView.subviews) {
        if (subView.frame.size.height <= 1) {//获取分割线view
            subView.hidden = NO;
            subView.frame = CGRectMake(0, subView.frame.origin.y, subView.frame.size.width, 1);
            subView.backgroundColor = [UIColor clearColor];//设置分割线颜色
        }
    }
    return [self.arrTimeModel objectAtIndex:row];
}

-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    CGFloat width = 125.0f;
    CGFloat height = 66.0f;

    UIView * myView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    myView.backgroundColor = [UIColor clearColor];

    UILabel * complateLabel = [[UILabel alloc] init];
    complateLabel.center = myView.center;
    complateLabel.bounds = CGRectMake(0, 0, width, height);
    complateLabel.textColor = RGB(35, 35, 35, 1);
    complateLabel.textAlignment = NSTextAlignmentCenter;
    complateLabel.font = row == self.selectRow ? [UIFont boldSystemFontOfSize:20] : [UIFont boldSystemFontOfSize:20];
    NSInteger time = [self.arrTimeModel[row] integerValue];
//    NSString *timeStr = [Tools getSecondsStr:time];
    complateLabel.text = [NSString stringWithFormat:@"%ld",time/60];
    [myView addSubview:complateLabel];
    ((UIView *)[self.pickView.subviews objectAtIndex:1]).backgroundColor = [UIColor clearColor];
    ((UIView *)[self.pickView.subviews objectAtIndex:2]).backgroundColor = [UIColor clearColor];
    return myView;
}

// 当用户选中UIPickerViewDataSource中指定列和列表项时激发该方法
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    self.selectRow = row;
    [self.pickView reloadAllComponents];
}

-(UIView *)container
{
    if (!_container) {
        _container = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 400)];
        _container.backgroundColor = [UIColor whiteColor];
        _container.layer.masksToBounds = YES;
        _container.layer.cornerRadius = 5;
    }
    return _container;
}

-(UIPickerView *)pickView
{
    if (!_pickView) {
        _pickView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 330)];
        _pickView.delegate = self;
        _pickView.dataSource = self;
    }
    return _pickView;
}

-(UIButton *)confirmButton
{
    if (!_confirmButton) {
        _confirmButton = [[UIButton alloc] initWithFrame:CGRectMake(30, 320, SCREEN_WIDTH -60, 50)];
        [_confirmButton setTitle:@"确定" forState:UIControlStateNormal];
        [_confirmButton addTarget:self action:@selector(clickConfirmAction) forControlEvents:UIControlEventTouchUpInside];
        _confirmButton.backgroundColor = RGB(228, 228, 228, 1);
        [_confirmButton setTitleColor:RGB(35, 35, 35, 1) forState:UIControlStateNormal];
        _confirmButton.titleLabel.font = [UIFont boldSystemFontOfSize:17];
        _confirmButton.layer.masksToBounds = YES;
        _confirmButton.layer.cornerRadius = 10;
    }
    return _confirmButton;
}

-(UILabel *)timeLabel
{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 132, 50, 66)];
        _timeLabel.text = @"定时";
        _timeLabel.font = [UIFont systemFontOfSize:14];
        _timeLabel.textColor = RGB(139, 139, 139, 1);
        _timeLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _timeLabel;
}

-(UILabel *)minuteLabel
{
    if (!_minuteLabel) {
        _minuteLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-90, 132, 50, 66)];
        _minuteLabel.text = @"分钟";
        _minuteLabel.font = [UIFont systemFontOfSize:14];
        _minuteLabel.textColor = RGB(139, 139, 139, 1);
        _minuteLabel.textAlignment = NSTextAlignmentRight;
    }
    return _minuteLabel;
}

-(UIView *)line1
{
    if (!_line1) {
        _line1 = [[UIView alloc] initWithFrame:CGRectMake(30, 132, SCREEN_WIDTH-60, 0.5)];
        _line1.backgroundColor = RGB(139, 139, 139, 0.2);
    }
    return _line1;
}

-(UIView *)line2
{
    if (!_line2) {
        _line2 = [[UIView alloc] initWithFrame:CGRectMake(30, 188, SCREEN_WIDTH-60, 0.5)];
        _line2.backgroundColor = RGB(139, 139, 139, 0.2);
    }
    return _line2;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
