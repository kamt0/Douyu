//
//  BaseView.h
//  douyuTVDemo
//
//  Created by 揭康伟 on 16/4/28.
//  Copyright © 2016年 kamto. All rights reserved.
//

#import <UIKit/UIKit.h>
#define APPWINDOW       [[UIApplication sharedApplication].delegate window]
#define SHIELD_ALPHA    0.3

@interface BaseView : UIView

- (UIView*)viewForView:(UIView *)view;
@end
