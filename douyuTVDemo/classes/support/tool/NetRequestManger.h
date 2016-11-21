//
//  NetRequestManger.h
//  douyuTVDemo
//
//  Created by 揭康伟 on 16/4/29.
//  Copyright © 2016年 kamto. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>

typedef void(^successBlock)(id json);
typedef void(^failureBlock)(NSError *error);

@interface NetRequestManger : NSObject

@property (nonatomic, assign) BOOL isReachable;


+ (NetRequestManger *)sharedManager;

+ (AFNetworkReachabilityStatus )currentStatus;

- (void)notifityNetWorkStatus;

- (void)startRequest:(void(^)(BOOL ))start;


+ (void)getData:(NSString *)url parameters:(id)parameters success:(void(^)(id json))success fail:(void(^)())fail;

+ (void)postData:(NSString *)url parameters:(id)parameters success:(successBlock)success fail:(failureBlock)fail;

- (void)cancleAllRequest;

@end
