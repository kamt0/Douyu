//
//  DirectSeedingViewController.m
//  douyuTVDemo
//
//  Created by 揭康伟 on 16/5/12.
//  Copyright © 2016年 kamto. All rights reserved.
//

#import "DirectSeedingViewController.h"
#import "QuanminViewController.h"
#import "DouyuViewController.h"
#import "ZhanqiViewController.h"
#import "TitleLabel.h"

@interface DirectSeedingViewController ()<UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView *titleScrollView;
@property (nonatomic, strong) UIScrollView *contentScrollView;
@end

@implementation DirectSeedingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addChildViewControllers];
    [self setupScrollView];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -super method
- (void)setUIElementsFontWhenAwake{
    
}
- (void)setupNavigationItems{
    [super setupNavigationItems];
}

#pragma mark -private method
- (void)addChildViewControllers{
    QuanminViewController*vc1 = [[QuanminViewController alloc]init];
    vc1.title = @"全民直播";
    DouyuViewController *vc2 =[[DouyuViewController alloc]init];
    vc2.title = @"斗鱼直播";
    ZhanqiViewController  *vc3 = [[ZhanqiViewController alloc]init];
    vc3.title = @"战旗直播";
    
    [self addChildViewController:vc1];
    [self addChildViewController:vc2];
    [self addChildViewController:vc3];
    
}
- (void)setupScrollView{
    _titleScrollView = [[UIScrollView alloc]initWithFrame:CGRectZero];
    _titleScrollView.showsHorizontalScrollIndicator = FALSE;
    _contentScrollView = [[UIScrollView alloc]initWithFrame:CGRectZero];
    _contentScrollView.showsHorizontalScrollIndicator = FALSE;
    _contentScrollView.showsVerticalScrollIndicator = FALSE;
    _contentScrollView.backgroundColor = [UIColor whiteColor];
    _contentScrollView.delegate = self;
    
    [self.view addSubview:_titleScrollView];
    [self.view addSubview:_contentScrollView];
    
    _titleScrollView.sd_layout.leftSpaceToView(self.view,0).topSpaceToView(self.view,64).rightSpaceToView(self.view,0).heightIs(40);
    _contentScrollView.sd_layout.leftSpaceToView(self.view,0).topSpaceToView(_titleScrollView,0).rightSpaceToView(self.view,0).bottomSpaceToView(self.view,0);
    NSInteger count = [self.childViewControllers count];
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    
    
    for (int i = 0; i < count; i ++) {
        TitleLabel *label = [[TitleLabel alloc]init];
        UIViewController *vc = self.childViewControllers[i];
        label.text = vc.title;
        label.frame = CGRectMake(i * (screenWidth/3), 0, screenWidth/3, 40);
        label.font  = [UIFont fontWithName:@"HYQiHei" size:24];
        label.tag = i;
        label.userInteractionEnabled = TRUE;
        [self.titleScrollView addSubview:label];
        [label addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(lblClick:)]];
    }
    
    _titleScrollView.contentSize  = CGSizeMake(count *(screenWidth/3), 0);
    
    _contentScrollView.contentSize = CGSizeMake(count * screenWidth, 0);
    _contentScrollView.pagingEnabled = TRUE;
    
    UIViewController *vc  = [self.childViewControllers firstObject];
    vc.view.frame = _contentScrollView.bounds;
    vc.view.backgroundColor = [UIColor grayColor];
    [_contentScrollView addSubview:vc.view];
    TitleLabel *label = [_titleScrollView.subviews firstObject];
    label.scale = 1;
    
}
- (void)lblClick:(UITapGestureRecognizer *)tap{
    TitleLabel *label = (TitleLabel *)tap.view;
    if ((int)label.scale == 1) return;
    CGFloat offsetX = label.tag * _contentScrollView.frame.size.width;
    CGFloat offsetY = _contentScrollView.contentOffset.y;
    CGPoint offset = CGPointMake(offsetX, offsetY);
    EndRefresh;
    [_contentScrollView setContentOffset:offset animated:YES];
}
#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    
    // 获得索引
    NSUInteger index = scrollView.contentOffset.x / _contentScrollView.frame.size.width;
    // 滚动标题栏
    TitleLabel *titleLable = (TitleLabel *)_titleScrollView.subviews[index];
    
    CGFloat offsetx = titleLable.center.x - _titleScrollView.frame.size.width * 0.5;
    
    CGFloat offsetMax = _titleScrollView.contentSize.width - _titleScrollView.frame.size.width;
    if (offsetx < 0) {
        offsetx = 0;
    }else if (offsetx > offsetMax){
        offsetx = offsetMax;
    }
    CGPoint offset = CGPointMake(offsetx, _titleScrollView.contentOffset.y);
    [_titleScrollView setContentOffset:offset animated:YES];
    // 添加控制器
    UIViewController *vc = self.childViewControllers[index];
    [_titleScrollView.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UIView *view = (UIView *)obj;
        if (idx != index) {
            if ([view isKindOfClass:[TitleLabel class]]) {
                TitleLabel *temlabel = _titleScrollView.subviews[idx];
                temlabel.scale = 0.0;
            }
        }
    }];
    if (vc.view.superview) return;
    
    vc.view.frame = scrollView.bounds;
    [_contentScrollView addSubview:vc.view];
}
/** 滚动结束 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewDidEndScrollingAnimation:scrollView];
}
/** 正在滚动 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    CGFloat value = ABS(scrollView.contentOffset.x / scrollView.frame.size.width);
    NSUInteger leftIndex = (int)value;
    NSUInteger rightIndex = leftIndex + 1;
    CGFloat scaleRight = (scrollView.contentOffset.x <0)?0:value - leftIndex;
    CGFloat scaleLeft = (rightIndex == self.childViewControllers.count||(scrollView.contentOffset.x<0))?1:1 - scaleRight;
    //scaleLeft =1 - scaleRight;
    //滑到最后一后一个板块后再右滑不设置scale
    if ([(UIView *)_titleScrollView.subviews[leftIndex] isKindOfClass:[TitleLabel class]]) {
        TitleLabel *labelRight = (TitleLabel *)_titleScrollView.subviews[leftIndex];
        labelRight.scale = scaleLeft;
    }
    
    // 考虑到最后一个板块，如果右边已经没有板块了 就不在下面赋值scale了
    //_titleScrollView.subviews不知道为什么里面有imageview存在, 防止报imageview setscale 错误，最好先判断下
    if (rightIndex < self.childViewControllers.count) {
        UIView * subView = _titleScrollView.subviews[rightIndex];
        if ([subView isKindOfClass:[TitleLabel class]]) {
            TitleLabel *labelRight = (TitleLabel *)subView;
            labelRight.scale = scaleRight;
        }
        
    }
    
}

@end
