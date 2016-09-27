//
//  HWPopoverView.h
//  HWPopoverViewDemo
//
//  Created by hw on 16/9/27.
//  Copyright © 2016年 hw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HWPopoverView : UIView

@property (nonatomic, copy) void (^didSelectCallBack)(NSInteger selectIndex);

- (instancetype)initWithTitles:(NSArray *)titles icons:(NSArray *)icons didSelectCallBack:(void (^)(NSInteger selectIndex))didSelectCallBack;

@end
