//
//  PictureFlowLayout.h
//  douyuTVDemo
//
//  Created by 揭康伟 on 16/5/26.
//  Copyright © 2016年 kamto. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PictureFlowLayout;

@protocol PictureFlowDelegate <NSObject>

-(CGFloat)PictureFlow:(PictureFlowLayout*)Flow heightForWidth:(CGFloat)width atIndexPath:(NSIndexPath*)indexPath;

@end

@interface PictureFlowLayout : UICollectionViewLayout

@property(nonatomic , assign) UIEdgeInsets sectionInset;

@property(nonatomic , assign) CGFloat rowMagrin;//行间距

@property(nonatomic , assign) CGFloat colMagrin;//列间距

@property(nonatomic , assign) CGFloat colCount;//列个数

@property(nonatomic , assign) id<PictureFlowDelegate>delegate;

@end
