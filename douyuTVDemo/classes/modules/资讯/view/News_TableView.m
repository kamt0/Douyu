//
//  News_TableView.m
//  douyuTVDemo
//
//  Created by 揭康伟 on 16/5/26.
//  Copyright © 2016年 kamto. All rights reserved.
//

#import "News_TableView.h"
#import "NewsDetailViewController.h"
#import "News_TableViewCell.h"
#import "NewsModel.h"
#import "LoadingView.h"
#import "PictureCycleModel.h"
#import "PictureCycleView.h"
#import "NSString+addition.h"
#import "DataCache.h"

@interface News_TableView()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic , strong) UIScrollView     *scrollView;

@property (nonatomic , strong) UIPageControl    *pageControl;

@property (nonatomic , strong) NSMutableArray   *dataArray;//数据源数组

@property (nonatomic , strong) NSMutableArray   *pictureArray;//图片数据数组

@property (nonatomic , strong) LoadingView      *loadingView;//加载视图

@property (nonatomic , strong) UIImageView      *reloadImageView;//重新加载图片视图
@property (nonatomic , assign) NSInteger        page;//页数

@property (nonatomic , strong) PictureCycleView *pictureCycleView;//图片轮播视图

@end

static  NSString *cellIdentifier = @"News_TableViewCell";

@implementation News_TableView
- (void)dealloc{
    _detailsBlock     = nil;
    _topicBlock       = nil;
    _scrollView       = nil;
    _pageControl      = nil;
    _dataArray        = nil;
    _pictureArray     = nil;
    _loadingView      = nil;
    _reloadImageView  = nil;
    _pictureCycleView = nil;
    
}
-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        
        //创建tableView
        
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) style:UITableViewStylePlain];
        
        //设置cell的高度
        
        _tableView.rowHeight = 80;
        
        //设置代理
        
        _tableView.delegate = self;
        
        _tableView.dataSource = self;
        
        //添加到视图上
        
        [self addSubview:_tableView];
        
        //添加表头表尾
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [self refreshData];
        }];
        _tableView.mj_footer =  [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            [self loadMoreData];
        }];
        //注册
        
        [_tableView registerClass:[News_TableViewCell class] forCellReuseIdentifier:cellIdentifier];
        
        //设置页数
        
        _page = 1;
        
        
        //初始化加载视图
        
        _loadingView = [[LoadingView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
        
        _loadingView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3f];
        
        _loadingView.loadingColor = [UIColor whiteColor];
        
        _loadingView.hidden = TRUE;//默认隐藏
        
        [self addSubview:_loadingView];
        
        
        //初始化图片轮播视图
        
        _pictureCycleView = [[PictureCycleView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.tableView.frame), CGRectGetWidth(self.tableView.frame) / 7 * 4)];
        
        _pictureCycleView.timeInterval = 3.0f;
        
        _pictureCycleView.isPicturePlay = TRUE;
        
        __weak typeof(self) weakSelf  = self;
        _pictureCycleView.selectedPictureBlock = ^(PictureCycleModel *model){
            
            //跳转相应的详情页面
            
            weakSelf.detailsBlock(model.pid , nil);
            
        };
        
    }
    
    return self;
    
}
//获取URL字符串

- (void)setUrlstring:(NSString *)urlstring{
    
    if (_urlstring != urlstring) {
        
        _urlstring = urlstring;
    }
    
    if (urlstring != nil) {
        
        //设置表视图样式无cell分隔线
        
        self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        
        //加载数据
        
        [self loadData];
        
        self.tableView.contentOffset = CGPointMake(0, 0);
        
       
        
    }
    
    
}


#pragma mark - 单击重新加载提示图片事件

- (void)reloadImageViewTapAction:(UITapGestureRecognizer *)tap{
    
    //重新调用加载数据
    
    [self loadData];
    
}

#pragma mark - 加载请求数据

//加载数据

