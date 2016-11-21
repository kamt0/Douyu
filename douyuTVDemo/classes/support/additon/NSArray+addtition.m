//
//  NSArray+addtition.m
//  douyuTVDemo
//
//  Created by 揭康伟 on 16/5/9.
//  Copyright © 2016年 kamto. All rights reserved.
//

#import "NSArray+addtition.h"

@implementation NSArray (addtition)
- (id)ObjectAtIndex:(NSUInteger)index {
    if ([self count] > 0)
        if (index < [self count]) {
            return [self objectAtIndex:index];
        }else
        return nil;
    else
        return nil;
}
- (NSArray *)reversedArray{
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:[self count]];
    NSEnumerator *enumerator = [self reverseObjectEnumerator];
    
    for (id element in enumerator)
        [array addObject:element];
    
    return array;
}
+ (NSArray *)reversedArray:(NSArray *)array{
    NSMutableArray *arrayTemp = [NSMutableArray arrayWithCapacity:[array count]];
    NSEnumerator *enumerator = [array reverseObjectEnumerator];
    
    for (id element in enumerator)
        [arrayTemp addObject:element];
    
    return array;

}

- (NSString *)arrayToJson {
    NSString *json = nil;
    NSError *error = nil;
    NSData *data =
    [NSJSONSerialization dataWithJSONObject:self options:0 error:&error];
    if (!error) {
        json = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        return json;
    } else
        return nil;
}
+ (NSString *)arrayToJson:(NSArray *)array {
    NSString *json = nil;
    NSError *error = nil;
    NSData *data =
    [NSJSONSerialization dataWithJSONObject:array options:0 error:&error];
    if (!error) {
        json = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        return json;
    } else
        return nil;
}
+ (NSArray *)arrWithJsonString:(NSString *)jsonString
{
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSArray *arr = [NSJSONSerialization JSONObjectWithData:jsonData
                                                   options:NSJSONReadingMutableContainers
                                                     error:&err];
    if(err) {
        return nil;
    }
    return arr;
}

- (NSArray *)sortArrayByAscending{
    NSComparator cmptr = ^(id obj1, id obj2){
        if ([obj1 integerValue] > [obj2 integerValue]) {
            return (NSComparisonResult)NSOrderedAscending;
        }
        
        if ([obj1 integerValue] < [obj2 integerValue]) {
            return (NSComparisonResult)NSOrderedDescending;
        }
        return (NSComparisonResult)NSOrderedSame;
    };
    return [self sortedArrayUsingComparator:cmptr];
}
- (NSArray *)sortArrayByDesceding{
    NSComparator cmptr = ^(id obj1, id obj2){
        if ([obj1 integerValue] > [obj2 integerValue]) {
            return (NSComparisonResult)NSOrderedDescending;
        }
        
        if ([obj1 integerValue] < [obj2 integerValue]) {
            return (NSComparisonResult)NSOrderedAscending;
        }
        return (NSComparisonResult)NSOrderedSame;
    };
    return [self sortedArrayUsingComparator:cmptr];
}
- (NSArray *)sortArrayByDecending:(id)key{
    NSSortDescriptor *descriptor = [[NSSortDescriptor alloc] initWithKey:key ascending:NO];
    NSArray *sortDescriptors = [NSArray arrayWithObjects:descriptor, nil];
    return [self sortedArrayUsingDescriptors:sortDescriptors];
}
- (NSArray *)sortArrayByAscending:(id)key{
     NSSortDescriptor *descriptor = [[NSSortDescriptor alloc] initWithKey:key ascending:YES];
     NSArray *sortDescriptors = [NSArray arrayWithObjects:descriptor, nil];
    return [self sortedArrayUsingDescriptors:sortDescriptors];
}

+ (NSMutableArray *)removeCommonObject:(NSMutableArray *)array key:(NSString *)key{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    for (NSDictionary *d in array) {
        [dic setObject:d forKey:d[key]];
    }
    
    return  [NSMutableArray arrayWithArray:[dic allValues]];
}
- (NSArray *)dereplication{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    NSInteger count = [self count];
    for (unsigned i = 0; i < count; i++){
        
        if ([array containsObject:[self objectAtIndex:i]] == NO){
            
            [array addObject:[self objectAtIndex:i]];
            
        }
    }
    return array;
}
@end
