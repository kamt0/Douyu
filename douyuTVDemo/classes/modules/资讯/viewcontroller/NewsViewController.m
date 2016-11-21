//
//  NewsViewController.m
//  douyuTVDemo
//
//  Created by 揭康伟 on 16/5/13.
//  Copyright © 2016年 kamto. All rights reserved.
//

#import "NewsViewController.h"
#import "NewsDetailViewController.h"
#import "NewsPictureScrollViewController.h"

#import "TabSliderView.h"
#import "News_TableView.h"
#import "News_PicturesView.h"

#define KNaviBarHeight      64
#define KTabViewHeight      40
#define KTabBarHeight       50

@interface NewsViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) TabSliderView *tabView; //标签导航栏视图

@property (nonatomic, strong) UIScrollView *scrollView; //滑动视图控制器

@property (nonatomic, strong) News_TableView *newsTopTableView;//头条

@property (nonatomic, strong) News_TableView *newsVideoTableView;//视频

@property (nonatomic, strong) News_PicturesView *prettyCharmingPicturesView;//靓照

@property (nonatomic, strong) News_PicturesView *prettyEmbarrassedPicturesView;//囧图

@property (nonatomic, strong) News_PicturesView *prettyWallpaperPicturesView;//壁纸
@end

@implementation NewsViewController

- (void)dealloc{
    _tabView                       = nil;
    _scrollView                    = nil;
    _newsTopTableView              = nil;
    _newsVideoTableView            = nil;
    _prettyCharmingPicturesView    = nil;
    _prettyWallpaperPicturesView   = nil;
    _prettyEmbarrassedPicturesView = nil;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     [[SDWebImageManager sharedManager].imageCache clearMemory];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 懒加载标签导航栏视图

-(TabSliderView *)tabView{
    
    if (_tabView == nil) {
        
        NSArray * tabArray = @[@"头条",@"视频",@"靓照",@"囧图",@"壁纸"];
        
        _tabView = [[TabSliderView alloc]initWithFrame:CGRectMake(0, KNaviBarHeight, self.view.frame.size.width, KTabViewHeight)];
        
        _tabView.dataArray = tabArray;
    }
    
    return _tabView;
    
}
#pragma mark - super method
- (void)setUIElementsFontWhenAwake{
    //加载所有视图
    
    [self loadAllView];
    
    //添加标签导航栏视图
    
    [self.view addSubview:self.tabView];
    
    //标签导航栏视图回调block实现
    
    __block NewsViewController *Self = self;
    
    _tabView.selectIndexBlcok = ^(NSInteger selectIndex){
        
        //根据标签导航下标切换不同视图显示
        
        [Self switchViewBySelectIndex:selectIndex];
        
    };
    
    //设置默认标签页
    
    _tabView.selectIndex = 0;
}
- (void)setupNavigationItems{
    [super setupNavigationItems];
}


#pragma mark - 根据标签导航下标切换不同视图显示

- (void)switchViewBySelectIndex:(NSInteger)selectIndex{
    
    //获取选中的下标 并设置内容视图相应的页面显示
    
    _scrollView.contentOffset = CGPointMake(CGRectGetWidth(_scrollView.frame) * selectIndex, 0);
    
}


#pragma mark - 加载所有视图

- (void)loadAllView{
    
    //初始化滑动视图
    
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0 , KNaviBarHeight+KTabViewHeight, CGRectGetWidth(self.view.frame) , CGRectGetHeight(self.view.frame) -KNaviBarHeight-KTabViewHeight- KTabBarHeight)];
    
    _scrollView.contentSize = CGSizeMake(CGRectGetWidth(_scrollView.frame) * 5 , CGRectGetHeight(_scrollView.frame));
    
    _scrollView.pagingEnabled = TRUE;
    
    _scrollView.directionalLockEnabled = TRUE;
    
    _scrollView.showsHorizontalScrollIndicator = FALSE;
    
    _scrollView.delegate = self;
    
    [self.view addSubview:_scrollView];
    
    
    //加载资讯表视图
    
    [self loadNewsTabelViews];
    
    //加载图片视图
    
    [self loadPicturesViews];
    
}

#pragma mark - 加载资讯表视图

