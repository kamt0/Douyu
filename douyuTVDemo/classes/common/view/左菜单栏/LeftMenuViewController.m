//
//  LeftMenuViewController.m
//  demo1
//
//  Created by 揭康伟 on 16/5/12.
//  Copyright © 2016年 kamto. All rights reserved.
//
#define itemWidth 150
#import "LeftMenuViewController.h"
#import "menuItem.h"
#import "AppDelegate.h"
#import "OtherViewController.h"
#import "BaseNavigationController.h"
#import "BaseTabBarController.h"

@interface LeftMenuViewController (){
    NSInteger _selectedIndex;
}

@end

@implementation LeftMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
    // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated{
   self.tabBarController.tabBar.hidden = TRUE;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)setupView{
    menuItem *item1 = [[menuItem alloc]initWithFrame:CGRectZero];
    item1.title = @"装备";
    item1.index = 1;
    item1.ClickButtonBlock = ^(NSInteger index){
        [self clickedButton:index];
    };
    
    menuItem *item2 = [[menuItem alloc]initWithFrame:CGRectZero];
    item2.title = @"英雄";
    item2.index = 2;
    item2.ClickButtonBlock = ^(NSInteger index){
        [self clickedButton:index];
    };
    
    menuItem *item3 = [[menuItem alloc]initWithFrame:CGRectZero];
    item3.title = @"符文";
    item3.index = 3;
    item3.ClickButtonBlock = ^(NSInteger index){
        [self clickedButton:index];
    };
    
    [self.view addSubview:item1];
    [self.view addSubview:item2];
    [self.view addSubview:item3];
    CGFloat scrennheight = [UIScreen mainScreen].bounds.size.height;
    CGFloat height = scrennheight/2 - 120;
    item1.sd_layout.leftSpaceToView(self.view,0).topSpaceToView(self.view,height).widthIs(itemWidth).heightIs(60);
    item2.sd_layout.leftSpaceToView(self.view,0).topSpaceToView(item1,20).widthIs(itemWidth).heightIs(60);
    item3.sd_layout.leftSpaceToView(self.view,0).topSpaceToView(item2,20).widthIs(itemWidth).heightIs(60);

    
    
}
- (void)clickedButton:(NSInteger)index{
    
    [DATA_EN.leftMenu hideMenuViewController];
    _selectedIndex = index;
}
#pragma mark -
#pragma mark ITRAirSideMenu Delegate

- (void)sideMenu:(ITRAirSideMenu *)sideMenu didRecognizePanGesture:(UIPanGestureRecognizer *)recognizer {
    
    NSLog(@"didRecognizePanGesture");
}

- (void)sideMenu:(ITRAirSideMenu *)sideMenu willShowMenuViewController:(UIViewController *)menuViewController {
    
    NSLog(@"willShowMenuViewController: %@ isMenuVisible <%d>", NSStringFromClass([menuViewController class]), (int)sideMenu.isLeftMenuVisible );
}

- (void)sideMenu:(ITRAirSideMenu *)sideMenu didShowMenuViewController:(UIViewController *)menuViewController {
    
    NSLog(@"didShowMenuViewController: %@ isMenuVisible <%d>", NSStringFromClass([menuViewController class]), (int)sideMenu.isLeftMenuVisible );
}

- (void)sideMenu:(ITRAirSideMenu *)sideMenu willHideMenuViewController:(UIViewController *)menuViewController {
    
    NSLog(@"willHideMenuViewController: %@ isMenuVisible <%d>", NSStringFromClass([menuViewController class]), (int)sideMenu.isLeftMenuVisible );
}

- (void)sideMenu:(ITRAirSideMenu *)sideMenu didHideMenuViewController:(UIViewController *)menuViewController{
    
    NSLog(@"didHideMenuViewController: %@ isMenuVisible <%d>", NSStringFromClass([menuViewController class]), (int)sideMenu.isLeftMenuVisible );
    
    switch (_selectedIndex) {
        case 1:
            [sideMenu setContentViewController:[[BaseNavigationController alloc] initWithRootViewController:[[OtherViewController alloc]init]]];
            break;
        case 2:
            [sideMenu setContentViewController:[[BaseNavigationController alloc] initWithRootViewController:[[OtherViewController alloc]init]]];
            break;
        case 3:
            [sideMenu setContentViewController:[[BaseNavigationController alloc] initWithRootViewController:[[OtherViewController alloc]init]]];
            break;
        default:
            break;
    }
    sideMenu.tabBarController.tabBar.hidden = FALSE;
    
}
@end
