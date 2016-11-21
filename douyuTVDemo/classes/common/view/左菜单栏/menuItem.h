//
//  menuItem.h
//  demo1
//
//  Created by 揭康伟 on 16/5/12.
//  Copyright © 2016年 kamto. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface menuItem : UIView
@property (nonatomic, strong) NSString  *imageName;
@property (nonatomic, strong) NSString  *title;
@property (nonatomic, assign) NSInteger  index;
@property (nonatomic, strong) void (^ClickButtonBlock)(NSInteger);
@end
