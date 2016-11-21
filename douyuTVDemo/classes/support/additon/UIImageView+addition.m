//
//  UIImageView+addition.m
//  douyuTVDemo
//
//  Created by 揭康伟 on 16/4/29.
//  Copyright © 2016年 kamto. All rights reserved.
//

#import "UIImageView+addition.h"
#import <UIImageView+AFNetworking.h>
#import <SDWebImage/UIImageView+WebCache.h>//两个加载方法一起会有黄色警告冲突，用任何一个即可
#import <SDImageCache.h>

@implementation UIImageView (addition)

- (void)setImageWithUrl:(NSString *)url placeholderImage:(UIImage *)placeholderImage
{
    if (url && [url length]) {
        NSString * imaUrl = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSURL *URL = [NSURL URLWithString:imaUrl];
       // [self setImageWithURL:URL placeholderImage:placeholderImage];
        [self sd_setImageWithURL:URL placeholderImage:placeholderImage];
    }
    else {
        self.image = placeholderImage;
    }
}

- (void)sd_setImageWithUrl:(NSString *)url placeholderImage:(UIImage *)placeholder{
    if (url && [url length]) {
        NSString * imaUrl = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSURL *URL = [NSURL URLWithString:imaUrl];
        [self sd_setImageWithURL:URL placeholderImage:placeholder];
    }
    else {
        self.image = placeholder;
    }
}

- (void)ad_setImageWithCache:(NSString *)url placeholderImage:(UIImage *)placeholder{

    NSString *ImageCacheUrl  = [url stringByAppendingString:@"cache"];
    UIImage *cacheImage   = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:ImageCacheUrl];
    if (cacheImage) {
        self.image = cacheImage;
    }else{
         NSString * imaUrl = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [self sd_setImageWithURL:[NSURL URLWithString:imaUrl] placeholderImage:placeholder completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            if (!error) {
                self.image = image;
                [[SDImageCache sharedImageCache] storeImage:image forKey:ImageCacheUrl];
            }
        }];
    }
    
}
@end
