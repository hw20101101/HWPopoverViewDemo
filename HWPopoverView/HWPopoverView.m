//
//  HWPopoverView.m
//  HWPopoverViewDemo
//
//  Created by hw on 16/9/27.
//  Copyright © 2016年 hw. All rights reserved.
//

#import "HWPopoverView.h"
#import "HWPopoverCell.h"

@interface HWPopoverView ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UIView *backgroundView;
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) NSArray *icons;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIImageView *triangleView;

@end

@implementation HWPopoverView

- (instancetype)initWithTitles:(NSArray *)titles icons:(NSArray *)icons didSelectCallBack:(void (^)(NSInteger selectIndex))didSelectCallBack
{
    if (self = [super init]) {
        _titles = titles;
        _icons  = icons;
        _didSelectCallBack = didSelectCallBack;
        [self initUI];
    }
    return self;
}

- (void)initUI
{
    __weak typeof(self) weakSelf = self;
    
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
    self.triangleView.image = [UIImage imageNamed:@"triangle_white"];
    [window addSubview:self.triangleView];
    [self.triangleView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@66);
        make.right.equalTo(@-15);
        make.size.mas_equalTo(CGSizeMake(22, 9));
    }];
    
    self.tableView = [UITableView new];
    self.tableView.alpha = 0;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.scrollEnabled = NO;
    self.tableView.layer.cornerRadius = 4;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [window addSubview:self.tableView];
    
    CGFloat height = self.titles.count * 44;
    [self.tableView makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@-5);
        make.top.equalTo(weakSelf.triangleView.bottom);
        make.size.mas_equalTo(CGSizeMake(120, height));
    }];
    
    [UIView animateWithDuration:0.5 animations:^{
        weakSelf.backgroundView.alpha = 0.1;
        weakSelf.triangleView.alpha = 1;
        weakSelf.tableView.alpha = 1;
    }];
}

- (void)viewTapAction
{
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.5 animations:^{
        weakSelf.backgroundView.alpha = 0;
        weakSelf.triangleView.alpha = 0;
        weakSelf.tableView.alpha = 0;
        weakSelf.alpha = 0;
        
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
