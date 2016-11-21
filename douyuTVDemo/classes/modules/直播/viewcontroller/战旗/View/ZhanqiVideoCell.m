//
//  ZhanqiVideoCell.m
//  douyuTVDemo
//
//  Created by 揭康伟 on 16/5/10.
//  Copyright © 2016年 kamto. All rights reserved.
//

#import "ZhanqiVideoCell.h"
#import "videoModel.h"

@interface ZhanqiVideoCell()
@property (nonatomic, strong) UIImageView *ThumbImageView;
@property (nonatomic, strong) UIImageView *genderImageView;
@property (nonatomic, strong) UILabel     *nickLabel;
@property (nonatomic, strong) UILabel     *titleLabel;
@property (nonatomic, strong) UILabel     *watchLabel;
@property (nonatomic, strong) videoModel  *videoModel;
@end
@implementation ZhanqiVideoCell

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
    }
    return self;
}
- (void)setupView{
    _ThumbImageView = [[UIImageView alloc]initWithFrame:CGRectZero];
    _genderImageView = [[UIImageView alloc]initWithFrame:CGRectZero];
    _nickLabel =[[UILabel alloc]initWithFrame:CGRectZero];
    _nickLabel.textAlignment = NSTextAlignmentLeft;
    _nickLabel.font = [UIFont systemFontOfSize:12];
    _nickLabel.textColor = [UIColor whiteColor];
    _titleLabel = [[UILabel alloc]initWithFrame:CGRectZero];
    _titleLabel.textAlignment = NSTextAlignmentLeft;
    _titleLabel.font = [UIFont systemFontOfSize:13];
    _watchLabel  = [[UILabel alloc]initWithFrame:CGRectZero];
    _watchLabel.textAlignment = NSTextAlignmentRight;
    _watchLabel.font = [UIFont systemFontOfSize:10];
    _watchLabel.textColor = [UIColor whiteColor];
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectZero];
    bgView.backgroundColor  = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.5];
    
    [self addSubview:_ThumbImageView];
    [self addSubview:_genderImageView];
    [self addSubview:bgView];
    [self addSubview:_nickLabel];
    [self addSubview:_titleLabel];
    [self addSubview:_watchLabel];
    
    _genderImageView.sd_layout.leftSpaceToView(self,5).bottomSpaceToView(self,5).widthIs(13).heightIs(13);
    _titleLabel.sd_layout.leftSpaceToView(_genderImageView,5).rightSpaceToView(self,5).bottomSpaceToView(self,5).heightIs(15);
    _ThumbImageView.sd_layout.leftSpaceToView(self,0).topSpaceToView(self,0).rightSpaceToView(self,0).bottomSpaceToView(self,27);
    bgView.sd_layout.leftSpaceToView(self,0).rightSpaceToView(self,0).bottomEqualToView(_ThumbImageView).heightIs(20);
    _nickLabel.sd_layout.leftSpaceToView(self,5).rightSpaceToView(self,5).bottomSpaceToView(self,29).heightIs(20);
    _watchLabel.sd_layout.rightSpaceToView(self,5).bottomEqualToView(_nickLabel).heightIs(20);
    //使用SDLayout 每一个控件需要同参照物约束时参照物需要先确定约束
    
    
}
- (void)setContent:(id)model{
    
    if ([model isKindOfClass:[videoModel class]]) {
        _videoModel = (videoModel *)model;
    }
    [_ThumbImageView  setImageWithUrl:_videoModel.thumb placeholderImage:nil];
    if ([_videoModel.gender integerValue] == 1) {
        [_genderImageView setImage:[UIImage imageNamed:@"icon_room_female"]];
    }else{
       [_genderImageView setImage:[UIImage imageNamed:@"icon_room_male"]];
    }
    _titleLabel.text = _videoModel.title;
    _nickLabel.text  = _videoModel.nick;
    if (_videoModel.watch) {
        _watchLabel.text = [NSString stringWithFormat:@"%@",_videoModel.watch];
        
    }
    
}



@end