- (void)loadData{
    
    //查询本地缓存 指定数据名 和 分组名
    
    id caCheData = [[DataCache shareDataCache] getDataForDocumentWithDataName:[NSString stringWithFormat:@"%@%ld",@"NewsListData",self.scrollPage] Classify:@"News"];
    
    if (caCheData == nil) {
        
        //显示加载视图
        
        self.loadingView.hidden = FALSE;
        
    } else {
        
        //解析前清空数据源数组
        
        [self.dataArray removeAllObjects];
        
        [self.tableView reloadData];
        
        //解析数据
        
        [self JSONSerializationWithData:caCheData];
        
    }
    
    //隐藏重新加载提示视图
    
    self.reloadImageView.hidden = TRUE;
    
    
    //请求数据
    
    __block typeof (self) weakSelf = self;
    
    //取消之前的请求
    
    [[NetRequestManger sharedManager] cancleAllRequest];
   
    //执行新的请求操作
    [NetRequestManger getData:[[NSString stringWithFormat:self.urlstring ,self.page] utf8Str] parameters:nil success:^(id json) {
        //隐藏重新加载提示视图
        
        weakSelf.reloadImageView.hidden = TRUE;
        
        //调用数据解析方法
        
        if (json != nil) {
            
            //解析前清空数据源数组
            
            [self.dataArray removeAllObjects];
            
            [self.tableView reloadData];
            
            //设置表视图样式有cell分隔线
            
            self.tableView.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
            
            [weakSelf JSONSerializationWithData:json];
            
            //将数据缓存到本地 指定数据名 和分组名
            
            [[DataCache shareDataCache] saveDataForDocumentWithData:json DataName:[NSString stringWithFormat:@"%@%ld",@"NewsListData",self.scrollPage]  Classify:@"News"];
        } else {
            
            if (weakSelf.dataArray.count == 0) {
                
                //显示重新加载提示视图
                
                weakSelf.reloadImageView.hidden = FALSE;
                
            }
            
        }
        
        //隐藏加载视图
        
        weakSelf.loadingView.hidden = TRUE;
        
    } fail:^{
        if (weakSelf.dataArray.count == 0) {
            
            //将表视图顶部视图设为nil 不显示图片轮播视图
            
            self.tableView.tableHeaderView = nil;
            
            //显示重新加载提示视图
            
            weakSelf.reloadImageView.hidden = FALSE;
            
            //隐藏加载视图
            
            weakSelf.loadingView.hidden = TRUE;
            
        }
        
    }];
    
    
}


#pragma mark - 解析数据

- (void)JSONSerializationWithData:(id)data{
    
    if (data != nil) {
        
        NSDictionary *dic = data;
        
        NSArray *tempDataArray = [dic valueForKey:@"data"];
        
        //判断是否有轮播图片数据键
        
        if ([[dic allKeys] containsObject:@"headerline"]) {
            
            if (![[dic objectForKey:@"headerline"] isEqual:[NSNull null]]) {
                
                //清空图片数据数组
                
                [self.pictureArray removeAllObjects];
                
                NSArray *tempPictureArray = [dic objectForKey:@"headerline"];
                
                if (tempPictureArray.count > 1) {
                    
                    for (NSDictionary *tempDic in tempPictureArray) {
                        
                        PictureCycleModel *model = [[PictureCycleModel alloc]init];
                        
                        model.pid = [tempDic valueForKey:@"id"] ;
                        
                        model.photoUrl = [tempDic valueForKey:@"photo"];
                        
                        [self.pictureArray addObject:model];
                        
                    }
                    
                    //将图片轮播视图添加到表视图顶部视图上 显示图片轮播视图
                    
                    self.tableView.tableHeaderView = self.pictureCycleView;
                    
                    //为图片轮播视图添加数据数组
                    
                    self.pictureCycleView.dataArray = self.pictureArray;
                    
                    //发送通知 传递轮播图数据
                    
                    NSDictionary * dic = @{@"pictureArray":self.pictureArray};
                    
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"PictureDataArray" object:self userInfo:dic];
                    
                    
                }
                
                
            } else {
                
            
                    //将表视图顶部视图设为nil 不显示图片轮播视图
                    
                    self.tableView.tableHeaderView = nil;
                    
            }
            
        }
        
        for (NSDictionary *tempDic in tempDataArray) {
            
            NewsModel *model = [[NewsModel alloc]init];
            
            [model setValuesForKeysWithDictionary:tempDic];
            
            [self.dataArray addObject:model];
            
        }
        
        //刷新
        
        [self.tableView reloadData];
        
    }else{
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
    }
    
}



#pragma mark - UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate

//实现代理方法

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //重用cell机制
    
    News_TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    
    //设置cell的frame cell默认是320
    
    cell.frame = CGRectMake(0, 0, self.tableView.frame.size.width,90);
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.model = self.dataArray[indexPath.row];
    
    return cell;
    
}

#pragma mark - 点击cell push到相应视图


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NewsModel *model =[self.dataArray objectAtIndex:indexPath.row];
    
    if (indexPath.row  == 0 && self.tableView.tableHeaderView != nil && [model.type isEqualToString:@"topic"]) {
        
        NSString *topicId = nil;
        
        NSArray *tempArray = [model.destUrl componentsSeparatedByString:@"&"];
        
        for (NSString *tempItem in tempArray) {
            
            if ([tempItem hasPrefix:@"topicId="]) {
                
                topicId = [tempItem substringFromIndex:8];
                
            }
            
        }
        
        self.topicBlock([NSString stringWithFormat:News_TopicURL , topicId ],model.type);
        
    }else{
        
        self.detailsBlock(model.id , model.type);
        
    }
    
    
}


