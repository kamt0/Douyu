//
//  DataCache.h
//  douyuTVDemo
//
//  Created by 揭康伟 on 16/5/13.
//  Copyright © 2016年 kamto. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataCache : NSObject
+(DataCache *)shareDataCache;

//保存数据到Document下指定文件夹下 以json格式保存

- (void)saveDataForDocumentWithData:(id)data DataName:(NSString *)dataName Classify:(NSString *)classifyName;

//在Document下指定文件夹下获取指定json数据

- (id)getDataForDocumentWithDataName:(NSString *)dataName Classify:(NSString *)classifyName;

//获取指定分类缓存的大小

- (CGFloat)getCacheSizeWithClassify:(NSString *)classifyName;

//删除指定分类文件夹

- (void)removeClassifyCacheWithClassify:(NSString *)classifyName;

//字节转换KB或者MB或者GB

- (NSString *)getKBorMBorGBWith:(CGFloat)folderSize;

@end
