//
//  AlertView.h
//  douyuTVDemo
//
//  Created by 揭康伟 on 16/5/7.
//  Copyright © 2016年 kamto. All rights reserved.
//

#import "BaseView.h"

@interface AlertView : BaseView

- (void)showMessage:(NSString *)message InView:(UIView *)supView;

- (void)showMessage:(NSString *)message InView:(UIView *)supView disappearDelay:(NSTimeInterval)delay;


@end
