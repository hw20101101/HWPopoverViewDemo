# HWPopoverViewDemo

###### 效果图：

![](0928_1.gif)


###### 用法：

```
	NSArray *titles = @[@"添加好友",@"多人会话",@"扫一扫"];
    NSArray *icons = @[@"right_menu_addFriend",@"right_menu_multichat",@"right_menu_QR"];
    self.popoverView = [[HWPopoverView alloc] initWithTitles:titles icons:icons style:HWPopoverViewStyleRightTop didSelectCallBack:^(NSInteger selectIndex) {
        NSLog(@"-->> selectIndex:%ld", (long)selectIndex);
    }];

```

###### 安装：
* 下载此Demo之后，拖动HWPopoverView文件夹到项目中，导入HWPopoverView.h
* 此工具类依赖Masonry，使用前请确保已导入或安装Masonry。