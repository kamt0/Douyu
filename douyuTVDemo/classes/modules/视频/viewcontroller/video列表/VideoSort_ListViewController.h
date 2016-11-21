//
//  VideoSort_ListViewController.h
//  douyuTVDemo
//
//  Created by 揭康伟 on 16/8/3.
//  Copyright © 2016年 kamto. All rights reserved.
//

#import "BaseViewController.h"

@interface VideoSort_ListViewController : BaseViewController

@property (nonatomic , strong) NSString * string;

@property (nonatomic , strong) NSString * name;

@property (nonatomic , strong) NSString *searchName;


//加载数据

-(void)loadData;

@end
