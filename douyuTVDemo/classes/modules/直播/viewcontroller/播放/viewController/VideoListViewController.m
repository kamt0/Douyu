//
//  VideoListViewController.m
//  douyuTVDemo
//
//  Created by 揭康伟 on 16/5/7.
//  Copyright © 2016年 kamto. All rights reserved.
//

#import "VideoListViewController.h"
#import "VideoPlayViewController.h"
#import "recommendLogic.h"
#import "ZhanqiLogic.h"
#import "DouyuLogic.h"
#import "videoModel.h"
#import "VideoCell.h"
#import "ZhanqiVideoCell.h"

@interface VideoListViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>{
    NSArray  *_seedingArray;
}
@property (nonatomic, strong) UICollectionView *collectionView;
@end

@implementation VideoListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupCollectionView];
    [self refresh:self.view];
    // Do any additional setup after loading the view.
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
    
    if (self.type == TVTypeQuanmin) {
        recommendLogic * dm = [[recommendLogic alloc]init];
        [dm getSeedingDataList:DirectSeedingUrl parameters:nil success:^(NSArray * seedingArray) {
            if (seedingArray) {
                _seedingArray = seedingArray;
                EndRefresh;
                [self.collectionView reloadData];
            }
        } fail:^{
            
        }];
    }else if (self.type == TVTypedouyu){
        DouyuLogic *dm = [[DouyuLogic alloc]init];
        [dm getSeedingLolList:DouyuLolListUrl success:^(NSArray *seedingArray) {
            _seedingArray = seedingArray;
            EndRefresh;
            [self.collectionView reloadData];
        } fail:^{
            
        }];
    }
    else if (self.type == TVTypezhanqi){

        ZhanqiLogic *dm = [[ZhanqiLogic alloc]init];
        [dm getSeedingLolList:ZhanqiLolListUrl success:^(NSArray *seedingArray) {
            _seedingArray = seedingArray;
            EndRefresh;
            [self.collectionView reloadData];
        } fail:^{
            
        }];
    }
    
}
#pragma mark
- (void)setupCollectionView{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 64, ScreenBoundWidth, ScreenBoundHeight - 64) collectionViewLayout:layout];
    collectionView.contentInset = UIEdgeInsetsMake(0, 0, 64, 0);
    collectionView.backgroundColor = [UIColor whiteColor];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    [collectionView registerClass:[VideoCell class] forCellWithReuseIdentifier:NSStringFromClass([VideoCell class])];
    [collectionView registerClass:[ZhanqiVideoCell class] forCellWithReuseIdentifier:NSStringFromClass([ZhanqiVideoCell class])];
    [self.view addSubview:collectionView];
    self.collectionView = collectionView;
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _seedingArray.count;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake((ScreenBoundWidth-15)/2, (ScreenBoundWidth-15)/2-10);
    
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdetifier = nil;
    if (self.type == TVTypeQuanmin||self.type == TVTypedouyu) {
        cellIdetifier = NSStringFromClass([VideoCell class]);
    }else if (self.type == TVTypezhanqi){
        cellIdetifier = NSStringFromClass([ZhanqiVideoCell class]);
    }
    
    id data = _seedingArray[indexPath.row];
    
    BaseCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdetifier forIndexPath:indexPath];
    
    [cell setContent:data];
    
    return cell;
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(5, 5,5 , 5);
}
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 5;
}
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 5;
}
#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    VideoPlayViewController * playVC = [[VideoPlayViewController alloc]init];
    videoModel *video = _seedingArray[indexPath.row];
    playVC.type = self.type;
    playVC.vid = video.uid;
    playVC.hidesBottomBarWhenPushed = TRUE;
    [self.navigationController pushViewController:playVC animated:TRUE];
        
    
}
@end
