# HWPopoverViewDemo


![](0927_1.gif)

* 用法：

```
	NSArray *titles = @[@"添加好友",@"多人会话",@"扫一扫"];
    NSArray *icons = @[@"right_menu_addFriend",@"right_menu_multichat",@"right_menu_QR"];
    self.popoverView = [[HWPopoverView alloc] initWithTitles:titles icons:icons didSelectCallBack:^(NSInteger selectIndex) {
        NSLog(@"-->> selectIndex:%ld", (long)selectIndex);
    }];

```