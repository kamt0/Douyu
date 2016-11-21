//
//  LandscapeNavView.m
//  douyuTVDemo
//
//  Created by 揭康伟 on 16/5/7.
//  Copyright © 2016年 kamto. All rights reserved.
//

#import "LandscapeNavView.h"
#import "UIButton+addition.h"

@implementation LandscapeNavView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
    }
    return self;
}
- (void)setupView{
    
    UIButton *backBtn = [UIButton ButtonWithRect:CGRectZero title:nil titleColor:nil Image:@"movie_back_s" HighlightedImage:nil clickAction:@selector(onClickedButton:) target:self contentEdgeInsets:UIEdgeInsetsZero tag:0];
    [self addSubview:backBtn];
    
    backBtn.sd_layout.leftSpaceToView(self,10).topSpaceToView(self,5).widthIs(30).heightIs(30);
    
}
- (void)onClickedButton:(UIButton *)sender{
    if (_onClickedNavButtonBlock) {
        _onClickedNavButtonBlock();
    }
}
@end
