//
//  News_PicturesView.m
//  douyuTVDemo
//
//  Created by 揭康伟 on 16/5/26.
//  Copyright © 2016年 kamto. All rights reserved.
//

#import "News_PicturesView.h"
#import "News_PictureCell.h"
#import "PictureModel.h"
#import "LoadingView.h"
#import "NSString+addition.h"
#import "PictureFlowLayout.h"

@interface News_PicturesView () <UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,PictureFlowDelegate>
@property (nonatomic , strong) UICollectionView *collectionView;

@property (nonatomic , strong) NSMutableArray *dataArray;

@property (nonatomic , strong) NSMutableArray *imageArray;

@property (nonatomic , strong) LoadingView *loadingView;//加载视图

@property (nonatomic , strong) UIImageView *reloadImageView;//重新加载图片视图

@property (nonatomic , assign) NSInteger page;//页数


@end

static NSString *identifier = @"pictureCollectionCell";
@implementation News_PicturesView


-(void)dealloc{
    
    _collectionView  = nil;
    _dataArray       = nil;
    _imageArray      = nil;
    _loadingView     = nil;
    _reloadImageView = nil;

}



-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        //创建集合视图瀑布流布局
        
        PictureFlowLayout * layOut = [[PictureFlowLayout alloc] init];
        
        layOut.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
        
        layOut.delegate = self;
        
        //创建集合视图
        
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) collectionViewLayout:layOut];
        
        //集合视图的背景色
        
        _collectionView.backgroundColor = [UIColor whiteColor];
        
        // 添加到视图
        
        [self addSubview:_collectionView];
        
        //设置代理
        
        _collectionView.delegate = self;
        
        _collectionView.dataSource = self;
        
        //注册
        
        [_collectionView registerClass:[News_PictureCell class] forCellWithReuseIdentifier:identifier];
        
        
        //设置页数
        
        _page = 1;
        

        
        //初始化加载视图
        
        _loadingView = [[LoadingView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
        
        _loadingView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
        
        _loadingView.loadingColor = [UIColor whiteColor];
        
        _loadingView.hidden = TRUE;//默认隐藏
        
        [self addSubview:_loadingView];
        
        
    }
    
    return self;
    
}


- (void)setUrlString:(NSString *)urlString{
    
    if (_urlString != urlString) {
        
        _urlString = urlString;
        
    }
    
    if (urlString != nil) {
        
        //加载数据
        
        [self loadData];
        
        
    }
    
    
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
    
    NSString *url = [[NSString stringWithFormat:self.urlString ,self.page] utf8Str];
    
    //请求数据
    
    __block typeof (self) Self = self;
    
    //取消之前的请求
    
    [[NetRequestManger sharedManager] cancleAllRequest];
    
    //执行新的请求操作
    
    [NetRequestManger getData:url parameters:nil success:^(id json) {
        //隐藏重新加载提示视图
        
        Self.reloadImageView.hidden = YES;
        
        //解析前清空数据源数组
        
        [Self.dataArray removeAllObjects];
        
        [Self.collectionView reloadData];
        
        //调用数据解析方法
        
        if (json != nil) {
            
            [Self JSONSerializationWithData:json];
            
        } else {
            
            //显示重新加载提示视图
            
            Self.reloadImageView.hidden = NO;
            
        }
        
        //隐藏加载视图
        
        Self.loadingView.hidden = YES;
        
    } fail:^{
       
        //清空数据源数组
        
        [Self.dataArray removeAllObjects];
        
        [Self.collectionView reloadData];
        
        //显示重新加载提示视图
        
        Self.reloadImageView.hidden = NO;
        
        //隐藏加载视图
        
        Self.loadingView.hidden = YES;
    }];
    
 
    
}

#pragma mark ---解析数据

- (void)JSONSerializationWithData:(id)data{
    
    NSDictionary *dic = data;
    
    NSArray *tempArray = [dic valueForKey:@"data"];
    
    for (NSDictionary *tempDic in tempArray) {
        
        PictureModel *model = [[PictureModel alloc]init];
        
        [model setValuesForKeysWithDictionary:tempDic];
        
        [self.dataArray addObject:model];
        
    }
    
    //刷新
    
    [self.collectionView reloadData];
    
    
    
}

#pragma mark -----集合视图的代理方法

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.dataArray.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    News_PictureCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    cell.model = self.dataArray[indexPath.item];
    
    return cell;
    
}


//cell是否可以被点击

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return YES;
}


//点击方法

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    self.prettyPicturesBlock([self.dataArray[indexPath.item] galleryId]);
    
    
}


#pragma mark ---代理方法

- (CGFloat)PictureFlow:(PictureFlowLayout *)Flow heightForWidth:(CGFloat)width atIndexPath:(NSIndexPath *)indexPath
{
    
    PictureModel *model = self.dataArray[indexPath.item];
    
    return [model.coverHeight floatValue] / [model.coverWidth floatValue ] * [model.coverWidth floatValue];
    
}









#pragma mark ---LazyLoading

-(NSMutableArray *)dataArray{
    
    if (_dataArray == nil) {
        
        _dataArray = [[NSMutableArray alloc]init];
        
    }
    
    return _dataArray;
    
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

@end
