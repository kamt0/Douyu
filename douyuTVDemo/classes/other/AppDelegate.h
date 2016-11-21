//
//  AppDelegate.h
//  douyuTVDemo
//
//  Created by 揭康伟 on 16/4/28.
//  Copyright © 2016年 kamto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "globalView.h"


@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) globalView *globalView;

- (void)clickGlobalView;
@end

