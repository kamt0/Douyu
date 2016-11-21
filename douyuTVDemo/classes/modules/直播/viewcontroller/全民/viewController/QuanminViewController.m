//
//  RecommendViewController.m
//  douyuTVDemo
//
//  Created by 揭康伟 on 16/4/28.
//  Copyright © 2016年 kamto. All rights reserved.
//

#import "QuanminViewController.h"

#import "BaseCollectionCell.h"
#import "recommendScrollCell.h"
#import "recommendListCell.h"
#import "VideoCell.h"
#import "RecomHeaderView.h"

#import "recommendLogic.h"
#import "videoModel.h"
#import "reconmendPageModel.h"
#import "recommendClassModel.h"
#import "recommendCollectionModel.h"

#import "VideoPlayViewController.h"
#import "VideoListViewController.h"

@interface QuanminViewController()<UICollectionViewDelegate,UICollectionViewDataSource>{
    recommendLogic *_dm;
    recommendCollectionModel *_recommendCollection;
}
@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation QuanminViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupCollectionView];
    [self refresh:self.view];
}

-(void)setupCollectionView{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, ScreenBoundWidth, ScreenBoundHeight-64) collectionViewLayout:flowLayout];
    collectionView.contentInset = UIEdgeInsetsMake(0, 0, 100, 0);
    collectionView.backgroundColor = [UIColor whiteColor];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    [collectionView registerClass:[recommendScrollCell class] forCellWithReuseIdentifier:NSStringFromClass([recommendScrollCell class])];
    [collectionView registerClass:[recommendListCell class] forCellWithReuseIdentifier:NSStringFromClass([recommendListCell class])];
    [collectionView registerClass:[VideoCell class] forCellWithReuseIdentifier:NSStringFromClass([VideoCell class])];
    [collectionView registerClass:[RecomHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([RecomHeaderView class])];
    //注意，collectionView先注册class后再添加在父视图上
    
    [self.view addSubview:collectionView];
    self.collectionView = collectionView;
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark super method
- (void)setUIElementsFontWhenAwake{
    
}
- (void)setupNavigationItems{
    [super setupNavigationItems];
}
- (void)requestData{
    _dm = [[recommendLogic alloc]init];
    [_dm getdata:RecommendUrl parameters:nil sucess:^(recommendCollectionModel *recommendCollectionData) {
        _recommendCollection = recommendCollectionData;
        [self.collectionView reloadData];
        EndRefresh;
    } fail:^{
        EndRefresh;
    }];
}

#pragma mark - private mehod

#pragma mark -UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 3;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (section < 2) {
        return 1;
        
    }else{
        NSArray *array = _recommendCollection.seedingData;
        if (array.count >= 4) {
            return 4;
        }else if(array.count > 0&&array.count <4){
            return 2;
        }else{
            return 0;
        }
    }
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return CGSizeMake(ScreenBoundWidth, ScreenBoundWidth/7*3);
    }else if (indexPath.section == 1){
        return CGSizeMake(ScreenBoundWidth, ScreenBoundWidth/5+20);
    }else{
        return CGSizeMake((ScreenBoundWidth-20)/2, (ScreenBoundWidth-20)/2-10);
    }
    
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdetifier = nil;
    id data = nil;
    if (indexPath.section == 0) {
        cellIdetifier = NSStringFromClass([recommendScrollCell class]);
        data = _recommendCollection.pageData;
    }else if (indexPath.section == 1){
        cellIdetifier = NSStringFromClass([recommendListCell class]);
        data = _recommendCollection.listData;
    }else{
        cellIdetifier = NSStringFromClass([VideoCell class]);
        data = _recommendCollection.seedingData[indexPath.row];
    }
    
    BaseCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdetifier forIndexPath:indexPath];
    cell.onChoosedClassBlock = ^(BOOL isLOLData){
        if (isLOLData) {
            VideoListViewController * listVC = [[VideoListViewController alloc]init];
            listVC.title = @"全民LOL直播间";
            listVC.type = TVTypeQuanmin;
            listVC.hidesBottomBarWhenPushed = TRUE;
            [self.navigationController pushViewController:listVC animated:TRUE];
        }else{
            [self showMessage:@"打死你！还点？老实看撸啊撸吧"];
        }
        
    };
    [cell setContent:data];
    
    return cell;
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    if (section == 0||section == 1) {
        return UIEdgeInsetsMake(0, 0, 0, 0);
    }
    return UIEdgeInsetsMake(5, 5, 5, 5);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    if (section >1) {
        return CGSizeMake(ScreenBoundWidth, 40);
    }
    return CGSizeMake(0, 0);
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section > 1) {
        if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
            RecomHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([RecomHeaderView class]) forIndexPath:indexPath];
            headerView.goMoreSeedingBlock = ^{
                VideoListViewController * listVC = [[VideoListViewController alloc]init];
                listVC.title = @"全民LOL直播间";
                listVC.type = TVTypeQuanmin;
                listVC.hidesBottomBarWhenPushed = TRUE;
                [self.navigationController pushViewController:listVC animated:TRUE];
            };
            headerView.title = @"逗比刘看直播啦";
            return headerView;
            
        }
    }
    return nil;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section > 1) {
        VideoPlayViewController * playVC = [[VideoPlayViewController alloc]init];
        videoModel *video = _recommendCollection.seedingData[indexPath.row];
        playVC.type = TVTypeQuanmin;
        playVC.vid = video.uid;
        playVC.hidesBottomBarWhenPushed = TRUE;
        [self.navigationController pushViewController:playVC animated:TRUE];
        
    }
}
@end
