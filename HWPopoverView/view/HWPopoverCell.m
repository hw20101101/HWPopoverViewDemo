//
//  HWPopoverCell.m
//  HWPopoverViewDemo
//
//  Created by hw on 16/9/27.
//  Copyright © 2016年 hw. All rights reserved.
//

#import "HWPopoverCell.h"
#import "Masonry.h"

@interface HWPopoverCell ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *iconView;

@end

@implementation HWPopoverCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createUI];
    }
    return self;
}

- (void)createUI
{
    __weak typeof(self) weakSelf = self;
    self.iconView = [UIImageView new];
    [self.contentView addSubview:self.iconView];
    [self.iconView makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf);
        make.left.equalTo(weakSelf).offset(15);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
    
    self.titleLabel = [UILabel new];
    self.titleLabel.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:self.titleLabel];
    [self.titleLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf);
        make.left.equalTo(weakSelf.iconView.right).offset(10);
        make.size.mas_equalTo(CGSizeMake(65, 15));
    }];
}

- (void)setText:(NSString *)text
{
    self.titleLabel.text = text;
}

- (void)setIconName:(NSString *)iconName
{
    if (iconName) {
        self.iconView.image = [UIImage imageNamed:iconName];
    } else {        
        __weak typeof(self) weakSelf = self;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.titleLabel remakeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(weakSelf);
            make.left.equalTo(@10);
            make.right.equalTo(@-10);
            make.height.equalTo(@15);
        }];
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
