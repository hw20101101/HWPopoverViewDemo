//
//  HWPopoverView.m
//  HWPopoverViewDemo
//
//  Created by hw on 16/9/27.
//  Copyright © 2016年 hw. All rights reserved.
//

#define kRowHeight 44
#define kTableViewWidth 120
#define RGB(r,g,b) ([UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1.0f])

#import "HWPopoverView.h"
#import "HWPopoverCell.h"

@interface HWPopoverView ()<UITableViewDelegate, UITableViewDataSource>

/**
 HWPopoverView的样式
 */
@property (nonatomic, assign) HWPopoverViewStyle style;
@property (nonatomic, assign) CGFloat tableViewHeight;

/**
 透明背景视图
 */
@property (nonatomic, strong) UIView  *backgroundView;


/**
 标题数组
 */
@property (nonatomic, strong) NSArray *titles;


/**
 图标数组
 */
@property (nonatomic, strong) NSArray *icons;
@property (nonatomic, strong) UITableView *tableView;

/**
 三角形图片
 */
@property (nonatomic, strong) UIImageView *triangleView;

/**
 选中item之后的回调
 */
@property (nonatomic, copy) void (^didSelectCallBack)(NSInteger selectIndex);

@end

@implementation HWPopoverView

- (instancetype)initWithTitles:(NSArray *)titles icons:(NSArray *)icons style:(HWPopoverViewStyle)style didSelectCallBack:(void (^)(NSInteger selectIndex))didSelectCallBack
{
    if (self = [super init]) {
        _titles = titles;
        _icons  = icons;
        _style  = style;
        _didSelectCallBack = didSelectCallBack;
        _tableViewHeight = titles.count * kRowHeight - 1;//height - 1:隐藏最后一条分割线
        [self initUI];
        [self updateConstraint];
        [self startAnimation];
    }
    return self;
}

- (void)initUI
{
    //透明背景视图
    self.backgroundView = [[UIView alloc] init];
    self.backgroundView.alpha = 0;
    self.backgroundView.backgroundColor = RGB(100, 100, 100);
    self.backgroundView.userInteractionEnabled = YES;
    [self.backgroundView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapAction)]];
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    [window addSubview:self.backgroundView];
    
    [self.backgroundView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(window);
    }];
    
    //三角形图片
    self.triangleView = [UIImageView new];
    self.triangleView.alpha = 0;
    [window addSubview:self.triangleView];
    
    [self.triangleView makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(22, 9));
    }];
    
    self.tableView = [UITableView new];
    self.tableView.alpha = 0;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.scrollEnabled = NO;
    self.tableView.layer.cornerRadius = 4;
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 0, kTableViewWidth, 0.5);
    [window addSubview:self.tableView];
    
    __weak typeof(self) weakSelf = self;
    [self.tableView makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kTableViewWidth, weakSelf.tableViewHeight));
    }];
}

- (void)startAnimation
{
    __weak typeof(self) weakSelf = self;
    
    [UIView animateWithDuration:0.5 animations:^{
        weakSelf.backgroundView.alpha = 0.1;
        weakSelf.triangleView.alpha = 1;
        weakSelf.tableView.alpha = 1;
    }];
}

- (void)updateConstraint
{
    __weak typeof(self) weakSelf = self;
    
    if(self.style == HWPopoverViewStyleRightBottom){
        
        self.triangleView.image = [UIImage imageNamed:@"triangle_down"];
        [self.triangleView updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(@-15);
            make.right.equalTo(@-15);
        }];
        
        [self.tableView updateConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(@-5);
            make.bottom.equalTo(weakSelf.triangleView.top);
        }];
        
    } else if(self.style == HWPopoverViewStyleLeftBottom){
        
        self.triangleView.image = [UIImage imageNamed:@"triangle_down"];
        [self.triangleView updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(@-15);
            make.left.equalTo(@15);
        }];
        
        [self.tableView updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@5);
            make.bottom.equalTo(weakSelf.triangleView.top);
        }];
        
    } else if(self.style == HWPopoverViewStyleLeftTop){
        
        self.triangleView.image = [UIImage imageNamed:@"triangle_up"];
        [self.triangleView updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@66);
            make.left.equalTo(@15);
        }];
        
        [self.tableView updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@5);
            make.top.equalTo(weakSelf.triangleView.bottom);
        }];
        
    } else {
        
        self.triangleView.image = [UIImage imageNamed:@"triangle_up"];
        [self.triangleView updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@66);
            make.right.equalTo(@-15);
        }];
        
        [self.tableView updateConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(@-5);
            make.top.equalTo(weakSelf.triangleView.bottom);
        }];
    }
}

#pragma mark - 透明背景视图点击事件
- (void)viewTapAction
{
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.5 animations:^{
        weakSelf.backgroundView.alpha = 0;
        weakSelf.triangleView.alpha = 0;
        weakSelf.tableView.alpha = 0;
        
    } completion:^(BOOL finished) {
        [weakSelf.backgroundView removeFromSuperview];
        [weakSelf.tableView removeFromSuperview];
        [weakSelf.triangleView removeFromSuperview];
        [weakSelf removeFromSuperview];
        weakSelf.backgroundView = nil;
        weakSelf.triangleView = nil;
        weakSelf.tableView = nil;
    }];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.titles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"UITableViewCell";
    HWPopoverCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[HWPopoverCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    cell.text = self.titles[indexPath.row];
    cell.iconName = self.icons[indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.didSelectCallBack) {
        self.didSelectCallBack(indexPath.row);
    }
    
    [self viewTapAction];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
