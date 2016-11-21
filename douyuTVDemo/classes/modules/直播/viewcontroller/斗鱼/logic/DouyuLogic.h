//
//  DouyuLogic.h
//  douyuTVDemo
//
//  Created by 揭康伟 on 16/5/11.
//  Copyright © 2016年 kamto. All rights reserved.
//

#import <Foundation/Foundation.h>
@class recommendCollectionModel;

@interface DouyuLogic : NSObject
- (void)getDatas:(void(^)(recommendCollectionModel * recommendCollection))completion;
- (void)getSeedingLolList:(NSString *)url success:(void(^)(NSArray *))success fail:(void(^)())fail;
@end
