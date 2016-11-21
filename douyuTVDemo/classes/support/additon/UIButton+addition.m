//
//  UIButton+addition.m
//  douyuTVDemo
//
//  Created by 揭康伟 on 16/5/7.
//  Copyright © 2016年 kamto. All rights reserved.
//

#import "UIButton+addition.h"

@implementation UIButton (addition)

+(UIButton *)ButtonWithRect:(CGRect)rect title:(NSString *)title
                 titleColor:(UIColor *)color Image:(NSString *)image HighlightedImage:(NSString *)highlightedImage clickAction:(SEL)clickAction target:(id)target contentEdgeInsets:(UIEdgeInsets)contentEdgeInsets tag:(NSInteger)tag{

    UIButton *button           = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame               = rect;
    [button setTitle:title forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    if (highlightedImage) {
        [button setImage:[UIImage imageNamed:highlightedImage] forState:UIControlStateHighlighted];
    }
    
    [button setTitleColor:color forState:UIControlStateNormal];
    button.contentEdgeInsets   = contentEdgeInsets;
    button.titleLabel.font     = [UIFont systemFontOfSize:12];
    button.backgroundColor     = [UIColor blackColor];
    if (clickAction) {
        [button addTarget:target
                   action:clickAction
         forControlEvents:UIControlEventTouchUpInside];
    }

    button.layer.cornerRadius  = 15;
    button.layer.masksToBounds = YES;
    button.tag                 = tag;
    return button;

}
@end
