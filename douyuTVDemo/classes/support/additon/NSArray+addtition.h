//
//  NSArray+addtition.h
//  douyuTVDemo
//
//  Created by 揭康伟 on 16/5/9.
//  Copyright © 2016年 kamto. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (addtition)
/**
 *  取数组里元素，防止出现空数组而取值时报异常
 *
 *  @param index 索引
 *
 *  @return
 */
- (id)ObjectAtIndex:(NSUInteger)index;
/**
 *  数组倒序
 *
 *  @return
 */
- (NSArray *)reversedArray;
/**
 *  数组倒序
 *
 *  @param array
 *
 *  @return 
 */
+ (NSArray *)reversedArray:(NSArray *)array;
/**
 *   数组转json字符串
 *
 *  @return
 */
- (NSString *)arrayToJson;
/**
 *  数组转json字符串
 *
 *  @param array
 *
 *  @return 
 */
+ (NSString *)arrayToJson:(NSArray *)array;
/**
 *  json字符串转成数组
 *
 *  @param jsonString
 *
 *  @return 
 */
+ (NSArray *)arrWithJsonString:(NSString *)jsonString;
/**
 *  数组降排序 对象为数字等，根据元素的intervalue
 *
 *  @return
 */
- (NSArray *)sortArrayByAscending;
/**
 *  数组升排序 对象为数字等，根据元素的intervalue
 *
 *  @return
 */
- (NSArray *)sortArrayByDesceding;
/**
 *  数组降排序 对象为model时
 *
 *  @param key 某一个属性
 *
 *  @return 
 */
- (NSArray *)sortArrayByDecending:(id)key;
/**
 *  数组升排序 对象为model时
 *
 *  @param key 某一个属性
 *
 *  @return 
 */
- (NSArray *)sortArrayByAscending:(id)key;
/**
 *  数组去重复,不改变原来顺序
 *
 *  @return
 */
- (NSArray *)dereplication;
@end
