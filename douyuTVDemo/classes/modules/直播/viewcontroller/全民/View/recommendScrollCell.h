//
//  recommendScrollCell.h
//  douyuTVDemo
//
//  Created by 揭康伟 on 16/4/29.
//  Copyright © 2016年 kamto. All rights reserved.
//

#import "BaseCollectionCell.h"
@class reconmendPageModel;

typedef void(^tapScrollPageBlock)(reconmendPageModel*,NSInteger);

@interface recommendScrollCell : BaseCollectionCell
@property (nonatomic, strong)tapScrollPageBlock tapPageBlock;
@end
