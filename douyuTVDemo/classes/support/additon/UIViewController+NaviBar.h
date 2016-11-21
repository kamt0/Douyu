//
//  UIViewController+NaviBar.h
//  douyuTVDemo
//
//  Created by 揭康伟 on 16/4/28.
//  Copyright © 2016年 kamto. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (NaviBar)

/**
 *	@brief	创建导航条左按钮
 *
 *	@param 	title 	按钮标题
 *	@param 	target 	按钮点击事件响应对象
 *	@param 	selector 	按钮点击事件响应方法
 */
- (void)leftItemTitle:(NSString *)title target:(id)target action:(SEL)selector;
/**
 *	@brief	创建导航条左按钮
 *
 *	@param 	imageName 	按钮图片
 *	@param 	target 	按钮点击事件响应对象
 *	@param 	selector 	按钮点击事件响应方法
 */
- (void)leftItemImage:(NSString *)imageName target:(id)target action:(SEL)selector;
/**
 *	@brief	创建导航条右按钮
 *
 *	@param 	title 	按钮标题
 *	@param 	target 	按钮点击事件响应对象
 *	@param 	selector 	按钮点击事件响应方法
 */

- (void)rightItemTitle:(NSString *)title target:(id)target action:(SEL)selector;
/**
 *	@brief	创建导航条右按钮
 *
 *	@param 	imageName 	按钮图片
 *	@param 	target 	按钮点击事件响应对象
 *	@param 	selector 	按钮点击事件响应方法
 */
- (void)rightItemImage:(NSString *)imageName target:(id)target action:(SEL)selector;
@end
