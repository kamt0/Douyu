//
//  DouyuLogic.m
//  douyuTVDemo
//
//  Created by 揭康伟 on 16/5/11.
//  Copyright © 2016年 kamto. All rights reserved.
//

#import "DouyuLogic.h"
#import "NetRequestManger.h"
#import "recommendCollectionModel.h"
#import "videoModel.h"
#import "reconmendPageModel.h"

@implementation DouyuLogic
- (void)getDatas:(void(^)(recommendCollectionModel * recommendCollection))completion{
    __block recommendCollectionModel *recommendCollection = nil;
    recommendCollection  = [[recommendCollectionModel alloc]init];
    __block NSInteger requestCount = 0;
    dispatch_block_t finishBlock = ^{
        if (2 == requestCount) {
            completion(recommendCollection);
        }
    };
    [self getRecomendPageData:^(NSArray *pageData) {
        
        recommendCollection.pageData = pageData;
        requestCount ++;
        finishBlock();
    }];
    [self getRecommendLolListData:^(NSArray *lolList) {
        recommendCollection.seedingData = lolList;
        requestCount ++;
        finishBlock();
    }];
    
}
- (void)getRecomendPageData:(void(^)(NSArray * pageData))completion{
    [NetRequestManger getData:DouyuRecommentUrl parameters:nil success:^(id json) {
        completion([self setupPagedata:json]);
    } fail:^{
        
    }];
}
- (void)getRecommendLolListData:(void(^)(NSArray * lolList))completion{
    [NetRequestManger getData:DouyuLolListUrl parameters:nil success:^(id json) {
        completion([self setupLolListData:json]);
    } fail:^{
        
    }];
    
}
- (NSArray *)setupPagedata:(id)json{
    if ([json[@"error"] integerValue] == 0) {
        NSArray *array = json[@"data"];
        NSMutableArray *pageData = [[NSMutableArray alloc]init];
        for (NSDictionary *dictionary in array) {
            reconmendPageModel *model = [[reconmendPageModel alloc]init];
            model.title = dictionary[@"title"];
            model.thumbImageUrl  = dictionary[@"pic_url"];
            [pageData addObject:model];
        }
        return pageData;
    }else{
        return nil;
    }
}
- (NSArray *)setupLolListData:(id)json{
    if ([json[@"error"] integerValue] == 0) {
        NSArray * array = json[@"data"];
        NSMutableArray * LolListdata = [[NSMutableArray alloc]init];
        for (int i = 0; i < array.count; i ++) {
            NSDictionary *dictionary = array[i];
            if (i < 4) {
                videoModel *model        = [[videoModel alloc]init];
                model.thumb              = dictionary[@"room_src"];
                model.avatar             = dictionary[@"avatar"];
                model.title              = dictionary[@"room_name"];
                model.uid                = dictionary[@"room_id"];
                model.watch              = dictionary[@"online"];
                model.nick               = dictionary[@"nickname"];
                
                [LolListdata addObject:model];
            }else{
                break;
            }
  
        }
        return LolListdata;
    }else{
        return nil;
    }
}
- (void)getSeedingLolList:(NSString *)url success:(void(^)(NSArray *))success fail:(void(^)())fail{
    [NetRequestManger getData:url parameters:nil success:^(id json) {
        success([self setupSeedingData:json]);
    } fail:^{
        
    }];
}
- (NSArray *)setupSeedingData:(id)json{
    if ([json[@"error"] integerValue] == 0) {
        NSArray *rooms = json[@"data"];
        NSMutableArray * lolListData = [[NSMutableArray alloc]init];
        for (NSDictionary *dictionary in rooms) {
            videoModel *model = [[videoModel alloc]init];
            model.avatar = dictionary[@"avatar"];
            model.thumb = dictionary[@"room_src"];
            model.title = dictionary[@"room_name"];
            model.nick = dictionary[@"nickname"];
            model.watch = dictionary[@"online"];
            model.uid = dictionary[@"room_id"];
            [lolListData addObject:model];
        }
        return lolListData;
    }else{
        return nil;
    }
}

@end
