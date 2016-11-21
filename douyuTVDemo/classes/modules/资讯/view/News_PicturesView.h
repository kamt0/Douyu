//
//  News_PicturesView.h
//  douyuTVDemo
//
//  Created by 揭康伟 on 16/5/26.
//  Copyright © 2016年 kamto. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^PrettyPicturesBlock)(NSString *string);

@interface News_PicturesView : UIView

@property (nonatomic, strong) PrettyPicturesBlock prettyPicturesBlock;

@property (nonatomic, strong) NSString *urlString;

@end
