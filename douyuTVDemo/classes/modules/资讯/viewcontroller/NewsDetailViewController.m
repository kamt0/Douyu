//
//  NewsDetailViewController.m
//  douyuTVDemo
//
//  Created by 揭康伟 on 16/5/26.
//  Copyright © 2016年 kamto. All rights reserved.
//

#import "NewsDetailViewController.h"
#import "LoadingView.h"
#import "NSString+addition.h"
#import "VideoListTableView.h"
#import "VideoDetailModel.h"
#import "Viedeo_PlayerViewController.h"


@interface NewsDetailViewController ()<UIWebViewDelegate>

@property (nonatomic, strong ) NSDictionary       *dataDic;

@property (nonatomic, strong ) NSString           *htmlTitle;

@property (nonatomic, strong ) NSString           *htmlStr;

@property (nonatomic, strong ) UIWebView          *webView;

@property (nonatomic , strong) LoadingView        *loadingView;//加载视图

@property (nonatomic ,strong ) UIImageView        *reloadImageView;//重新加载图片视图

@property (nonatomic , strong) VideoListTableView *videoListTableView;//视频列表视图


@end

@implementation NewsDetailViewController


-(void)dealloc{
    
    _dataDic = nil;
    
    _htmlTitle = nil;
    
    _htmlStr = nil;
    
    _webView = nil;
    
    _loadingView = nil;
    
    _reloadImageView = nil;
    
    _videoListTableView = nil;
  
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //标题
    
    self.title = @"资讯";
    
    
    
    //添加导航栏左按钮
    
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"iconfont-sharebutton"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] style:UIBarButtonItemStyleDone target:self action:@selector(rightBarButtonAction:)];
    
    rightBarButton.tintColor = [UIColor whiteColor];
    
    self.navigationItem.rightBarButtonItem = rightBarButton;
    
    
    
}


- (void)setUrlString:(NSString *)urlString{
    
    
    if (_urlString != urlString) {
        
        _urlString = urlString ;
    }
    
    if (urlString != nil) {
        
        //加载数据
        
        [self loadData];
        
    }
    
    
}

-(void)setHtmlStr:(NSString *)htmlStr{
    
    if (_htmlStr != htmlStr) {
        
        
        _htmlStr = htmlStr ;
        
    }
    
    //清除敏感词汇
    
    _htmlStr = [_htmlStr removeSensitiveWordsWithArray:@[@"多玩"]];
    
}

#pragma mark ---单击重新加载提示图片事件

- (void)reloadImageViewTapAction:(UITapGestureRecognizer *)tap{
    
    //重新调用加载数据
    
    [self loadData];
    
}

#pragma mark ---加载数据

//加载数据

- (void)loadData{
    
    //显示加载视图
    
    self.loadingView.hidden = NO;
    
    //隐藏重新加载提示视图
    
    self.reloadImageView.hidden = YES;
    
    //清空webView内容
    
    [self.webView loadHTMLString:@" " baseURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]]];
    
    //请求数据
    
    __block typeof (self) Self = self;
    
    //取消之前的请求
    
    [[NetRequestManger sharedManager] cancleAllRequest];
    //执行新的请求操作
   [NetRequestManger getData:self.urlString parameters:nil success:^(id json) {
       if (json != nil) {
           
           //解析JSON数据
           
           [Self JSONSerializationWithData:json];
           
       } else {
           
           //显示重新加载提示视图
           
           Self.reloadImageView.hidden = NO;
           
       }
       
       //隐藏加载视图
       
       Self.loadingView.hidden = YES;
   } fail:^{
       //显示重新加载提示视图
       
       Self.reloadImageView.hidden = NO;
       
       //隐藏加载视图
       
       Self.loadingView.hidden = YES;
   }];
    
    
   
    
}

#pragma mark ---解析数据

- (void)JSONSerializationWithData:(id)data{
    
    if (data != nil) {
        
        //NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        self.htmlStr = [[data valueForKey:@"data"] valueForKey:@"content"];
        
        self.htmlTitle = [[data valueForKey:@"data"] valueForKey:@"title"];
        
        //更新webView
        
        [self.webView loadHTMLString:self.htmlStr baseURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]]];
        
    }
    
}

