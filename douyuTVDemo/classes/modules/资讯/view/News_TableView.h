//
//  News_TableView.h
//  douyuTVDemo
//
//  Created by 揭康伟 on 16/5/26.
//  Copyright © 2016年 kamto. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^DetailsBlock)(NSString *string , NSString *type);

@interface News_TableView : UIView

@property (nonatomic, strong) DetailsBlock detailsBlock;

@property (nonatomic, strong) DetailsBlock topicBlock;

@property (nonatomic, strong) UITableView  *tableView;//表视图

@property (nonatomic, strong) NSString     *urlstring;//URL字符串

@property (nonatomic , assign) NSInteger   scrollPage;//在滑动视图中的页数

@end
