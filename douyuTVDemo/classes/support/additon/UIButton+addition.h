//
//  UIButton+addition.h
//  douyuTVDemo
//
//  Created by 揭康伟 on 16/5/7.
//  Copyright © 2016年 kamto. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (addition)
/**
 *  圆形btn
 *
 *  @param rect              frame
 *  @param title             标题
 *  @param color             标题颜色
 *  @param image             按钮图片
 *  @param highlightedImage  高亮图片
 *  @param clickAction       点击相应时间
 *  @param tag               相应者
 *  @param contentEdgeInsets 文字和图片的边距
 *  @param tag               tag
 *
 *  @return <#return value description#>
 */
+(UIButton *)ButtonWithRect:(CGRect)rect title:(NSString *)title
                 titleColor:(UIColor *)color Image:(NSString *)image HighlightedImage:(NSString *)highlightedImage clickAction:(SEL)clickAction target:(id)target contentEdgeInsets:(UIEdgeInsets)contentEdgeInsets tag:(NSInteger)tag;
@end