- (void)loadNewsTabelViews{
    
    __block typeof (self) Self = self;
    
    __block NewsDetailViewController *details = [[NewsDetailViewController alloc]init];
    
    //头条资讯表视图
    
    _newsTopTableView = [[News_TableView alloc]initWithFrame:CGRectMake(0 , 0 , CGRectGetWidth(_scrollView.frame) , CGRectGetHeight(_scrollView.frame))];
    
    _newsTopTableView.scrollPage = 0;
    
    //设置URL
    
    _newsTopTableView.urlstring = [NSString stringWithFormat:kNews_ListURL,@"headlineNews",@"%ld"];
    
    //跳转到头条 详情页面
    
    _newsTopTableView.detailsBlock = ^(NSString *string , NSString *type){
        
        details.urlString = [NSString stringWithFormat:@"%@%@",News_WebViewURl,string];
        
        details.type = type;
        
        [Self.navigationController pushViewController:details animated:YES];
        
    };
    _newsTopTableView.topicBlock = ^(NSString *string , NSString *type){
        
    };
    [_scrollView addSubview: _newsTopTableView];
    
   

    
    //视频资讯表视图
    
    _newsVideoTableView = [[News_TableView alloc]initWithFrame:CGRectMake(CGRectGetWidth(_scrollView.frame)  , 0 , CGRectGetWidth(_scrollView.frame) , CGRectGetHeight(_scrollView.frame))];
    
    _newsVideoTableView.scrollPage = 1;
    
    //设置URL
    
    _newsVideoTableView.urlstring = [NSString stringWithFormat:kNews_ListURL, @"newsVideo" ,@"%ld"];
    
    //跳转详情页面
    
    _newsVideoTableView.detailsBlock = ^(NSString *string , NSString *type){
        
        details.urlString = [NSString stringWithFormat:@"%@%@",News_WebViewURl,string];
        
        details.type = type;
        
        [Self.navigationController pushViewController:details animated:YES];
        
    };
    
    [_scrollView addSubview: _newsVideoTableView];
    
    
    //隐藏tabBar
    
    details.hidesBottomBarWhenPushed = YES;
    
   
    
}

#pragma mark - 加载图片视图

- (void)loadPicturesViews{
    
    __block typeof (self) weakSelf = self;
    __block NewsPictureScrollViewController *pictureVc = [[NewsPictureScrollViewController alloc]init];

    //创建靓照图片视图
    
    _prettyCharmingPicturesView = [[News_PicturesView alloc]initWithFrame:CGRectMake(CGRectGetWidth(_scrollView.frame) * 2 , 0 , CGRectGetWidth(_scrollView.frame) , CGRectGetHeight(_scrollView.frame))];
    
    //设置URL
    
    _prettyCharmingPicturesView.urlString = [NSString stringWithFormat:News_PrettyPicturesURL, @"beautifulWoman" ,@"%ld"];
    
     _prettyCharmingPicturesView.prettyPicturesBlock = ^(NSString *string){
        
        pictureVc.pictureString = [NSString stringWithFormat:@"%@%@",News_PicturesURL,string];
        
        
        [weakSelf presentViewController:pictureVc animated:YES completion:^{
            
        }];
        
    };
    
    [_scrollView addSubview:_prettyCharmingPicturesView];
    
    
    //创建囧图图片视图
    
    _prettyEmbarrassedPicturesView = [[News_PicturesView alloc]initWithFrame:CGRectMake(CGRectGetWidth(_scrollView.frame) * 3 , 0 , CGRectGetWidth(_scrollView.frame) , CGRectGetHeight(_scrollView.frame))];
    
    //设置URL
    
    _prettyEmbarrassedPicturesView.urlString = [NSString stringWithFormat:News_PrettyPicturesURL, @"jiongTu" ,@"%ld"];

    _prettyEmbarrassedPicturesView.prettyPicturesBlock = ^(NSString *string){
        
        pictureVc.pictureString = [NSString stringWithFormat:@"%@%@",News_PicturesURL,string];
        
        
        [weakSelf presentViewController:pictureVc animated:YES completion:^{
            
        }];
        
    };
    
    [_scrollView addSubview:_prettyEmbarrassedPicturesView];
    
    
    //创建壁纸图片视图
    
    _prettyWallpaperPicturesView = [[News_PicturesView alloc]initWithFrame:CGRectMake(CGRectGetWidth(_scrollView.frame) * 4 , 0 , CGRectGetWidth(_scrollView.frame) , CGRectGetHeight(_scrollView.frame))];
    
    //设置URL
    
    _prettyWallpaperPicturesView.urlString = [NSString stringWithFormat:News_PrettyPicturesURL, @"wallpaper" ,@"%ld"];

    _prettyWallpaperPicturesView.prettyPicturesBlock = ^(NSString *string){
        
        pictureVc.pictureString = [NSString stringWithFormat:@"%@%@",News_PicturesURL,string];
        
        
        [weakSelf presentViewController:pictureVc animated:YES completion:^{
            
        }];
        
    };
    
    [_scrollView addSubview:_prettyWallpaperPicturesView];
    
    
    
    //隐藏tabBar
    
    pictureVc.hidesBottomBarWhenPushed = YES;
    
}

#pragma mark - UIScrollViewDelegate

//滚动视图减速完成，滚动将停止时，调用该方法。一次有效滑动，只执行一次。

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    NSInteger page = scrollView.contentOffset.x / scrollView.frame.size.width;
    
    //设置相应的标签导航视图的选中下标
    
    self.tabView.selectIndex = page;
    
}
@end
