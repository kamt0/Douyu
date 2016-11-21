//
//  LibiaryAPI.m
//  douyuTVDemo
//
//  Created by 揭康伟 on 16/5/10.
//  Copyright © 2016年 kamto. All rights reserved.
//

#import "LibiaryAPI.h"

@implementation LibiaryAPI
+ (UIViewController*)viewControllerWithKey:(NSString*)key{
    NSString *strClass = @"";
//    NSDictionary *dict = @{
//                           @"tab_0" : @"QuanminViewController",
//                           @"tab_1" : @"DouyuViewController",
//                           @"tab_2" : @"ZhanqiViewController",
//                           };
    NSDictionary *dict = @{
                           @"tab_0" : @"DirectSeedingViewController",
                           @"tab_1" : @"NewsViewController",
                           @"tab_2" : @"VideosViewController",
                           @"tab_3" : @"OtherViewController"
                           };

    if (key && key.length > 0) {
        strClass = [dict objectForKey:key];
        if (strClass && strClass.length > 0) {
            UIViewController *controller = [NSClassFromString(strClass) new];
            return controller;
        }
    }
    return nil;

}

+ (NSDictionary *)initWithFileName:(NSString *)fileName
                         extension:(NSString *)extension{
    NSString *strJSONPath =
    [[NSBundle mainBundle] pathForResource:fileName ofType:extension];
    NSDictionary *dict = [NSJSONSerialization
                          JSONObjectWithData:[NSData dataWithContentsOfFile:strJSONPath]
                          options:0
                          error:nil];
    
    return dict;

}
@end