#pragma mark - refresh  loadMore
- (void)refreshData{
    //清空页数
    
    self.page = 1;
    
    //解析前清空数据原数组
    
   
    //调用数据解析方法
    //查询本地缓存 指定数据名 和 分组名
    
     self.loadingView.hidden = FALSE;
    
    id caCheData = [[DataCache shareDataCache] getDataForDocumentWithDataName:[NSString stringWithFormat:@"%@%ld",@"NewsListData",self.scrollPage] Classify:@"News"];
    
    if (caCheData == nil) {
        
    } else {
        
        //解析前清空数据源数组
        
        [self.dataArray removeAllObjects];
        
        [self.tableView reloadData];
        
        //解析数据
        
        [self JSONSerializationWithData:caCheData];
        
    }
    
    //隐藏重新加载提示视图
    
    self.reloadImageView.hidden = TRUE;
    
   
    //请求数据
    
    __block typeof (self) weakSelf = self;
    
    //取消之前的请求
    
    [[NetRequestManger sharedManager] cancleAllRequest];
    
    //执行新的请求操作
    [NetRequestManger getData:[[NSString stringWithFormat:self.urlstring ,self.page] utf8Str] parameters:nil success:^(id json) {
        //隐藏重新加载提示视图

        weakSelf.reloadImageView.hidden = TRUE;
        
        [weakSelf.tableView.mj_header endRefreshing];
        //调用数据解析方法
        
        if (json != nil) {
            
            //解析前清空数据源数组
            
            [self.dataArray removeAllObjects];
            
            [self.tableView reloadData];
            
            //设置表视图样式有cell分隔线
            
            self.tableView.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
            
            [weakSelf JSONSerializationWithData:json];
            
            //将数据缓存到本地 指定数据名 和分组名
            
            [[DataCache shareDataCache] saveDataForDocumentWithData:json DataName:[NSString stringWithFormat:@"%@%ld",@"NewsListData",self.scrollPage]  Classify:@"News"];
        } else {
            
            if (weakSelf.dataArray.count == 0) {
                
                //显示重新加载提示视图
                
                weakSelf.reloadImageView.hidden = FALSE;
                
            }
            
        }
        
        //隐藏加载视图
        
        weakSelf.loadingView.hidden = TRUE;
        
    } fail:^{
        if (weakSelf.dataArray.count == 0) {
            
            //将表视图顶部视图设为nil 不显示图片轮播视图
            
            self.tableView.tableHeaderView = nil;
            
            //显示重新加载提示视图
            
            weakSelf.reloadImageView.hidden = FALSE;
            
            //隐藏加载视图
            
            
            
        }
        weakSelf.loadingView.hidden = TRUE;
        [weakSelf.tableView.mj_header endRefreshing];
        
    }];
   
}

- (void)loadMoreData{
    self.page ++;
    
    //请求数据
    
    __block typeof (self) weakSelf = self;
    
    //取消之前的请求
    
    [[NetRequestManger sharedManager] cancleAllRequest];
    
    //执行新的请求操作
    [NetRequestManger getData:[[NSString stringWithFormat:self.urlstring ,self.page] utf8Str] parameters:nil success:^(id json) {
        
        [weakSelf.tableView.mj_footer endRefreshing];
        //调用数据解析方法
        
        if (json != nil) {
        
            [weakSelf JSONSerializationWithData:json];
            
          
        }
        //隐藏加载视图
        
        weakSelf.loadingView.hidden = TRUE;
        
    } fail:^{
        if (weakSelf.dataArray.count == 0) {
            
            //将表视图顶部视图设为nil 不显示图片轮播视图
            
            self.tableView.tableHeaderView = nil;
            
            //显示重新加载提示视图
            
            weakSelf.reloadImageView.hidden = FALSE;
            
           
            
        }
        //隐藏加载视图
        weakSelf.loadingView.hidden = TRUE;
        [weakSelf.tableView.mj_footer endRefreshing];
        
    }];

}
#pragma mark - LazyLoading


-(NSMutableArray *)dataArray{
    
    if (_dataArray == nil) {
        
        _dataArray = [[NSMutableArray alloc]init];
        
    }
    
    return _dataArray;
    
}

-(NSMutableArray *)pictureArray{
    
    if (_pictureArray == nil) {
        
        _pictureArray = [[NSMutableArray alloc]init];
        
    }
    
    return _pictureArray;
    
}



-(UIImageView *)reloadImageView{
    
    if (_reloadImageView == nil) {
        
        //初始化 并添加单击手势
        
        UITapGestureRecognizer *reloadImageViewTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(reloadImageViewTapAction:)];
        
        _reloadImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 200, 200)];
        
        _reloadImageView.center = CGPointMake(CGRectGetWidth(self.frame) / 2 , CGRectGetHeight(self.frame) / 2);
        
        _reloadImageView.image = [[UIImage imageNamed:@"reloadImage"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        
        _reloadImageView.tintColor = [UIColor lightGrayColor];
        
        _reloadImageView.backgroundColor = [UIColor clearColor];
        
        [_reloadImageView addGestureRecognizer:reloadImageViewTap];
        
        _reloadImageView.hidden = TRUE;//默认隐藏
        
        _reloadImageView.userInteractionEnabled = TRUE;
        
        [self addSubview:_reloadImageView];
        
        
    }
    
    return _reloadImageView;
    
}

@end
