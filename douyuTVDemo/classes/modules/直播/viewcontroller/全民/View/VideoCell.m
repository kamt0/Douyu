//
//  VideoCell.m
//  douyuTVDemo
//
//  Created by 揭康伟 on 16/5/6.
//  Copyright © 2016年 kamto. All rights reserved.
//

#import "VideoCell.h"
#import "videoModel.h"
#import "NSString+addition.h"

@interface VideoCell()
@property (nonatomic, strong) UIImageView *ThumbImageView;
@property (nonatomic, strong) UIImageView *avatarImageView;
@property (nonatomic, strong) UILabel     *nickLabel;
@property (nonatomic, strong) UILabel     *titleLabel;
@property (nonatomic, strong) UILabel     *watchLabel;
@property (nonatomic, strong) videoModel  *videoModel;
@end
@implementation VideoCell

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
    }
    return self;
}
- (void)setupView{
    _ThumbImageView  = [[UIImageView alloc]initWithFrame:CGRectZero];
    _avatarImageView = [[UIImageView alloc]initWithFrame:CGRectZero];
    _nickLabel       = [[UILabel alloc]initWithFrame:CGRectZero];
    _titleLabel      = [[UILabel alloc]initWithFrame:CGRectZero];
    _titleLabel.font = [UIFont systemFontOfSize:13];
    _watchLabel      = [[UILabel alloc]initWithFrame:CGRectZero];
    _watchLabel.font = [UIFont systemFontOfSize:10];
    _watchLabel.textColor       = [UIColor whiteColor];
    _watchLabel.textAlignment   = NSTextAlignmentRight;
    _watchLabel.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.5];
    
    [self addSubview:_ThumbImageView];
    [self addSubview:_avatarImageView];
    [self addSubview:_nickLabel];
    [self addSubview:_titleLabel];
    [self addSubview:_watchLabel];
    
    _titleLabel.sd_layout.leftSpaceToView(self,5).rightSpaceToView(self,5).bottomSpaceToView(self,5).heightIs(15);
    _ThumbImageView.sd_layout.leftSpaceToView(self,0).topSpaceToView(self,0).rightSpaceToView(self,0).bottomSpaceToView(self,47);
    _avatarImageView.sd_layout.leftSpaceToView(self,8).bottomSpaceToView(self,23).widthIs(35).heightIs(35);
    _nickLabel.sd_layout.leftSpaceToView(_avatarImageView,3).rightSpaceToView(self,5).topSpaceToView(_ThumbImageView,1).bottomSpaceToView(_titleLabel,6).heightIs(20);
     _watchLabel.sd_layout.rightSpaceToView(self,5).bottomSpaceToView(self,49).heightIs(20);
    //使用SDLayout 每一个控件需要同参照物约束时参照物需要先确定约束

    
}
- (void)setContent:(id)model{
    
    if ([model isKindOfClass:[videoModel class]]) {
        _videoModel = (videoModel *)model;
    }
    [_ThumbImageView  setImageWithUrl:_videoModel.thumb placeholderImage:nil];
    [_avatarImageView setImageWithUrl:_videoModel.avatar placeholderImage:nil];
    _titleLabel.text = _videoModel.title;
    _nickLabel.text  = _videoModel.nick;
    if (_videoModel.watch) {
         _watchLabel.text = [NSString stringWithFormat:@"%@",_videoModel.watch];
        _watchLabel.width = [_watchLabel.text textWidthWithfont:10];
        _watchLabel.sd_layout.rightSpaceToView(self,5).bottomEqualToView(_nickLabel).heightIs(20).widthIs(_watchLabel.width);
    }
   
    
    _avatarImageView.layer.cornerRadius  = _avatarImageView.height/2;
    _avatarImageView.layer.masksToBounds = TRUE;
    _ThumbImageView.layer.cornerRadius   = 8;
    _ThumbImageView.layer.masksToBounds  = TRUE;
}

@end
