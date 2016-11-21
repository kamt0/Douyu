//
//  VideoSortCollectionView.m
//  douyuTVDemo
//
//  Created by 揭康伟 on 16/8/3.
//  Copyright © 2016年 kamto. All rights reserved.
//

#import "VideoSortCollectionView.h"
#import "VideoSortHeadView.h"
#import "VideoSortCollectionViewCell.h"
#import "videoSortModel.h"
#import "LoadingView.h"
#import "DataCache.h"
#import "UIView+LXAlertView.h"

@interface VideoSortCollectionView ()

@property (nonatomic ,retain) NSMutableArray *dataArray;//数据原数组

@property (nonatomic ,retain) NSMutableArray *headerArray;//区头数据源

@property (nonatomic ,retain) UIImageView *reloadImageView;//重新加载图片视图

@property (nonatomic ,retain) LoadingView *loadingView;//加载视图

@end

static NSString *cellIdentifier = @"VideoSortCollectionViewCell";
static NSString *headIdentifier = @"VideoSortHeadView";

@implementation VideoSortCollectionView

-(void)dealloc{
    
    _dataArray = nil;
    
    _headerArray = nil;
    
    _reloadImageView = nil;
    
    _loadingView = nil;
    
}

//初始化

-(instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout{
    
    if (self = [super initWithFrame:frame collectionViewLayout:layout]) {
        
        //设置背景色
        
        self.backgroundColor = [UIColor whiteColor];
        
        //设置代理
        
        self.delegate = self;
        
        self.dataSource = self;
        
        //添加刷新表头
        self.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [self loadData];
        }];
        
        [self registerClass:[VideoSortCollectionViewCell class] forCellWithReuseIdentifier:cellIdentifier];
        
     
        [self registerClass:[VideoSortHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headIdentifier];
        
        
        //初始化加载视图
        
        _loadingView = [[LoadingView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
        
        _loadingView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
        
        _loadingView.loadingColor = [UIColor whiteColor];
        
        _loadingView.hidden = YES;//默认隐藏
        
        [self addSubview:_loadingView];
        
        
        //加载数据
        
        [self loadData];
        
        
    }
    
    return self;
    
}

-(void)loadData{
    
    //查询本地缓存 指定数据名
    
    id caCheData = [[DataCache shareDataCache] getDataForDocumentWithDataName:@"VideoSortData" Classify:@"Video"];
    
    if (caCheData == nil) {
        
        //显示加载视图
        
        self.loadingView.hidden = NO;
        
    } else {
        
        //解析数据
        
        [self NSJSONSerializationWithData:caCheData];
        
    }
    
    //隐藏重新加载提示视图
    
    self.reloadImageView.hidden = YES;
    
    __block VideoSortCollectionView *Self = self;
    
    //取消之前的请求
    [[NetRequestManger sharedManager] cancleAllRequest];
   
    //执行新的请求操作
    [NetRequestManger getData:kUnion_Video_SortURL parameters:nil success:^(id json) {
        
        if (json != nil) {
            
            //解析数据
            
            [Self NSJSONSerializationWithData:json];
            
            //将数据缓存到本地 指定数据名
            
            [[DataCache shareDataCache] saveDataForDocumentWithData:json DataName:@"VideoSortData" Classify:@"Video"];
            
        } else {
            
            //显示重新加载提示视图
            
            self.reloadImageView.hidden = NO;
            
        }
        
        //隐藏加载视图
        [self.mj_header endRefreshing];
        self.loadingView.hidden = YES;
        
    } fail:^{
        
        if (self.dataArray.count > 0 ) {
            
            [UIView addLXNotifierWithText:@"加载失败 快看看网络去哪了" dismissAutomatically:YES];
            
            
        } else {
            
            //显示重新加载提示视图
            
            self.reloadImageView.hidden = NO;
            
            //隐藏加载视图
            
            self.loadingView.hidden = YES;
            
        }

    }];
    
    
    
}

#pragma mark - LazyLoading

-(NSMutableArray *)dataArray{
    
    if (_dataArray == nil) {
        
        _dataArray = [[NSMutableArray alloc]init];
        
    }
    
    return _dataArray;
    
}


-(NSMutableArray *)headerArray{
    
    if (_headerArray == nil) {
        
        _headerArray = [[NSMutableArray alloc]init];
        
    }
    
    return _headerArray;
    
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
        
        _reloadImageView.hidden = YES;//默认隐藏
        
        _reloadImageView.userInteractionEnabled = YES;
        
        [self addSubview:_reloadImageView];
        
        
    }
    
    return _reloadImageView;
    
}

#pragma mark - 单击重新加载提示图片事件

- (void)reloadImageViewTapAction:(UITapGestureRecognizer *)tap{
    
    //重新调用加载数据
    
    [self loadData];
    
}

#pragma mark - 解析数据

-(void)NSJSONSerializationWithData:(id)data{
    
    
    if (data != nil) {
        
        //解析前清空数据原数组
        
        [self.dataArray removeAllObjects];
        
        [self.headerArray removeAllObjects];
        
        NSMutableArray *array = data;
        
        //遍历取出所有字典
        
        for (NSDictionary *dic in array) {
            
            //在字典中用key取出subCategory里的值
            
            NSMutableArray *subArray = [dic valueForKey:@"subCategory"];
            
            [self.headerArray addObject:[dic valueForKey:@"name"]];
            
            NSMutableArray *itemArray = [NSMutableArray array];
            
            for (NSDictionary *subDic in subArray) {
                
                videoSortModel *model = [[videoSortModel alloc]init];
                
                [model setValuesForKeysWithDictionary:subDic];
                
                [itemArray addObject:model];
                
            }
            
            //添加到数据原数组中
            
            [self.dataArray addObject:itemArray];
            
        }
        
        //刷新数据
        
        [self reloadData];
        
    }
    
    
}

#pragma mark - UICollectionViewDataSource , UICollectionViewDelegate  方法

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return self.dataArray.count;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return [self.dataArray[section] count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    VideoSortCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
    cell.sortModel = self.dataArray[indexPath.section][indexPath.row];
    
    return cell;
}

#pragma mark - 设置页眉的尺寸

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    if (section == 0 ) {
        
        CGSize size = CGSizeMake(CGRectGetWidth(self.frame), 80);
        
        return size;
    }else{
        
        CGSize size = CGSizeMake(CGRectGetWidth(self.frame), 30);
        
        return size;
        
    }
}

#pragma mark - 为collection view添加一个表头视图

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    VideoSortHeadView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headIdentifier forIndexPath:indexPath];
    
    //判断
    
    if (indexPath.section == 0 ) {
        
        __block VideoSortCollectionView *Self = self;
        
        header.videoSearchBlock = ^(NSString *videoName){
            
            Self.videoSearchBlock(videoName);
            
        };
        
        //隐藏
        
        header.textField.hidden = NO;
        
        header.button.hidden = NO;
    }
    else{
        
        header.textField.hidden = YES;
        
        header.button.hidden = YES;
    }
    
    header.myHeader.text = self.headerArray[indexPath.section];
    
    return header;
}

#pragma mark - 点击方法

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    videoSortModel *model = self.dataArray[indexPath.section][indexPath.row];
    
    self.block(model.tag , model.name);
    
}


@end
