//
//  News_PictureCell.m
//  douyuTVDemo
//
//  Created by 揭康伟 on 16/5/26.
//  Copyright © 2016年 kamto. All rights reserved.
//

#import "News_PictureCell.h"
#import "NSString+addition.h"
#import "SingTonManger.h"
#import <UIImageView+WebCache.h>
#import "MBProgressHUD.h"

@interface News_PictureCell ()<MBProgressHUDDelegate>

@property (nonatomic , strong ) MBProgressHUD *HUD;//HUD提示框

@property (nonatomic , strong ) MBRoundProgressView *roundProgressView;//进度条视图

@property (nonatomic , strong ) UILabel *promptLabel;//提示Label

@end

@implementation News_PictureCell

-(void)dealloc{
    
    _coverImageView    = nil;
    _picsumLable       = nil;
    _titleLable        = nil;
    _model             = nil;
    _HUD               = nil;
    _roundProgressView = nil;
   
}





//初始化方法

- (id)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        
        _coverImageView = [[UIImageView alloc]init];
        
        [self.contentView addSubview:_coverImageView];
        
        _titleLable = [[UILabel alloc]init];
        
        _titleLable.font = [UIFont systemFontOfSize:14];
        
        _titleLable.textColor = [UIColor blackColor];
        
        _titleLable.backgroundColor = [UIColor whiteColor];
        
        _titleLable.textAlignment = NSTextAlignmentLeft;
        
        _titleLable.numberOfLines = 0;
        
        [self.contentView addSubview:_titleLable];
        
        _picsumLable = [[UILabel alloc]init];
        
        _picsumLable.backgroundColor = [UIColor blackColor];
        
        _picsumLable.alpha = 0.7;
        
        _picsumLable.textAlignment = NSTextAlignmentRight;
        
        _picsumLable.textColor = [UIColor whiteColor];
        
        _picsumLable.font = [UIFont systemFontOfSize:14];
        
        [self.contentView addSubview:_picsumLable];
        
        _promptLabel = [[UILabel alloc]init];
        
        _promptLabel.text = @"我是图~";
        
        _promptLabel.font = [UIFont boldSystemFontOfSize:22];
        
        _promptLabel.textColor = [UIColor lightGrayColor];
        
        _promptLabel.hidden = YES;
        
        [self.contentView addSubview:_promptLabel];
        
        
        
        
        //初始化圆形进度条视图
        
        _roundProgressView = [[MBRoundProgressView alloc]initWithFrame:CGRectMake(0, 0, 40 , 40 )];
        
        _roundProgressView.progressTintColor = [UIColor lightGrayColor];
        
        //初始化HUD提示框视图
        
        _HUD = [[MBProgressHUD alloc] initWithView:self];
        
        [self addSubview:_HUD];
        
        _HUD.mode = MBProgressHUDModeCustomView;//设置自定义视图模式
        
        _HUD.color = [UIColor clearColor];
        
        _HUD.customView = _roundProgressView;
        
    }
    
    return self;
}


//设置frame

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    //图片的frame
    
    self.coverImageView.frame = CGRectMake(0, 0, self.frame.size.width , self.frame.size.height - 50);
    
    //标题的frame
    
    self.titleLable.frame = CGRectMake(0, self.frame.size.height - 50, self.coverImageView.frame.size.width ,50);
    
    //页数的frame
    
    self.picsumLable.frame = CGRectMake(0, self.frame.size.height - 50 - 18, self.coverImageView.frame.size.width, 18);
    
    //提示Label的frame
    
    self.promptLabel.frame = CGRectMake(0, 0, 80 , 30);
    
    self.promptLabel.center = CGPointMake(CGRectGetWidth(self.frame) / 2 , CGRectGetHeight(self.coverImageView.frame) / 2 );
    
}


- (void)setModel:(PictureModel *)model{
    
    if ( _model != model) {
        
        _model = model;
        
    }
    
    _picsumLable.text = [NSString stringWithFormat:@"共%@张",_model.picsum];
    
    _titleLable.text = [_model.title removeSensitiveWordsWithArray:@[@"手机盒子"]];
    
    
    
    //通过设置管理 获取是否允许加载图片
    
    if ([DATA_EN loadImageAccordingToTheSetType]) {
        
        //隐藏提示Label
        
        _promptLabel.hidden = TRUE;
        
        //图片解析
        
        [_roundProgressView setProgress:0.0f];
        
        [_HUD show:TRUE];
        
        NSURL *url = [NSURL URLWithString:_model.coverUrl];
        
        __block typeof(self) Self = self;
        
        [self.coverImageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"imagedefault"] options:SDWebImageCacheMemoryOnly progress:^(NSInteger receivedSize, NSInteger expectedSize) {
            
            float progressFloat = (float)receivedSize/(float)expectedSize;
            
            [Self.roundProgressView setProgress:progressFloat];
            
            
        } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            
            [Self.HUD hide:FALSE];
            
        }];
        
        
    } else {
        
        //显示提示Label
        
        _promptLabel.hidden = FALSE;
        
    }
    
    
}

#pragma mark - MBProgressHUDDelegate

- (void)hudWasHidden:(MBProgressHUD *)hud {
    
    //提示框隐藏时 删除提示框视图
    
    [hud removeFromSuperview];
       
    hud = nil;
    
}


@end
