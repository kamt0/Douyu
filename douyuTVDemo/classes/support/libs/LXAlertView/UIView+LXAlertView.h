//
//  UIView+MJAlertView.h
//  LXAlertView
//
//

#import <UIKit/UIKit.h>

@interface UIView (LXAlertView)

+ (void) addLXNotifierWithText : (NSString* ) text dismissAutomatically : (BOOL) shouldDismiss;

+ (void) dismissLXNotifier;

@end
