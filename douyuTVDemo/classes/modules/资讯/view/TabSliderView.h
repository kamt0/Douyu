//
//  TabSliderView.h
//  douyuTVDemo
//
//  Created by 揭康伟 on 16/5/25.
//  Copyright © 2016年 kamto. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TabSliderView : UIView
//数据源数组
@property (nonatomic, strong) NSArray      *dataArray;
//滑动视图
@property (nonatomic, strong) UIScrollView *scrollView;
//下划线视图
@property (nonatomic, strong) UIView       *lineView;
//选中按钮下标
@property (nonatomic, assign) NSInteger    selectIndex;
////返回选中的下标
@property (nonatomic, strong) void(^selectIndexBlcok) (NSInteger selectIndex );
@end
