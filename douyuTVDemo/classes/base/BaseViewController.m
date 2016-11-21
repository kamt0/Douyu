//
//  BaseViewController.m
//  douyuTVDemo
//
//  Created by 揭康伟 on 16/4/28.
//  Copyright © 2016年 kamto. All rights reserved.
//


#import "BaseViewController.h"
#import "AlertView.h"
@interface BaseViewController ()

@end

@implementation BaseViewController
- (void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    //这个不起作用时在info设置
    //View controller-based status bar appearance 为NO
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(refreshFinsh:) name:RefreshDataFinshedNotification object:nil];

    [self setupNavigationItems];
    [self setUIElementsFontWhenAwake];
    //[self requestData];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupNavigationItems{
    
    if (IOS7_OR_LATER) {
        self.navigationController.navigationBar.translucent = TRUE;
        self.navigationController.navigationBar.barTintColor = DEDAULT_COLOR;
       self.navigationController.navigationBar.backgroundColor = DEDAULT_COLOR;
        self.extendedLayoutIncludesOpaqueBars = FALSE;
        //self.edgesForExtendedLayout = UIRectEdgeNone;
        //tabBar的背景色会随着navigationBar的背景色变化 而且整个view会下移64像素，translucent设置为no也会造成这样
        self.automaticallyAdjustsScrollViewInsets = FALSE;
        
    }
    else {
        self.navigationController.navigationBar.translucent = TRUE;
       self.navigationController.navigationBar.barTintColor = DEDAULT_COLOR;
       self.navigationController.navigationBar.backgroundColor = DEDAULT_COLOR;
    }
    
    if (self.navigationController.viewControllers.count > 1) {
       [self leftItemImage:@"btn_back" target:self action:@selector(back)];
    }
}
- (void)setUIElementsFontWhenAwake{
    SHOULDOVERRIDE_M(@"BaseViewController", NSStringFromClass([self class]), @"子类必须重写setUIElementsFontWhenAwake这一方法");
}

- (void)requestData{
    SHOULDOVERRIDE_M(@"BaseViewController", NSStringFromClass([self class]), @"子类必须重写requestData这一方法");
}
- (void)refresh:(UIView *)view{
     __block  BOOL netWorkReachable = TRUE;
     [view.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIView *view = obj;
        if ([view isKindOfClass:[UICollectionView class]]) {
            UICollectionView * collectionView  = (UICollectionView *)view;
            collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
                if (netWorkReachable) {
                    [self requestData];
                }
                
            }];
            //这儿执行后就会对网络状态进行监测
            [[NetRequestManger sharedManager] startRequest:^(BOOL networkStatus) {
                netWorkReachable = netWorkReachable;
                if (networkStatus) {
                    [collectionView.mj_header beginRefreshing];
                }else{
                    NSLog(@"网络很槽糕");
                }
            }];
            
            
        }else if ([view isKindOfClass:[UITableView class]]){
            UITableView *tableView = (UITableView *)view;
            tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
                if (netWorkReachable) {
                    [self requestData];
                }
                
            }];
            [[NetRequestManger sharedManager] startRequest:^(BOOL networkStatus) {
                netWorkReachable = networkStatus;
                if (networkStatus) {
                    [tableView.mj_header beginRefreshing];
                }else{
                    NSLog(@"网络很槽糕");
                }
            }];

            
        }
    }];
}
- (void)back{
    
    if(self.presentingViewController) {
        [self.presentingViewController dismissViewControllerAnimated:TRUE completion:nil];
    }
    else if (self.navigationController) {
        [self.navigationController popViewControllerAnimated:TRUE];
    }
}
- (void)refreshFinsh:(NSNotification *)notification{
    UIView *view = (UIView *)notification.object;
    [view.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIView *view = obj;
        if ([view isKindOfClass:[UICollectionView class]]) {
            UICollectionView * collectionView  = (UICollectionView *)view;
            [collectionView.mj_header endRefreshing];
        }else if ([view isKindOfClass:[UITableView class]]){
            UITableView *tableView = (UITableView *)view;
            [tableView.mj_header endRefreshing];
        }
    }];
}

- (void)showMessage:(NSString *)message{
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    NSInteger alertTag = 200000;
    AlertView *alertView = (AlertView *)[keyWindow viewWithTag:alertTag];
    if (!alertView) {
        alertView = [[AlertView alloc]init];
        alertView.tag = alertTag;
        [alertView showMessage:message InView:keyWindow];

    }
    
}


@end
