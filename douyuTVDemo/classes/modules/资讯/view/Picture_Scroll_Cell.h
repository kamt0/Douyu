//
//  Picture_Scroll_Cell.h
//  douyuTVDemo
//
//  Created by 揭康伟 on 16/8/1.
//  Copyright © 2016年 kamto. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Picture_Scroll_Model;

@interface Picture_Scroll_Cell : UICollectionViewCell

@property (nonatomic, strong) Picture_Scroll_Model *model;

@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong) UILabel *titleLable;

@property (nonatomic, strong) UIScrollView *scrollView;

@end
