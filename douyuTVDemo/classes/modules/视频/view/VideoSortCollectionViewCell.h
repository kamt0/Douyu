//
//  VideoSortCollectionViewCell.h
//  douyuTVDemo
//
//  Created by 揭康伟 on 16/8/3.
//  Copyright © 2016年 kamto. All rights reserved.
//

#import <UIKit/UIKit.h>

@class videoSortModel;

@interface VideoSortCollectionViewCell : UICollectionViewCell

@property (nonatomic ,strong) videoSortModel *sortModel;

@property (nonatomic ,strong) UIImageView *imageView;

@property (nonatomic ,strong) UILabel *titleLable;

@property (nonatomic ,strong) UILabel *upDataLable;

@end
