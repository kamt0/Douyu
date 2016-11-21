//
//  News_PictureCell.h
//  douyuTVDemo
//
//  Created by 揭康伟 on 16/5/26.
//  Copyright © 2016年 kamto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PictureModel.h"


@interface News_PictureCell : UICollectionViewCell


@property (nonatomic, strong) UIImageView  *coverImageView;

@property (nonatomic, strong) UILabel      *titleLable;

@property (nonatomic, strong) UILabel      *picsumLable;

@property (nonatomic, strong) PictureModel *model;

@end
