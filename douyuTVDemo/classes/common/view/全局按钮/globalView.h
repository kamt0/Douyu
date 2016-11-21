//
//  globalView.h
//  douyuTVDemo
//
//  Created by 揭康伟 on 16/5/13.
//  Copyright © 2016年 kamto. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^clickBlock)();

@interface globalView : UIView

@property (nonatomic ,assign) CGPoint startPoint;//触摸起始点

@property (nonatomic ,assign) CGPoint endPoint;//触摸结束点

@property (nonatomic ,assign) clickBlock clickBlock;

@end
