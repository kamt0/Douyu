//
//  BaseCollectionCell.h
//  douyuTVDemo
//
//  Created by 揭康伟 on 16/4/29.
//  Copyright © 2016年 kamto. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseCollectionCell : UICollectionViewCell
@property (nonatomic, strong) void(^onChoosedClassBlock)(BOOL);

- (void)setContent:(id)model;
@end
