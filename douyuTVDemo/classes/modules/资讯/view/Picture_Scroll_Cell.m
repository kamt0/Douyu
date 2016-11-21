//
//  Picture_Scroll_Cell.m
//  douyuTVDemo
//
//  Created by 揭康伟 on 16/8/1.
//  Copyright © 2016年 kamto. All rights reserved.
//

#import "Picture_Scroll_Cell.h"
#import <UIImageView+WebCache.h>
#import "MBProgressHUD.h"
#import "Picture_Scroll_Model.h"

@interface Picture_Scroll_Cell ()<MBProgressHUDDelegate,UIScrollViewDelegate,UIGestureRecognizerDelegate>

@property (nonatomic , retain ) MBProgressHUD *HUD;//HUD提示框

@property (nonatomic , retain ) MBRoundProgressView *roundProgressView;//进度

@end

@implementation Picture_Scroll_Cell
- (void)dealloc{
    
    _imageView = nil;
    
    _titleLable = nil;
    
    _scrollView = nil;
    
    _model = nil;
    
    _HUD = nil;
    
    _roundProgressView = nil;
    
}


- (instancetype)initWithFrame:(CGRect)frame{
    
    if ( self = [super initWithFrame:frame]) {
        
        //初始化滑动视图
        
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
        
        _scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
        
        _scrollView.maximumZoomScale = 3;
        
        _scrollView.minimumZoomScale = 1;
        
        _scrollView.zoomScale = 1;
        
        _scrollView.delegate = self;
        
        [self.contentView addSubview:_scrollView];
        
        //初始化图片视图
        
        UITapGestureRecognizer *imageTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageTapAction:)];
        
        imageTap.numberOfTapsRequired = 2;
        
        imageTap.numberOfTouchesRequired = 1;
        
        _imageView = [[UIImageView alloc]init];
        
        _imageView.userInteractionEnabled = YES;
        
        [_imageView addGestureRecognizer:imageTap];
        
        [_scrollView addSubview:_imageView];
        
        
        //初始化圆形进度条视图
        
        _roundProgressView = [[MBRoundProgressView alloc]initWithFrame:CGRectMake(0, 0, 64 , 64 )];
        
        //初始化HUD提示框视图
        
        _HUD = [[MBProgressHUD alloc] initWithView:self];
        
        [self addSubview:_HUD];
        
        //        _HUD.mode = MBProgressHUDModeDeterminate;
        
        _HUD.mode = MBProgressHUDModeCustomView;//设置自定义视图模式
        
        _HUD.delegate = self;
        
        _HUD.color = [UIColor clearColor];
        
        _HUD.customView = _roundProgressView;
        
        
    }
    
    return self;
    
    
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    
}

#pragma mark - MBProgressHUDDelegate

- (void)hudWasHidden:(MBProgressHUD *)hud {
    
    //提示框隐藏时 删除提示框视图
    
    //    [hud removeFromSuperview];
    //
    //    [hud release];
    //
    //    hud = nil;
    
}

#pragma mark ---图片双击事件

- (void)imageTapAction:(UITapGestureRecognizer *)tap{
    
    //还原缩放比例
    
    _scrollView.zoomScale = 1;
    
}


- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    
    return self.imageView;
    
}

//当scrollView正在缩放的时候会频繁响应的方法

-(void)scrollViewDidZoom:(UIScrollView *)scrollView{
    
    //x和y轴的增量:
    
    //当scrollView自身的宽度或者高度大于其contentSize的时候, 增量为:自身宽度或者高度减去contentSize宽度或者高度除以2,或者为0
    
    //条件运算符
    
    CGFloat delta_x= scrollView.bounds.size.width > scrollView.contentSize.width ? (scrollView.bounds.size.width-scrollView.contentSize.width)/2 : 0;
    
    CGFloat delta_y= scrollView.bounds.size.height > scrollView.contentSize.height ? (scrollView.bounds.size.height - scrollView.contentSize.height)/2 : 0;
    
    //让imageView一直居中
    
    //实时修改imageView的center属性 保持其居中
    
    self.imageView.center=CGPointMake(scrollView.contentSize.width/2 + delta_x, scrollView.contentSize.height/2 + delta_y);
    
}


- (void)setModel:(Picture_Scroll_Model *)model{
    
    if ( _model != model) {
    
        _model = model;
        
    }
    
    _scrollView.zoomScale = 1;
    
    _titleLable.text = _model.title;
    
    //加载图片
    
    NSURL *url = [NSURL URLWithString:model.url];
    
    [_roundProgressView setProgress:0.0f];
    
    [_HUD show:YES];
    
    __block typeof(self) Self = self;
    
    [_imageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@""] options:SDWebImageCacheMemoryOnly  progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        
        float progressFloat = (float)receivedSize/(float)expectedSize;
        
        [Self.roundProgressView setProgress:progressFloat];
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        [Self.HUD hide:NO];
        
    }];
    
    
       
    CGFloat width =  [_model.fileWidth floatValue];
    
    CGFloat height = [_model.fileHeight floatValue];
    
    self.imageView.frame = CGRectMake(0, 0, self.scrollView.frame.size.width, self.scrollView.frame.size.width/(width/height));
    
    _scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.imageView.frame), CGRectGetHeight(self.imageView.frame));
    
    self.imageView.center = CGPointMake(CGRectGetWidth(_scrollView.frame) / 2 , CGRectGetHeight(_scrollView.frame) / 2 );
    
}


@end
