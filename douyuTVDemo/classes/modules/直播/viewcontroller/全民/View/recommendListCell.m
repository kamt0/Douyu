//
//  recommendListCell.m
//  douyuTVDemo
//
//  Created by 揭康伟 on 16/4/29.
//  Copyright © 2016年 kamto. All rights reserved.
//

#import "recommendListCell.h"
#import "recommendClassModel.h"

@interface recommendListCell(){
    CGFloat      _contentSizeWidth;
    NSArray      *_classData;
    NSInteger    _lolIndex;
}
@property (nonatomic, strong) UIScrollView *scrollView;
@end
@implementation recommendListCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, ScreenBoundWidth, self.height)];
        [self addSubview:_scrollView];
    }
    return self;
}

- (void)setContent:(id)model{
    
    if ([model isKindOfClass:[NSArray class]]) {
        _classData = model;
    }
    [self restore];
    _contentSizeWidth = 0;
    for (int i = 0; i < _classData.count; i ++) {
        recommendClassModel * model = _classData[i];
        UIView *containView = [self getContainView];
        containView.left = _contentSizeWidth;
        UIButton *button = [self getUIButton];
        button.tag = i;
    
        UILabel  *label = [self getLabel];
        label.text =  model.title;
        if ([model.title isEqualToString:@"英雄联盟"]) {
            _lolIndex = i;
        }
        [label sizeToFit];
        UIImageView *imageView = [self getImageView];
        [imageView setImageWithUrl:model.thumbImageUrl placeholderImage:nil];
        [containView addSubview:button];
        [containView addSubview:label];
        [containView addSubview:imageView];
        _contentSizeWidth = containView.left + containView.width;
        [_scrollView addSubview:containView];
    }
    _scrollView.contentSize = CGSizeMake(_contentSizeWidth, ScreenBoundWidth/5);
}


- (UIView *)getContainView{
    
    UIView * contatinView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenBoundWidth/5, ScreenBoundWidth/5)];
    contatinView.backgroundColor = [UIColor whiteColor];
    return contatinView;
}
- (UIButton *)getUIButton{
    
    UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, ScreenBoundWidth/5, ScreenBoundWidth/5)];
    [button setTitle:nil forState:UIControlStateNormal];
    [button addTarget:self action:@selector(onClickedClassIndex:) forControlEvents:UIControlEventTouchUpInside];
    return button;
    
}
- (UILabel *)getLabel{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, ScreenBoundWidth/7 +15,ScreenBoundWidth/7, 20)];
    ;
    return label;
}
- (UIImageView *)getImageView{
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, ScreenBoundWidth/7, ScreenBoundWidth/7)];
    imageView.layer.cornerRadius = imageView.height/2;
    imageView.layer.masksToBounds = TRUE;
    return imageView;
}
- (void)restore{
   [self.scrollView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
       UIView *view = obj;
       [view removeFromSuperview];
   }];
}
- (void)onClickedClassIndex:(UIButton *)sender{
    
    BOOL isHasData = FALSE;
    if (sender.tag == _lolIndex) {
        isHasData = TRUE;
    }
    if (self.onChoosedClassBlock) {
        self.onChoosedClassBlock(isHasData);
    }
}
@end