#pragma mark ---UIWebViewDelegate

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    
    //加载完成
    
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    
    if ([request.URL isEqual:[NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]]]) {
        
        return YES;
        
    }else{
        
        //判断类型 根据不同类型 进行不同处理
        
        NSString *urlString = [request.URL absoluteString];
        
        if (self.type != nil) {
            
            if ([self.type isEqualToString:@"video"]) {
                
                //视频
                
                [self webViewVideoWithUrl:urlString];
                
                
            } else if ([self.type isEqualToString:@"news"]) {
                
                //信息
                
                //通过浏览器打开
                
                [[UIApplication sharedApplication] openURL:request.URL];
                
                return NO;
                
            }
            
            
        }else {
            
            
            //通过浏览器打开
            
            [[UIApplication sharedApplication] openURL:request.URL];
            
            return NO;
            
            
        }
        
        
        
        
        return NO;
        
    }
    
}

//通过url字符串 获取视频ID 并判断播放 或 下载操作

-(void)webViewVideoWithUrl:(NSString *)urlString{
    
    //判断是否以指定域名链接开头
    
    if ([urlString hasPrefix:@"http://box.dwstatic.com/unsupport"]) {
        
        NSString *vid = nil;
        
        NSString *type = nil;
        
        //去除域名部分
        
        urlString = [urlString stringByReplacingOccurrencesOfString:@"http://box.dwstatic.com/unsupport" withString:@""];
        
        NSRange range = [urlString rangeOfString:@"?"];
        
        urlString = [urlString substringFromIndex:range.location + range.length];
        
        //分隔字符串 获取参数
        
        NSArray *tempArray = [urlString componentsSeparatedByString:@"&"];
        
        for (NSString *item in tempArray) {
            
            if ([item hasPrefix:@"vid="]) {
                
                vid = [item substringFromIndex:4];
                
            }
            
            if ([item hasPrefix:@"lolboxAction="]) {
                
                type = [item substringFromIndex:13];
                
            }
            
        }
        
        //判断类型
        
        if (vid != nil && type != nil) {
            
            if ([type isEqualToString:@"videoPlay"]) {
                
                //根据vid查询视频详情数据 并跳转视频播放
                
                [self.videoListTableView netWorkingGetVideoDetailsWithVID:vid Title:self.htmlTitle];
                
            } else if ( [type isEqualToString:@"videoDownLoad"]){
                
                //下载视频
                
                
                
            }
            
            
        }
        
        
    }
    
    
    
}




#pragma mark ---rightBarButtonAction

- (void)rightBarButtonAction:(UIBarButtonItem *)sender{
    
    
}


#pragma mark ---LazyLoading

-(VideoListTableView *)videoListTableView{
    
    if (_videoListTableView == nil) {
        
        _videoListTableView = [[VideoListTableView alloc]init];
        
        _videoListTableView.rootVC = self;
        
    }
    
    return _videoListTableView;
}

-(UIWebView *)webView{
    
    if (_webView == nil) {
        
        _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 50)];
        
        //自适应屏幕
        
        _webView.scalesPageToFit = NO;
        
        _webView.dataDetectorTypes = UIDataDetectorTypeAll;
        
        _webView.delegate = self;
        
        [self.view addSubview:_webView];
        
        
    }
    
    return _webView;
    
}

-(LoadingView *)loadingView{
    
    if (_loadingView == nil) {
        
        //初始化加载视图
        
        _loadingView = [[LoadingView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) - 64)];
        
        _loadingView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.0f];
        
        _loadingView.loadingColor = DEDAULT_COLOR;
        
        _loadingView.hidden = YES;//默认隐藏
        
        [self.webView addSubview:_loadingView];
        
        [self.webView bringSubviewToFront:_loadingView];
        
    }
    
    return _loadingView;
}




-(UIImageView *)reloadImageView{
    
    if (_reloadImageView == nil) {
        
        //初始化 并添加单击手势
        
        UITapGestureRecognizer *reloadImageViewTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(reloadImageViewTapAction:)];
        
        _reloadImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 200, 200)];
        
        _reloadImageView.center = CGPointMake(CGRectGetWidth(self.view.frame) / 2 , CGRectGetHeight(self.view.frame) / 2);
        
        _reloadImageView.image = [[UIImage imageNamed:@"reloadImage"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        
        _reloadImageView.tintColor = [UIColor lightGrayColor];
        
        _reloadImageView.backgroundColor = [UIColor clearColor];
        
        [_reloadImageView addGestureRecognizer:reloadImageViewTap];
        
        _reloadImageView.hidden = YES;//默认隐藏
        
        _reloadImageView.userInteractionEnabled = YES;
        
        [self.view addSubview:_reloadImageView];
        
        
    }
    
    return _reloadImageView;
    
}









- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - method
- (void)setUIElementsFontWhenAwake{
    
}
- (void)setupNavigationItems{
    [super setupNavigationItems];
}
@end
