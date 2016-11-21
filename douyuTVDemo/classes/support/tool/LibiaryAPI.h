//
//  LibiaryAPI.h
//  douyuTVDemo
//
//  Created by 揭康伟 on 16/5/10.
//  Copyright © 2016年 kamto. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LibiaryAPI : NSObject

+ (UIViewController*)viewControllerWithKey:(NSString*)key;

+ (NSDictionary *)initWithFileName:(NSString *)fileName
                         extension:(NSString *)extension;
@end
