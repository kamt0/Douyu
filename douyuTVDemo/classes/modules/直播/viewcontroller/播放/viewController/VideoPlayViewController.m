//
//  VideoPlayViewController.m
//  douyuTVDemo
//
//  Created by 揭康伟 on 16/5/7.
//  Copyright © 2016年 kamto. All rights reserved.
//

#import "VideoPlayViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "PlayView.h"
#import "LandscapeNavView.h"
#import "BaseNavigationController.h"

@interface VideoPlayViewController ()<UIWebViewDelegate>
    
@property (nonatomic ,strong) AVPlayer     *player;
@property (nonatomic ,strong) AVPlayerItem *playerItem;
@property (nonatomic, strong) PlayView     *playView;
@property (nonatomic, strong) UIWebView    *webView;
@end

@implementation VideoPlayViewController

- (void)viewDidLoad {
    [super viewDidLoad];


    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = TRUE;
    [[UIApplication sharedApplication] setStatusBarHidden:TRUE];
    [DATA_EN downloadViewHiddenOrShow:TRUE];
}
- (void)viewWillDisappear:(BOOL)animated{
    [[UIApplication sharedApplication] setStatusBarHidden:FALSE];
}
- (void)viewDidDisappear:(BOOL)animated{
     //释放播放资源
    [self.playView.player replaceCurrentItemWithPlayerItem:nil];
    [DATA_EN downloadViewHiddenOrShow:FALSE];
}
- (void)dealloc{
    self.playerItem = nil;
    self.player     = nil;
    self.playView   = nil;
    self.webView    = nil;
}
#pragma mark super method
- (void)setUIElementsFontWhenAwake{
    if (self.type == TVTypedouyu) {
        [self creatWebView];
    }else{
        [self creatPlayView];
        [self creatLandscapeNavView];
    }
    
    [self playVideo];
}
- (void)setupNavigationItems{
    [super setupNavigationItems];
}

#pragma mark - private method
//由于没有获取到斗鱼的直播地址，只有暂时先加载网页播放
- (void)creatWebView{
    _webView                          = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, ScreenBoundHeight, ScreenBoundWidth)];
    CATransform3D transform           = CATransform3DMakeRotation(M_PI / 2, 0, 0, 1.0);
    _webView.layer.transform          = transform;
    _webView.center                   = self.view.center;

    _webView.delegate                 = self;
    _webView.scalesPageToFit          = TRUE;
    _webView.scrollView.scrollEnabled = FALSE;
    [self.view addSubview:_webView];
    UIButton *btn  =[[UIButton alloc]initWithFrame:CGRectMake(10, 5, 30, 30)];
    [btn setImage:[UIImage imageNamed:@"movie_back_s"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(ClickedBack) forControlEvents:UIControlEventTouchUpInside];
    [_webView addSubview:btn];
}

- (void)creatPlayView{
    _playView = [[PlayView alloc]initWithFrame:CGRectMake(0, 0, ScreenBoundHeight, ScreenBoundWidth)];
   
    CATransform3D transform = CATransform3DMakeRotation(M_PI / 2, 0, 0, 1.0);
    _playView.layer.transform  =  transform;
    _playView.center = self.view.center;
    [self.view addSubview:_playView];
}
- (void)creatLandscapeNavView{
    LandscapeNavView * navView  =[[LandscapeNavView alloc]initWithFrame:CGRectMake(0, 0, ScreenBoundHeight, ScreenBoundWidth)];
   
    navView.onClickedNavButtonBlock = ^{
        [self.navigationController popViewControllerAnimated:TRUE];
        self.navigationController.navigationBarHidden = FALSE;
    };
    [self.view addSubview:navView];
    CATransform3D transform = CATransform3DMakeRotation(M_PI / 2, 0, 0, 1.0);
    navView.layer.transform = transform;
    navView.center  = self.view.center;
}
#pragma mark - 调入播放网址

- (void)playVideo{
   
    NSMutableString * filePath = [[NSMutableString alloc]init];
    if (self.type == TVTypeQuanmin) {
        [filePath appendString:[NSString stringWithFormat:@"http://hls.quanmin.tv/live/%@/playlist.m3u8",_vid]];
    }else if (self.type == TVTypedouyu){
         [filePath appendString:[NSString stringWithFormat:@"http://www.douyu.com/room/share/%@",_vid]];
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[filePath stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
        [_webView loadRequest:request];
        return;
    }else if (self.type == TVTypezhanqi){
       [filePath appendString:[NSString stringWithFormat:@"http://dlhls.cdn.zhanqi.tv/zqlive/%@.m3u8",_vid]];
    }
    
    NSString *str              = [filePath stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *videoUrl            = [NSURL URLWithString:str];
    
    self.playerItem            = [AVPlayerItem playerItemWithURL:videoUrl];
    self.player                = [AVPlayer playerWithPlayerItem:self.playerItem];
    self.playView.player       = self.player;
    [self.playView.player play];
    
}

- (void)ClickedBack{
    [self.navigationController popViewControllerAnimated:TRUE];
    self.navigationController.navigationBarHidden = FALSE;
}

@end
