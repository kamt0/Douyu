//
//  VideoSortCollectionViewCell.m
//  douyuTVDemo
//
//  Created by 揭康伟 on 16/8/3.
//  Copyright © 2016年 kamto. All rights reserved.
//

#import "VideoSortCollectionViewCell.h"
#import "videoSortModel.h"

@implementation VideoSortCollectionViewCell

-(void)dealloc{
    
    _imageView = nil;
    
    _titleLable = nil;
    
    _upDataLable = nil;
    
    _sortModel = nil;
    
}

-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        //初始化图片视图
        
        _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height - 20)];
        
        _imageView.image = [UIImage imageNamed:@"poluoimage_gray"];
        
        //添加到cell上
        
        [self addSubview:_imageView];
        
        
        _titleLable = [[UILabel alloc]initWithFrame:CGRectMake(0, self.frame.size.height - 20, self.frame.size.width, 20)];
        
        //居中
        
        _titleLable.textAlignment = NSTextAlignmentCenter;
        
        //字体大小
        
        _titleLable.font = [UIFont systemFontOfSize:12];
        
        //字体颜色
        
        _titleLable.textColor = [UIColor grayColor];
        
        
        //添加到cell上
        
        [self addSubview:_titleLable];
        
        _upDataLable = [[UILabel alloc]initWithFrame:CGRectMake(0, self.imageView.frame.size.height - 20, self.frame.size.width, 20)];
        
        //字体显示在最右边
        
        _upDataLable.textAlignment = NSTextAlignmentRight;
        
        _upDataLable.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.7];
        
        //字体大小
        
        _upDataLable.font = [UIFont systemFontOfSize:14];
        
        _upDataLable.textColor = [UIColor whiteColor];
        
        //添加到cell上
        
        [self addSubview:_upDataLable];
        
        
        
    }
    
    return self;
}

-(void)setSortModel:(videoSortModel *)sortModel{
    
    if (self.sortModel != sortModel) {
    
        _sortModel = sortModel;
        
    }
    
    //SDWebImage异步加载图片
    
   [_imageView sd_setImageWithUrl:sortModel.icon placeholderImage:ImageNamed(@"poluoimage_gray")];
    //判断sortModel.dailyUpdate中是否有0这个字符串
    
    if ([sortModel.dailyUpdate isEqualToString:@"0"]) {
        
        //隐藏self.upDataLable视图
        
        self.upDataLable.hidden = YES;
        
    } else {
        
        //不隐藏
        
        self.upDataLable.hidden = NO;
        
    }
    
    //赋值
    
    _titleLable.text = sortModel.name;
    
    //将字符串强转成 NSInteger
    
    NSInteger daiInteger = [sortModel.dailyUpdate integerValue];
    
    //声明一个字符串
    
    NSString *string = nil;
    
    //判断数字
    
    if (daiInteger > 99) {
        
        //显示类型
        
        string = [NSString stringWithFormat:@"最新%ld+个",(long)daiInteger];
        
    } else {
        
        string = [NSString stringWithFormat:@"最新%ld个",(long)daiInteger];
        
    }
    
    //将数字部分设置成蓝色  其他部分设置成白色
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:string];
    
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0 , 2  )];
    
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(string.length - 1 , 1)];
    
    [str addAttribute:NSForegroundColorAttributeName value:DEDAULT_COLOR range:NSMakeRange(2 , string.length - 3 )];
    
    self.upDataLable.attributedText = str;
    

}

@end
