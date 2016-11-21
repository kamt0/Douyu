//
//  BaseNavigationController.m
//  douyuTVDemo
//
//  Created by 揭康伟 on 16/4/28.
//  Copyright © 2016年 kamto. All rights reserved.
//

#import "BaseNavigationController.h"

@interface BaseNavigationController ()

@end

@implementation BaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    //导航栏按钮字体颜色
    self.navigationBar.tintColor = [UIColor whiteColor];
    //导航栏标题颜色
    self.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                              [UIColor whiteColor],NSForegroundColorAttributeName,
                                              [UIFont systemFontOfSize:18],NSFontAttributeName,
                                              nil];

    if (IOS7_OR_LATER) {
        self.navigationBar.translucent = TRUE;
        self.navigationBar.barTintColor = DEDAULT_COLOR;
        self.navigationBar.backgroundColor = DEDAULT_COLOR;
        
    }


    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
