//
//  SingTonManger.h
//  douyuTVDemo
//
//  Created by 揭康伟 on 16/5/13.
//  Copyright © 2016年 kamto. All rights reserved.
//
/**
 *  单例模式
 *
 */
#import <Foundation/Foundation.h>
#import "ITRAirSideMenu.h"
@interface SingTonManger : NSObject
@property (nonatomic, strong) ITRAirSideMenu *leftMenu;

+(instancetype)sharedSingTonManger;


//根据设置类型加载图片 (所有网络,仅WiFi等..)

-(BOOL)loadImageAccordingToTheSetType;
//设置下载气泡视图显示与隐藏 (YES为隐藏 NO为显示)

-(void)downloadViewHiddenOrShow:(BOOL)isHidden;
@end
