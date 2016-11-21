//
//  News_TableViewCell.h
//  douyuTVDemo
//
//  Created by 揭康伟 on 16/5/26.
//  Copyright © 2016年 kamto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsModel.h"

@interface News_TableViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView *photoImageView;

@property (nonatomic, strong) UILabel     *titleLabel;

@property (nonatomic, strong) UILabel     *contentLabel;

@property (nonatomic, strong) UILabel     *timeLabel;

@property (nonatomic, strong) UILabel     *readCountLabel;

@property (nonatomic, strong) UILabel     *readWordLabel;

@property (nonatomic, strong) UILabel     *photoVideoLabel;

@property (nonatomic, strong) UIView      *whiteView;

@property (nonatomic, retain) NewsModel    *model;//数据模型

@end
