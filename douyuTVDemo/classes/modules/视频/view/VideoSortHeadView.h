//
//  VideoSortHeadView.h
//  douyuTVDemo
//
//  Created by 揭康伟 on 16/8/3.
//  Copyright © 2016年 kamto. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^VideoSearchBlock)(NSString *videoName);

@interface VideoSortHeadView : UICollectionReusableView<UITextFieldDelegate>

@property (nonatomic ,strong) UILabel *myHeader;

@property (nonatomic ,strong) UITextField *textField;

@property (nonatomic ,strong) UIButton *button;

@property (nonatomic ,strong) VideoSearchBlock videoSearchBlock;//视频搜索block


@end
