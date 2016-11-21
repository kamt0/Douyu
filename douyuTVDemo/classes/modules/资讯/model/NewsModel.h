//
//  NewsModel.h
//  douyuTVDemo
//
//  Created by 揭康伟 on 16/5/26.
//  Copyright © 2016年 kamto. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsModel : NSObject

@property (nonatomic, strong) NSString *id;//ID

@property (nonatomic, strong) NSString *title;//标题

@property (nonatomic, strong) NSString *content;//内容

@property (nonatomic, strong) NSString *time;//时间

@property (nonatomic, strong) NSString *readCount;//阅读计数

@property (nonatomic, strong) NSString *photo;//图片URL

@property (nonatomic, strong) NSString *type;//类型

@property (nonatomic, strong) NSString *destUrl;//目标URL

@end
