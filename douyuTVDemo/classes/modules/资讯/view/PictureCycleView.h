//
//  PictureCycleView.h
//  douyuTVDemo
//
//  Created by 揭康伟 on 16/5/26.
//  Copyright © 2016年 kamto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PictureCycleModel.h"

typedef void (^SelectedPictureBlock)(PictureCycleModel *model);

@interface PictureCycleView : UIView

@property (nonatomic , strong) NSMutableArray *dataArray;//数据源数组

@property (nonatomic , assign) NSTimeInterval timeInterval;//轮播时间间隔

@property (nonatomic , assign) BOOL isPicturePlay;//是否播放图片

@property (nonatomic , strong) SelectedPictureBlock selectedPictureBlock;//选中图片Block

@end

@interface PictureCycleItem : UIView

@property (nonatomic , retain ) PictureCycleModel *model;//数据模型

@end
