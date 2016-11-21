//
//  TitleLabel.m
//  demo1
//
//  Created by 揭康伟 on 16/5/12.
//  Copyright © 2016年 kamto. All rights reserved.
//
#define minScale 0.7
#define TitleLabel_COLOR(a)  [UIColor colorWithRed:(105*a)/255.0f green:(149*a)/255.0f blue:(246*a)/255.0f alpha:1]
#import "TitleLabel.h"

@implementation TitleLabel

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.textAlignment = NSTextAlignmentCenter;
        self.scale = 0.0;
    }
    return self;
}

- (void)setScale:(CGFloat)scale{
    _scale = scale;
    self.textColor = TitleLabel_COLOR(scale);
    CGFloat trueScale = minScale + (1 - minScale)*scale;
    self.transform = CGAffineTransformMakeScale(trueScale, trueScale);
}
@end
