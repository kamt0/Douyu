//
//  recommendLogic.m
//  douyuTVDemo
//
//  Created by 揭康伟 on 16/4/29.
//  Copyright © 2016年 kamto. All rights reserved.
//

#import "recommendLogic.h"
#import "NetRequestManger.h"
#import "recommendCollectionModel.h"
#import "reconmendPageModel.h"
#import "recommendClassModel.h"
#import "videoModel.h"

@implementation recommendLogic

- (void)getdata:(NSString *)url parameters:(NSDictionary *)parameters sucess:(void(^)(recommendCollectionModel * recommendCollection))success fail:(void(^)())fail{
  
   [NetRequestManger getData:url parameters:parameters success:^(id json) {
       recommendCollectionModel * collectionModel = [self setupRecommendCollectionModel:json];
       success(collectionModel);
       
   } fail:^{
       fail();
   }];
    
}

- (recommendCollectionModel *)setupRecommendCollectionModel:(id)json{
    
    recommendCollectionModel *collectionModel = [[recommendCollectionModel alloc]init];
    if ([json isKindOfClass:[NSDictionary class]]) {
        NSDictionary * dict = (NSDictionary *)json;
        
        NSMutableArray *recomendPageArray = [NSMutableArray array];
        NSMutableArray *recomendClassArray =[NSMutableArray array];
        NSMutableArray *recomendLoLArray  =[NSMutableArray array];
        
        for (NSDictionary *dictionary in dict[@"app-index"]) {
            reconmendPageModel * model =[[reconmendPageModel alloc]init];
            if (dictionary[@"link_object"][@"title"]) {
               model.title = dictionary[@"link_object"][@"title"];
            }else{
                 model.title = dictionary[@"title"];
            }
           
            if (dictionary[@"thumb"]) {
                model.thumbImageUrl = dictionary[@"thumb"];
            }else{
                 model.thumbImageUrl  =dictionary[@"link_object"][@"thumb"];
            }
           
            [recomendPageArray addObject:model];
        }
        for (NSDictionary * dictionary in dict[@"app-classification"]) {
            recommendClassModel *model = [[recommendClassModel alloc]init];
            model.classId = dictionary[@"id"];
            model.title = dictionary[@"title"];
            model.thumbImageUrl = dictionary[@"thumb"];
            [recomendClassArray addObject:model];
        }
        NSArray *lolSeedingArray = dict[@"app-lol"];
        if (lolSeedingArray.count) {
            for (NSDictionary *dictionary in lolSeedingArray) {
                videoModel *model = [[videoModel alloc]init];
                model.avatar = dictionary[@"link_object"][@"avatar"];
                model.thumb = dictionary[@"link_object"][@"thumb"];
                model.title = dictionary[@"link_object"][@"title"];
                model.nick = dictionary[@"link_object"][@"nick"];
                model.watch = dictionary[@"link_object"][@"view"];
                model.uid = dictionary[@"link_object"][@"uid"];
                [recomendLoLArray addObject:model];
            }
        }
        collectionModel.pageData = recomendPageArray;
        collectionModel.listData = recomendClassArray;
        collectionModel.seedingData = recomendLoLArray;
    }
    return collectionModel;
}

//由于接口问题没有根据页数加载
- (void)getSeedingDataList:(NSString *)url parameters:(NSDictionary *)parameters success:(void(^)(NSArray *))success fail:(void(^)())fail{
    
    [NetRequestManger getData:url parameters:parameters success:^(id json) {
        NSArray *data = json[@"data"];
        NSMutableArray *lolSeedingArray = [NSMutableArray array];
        if (data.count) {
            for (NSDictionary *dictionary in data) {
                if ([dictionary[@"category_name"] isEqualToString:@"英雄联盟"]) {
                    videoModel *model = [[videoModel alloc]init];
                    model.avatar = dictionary[@"avatar"];
                    model.thumb = dictionary[@"thumb"];
                    model.title = dictionary[@"title"];
                    model.nick = dictionary[@"nick"];
                    model.watch = dictionary[@"view"];
                    model.uid = dictionary[@"uid"];
                    [lolSeedingArray addObject:model];
                }
            }
            success(lolSeedingArray);
        }else{
            success(nil);
        }
        
    } fail:^{
        fail();
    }];

    
}

@end
