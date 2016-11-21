//
//  OtherViewController.m
//  douyuTVDemo
//
//  Created by 揭康伟 on 16/5/13.
//  Copyright © 2016年 kamto. All rights reserved.
//

#import "OtherViewController.h"
#import "ITRAirSideMenu.h"

@interface OtherViewController ()

@end

@implementation OtherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;

    [self leftItemImage:@"icon_menu" target:self action:@selector(presentLeftMenuViewController)];
    // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = FALSE;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
   
}
- (void) presentLeftMenuViewController{
    
    //show left menu with animation

    self.tabBarController.tabBar.hidden = TRUE;
    [DATA_EN.leftMenu presentLeftMenuViewController];
    
}
#pragma mark -super method
- (void)setUIElementsFontWhenAwake{
    
}
- (void)setupNavigationItems{
    [super setupNavigationItems];
}

@end
