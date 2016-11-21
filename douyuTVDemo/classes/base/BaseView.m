//
//  BaseView.m
//  douyuTVDemo
//
//  Created by 揭康伟 on 16/4/28.
//  Copyright © 2016年 kamto. All rights reserved.
//

#import "BaseView.h"

@implementation BaseView

- (UIView*)keyboardView
{
    if (IOS7_OR_LATER) {
        UIView *keyboardView = [[[[[UIApplication sharedApplication] windows] lastObject] subviews] firstObject];
        return keyboardView;
    }
    else {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for (UIWindow *window in [windows reverseObjectEnumerator]) {
            for (UIView *view in [window subviews]) {
                // UIPeripheralHostView is used from iOS 4.0, UIKeyboard was used in previous versions:
                if (!strcmp(object_getClassName(view), "UIPeripheralHostView") || !strcmp(object_getClassName(view), "UIKeyboard")) {
                    return view;
                }
            }
        }
        return nil;
    }
}

- (UIView*)viewForView:(UIView *)view
{
    UIView *keyboardView = [self keyboardView];
    if (keyboardView) {
        view = keyboardView.superview;
    }
    
    return view;
}


@end
