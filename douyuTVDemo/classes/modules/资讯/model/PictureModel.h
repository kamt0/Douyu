//
//  PictureModel.h
//  douyuTVDemo
//
//  Created by 揭康伟 on 16/5/26.
//  Copyright © 2016年 kamto. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PictureModel : NSObject


@property (nonatomic, strong) NSString *galleryId;

@property (nonatomic, strong) NSString *coverUrl;

@property (nonatomic, strong) NSString *title;

@property (nonatomic, strong) NSString *picsum;

@property (nonatomic, strong) NSString *coverWidth;//图片宽度

@property (nonatomic, strong) NSString *coverHeight;//图片高度

@property (nonatomic, strong) NSString *modify_time;//时间


@end
