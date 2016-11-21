//
//  UIViewController+NaviBar.m
//  douyuTVDemo
//
//  Created by 揭康伟 on 16/4/28.
//  Copyright © 2016年 kamto. All rights reserved.
//
#define kSpace -18
#define KFont  15
#import "UIViewController+NaviBar.h"

@implementation UIViewController (NaviBar)

- (UIBarButtonItem *)_createBarButtonTitle:(NSString *)title target:(id)target action:(SEL)selector
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(15, 0, 50, 40);
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    btn.titleLabel.font = [UIFont systemFontOfSize:KFont];
    [btn addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
   
    UIBarButtonItem *btnItem=[[UIBarButtonItem alloc] initWithCustomView:btn];
    return btnItem;
}
- (UIBarButtonItem *)_createBarButton:(NSString *)image target:(id)target action:(SEL)selector
{
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
   btn.frame = CGRectMake(0, 0, 40, 40);
    if (image) {
        [btn setImage:[UIImage imageNamed:image ] forState:UIControlStateNormal];
        
    }
    btn.exclusiveTouch = TRUE;
    UIBarButtonItem *btnItem=[[UIBarButtonItem alloc] initWithCustomView:btn];
    return btnItem;
}

- (void)leftItemTitle:(NSString *)title target:(id)target action:(SEL)selector{
    UIBarButtonItem * FixSpaceBarbutton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    FixSpaceBarbutton.width = kSpace;
    UIBarButtonItem * barButton = [self _createBarButtonTitle:title target:target
    action:selector];
    [self.navigationItem setRightBarButtonItems:@[barButton,FixSpaceBarbutton]];
}

- (void)leftItemImage:(NSString *)imageName target:(id)target action:(SEL)selector{
//    UIBarButtonItem * FixSpaceBarbutton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
//    FixSpaceBarbutton.width = kSpace;
    
    
    UIBarButtonItem *leftBarButton = [self _createBarButton:imageName target:target action:selector];

    [self.navigationItem setLeftBarButtonItem:leftBarButton];
    //[self.navigationItem setLeftBarButtonItems:@[leftBarButton,FixSpaceBarbutton]];
}





- (void)rightItemTitle:(NSString *)title target:(id)target action:(SEL)selector{
    
    
    UIBarButtonItem * FixSpaceBarbutton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    FixSpaceBarbutton.width = kSpace;
    UIBarButtonItem * barButton = [self _createBarButtonTitle:title
      target:target
    action:selector];
    [self.navigationItem setRightBarButtonItems:@[barButton,FixSpaceBarbutton]];
}


- (void)rightItemImage:(NSString *)imageName target:(id)target action:(SEL)selector{
    
    
    UIBarButtonItem * FixSpaceBarbutton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    FixSpaceBarbutton.width = kSpace;
    
    
    UIBarButtonItem * barButton =[self _createBarButton:imageName
      target:target
     action:selector];
    
    [self.navigationItem setRightBarButtonItems:@[barButton,FixSpaceBarbutton]];
}
@end
