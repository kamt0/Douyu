//
//  ZhanqiLogic.m
//  douyuTVDemo
//
//  Created by 揭康伟 on 16/5/10.
//  Copyright © 2016年 kamto. All rights reserved.
//

#import "ZhanqiLogic.h"
#import "NetRequestManger.h"
#import "recommendCollectionModel.h"
#import "reconmendPageModel.h"
#import "videoModel.h"
@implementation ZhanqiLogic

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
    [NetRequestManger getData:ZhanqiPagedataUrl parameters:nil success:^(id json) {
        completion([self setupPagedata:json]);
    } fail:^{
        
    }];
}
- (void)getRecommendLolListData:(void(^)(NSArray * lolList))completion{
    [NetRequestManger getData:ZhanqiRecommentUrl parameters:nil success:^(id json) {
        completion([self setupLolListData:json]);
    } fail:^{
        
    }];

}
- (NSArray *)setupPagedata:(id)json{
    if ([json[@"code"] integerValue] == 0) {
        NSArray *array = json[@"data"];
        NSMutableArray *pageData = [[NSMutableArray alloc]init];
        for (NSDictionary *dictionary in array) {
            reconmendPageModel *model = [[reconmendPageModel alloc]init];
            model.title = dictionary[@"room"][@"title"];
            model.thumbImageUrl  = dictionary[@"room"][@"spic"];
            [pageData addObject:model];
        }
        return pageData;
    }else{
        return nil;
    }
}
- (NSArray *)setupLolListData:(id)json{
    if ([json[@"code"] integerValue] == 0) {
        NSArray * array = json[@"data"];
        NSMutableArray * LolListdata = [[NSMutableArray alloc]init];
        for (NSDictionary *dictionary in array) {
            if ([dictionary[@"keyword"] isEqualToString:@"index.lol"]) {
                NSArray * lists = dictionary[@"lists"];
                for (NSDictionary *dictionary in lists) {
                    videoModel *model = [[videoModel alloc]init];
                    model.thumb = dictionary[@"spic"];
                    model.avatar = dictionary[@"avatar"];
                    model.title = dictionary[@"title"];
                    model.uid = dictionary[@"videoId"];
                    model.watch = dictionary[@"follows"];
                    model.nick = dictionary[@"nickname"];
                    [LolListdata addObject:model];
                    
                }
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
        NSDictionary *dict = json[@"data"];
        NSArray *rooms = dict[@"rooms"];
        NSMutableArray * lolListData = [[NSMutableArray alloc]init];
        for (NSDictionary *dictionary in rooms) {
            videoModel *model = [[videoModel alloc]init];
            model.avatar = dictionary[@"avatar"];
            model.thumb = dictionary[@"spic"];
            model.title = dictionary[@"title"];
            model.nick = dictionary[@"nickname"];
            model.watch = dictionary[@"follows"];
            model.uid = dictionary[@"videoId"];
            model.gender = dictionary[@"gender"];
            [lolListData addObject:model];
       }
        return lolListData;
    }else{
        return nil;
    }
}
@end
