//
//  Picture_Scroll_Model.h
//  douyuTVDemo
//
//  Created by 揭康伟 on 16/8/1.
//  Copyright © 2016年 kamto. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Picture_Scroll_Model : NSObject

@property (nonatomic, strong) NSString *title;//标题

@property (nonatomic, strong) NSString *url;//图片地址

@property (nonatomic, strong) NSString *source;//下载图片

@property (nonatomic, strong) NSString *fileWidth;//图片宽度

@property (nonatomic, strong) NSString *fileHeight;//图片高度

@property (nonatomic, strong) NSString *picId;//图片ID

@property (nonatomic, strong) NSString *picDesc;//图片描述

@end
