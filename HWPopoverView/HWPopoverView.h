//
//  HWPopoverView.h
//  HWPopoverViewDemo
//
//  Created by hw on 16/9/27.
//  Copyright © 2016年 hw. All rights reserved.
//

typedef NS_ENUM(NSInteger, HWPopoverViewStyle){
    HWPopoverViewStyleUpLeft,//左上角
    HWPopoverViewStyleUpRight,//右上角
    HWPopoverViewStyleDownLeft,//左下角
    HWPopoverViewStyleDownRight//右下角
};

#import <UIKit/UIKit.h>

@interface HWPopoverView : UIView

@property (nonatomic, copy) void (^didSelectCallBack)(NSInteger selectIndex);

- (instancetype)initWithTitles:(NSArray *)titles icons:(NSArray *)icons style:(HWPopoverViewStyle)style didSelectCallBack:(void (^)(NSInteger selectIndex))didSelectCallBack;

@end
