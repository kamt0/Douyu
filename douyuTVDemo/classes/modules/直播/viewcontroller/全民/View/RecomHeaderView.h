//
//  RecomHeaderView.h
//  douyuTVDemo
//
//  Created by 揭康伟 on 16/5/5.
//  Copyright © 2016年 kamto. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecomHeaderView : UICollectionReusableView
@property (nonatomic, strong) void(^goMoreSeedingBlock)();
@property (nonatomic, strong) NSString *title;
@end
