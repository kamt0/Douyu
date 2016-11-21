//
//  VideoListTableView.h
//  douyuTVDemo
//
//  Created by 揭康伟 on 16/5/27.
//  Copyright © 2016年 kamto. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^SelectedVideoBlock)(NSMutableArray *videoArray , NSString *videoTitle);

@interface VideoListTableView : UITableView


@property (nonatomic , strong ) NSString *urlStr;//URL字符串

@property (nonatomic , strong ) SelectedVideoBlock selectedVideoBlock;//选中视频cellBlock

@property (nonatomic , strong ) UIViewController *rootVC;//父视图控制器

@property (nonatomic , assign ) BOOL isShowLoadingView;//是否显示加载视图

//请求视频详情数据

- (void)netWorkingGetVideoDetailsWithVID:(NSString *)vid Title:(NSString *)title;

@end
