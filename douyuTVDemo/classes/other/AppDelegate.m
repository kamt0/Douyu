//
//  AppDelegate.m
//  douyuTVDemo
//
//  Created by 揭康伟 on 16/4/28.
//  Copyright © 2016年 kamto. All rights reserved.
//

#import "AppDelegate.h"
#import "BaseTabBarController.h"
#import <CBZSplashView.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    self.window.rootViewController = [[BaseTabBarController alloc]init];
    [self.window makeKeyAndVisible];
    
    [self loadstartImage];
   
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application
{
    // 清除内存缓存
    [[SDWebImageManager sharedManager].imageCache clearMemory];
    // 取消所有下载
    [[SDWebImageManager sharedManager] cancelAll];
}

//加载启动图片

- (void)loadstartImage{
    
    //启动图片动画
    
    UIImage *icon = [UIImage imageNamed:@"startImage"];
    
    UIColor *color = DEDAULT_COLOR;
    
    CBZSplashView *splashView = [CBZSplashView splashViewWithIcon:icon backgroundColor:color];
    
    splashView.animationDuration = 1.4f;
    
    splashView.iconColor = [UIColor whiteColor];
    
    [self.window addSubview:splashView];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [splashView startAnimation];//延迟0.5秒开启动画
         [self loadGlobalView];
        
    });
    
}
//记载气泡
- (void)loadGlobalView{
    
    self.globalView = [[globalView alloc]initWithFrame:CGRectMake(CGRectGetWidth(self.window.frame) - 80 , self.window.frame.size.height - 190, 60, 60)];
    self.globalView.backgroundColor = [UIColor clearColor];
    [self.window addSubview:self.globalView];
    [self.window bringSubviewToFront:self.globalView];
    
   
}
#pragma mark - 点击全局按钮事件
- (void)clickGlobalView{
  
}


@end
