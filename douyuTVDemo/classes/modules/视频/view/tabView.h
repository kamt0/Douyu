//
//  tabView.h
//  douyuTVDemo
//
//  Created by 揭康伟 on 16/8/3.
//  Copyright © 2016年 kamto. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^SelectIndexBlock)(NSInteger selectIndex);

@interface tabView : UIView

@property (nonatomic , strong)NSArray *dataArray;//数据源数组

@property (nonatomic , strong)UIScrollView *scrollView;//滑动视图

@property (nonatomic , strong)UIView *lineView; //下划线视图

@property (nonatomic , assign)NSInteger selectIndex;//选中按钮下标

@property (nonatomic , strong)SelectIndexBlock returnIndex;//返回选中的下标

@end
