//
//  RecomHeaderView.m
//  douyuTVDemo
//
//  Created by 揭康伟 on 16/5/5.
//  Copyright © 2016年 kamto. All rights reserved.
//

#import "RecomHeaderView.h"

@interface RecomHeaderView()
@property (nonatomic, strong) UILabel *titleLabel;
@end;
@implementation RecomHeaderView

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
    }
    return self;
}
- (void)setupView{
    UILabel *label1 = [UILabel new];
    label1.backgroundColor = COLOR_HEX(@"E6E6E6");
    
    UILabel *label2 = [UILabel new];
    label2.backgroundColor = COLOR_HEX(@"FF4C27");
    
    _titleLabel = [UILabel new];
    _titleLabel.font = [UIFont systemFontOfSize:16];
    
    UIButton *button = [UIButton new];
    [button setTitle:@"进去看看" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:13];
    button.titleLabel.textAlignment = NSTextAlignmentRight;
    [button addTarget:self action:@selector(pressButton) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:label1];
    [self addSubview:label2];
    [self addSubview:_titleLabel];
    [self addSubview:button];
    
    label1.sd_layout.leftSpaceToView(self,0).rightSpaceToView(self,0).topSpaceToView(self,0).heightIs(10);
    label2.sd_layout.leftSpaceToView(self,8).topSpaceToView(label1,5).widthIs(5).bottomSpaceToView(self,5);
    _titleLabel.sd_layout.leftSpaceToView(label2,5).topSpaceToView(label1,5).bottomSpaceToView(self,5).widthIs(120);
    button.sd_layout.rightSpaceToView(self,8).topSpaceToView(label1,5).bottomSpaceToView(self,5).widthIs(70);
    
}
- (void)setTitle:(NSString *)title{
    _titleLabel.text = title;
}
- (void)pressButton{
    if (_goMoreSeedingBlock) {
        _goMoreSeedingBlock();
    }
}

@end
