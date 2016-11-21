//
//  TabbarModel.h
//  douyuTVDemo
//
//  Created by 揭康伟 on 16/5/10.
//  Copyright © 2016年 kamto. All rights reserved.
//

#import <JSONModel/JSONModel.h>
@protocol TabbarModel
@end
@interface TabbarModel : JSONModel
@property (nonatomic, strong) NSString<Optional>* title;
@property (nonatomic, strong) NSString<Optional>* key;
@property (nonatomic, strong) NSString<Optional>* type;
@property (nonatomic, strong) NSString<Optional>* image;
@property (nonatomic, strong) NSString<Optional>* image_hl;
@property (nonatomic, strong) NSArray<TabbarModel,Optional>* subitems;
@end

@interface TabbarSourceModel : JSONModel
@property (nonatomic, strong) NSArray<TabbarModel, Optional>* items;

@end