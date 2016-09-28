//
//  HWPopoverView.h
//  HWPopoverViewDemo
//
//  Created by hw on 16/9/27.
//  Copyright © 2016年 hw. All rights reserved.
//

typedef NS_ENUM(NSInteger, HWPopoverViewStyle){
    HWPopoverViewStyleLeftTop,//左上角
    HWPopoverViewStyleRightTop,//右上角
    HWPopoverViewStyleLeftBottom,//左下角
    HWPopoverViewStyleRightBottom//右下角
};

#import <UIKit/UIKit.h>

@interface HWPopoverView : UIView

/**
 初始化PopoverView

 @param titles            标题数组
 @param icons             图标数组
 @param style             样式
 @param didSelectCallBack 选中item之后的回调

 @return 实例
 */
- (instancetype)initWithTitles:(NSArray *)titles icons:(NSArray *)icons style:(HWPopoverViewStyle)style didSelectCallBack:(void (^)(NSInteger selectIndex))didSelectCallBack;

@end
