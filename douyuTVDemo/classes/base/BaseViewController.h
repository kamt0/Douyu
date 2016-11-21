//
//  BaseViewController.h
//  douyuTVDemo
//
//  Created by 揭康伟 on 16/4/28.
//  Copyright © 2016年 kamto. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController

- (void)setupNavigationItems;
- (void)setUIElementsFontWhenAwake;

- (void)back;
- (void)requestData;
/**
 *  当view有子view为集合图或者表格图需要刷新加载数据时调用
 *
 *  @param view
 */
- (void)refresh:(UIView *)view;
/**
 * 提示消息
 *
 *  @param message
 */
- (void)showMessage:(NSString *)message;
@end
