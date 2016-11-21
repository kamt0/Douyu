//
//  recommendScrollCell.m
//  douyuTVDemo
//
//  Created by 揭康伟 on 16/4/29.
//  Copyright © 2016年 kamto. All rights reserved.
//

#import "recommendScrollCell.h"
#import "CycleScrollView.h"
#import "reconmendPageModel.h"

@interface recommendScrollCell(){
    NSArray * _pageData;
}
@property (nonatomic, strong) CycleScrollView * scrollView;
@end
@implementation recommendScrollCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}


- (void)setContent:(id)model{
    if ([model isKindOfClass:[NSArray class]]) {
        _pageData  = model;
    }
    NSMutableArray *imageViewArray = [[NSMutableArray alloc]init];
    for (int i = 0 ;i < _pageData.count ;i ++) {
        UIImageView *imageView =[[UIImageView alloc]init];
        imageView.frame = CGRectMake(0, 0, ScreenBoundWidth, self.height);
        reconmendPageModel *model = _pageData[i];
        if (model.thumbImageUrl) {
            [imageView setImageWithUrl:model.thumbImageUrl placeholderImage:nil];

        }
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(20, self.frame.size.height-20, ScreenBoundWidth, 20)];
        label.backgroundColor                       = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.5];
        [imageView addSubview:label];
        label.text = model.title;
        label.textColor = [UIColor whiteColor];
        label.textAlignment = NSTextAlignmentLeft;
        
        [imageViewArray addObject:imageView];
    }
    self.scrollView = [[CycleScrollView alloc]initWithFrame:CGRectMake(0, 0, ScreenBoundWidth, self.height) animationDuration:2.0 Count:imageViewArray.count];
    self.scrollView.fetchContentViewAtIndex = ^UIView *(NSInteger pageIndex){
        return imageViewArray.count?imageViewArray[pageIndex]:[UIView new];
    };
    self.scrollView.totalPagesCount = ^NSInteger(void){
        return imageViewArray.count;
    };
    __weak typeof(self) weakSelf = self;
    self.scrollView.TapActionBlock = ^(NSInteger tapIndex){

        if (weakSelf.tapPageBlock) {
            weakSelf.tapPageBlock(nil,tapIndex);
        }
    };
    [self addSubview:self.scrollView];
}
@end
