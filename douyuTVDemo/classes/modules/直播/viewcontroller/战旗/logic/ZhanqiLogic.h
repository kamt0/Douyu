//
//  ZhanqiLogic.h
//  douyuTVDemo
//
//  Created by 揭康伟 on 16/5/10.
//  Copyright © 2016年 kamto. All rights reserved.
//

#import <Foundation/Foundation.h>
@class recommendCollectionModel;
@interface ZhanqiLogic : NSObject
- (void)getDatas:(void(^)(recommendCollectionModel * recommendCollection))completion;
- (void)getSeedingLolList:(NSString *)url success:(void(^)(NSArray *))success fail:(void(^)())fail;

@end
