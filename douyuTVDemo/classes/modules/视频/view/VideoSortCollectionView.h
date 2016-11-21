//
//  VideoSortCollectionView.h
//  douyuTVDemo
//
//  Created by 揭康伟 on 16/8/3.
//  Copyright © 2016年 kamto. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^myBlock) (NSString *tag , NSString *name);

typedef void (^VideoSearchBlock)(NSString *videoName);

@interface VideoSortCollectionView : UICollectionView<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic ,copy) myBlock block;

@property (nonatomic ,copy) VideoSearchBlock videoSearchBlock;//视频搜索block


@end
