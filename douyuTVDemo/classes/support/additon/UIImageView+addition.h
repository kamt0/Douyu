//
//  UIImageView+addition.h
//  douyuTVDemo
//
//  Created by 揭康伟 on 16/4/29.
//  Copyright © 2016年 kamto. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (addition)
/**
 *  AFNetworking带的获取图片
 *
 *  @param url
 *  @param placeholderImage
 */
- (void)setImageWithUrl:(NSString *)url placeholderImage:(UIImage *)placeholderImage;


/**
 *  SDWebImage 图片获取
 *
 *  @param url
 *  @param placeholder
 */
- (void)sd_setImageWithUrl:(NSString *)url placeholderImage:(UIImage *)placeholder;
/**
 *   SDWebImage 先读取缓存图片 没有就再读取
 *
 *  @param url
 *  @param placeholder
 */
- (void)ad_setImageWithCache:(NSString *)url placeholderImage:(UIImage *)placeholder;

@end
