//
//  NetRequestManger.m
//  douyuTVDemo
//
//  Created by 揭康伟 on 16/4/29.
//  Copyright © 2016年 kamto. All rights reserved.
//

#import "NetRequestManger.h"

@implementation NetRequestManger

static AFNetworkReachabilityStatus  _networkStatus;

OBJECT_SINGLETON_BOILERPLATE(NetRequestManger, sharedManager)


- (void)notifityNetWorkStatus{
    
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        _networkStatus = status;
        
        switch (status) {
                
            case AFNetworkReachabilityStatusNotReachable:{
                
                NSLog(@"无网络");
                _isReachable = FALSE;
                break;
                
            }
                
            case AFNetworkReachabilityStatusReachableViaWiFi:{
                
                NSLog(@"WiFi网络");
                _isReachable = TRUE;
                
                break;
                
            }
                
            case AFNetworkReachabilityStatusReachableViaWWAN:{
                
                NSLog(@"无线网络");
                _isReachable = TRUE;
                break;
                
            }
                
            default:
                
                break;
                
        }
    }];

}
- (void)startRequest:(void(^)(BOOL ))start{
    
  
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        _networkStatus = status;
        switch (status) {
                
            case AFNetworkReachabilityStatusNotReachable:{
                
                NSLog(@"无网络");
                start(FALSE);
                break;
                
            }
                
            case AFNetworkReachabilityStatusReachableViaWiFi:{
                
                NSLog(@"WiFi网络");
                start(TRUE);
                
                break;
                
            }
                
            case AFNetworkReachabilityStatusReachableViaWWAN:{
                
               
               start(TRUE);
                break;
                
            }
                
            default:
                
                break;
                
        }
    }];
   

}

+ (AFNetworkReachabilityStatus)currentStatus{
    
    return _networkStatus;
}
+ (void)getData:(NSString *)url parameters:(id)parameters success:(void(^)(id json))success fail:(void(^)())fail{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    // 返回的数据格式是JSON
//    manager.responseSerializer = [AFJSONResponseSerializer serializer];
//    // 申明请求的数据是json类型
//    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    // 设置超时时间
    
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    
    manager.requestSerializer.timeoutInterval = 15.0f;
    
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    manager.responseSerializer.acceptableContentTypes =
    [NSSet setWithObjects:@"application/json", @"text/json", @"text/plain",
     @"text/html", nil];
    
    [manager GET:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        success(responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
       
        fail();
    }];
}

+ (void)postData:(NSString *)url parameters:(id)parameters success:(successBlock)success fail:(failureBlock)fail{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
   
    [manager POST:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        success(responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        fail(error);
    }];
}
- (void)cancleAllRequest {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.operationQueue cancelAllOperations];
}
@end
