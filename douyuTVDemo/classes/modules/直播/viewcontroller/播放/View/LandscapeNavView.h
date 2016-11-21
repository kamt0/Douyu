//
//  LandscapeNavView.h
//  douyuTVDemo
//
//  Created by 揭康伟 on 16/5/7.
//  Copyright © 2016年 kamto. All rights reserved.
//

#import "BaseView.h"
typedef void(^onClickedNavButtonBlock)();
@interface LandscapeNavView : BaseView
@property (nonatomic, strong) onClickedNavButtonBlock onClickedNavButtonBlock;
@end
