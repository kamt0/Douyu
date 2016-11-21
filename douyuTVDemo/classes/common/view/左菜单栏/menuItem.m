//
//  menuItem.m
//  demo1
//
//  Created by 揭康伟 on 16/5/12.
//  Copyright © 2016年 kamto. All rights reserved.
//
#define IconHeight  60
#import "menuItem.h"
#import "UIView+SDAutoLayout.h"
@interface menuItem()
@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel     *nameLabel;
@end
@implementation menuItem

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
    }
    return self;
}
- (void)setupView{
    _iconImageView = [UIImageView new];
    _iconImageView.backgroundColor = [UIColor redColor];
    _iconImageView.layer.cornerRadius = IconHeight/2;
    _iconImageView.layer.masksToBounds = TRUE;
    _nameLabel = [UILabel new];
    _nameLabel.textAlignment = NSTextAlignmentLeft;
    _nameLabel.font = [UIFont systemFontOfSize:22];
    _nameLabel.textColor = [UIColor whiteColor];
    UIButton *btn = [UIButton new];
    [btn addTarget:self action:@selector(ClickButton) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:btn];
    [self addSubview:_iconImageView];
    [self addSubview:_nameLabel];
    
    _iconImageView.sd_layout.leftSpaceToView(self,15).topSpaceToView(self,0).bottomSpaceToView(self,0).widthIs(IconHeight).heightIs(IconHeight);
    _nameLabel.sd_layout.leftSpaceToView(_iconImageView,5).rightSpaceToView(self,0).centerYEqualToView(_iconImageView).heightIs(30);
    btn.sd_layout.leftSpaceToView(self,0).rightSpaceToView(self,0).topSpaceToView(self,0).bottomSpaceToView(self,0);
}
- (void)setImageName:(NSString *)imageName{
    _imageName = imageName;
    _iconImageView.image = [UIImage imageNamed:_imageName];
    
}
- (void)setTitle:(NSString *)title{
    _title = title;
    _nameLabel.text = _title;
   
}
- (void)setIndex:(NSInteger)index{
    _index = index;
}
- (void)ClickButton{
    if (self.ClickButtonBlock) {
        self.ClickButtonBlock(_index);
    }
}
@end
