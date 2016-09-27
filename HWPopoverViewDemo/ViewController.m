//
//  ViewController.m
//  HWPopoverViewDemo
//
//  Created by hw on 16/9/27.
//  Copyright © 2016年 hwacdx. All rights reserved.
//

#import "ViewController.h"
#import "HWPopoverView.h"

@interface ViewController ()

@property (nonatomic, strong) HWPopoverView *popoverView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNavigationItem];
    self.title = @"HWPopoverViewDemo";
}

- (void)initNavigationItem
{
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(rightBarButtonItemAction)];
    [self.navigationItem setRightBarButtonItem:item];
}

- (void)rightBarButtonItemAction
{
    NSArray *titles = @[@"添加好友",@"多人会话",@"扫一扫"];
    NSArray *icons = @[@"right_menu_addFriend",@"right_menu_multichat",@"right_menu_QR"];
    self.popoverView = [[HWPopoverView alloc] initWithTitles:titles icons:icons style:HWPopoverViewStyleUpRight didSelectCallBack:^(NSInteger selectIndex) {
        NSLog(@"-->> selectIndex:%ld", (long)selectIndex);
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
