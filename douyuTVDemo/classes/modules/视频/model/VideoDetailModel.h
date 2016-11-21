//
//  VideoDetailModel.h
//  douyuTVDemo
//
//  Created by 揭康伟 on 16/5/27.
//  Copyright © 2016年 kamto. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VideoDetailModel : NSObject

@property (nonatomic , strong ) NSString *vid;//视频ID

@property (nonatomic , strong ) NSString *definition;//视频清晰度 350  1000  1300

@property (nonatomic , strong ) NSString *transcode_id;//视频转码ID

@property (nonatomic , strong ) NSString *video_name;//视频名

@property (nonatomic , strong ) NSString *size;//视频大小

@property (nonatomic , strong ) NSString *width;//视频宽

@property (nonatomic , strong ) NSString *height;//视频高

@property (nonatomic , strong ) NSString *duration;//视频时长

@property (nonatomic , strong ) NSArray  *urls;//视频URL

@property (nonatomic , strong ) NSString *cover;//封面图URL


@end
