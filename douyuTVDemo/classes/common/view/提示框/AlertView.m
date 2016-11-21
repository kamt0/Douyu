//
//  AlertView.m
//  douyuTVDemo
//
//  Created by 揭康伟 on 16/5/7.
//  Copyright © 2016年 kamto. All rights reserved.
//
#define DEFAULT_MARGIN_TOP   30
#define DEFAULT_SELF_WIDTH   230
#define DEFAULT_SELF_HEIGHT  76
#import "AlertView.h"
@interface AlertView()
    
@property (nonatomic, strong) UILabel *messageLabel;
@property (strong, nonatomic) UIControl *bgControl;
- (void)hide;
//Animation
- (CAKeyframeAnimation*)scaleAnimation:(BOOL)show;
@end
@implementation AlertView
- (instancetype)initWithFrame:(CGRect)frame{
    self                        = [super initWithFrame:frame];
    if (self) {
    self.width                  = DEFAULT_SELF_WIDTH;
    self.height                 = DEFAULT_SELF_HEIGHT;
    CALayer *layer              = self.layer;
    layer.shadowOffset          = CGSizeMake(0, 2);
    layer.shadowColor           = RGBCOLOR(184, 183, 184).CGColor;
    layer.shadowRadius          = 0.5f;
    layer.shadowOpacity         = 1.0;
    layer.masksToBounds         = TRUE;
    layer.shadowPath            = [UIBezierPath bezierPathWithRect:CGRectMake(0, CGRectGetHeight(self.bounds) - 2, CGRectGetWidth(self.bounds), 2)].CGPath;
    layer.cornerRadius          = 4.0;

    self.backgroundColor        = [UIColor whiteColor];
    _messageLabel               = [UILabel new];
    _messageLabel.numberOfLines = 0;
    _messageLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_messageLabel];

        _messageLabel.sd_layout.centerXEqualToView(self).topSpaceToView(self,10).bottomSpaceToView(self,10).widthIs(DEFAULT_SELF_WIDTH-16);
    _bgControl                  = [[UIControl alloc] initWithFrame:[APPWINDOW bounds]];
    _bgControl.backgroundColor  = [UIColor blackColor];
    _bgControl.alpha            = SHIELD_ALPHA;
        [_bgControl addTarget:self action:@selector(onCancelBtnClicked:) forControlEvents:UIControlEventTouchUpInside];


    }
    return self;
}
- (void)showMessage:(NSString *)message InView:(UIView *)supView
{
    _bgControl.alpha                    = 0.0;
    UIView *superView                   = [self viewForView:supView];
    [superView addSubview:_bgControl];
    [superView addSubview:self];
    CGPoint origin                      = CGPointMake((CGRectGetWidth(superView.bounds) - CGRectGetWidth(self.bounds))/2, (CGRectGetHeight(superView.bounds) - CGRectGetHeight(self.bounds))/2 - DEFAULT_MARGIN_TOP);
    CGRect frame                        = self.bounds;
    frame.origin.x                      = origin.x;
    frame.origin.y                      = origin.y;
    self.messageLabel.text              = message;

    CGFloat height    = [self.messageLabel.attributedText boundingRectWithSize:CGSizeMake(DEFAULT_SELF_WIDTH -16, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size.height;

    frame.size.height                   = height + DEFAULT_SELF_HEIGHT;
    self.frame                          = frame;

    [UIView animateWithDuration:0.3
                     animations:^{
                  self.alpha   = 1.0;
                  _bgControl.alpha  = SHIELD_ALPHA;
                  [self.layer addAnimation:[self scaleAnimation:YES] forKey:@"ITTALERTVIEWWILLAPPEAR"];
                     }
    completion:^(BOOL finished){
                         if (finished) {
                         }
                     }];
}

- (void)showMessage:(NSString *)message InView:(UIView *)supView disappearDelay:(NSTimeInterval)delay
{
    _bgControl.alpha                    = 0.0;
    UIView *superView                   = [self viewForView:supView];
    [superView addSubview:_bgControl];
    [superView addSubview:self];
    CGPoint origin                      = CGPointMake((CGRectGetWidth(superView.bounds) - CGRectGetWidth(self.bounds))/2, (CGRectGetHeight(superView.bounds) - CGRectGetHeight(self.bounds))/2 - DEFAULT_MARGIN_TOP);
    CGRect frame                        = self.bounds;
    frame.origin.x                      = origin.x;
    frame.origin.y                      = origin.y;
    self.messageLabel.text              = message;
    CGFloat height                      = [self.messageLabel.attributedText boundingRectWithSize:CGSizeMake(DEFAULT_SELF_WIDTH, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size.height;
    self.messageLabel.height            = height;

    frame.size.height                   = height + DEFAULT_SELF_HEIGHT;
    self.frame                          = frame;

    __block typeof(self)weakSelf        = self;
    [UIView animateWithDuration:0.3
                     animations:^{
                 self.alpha   = 1.0;
                 _bgControl.alpha  = SHIELD_ALPHA;
                 [self.layer addAnimation:[self scaleAnimation:YES] forKey:@"ITTALERTVIEWWILLAPPEAR"];
                     }
    completion:^(BOOL finished){
                         if (finished) {
                             [weakSelf performSelector:@selector(hide) withObject:nil afterDelay:delay];
                         }
                     }];
}


- (void)hide
{
    [UIView animateWithDuration:0.2 animations:^{
                self.alpha         = 0.0;
                _bgControl.alpha     = 0.0;
   
                     }
    completion:^(BOOL finished){
                         if (finished) {
                             [_bgControl removeFromSuperview];

                             [self removeFromSuperview];
                         }
                     }];
}

#pragma mark - Animation
- (CAKeyframeAnimation*)scaleAnimation:(BOOL)show
{
    CAKeyframeAnimation *scaleAnimation = nil;
    scaleAnimation                      = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    scaleAnimation.delegate             = self;
    scaleAnimation.fillMode             = kCAFillModeForwards;

    NSMutableArray *values              = [NSMutableArray array];
    if (show){
    scaleAnimation.duration             = 0.5;
        [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.85, 0.85, 0.85)]];
        [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.05, 1.05, 1.05)]];
        [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.95, 0.95, 0.95)]];
        [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    }else{
    scaleAnimation.duration             = 0.3;
        [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
        [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 0.9)]];
        [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.8, 0.8, 0.8)]];
        [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.6, 0.6, 0.6)]];
    }
    scaleAnimation.values               = values;
    scaleAnimation.timingFunction       = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    scaleAnimation.removedOnCompletion  = TRUE;
    return scaleAnimation;
}


- (void)onCancelBtnClicked:(id)sender
{
    [self hide];
}

@end
