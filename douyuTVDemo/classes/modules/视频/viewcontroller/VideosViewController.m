//
//  VideosViewController.m
//  douyuTVDemo
//
//  Created by 揭康伟 on 16/5/13.
//  Copyright © 2016年 kamto. All rights reserved.
//

#import "VideosViewController.h"
#import "tabView.h"
#import "videoSortModel.h"
#import "VideoSort_ListViewController.h"
#import "VideoSortCollectionView.h"
#import "VideoListTableView.h"
#import "AppDelegate.h"

@interface VideosViewController ()

@property (nonatomic , strong)tabView *tabView; //标签导航栏视图

@property (nonatomic , strong) VideoSortCollectionView *sortView;//分类视图

@property (nonatomic , strong) VideoListTableView *latestView;//最新视图

@property (nonatomic ,retain) VideoSort_ListViewController *videoListVC;//视频列表视图控制器

@end

@implementation VideosViewController

-(void)dealloc{
    
    _tabView = nil;
    
    _latestView = nil;
    
    _sortView = nil;
    
    _videoListVC = nil;
    

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.edgesForExtendedLayout = UIRectEdgeNone; //压入桟的控制器frame的y值就是从导航条下面开始,这个属性从7.0开始出现的
    //self.navigationController.navigationBar.translucent = NO;// translucent属性在ios6之前默认为no,而在ios7下的导航栏默认却是半透明的，为yes,当前控制器是作为navigationController的子控制器，而系统会自动使导航栏下面的第一个scrollview的contentOffset.y值下移64个点
    
    //添加标签导航栏视图
    
    [self.view addSubview:self.tabView];
   
    
    //标签导航栏视图回调block实现
    
    __block VideosViewController *Self = self;
    
    self.tabView.returnIndex = ^(NSInteger selectIndex){
        
        //根据标签导航下标切换不同视图显示
        
        [Self switchViewBySelectIndex:selectIndex];
        
    };
    
    //添加分类视图
    
    [self.view addSubview:self.sortView];
    
    //添加最新视图
    
    [self.view addSubview:self.latestView];
    
    //默认显示分类视图
    
    self.tabView.selectIndex = 0;
    
    //默认sortView在最上方
    
    [self.view bringSubviewToFront:self.sortView];
    

}



#pragma mark----导航控制器上的下载按钮

-(void)navigationButton{
    
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"iconfont-xiazai"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] style:UIBarButtonItemStyleDone target:self action:@selector(rightButtonAction:)];
    
    rightButtonItem.tintColor = [UIColor whiteColor];
    
    self.navigationItem.rightBarButtonItem = rightButtonItem;
    
}





#pragma mark ---下载按钮响应事件

-(void)rightButtonAction:(UIBarButtonItem *)sender{
    
    //调用打开下载视图控制器方法
    
    AppDelegate *app = [UIApplication sharedApplication].delegate;
    
   // [app openDownloadVC];
    
    
}


#pragma mark - 懒加载标签导航栏视图

-(tabView *)tabView{
    
    if (_tabView == nil) {
        
        NSArray * tabArray = @[@"分类",@"最新"];
        
        _tabView = [[tabView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40)];
        _tabView.dataArray = tabArray;
    }
    
    return _tabView;
    
}

#pragma mark ---根据标签导航下标切换不同视图显示

- (void)switchViewBySelectIndex:(NSInteger)selectIndex{
    
    //判断选中的标签下标 执行相应的切换
    
    switch (selectIndex) {
        case 0:
            
            //分类视图
            
            [self.view bringSubviewToFront:self.sortView];
            
            break;
            
        case 1:
        {
            
            //最新视图
            
            [self.view bringSubviewToFront:self.latestView];
            
        }
            break;
            
        default:
            break;
    }
    
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    //清空内存中的图片缓存
    
    [[SDImageCache sharedImageCache] clearMemory];
    
}




#pragma mark - LazyLoading
-(VideoSortCollectionView *)sortView{
    
    if (_sortView == nil) {
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        
        //设置单元格大小
        
        flowLayout.itemSize = CGSizeMake( ( CGRectGetWidth(self.view.frame) - 50 ) /4 , ( CGRectGetWidth(self.view.frame) - 50 ) /4 + 20);
        
        //设置最小左右间距 ，单元格之间
        
        flowLayout.minimumInteritemSpacing = 10;
        
        //设置最小上下间距
        
        flowLayout.minimumLineSpacing = 10;
        
        //设置滑动方向
        
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        
        //设置cell的边界范围
        
        flowLayout.sectionInset = UIEdgeInsetsMake(10 , 10 , 10 , 10 );
        
        _sortView = [[VideoSortCollectionView alloc]initWithFrame:CGRectMake(0, 40, self.view.frame.size.width, self.view.frame.size.height - 40 - 113) collectionViewLayout:flowLayout];
        
        
        __block VideosViewController *Self = self;
        
        _sortView.block = ^(NSString *tag , NSString *name){
            
            Self.videoListVC.string = tag;
            
            Self.videoListVC.name = name;
            
            [Self.videoListVC loadData];//加载数据
            
            Self.videoListVC.hidesBottomBarWhenPushed = YES;//隐藏tabbar
            
            [Self.navigationController pushViewController:Self.videoListVC animated:YES];
            
        };
        
        _sortView.videoSearchBlock = ^(NSString *videoName){
            
            Self.videoListVC.name = [NSString stringWithFormat:@"%@的搜索结果",videoName];
            
            Self.videoListVC.searchName = videoName;
            
            [Self.videoListVC loadData];//加载数据
            
            Self.videoListVC.hidesBottomBarWhenPushed = YES;//隐藏tabbar
            
            [Self.navigationController pushViewController:Self.videoListVC animated:YES];
            
        };
        
        
        
    }
    
    return _sortView;
    
}


//最新
- (VideoListTableView *)latestView{
    
    if (_latestView == nil) {
        
        _latestView = [[VideoListTableView alloc]initWithFrame:CGRectMake(0, 40 , self.view.frame.size.width, self.view.frame.size.height - 113 - 40) style:UITableViewStylePlain];
        
        _latestView.urlStr = kUnion_Video_NewURL;
        
        _latestView.rootVC = self;
        
    }
    
    return _latestView;
}


-(VideoSort_ListViewController *)videoListVC{
    
    if (_videoListVC == nil) {
        
        _videoListVC = [[VideoSort_ListViewController alloc]init];
        
    }
    
    return _videoListVC;
    
}
#pragma mark - super method
- (void)setUIElementsFontWhenAwake{
    
}
- (void)setupNavigationItems{
   
}
@end
