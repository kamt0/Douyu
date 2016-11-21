//
//  BaseTabBarController.m
//  douyuTVDemo
//
//  Created by 揭康伟 on 16/4/28.
//  Copyright © 2016年 kamto. All rights reserved.
//

#import "BaseTabBarController.h"
#import "BaseNavigationController.h"
#import "BaseViewController.h"
#import "QuanminViewController.h"
#import "DouyuViewController.h"
#import "ZhanqiViewController.h"
#import "LeftMenuViewController.h"
#import "LibiaryAPI.h"
#import "TabbarModel.h"

@interface BaseTabBarController ()<UITabBarControllerDelegate>

@end

@implementation BaseTabBarController
//执行顺序
//在程序运行后立即执行,若自身未定义，不沿用父类的方法
+ (void)load{
    
}
//在类的方法第一次被调时执行,若自身未定义，沿用父类的方法
+ (void)initialize{
    //获取当前页面下所有的item
    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor orangeColor]} forState:UIControlStateSelected];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
    // Do any additional setup after loading the view.
    //[self addChildViewControllers];

    [self setupTabbarViewControllers];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - private method
- (void)addChildViewControllers{
    
    QuanminViewController *recomendVC = [[QuanminViewController alloc]init];
    [self addChildVC:recomendVC andTitle:@"全民" andImage:@"tabbar_home" andSelectedImage:@"tabbar_home_sel"];
    
    DouyuViewController *columnVC = [[DouyuViewController alloc]init];
   [self addChildVC:columnVC andTitle:@"斗鱼" andImage:@"tabbar_game" andSelectedImage:@"tabbar_game_sel"];
    
    ZhanqiViewController *directSeedingVC = [[ZhanqiViewController alloc]init];
    
   [self addChildVC:directSeedingVC andTitle:@"战旗" andImage:@"tabbar_room" andSelectedImage:@"tabbar_room_sel"];
    
    
}

- (void)addChildVC:(BaseViewController *)childC andTitle:(NSString *)title andImage:(NSString *)image andSelectedImage:(NSString *)selectedImage{
    childC.title = title;
    childC.tabBarItem.image = [[UIImage imageNamed:image]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childC.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
     BaseNavigationController *nav = [[BaseNavigationController alloc]initWithRootViewController:childC];
    [self addChildViewController:nav];
    
}
- (void)setupTabbarViewControllers{
    NSMutableArray *controllers = [NSMutableArray array];
    
    TabbarSourceModel *sourceModel =[[TabbarSourceModel alloc]initWithDictionary:[LibiaryAPI initWithFileName:@"rootTabs" extension:@"json"] error:nil];
    
    for (TabbarModel *tabModel in sourceModel.items) {
        
        BaseViewController *vc =
            (BaseViewController *)[LibiaryAPI viewControllerWithKey:tabModel.key];
        BaseNavigationController *nav = [[BaseNavigationController alloc]initWithRootViewController:vc];
        
        vc.title = tabModel.title;
        for (TabbarModel *model in tabModel.subitems) {
            UITabBarItem *customItem = [[UITabBarItem alloc]initWithTitle:model.title image: [UIImage imageNamed:model.image] selectedImage:[UIImage imageNamed:model.image_hl]];
            [customItem setTitleTextAttributes:@{NSForegroundColorAttributeName:DEDAULT_COLOR,NSFontAttributeName : [UIFont boldSystemFontOfSize:10.0]} forState:UIControlStateSelected];
//            customItem.imageInsets = UIEdgeInsetsMake(-3, 0, 3, 0);
//            [customItem setTitlePositionAdjustment:UIOffsetMake(0, -5)];

            vc.tabBarItem = customItem;
        }
        if ([tabModel.key isEqualToString:@"tab_3"]) {
            
            LeftMenuViewController *leftMenuVC  =[[LeftMenuViewController alloc]init];
            ITRAirSideMenu *  _Leftmenu = [[ITRAirSideMenu alloc] initWithContentViewController:nav leftMenuViewController:leftMenuVC];
            _Leftmenu.backgroundImage = [UIImage imageNamed:@"AUQNL91OA424"];
            _Leftmenu.delegate = leftMenuVC;
            
            //content view shadow properties
            _Leftmenu.contentViewShadowColor = [UIColor blackColor];
            _Leftmenu.contentViewShadowOffset = CGSizeMake(0, 0);
            _Leftmenu.contentViewShadowOpacity = 0.6;
            _Leftmenu.contentViewShadowRadius = 12;
            _Leftmenu.contentViewShadowEnabled = YES;
            
            //content view animation properties
            _Leftmenu.contentViewScaleValue = 0.7f;
            _Leftmenu.contentViewRotatingAngle = 30.0f;
            _Leftmenu.contentViewTranslateX = 130.0f;
            
            //menu view properties
            _Leftmenu.menuViewRotatingAngle = 30.0f;
            _Leftmenu.menuViewTranslateX = 130.0f;
            _Leftmenu.tabBarItem = vc.tabBarItem;
            
            DATA_EN.leftMenu = _Leftmenu;
            [controllers addObject:DATA_EN.leftMenu];
            
        }else{
           [controllers addObject:nav]; 
        }
        
        
    }
    
    self.viewControllers = controllers;
}
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    NSLog(@"%d",(int)self.selectedIndex);
}

@end
