//
//  recommendLogic.h
//  douyuTVDemo
//
//  Created by 揭康伟 on 16/4/29.
//  Copyright © 2016年 kamto. All rights reserved.
//

#import <Foundation/Foundation.h>
@class recommendCollectionModel;
@interface recommendLogic : NSObject

- (void)getdata:(NSString *)url parameters:(NSDictionary *)parameters sucess:(void(^)(recommendCollectionModel * recommendCollection))success fail:(void(^)())fail;

- (void)getSeedingDataList:(NSString *)url parameters:(NSDictionary *)parameters success:(void(^)(NSArray *))success fail:(void(^)())fail;
@end
