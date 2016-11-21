//
//  Viedeo_PlayerViewController.h
//  douyuTVDemo
//
//  Created by 揭康伟 on 16/5/27.
//  Copyright © 2016年 kamto. All rights reserved.
//

#import "BaseViewController.h"

@interface Viedeo_PlayerViewController : BaseViewController

@property (nonatomic, strong) NSString *videoTitle;//视频标题

@property (nonatomic, strong) NSMutableArray * videoArray;//视频数组 (包含标清 高清 超清 视频详情数据)

@end
